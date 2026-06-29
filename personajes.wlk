class Personaje{
    const property nombre
    var property vidaMaxima
    var property vida = vidaMaxima
    var property fuerza
    var property defensa
    var property estaDefendiendose = false
    
   
   var property position = null
   var property image = null

    

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
    }

    method defenderse() {
        estaDefendiendose = true
    }
    
    method recibirCuracion(cantidad) {
        vida = (vida + cantidad).min(self.vidaMaxima())
    }
}