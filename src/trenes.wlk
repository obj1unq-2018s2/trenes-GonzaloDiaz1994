import vagones.*
import deposito.*

class Formacion{
	var property locomotoras
	var property vagones
	constructor(_locomotoras, _vagones) {
		locomotoras= _locomotoras
		vagones= _vagones
	}
	method agregarLocomotora(locomotora){
		locomotoras.add(locomotora)
	}
	method agregarVagon(vagon){
		vagones.add(vagon)
	}
	method totalDePasajeros(){
		return vagones.map{vagon => vagon.cantidadDePasajeros()}.sum()
	}
	method cantidadVagonesLivianos(){
		return vagones.count{vagon => vagon.esLiviano() }
	}
	method todosVagonesLivianos(){
		return vagones.all{vagon=> vagon.esLiviano()}
	}
	method velocidadMaximaDeFormacion(){
		return locomotoras.min{locomotora => locomotora.velocidadMaxima()}.velocidadMaxima()
	}
	method esEficiente(){
		return locomotoras.all{
			locomotora => locomotora.arrastreUtil() >= locomotora.peso() * 5
		}
	}
	method arrastreTotalLocomotoras(){
		return locomotoras.map{locomotora => locomotora.arrastreUtil()}.sum()
	}
	method pesoTotalVagones(){
		return vagones.map{vagon => vagon.peso()}.sum()	
	}
	method pesoTotalLocomotoras(){
		return locomotoras.map{locomotora=> locomotora.peso()}.sum()
	}
	method puedeMoverse(){
		return self.arrastreTotalLocomotoras() >= self.pesoTotalVagones()
	}
	method kilosDeEmpujeFaltante(){
		if(self.puedeMoverse()){
			return 0
		}else{
			return self.pesoTotalVagones() - self.arrastreTotalLocomotoras()
		}
	}
	method vagonMasPesado(){
		return vagones.max{vagon => vagon.peso()}
	}
	method cantidadVagones(){
		return vagones.size()
	}
	method cantidadLocomotoras(){
		return locomotoras.size()
	}
	method esCompleja(){
		return self.cantidadVagones() + self.cantidadLocomotoras() > 20
				or self.pesoTotalVagones() + self.pesoTotalLocomotoras() > 10000
	}
	method tieneMuchosBanios() = vagones.all{
			vagon=> vagon.cantidadDePasajeros() == vagon.cantidadDeBanios()*50
	}
	method bienArmada() = self.puedeMoverse()
}

class FormacionCortaDistancia inherits Formacion{
	 
	override method bienArmada(){
	 	return super() and not self.esCompleja()
	 }
	 method velocidadMaxima() = 60.min(self.velocidadMaximaDeFormacion())
}

class FormacionLargaDistancia inherits Formacion{
	var property ciudadGrande
	constructor (_locomotoras,_vagones,_ciudadGrande) =
		super(_locomotoras,_vagones){
		ciudadGrande = _ciudadGrande
	}
	override method bienArmada(){
		return super() and self.tieneMuchosBanios()
	}
	method velocidadMaxima(){
		if(ciudadGrande){
			return 200.min(self.velocidadMaximaDeFormacion())
		}else{ return 150.min(self.velocidadMaximaDeFormacion())}
	}
}

class FormacionAltaVelocidad inherits FormacionLargaDistancia{
		
	override method velocidadMaxima() = self.velocidadMaximaDeFormacion() >= 250
	
	override method bienArmada(){
		return super() and self.todosVagonesLivianos() and self.velocidadMaxima()
	}
}





