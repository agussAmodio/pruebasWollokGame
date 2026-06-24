import personajes.*
object managerDeBatallas {
    var property jugador = null
    var property enemigo = null


    // REVISAR SI PUEDE MEJORAR
    var property estadoActual = "TURNO_JUGADOR"

    method esTurnoDelJugador() {
        return estadoActual == "TURNO_JUGADOR"
    }

    method esTurnoDelEnemigo() {
        return estadoActual == "TURNO_ENEMIGO"
    }

    method esTurnoFinalizado() {
        return estadoActual == "FINALIZADO"
    }

    method cambiarATurnoEnemigo() {
        estadoActual = "TURNO_ENEMIGO"
    }

    method cambiarAturnoDelJugador() {
        estadoActual = "TURNO_JUGADOR"
    }

    method finalizarTurno() {
        estadoActual = "FINALIZADO"
    }

    // Acción que se ejecuta al elegir "ATACAR" en el menú
    method procesarTurnoJugador() {
        if (self.esTurnoDelJugador() and jugador.estaVivo()){
            
            jugador.atacar(enemigo)
            game.say(jugador, "¡Enemigo atacado!")

            self.comprobarFinDeBatalla()

            // Si el enemigo no murió, le pasamos el turno
            if (!self.esTurnoFinalizado()){
                self.cambiarATurnoEnemigo()
                game.schedule(1500, { self.ejecutarTurnoEnemigo() })
            }
        }
    }

    method ejecutarTurnoEnemigo() {
        if (enemigo.estaVivo()){
            enemigo.atacar(jugador)
            game.say(enemigo, "¡Jugador atacado!")
        }

        self.comprobarFinDeBatalla()

        if (!self.esTurnoFinalizado()){
            self.cambiarAturnoDelJugador()
        }
    }


    method comprobarFinDeBatalla() {
        if (!enemigo.estaVivo()){
            self.finalizarTurno()
            game.say(jugador, "¡El jugador ganó la batalla!")
        } else if (!jugador.estaVivo()){
            self.finalizarTurno()
            game.say(enemigo, "El jugador ha sido derrotado...")
        }
        // Si ambos siguen vivos, no pasa nada y la pelea continúa
    }
}