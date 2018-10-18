import vagones.*
import trenes.*

class Deposito{
	var property formaciones				// lista de formaciones
	var property locomotorasSueltas			//locomotoras sueltas
	constructor(_formaciones, _locomotorasSueltas){
		formaciones = _formaciones
		locomotorasSueltas = _locomotorasSueltas
	}
	method agregarLocomotoraSuelta(formacion){
		var locomotoraElegida = locomotorasSueltas.find{
								locomotora=>locomotora.arrastreUtil()
								>= formacion.kilosDeEmpujeFaltante()}
		if(not formacion.puedeMoverse()){
			formaciones.find{tren=>tren == formacion}.agregarLocomotora(locomotoraElegida)
			locomotorasSueltas.remove(locomotoraElegida)
		}
	}
	method vagonesPesados(){
		return formaciones.map{formacion=> formacion.vagonMasPesado()}.asSet()
	}
	method necesitaConductor(){
		return formaciones.any{formacion=> formacion.esCompleja()}
	}
}
