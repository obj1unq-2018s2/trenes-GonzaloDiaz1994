class Locomotora{
	const property  peso
	var property pesoMaximoDeArrastre
	var property velocidadMaxima
	constructor(_peso, _pesoMaximoDeArrastre, _velocidadMaxima){
		peso = _peso
		pesoMaximoDeArrastre = _pesoMaximoDeArrastre
		velocidadMaxima = _velocidadMaxima
	}
	method arrastreUtil() = pesoMaximoDeArrastre - peso	
}

class Vagon{
	method esLiviano() = self.peso() < 2500
	method peso()
}

class VagonDePasajeros inherits Vagon{
	const largo
	const anchoUtil
	const medidaReferencia = 2.5
	constructor(_largo, _anchoUtil){
		largo = _largo
		anchoUtil = _anchoUtil
	}
	method cantidadDePasajeros(){
		if (anchoUtil <= medidaReferencia){
			return largo * 8
		}else{
			return largo * 10
		}
	}
	override method peso() = self.cantidadDePasajeros() * 80
	method cantidadDeBanios(){
		return self.cantidadDePasajeros() / 50
	}
}

class VagonDeCarga inherits Vagon{
	var property cargaMaxima
	constructor(_cargaMaxima){
		cargaMaxima = _cargaMaxima
	}
	override method peso() = cargaMaxima + 160
	method cantidadDePasajeros() = 0	
	method cantidadDeBanios() = 0
}