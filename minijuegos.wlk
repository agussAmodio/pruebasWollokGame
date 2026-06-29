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
        managerAsociado.estadoActual().finalizarMinijuego(managerAsociado, gano)
    }
}


