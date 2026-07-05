class Personaje{
    const property nombre // no queda
    var property vidaMaxima // ok
    var property vida = vidaMaxima // ok
    var property fuerza //ok
    var property defensa //ok
    var property estaDefendiendose = false // ok
    
   
   var property position = null //ok
   var property image = null // ok

    

    method atacar(unEnemigo) {
        unEnemigo.recibirDaño(fuerza)
    }

    method recibirDaño(cantidadDeDaño) {
        if (estaDefendiendose) {
            vida = (vida - cantidadDeDaño / 2).max(0)
            estaDefendiendose = false      
        }else{
            vida = (vida - cantidadDeDaño).max(0)
        }
    }

    method estaVivo() {
        return vida > 0
    } // ok

    method defenderse() {
        estaDefendiendose = true
    }
    
    method recibirCuracion(cantidad) {
        vida = (vida + cantidad).min(self.vidaMaxima())
    }
}