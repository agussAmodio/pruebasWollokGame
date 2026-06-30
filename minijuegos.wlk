import wollok.game.*

object miniJuegoCuracion {
    var property clicks = 0
    var property activo = false
    var managerAsociado = null

    method iniciar(manager) {
        managerAsociado = manager
        clicks = 0
        activo = true
        game.say(manager.jugador(), "¡Apretá la 'X' rápido para batir la poción!")
        
        // Da 3 segundos de tiempo límite
        game.schedule(3000, { self.terminarTiempo() })
    }

    method registrarClick() {
        if (activo) {
            clicks += 1
            if (clicks >= 10) { self.finalizar(true) } 
        }
    }

    method terminarTiempo() {
        if (activo) { self.finalizar(false) } 
    }

    method finalizar(gano) {
        activo = false
        // Le pasamos 'self' al final para decir "soy el minijuego de curación"
        managerAsociado.estadoActual().finalizarMinijuego(managerAsociado, gano, self)
    }
}

// JUEGO DE ATAQUE


object medidor {
    var property position = game.at(4, 1) 
    method image() = "medidorPrecision.png" // Tu barra de madera de 400x100
}

object aguja {
    var property position = game.at(4, 3) // Fila 3 para que flote sobre el medidor
    method image() = "agujaVisual.png" 

    method mover() {
        // Va de la columna 4 a la 11 en bucle
        position = if (position.x() < 11) position.right(1) else game.at(4, 3)
    }
}

object miniJuegoAtaque {
    var property activo = false
    var managerAsociado = null

    method iniciar(manager) {
        managerAsociado = manager
        activo = true
        
        game.addVisual(medidor)
        game.addVisual(aguja)
        
        // Iniciamos el movimiento automático
        game.onTick(100, "movimientoAguja", { aguja.mover() })
        game.say(manager.jugador(), "¡Presioná ESPACIO en el centro!")
    }

method detenerYValidar() {
        if (activo) {
            activo = false
            
            game.removeTickEvent("movimientoAguja")
            game.removeVisual(aguja)
            game.removeVisual(medidor)
            
            var gano = aguja.position().x() >= 8
            
            // CORREGIDO: Sacamos la 'a' extra de "finalizara..." -> debe ser "finalizarMinijuego"
            managerAsociado.estadoActual().finalizarMinijuego(managerAsociado, gano, self)
        }
    }
}

