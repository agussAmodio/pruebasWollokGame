import personajes.*
import minijuegos.*
object turnoJugador {
    method atacar(manager) {
        manager.jugador().atacar(manager.enemigo())
        game.say(manager.jugador(), "¡Enemigo atacado!")
        manager.comprobarFinDeBatalla()
        
        // Delegamos el pase de turno al estado actual
        manager.estadoActual().pasarTurno(manager)
    }

    method usarPocion(manager) {
        //AGREGADO MINIJUEGO
        manager.estadoActual(turnoMinijuego)
        miniJuegoCuracion.iniciar(manager)


        // ESTA PARTE FUNCIONA
        //manager.jugador().recibirCuracion(40) 
        //game.say(manager.jugador(), "¡Usé una poción y recuperé vida!")
        //self.pasarTurno(manager)
    }

    method defenderse(manager) {
        manager.jugador().defenderse()
        game.say(manager.jugador(), "¡Me defiendo! El próximo golpe dolerá menos.")
        self.pasarTurno(manager)
    }

    method rendirse(manager) {
        manager.estadoActual(batallaFinalizada)
        game.say(manager.jugador(), "Me rindo... ¡Vos ganás!")
        game.say(manager.enemigo(), "¡Ja! Sabía que ibas a arrugar.")
    }

    // Como soy el turno del jugador y se terminó mi acción, paso al turno enemigo con delay
    method pasarTurno(manager) {
        manager.estadoActual(turnoEnemigo)
        game.schedule(1500, { manager.ejecutarTurnoEnemigo() })
    }
}

object turnoEnemigo {
    method atacar(manager) {}
    method usarPocion(manager) {}
    method defenderse(manager) {}
    method rendirse(manager) {}

    // Cuando el enemigo termina, volvemos al turno del jugador de forma instantánea
    method pasarTurno(manager) {
        manager.estadoActual(turnoJugador)
    }
}

object batallaFinalizada {
    method atacar(manager) {}
    method usarPocion(manager) {}
    method defenderse(manager) {}
    method rendirse(manager) {}
    
    // Si la batalla terminó, pasar de turno no hace absolutamente nada
    method pasarTurno(manager) {} 
}

object turnoMinijuego {
    method atacar(manager) {}
    method usarPocion(manager) {}
    method defenderse(manager) {}
    method rendirse(manager) {}

    // Este método lo va a llamar el minijuego al terminar
    method finalizarMinijuego(manager, ganoElMinijuego) {
        if (ganoElMinijuego) {
            manager.jugador().recibirCuracion(20) // Curación potenciada si apretó rápido!
            game.say(manager.jugador(), "¡Poción perfecta! Recuperé mucha vida.")
        } else {
            manager.jugador().recibirCuracion(10) // Curación débil si falló o no llegó
            game.say(manager.jugador(), "Se me derramó un poco... Recuperé poca vida.")
        }
        
        manager.comprobarFinDeBatalla()
        
        // Pasamos el turno al enemigo de forma normal
        manager.estadoActual(turnoEnemigo)
        game.schedule(1500, { manager.ejecutarTurnoEnemigo() })
    }
}

class ManagerDeBatalla {
    var property jugador = null
    var property enemigo = null
    var property estadoActual = turnoJugador

    // Métodos de la interfaz/teclado
    method procesarAtaqueJugador() {
        if (jugador.estaVivo()) { estadoActual.atacar(self) }
    }

    method procesarPocionJugador() {
        if (jugador.estaVivo()) { estadoActual.usarPocion(self) }
    }

    method procesarDefensaJugador() {
        if (jugador.estaVivo()) { estadoActual.defenderse(self) }
    }

    method procesarRendicionJugador() {
        if (jugador.estaVivo()) { estadoActual.rendirse(self) }
    }

    // Lógica del enemigo
    method ejecutarTurnoEnemigo() {
        if (enemigo.estaVivo()) {
            enemigo.atacar(jugador)
            game.say(enemigo, "¡Jugador atacado!")
        }

        self.comprobarFinDeBatalla()

        // POLIMÓRFICO: Le digo al estado "pasá al turno siguiente".
        // Si el estado es 'turnoEnemigo' pasará a 'turnoJugador'.
        // Si es 'batallaFinalizada', no hará nada.
        estadoActual.pasarTurno(self)
    }

    method comprobarFinDeBatalla() {
        if (!enemigo.estaVivo()) {
            estadoActual = batallaFinalizada
            game.say(jugador, "¡El jugador ganó la batalla!")
        } else if (!jugador.estaVivo()) {
            estadoActual = batallaFinalizada
            game.say(enemigo, "El jugador ha sido derrotado...")
        }
    }
}