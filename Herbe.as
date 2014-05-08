package  {
	import flash.display.Sprite;
	
	public class Herbe extends Sprite {
		var brins:Array = []
		var couleurs:Array = []
		var l:int;
		var h:int;
		var GC1:uint;
		var GC2:uint;
		var GR:int;
		public function Herbe(Largeur:int, Hauteur:int, Couleur1Brins:uint, Couleur2Brins:uint,RandomnessBrins:int) {
			l=Largeur;
			h=Hauteur;
			GC1=Couleur1Brins;
			GC2=Couleur2Brins;
			GR = RandomnessBrins;
		}
		function Render(vent:Number, Deplacement:int, hauteur:int){
			graphics.clear()
			while(brins.length*l-Deplacement<850)plusUn();
			for(var i:int = Deplacement/l-3; i<((Deplacement+850)/l-3>brins.length?brins.length:(Deplacement+850)/l-3); i++){
				graphics.beginFill(couleurs[i])
				graphics.moveTo(l*(i-1)-Deplacement,y/600*hauteur+hauteur*0.5)
				graphics.lineTo(l*(i+1)-Deplacement,y/600*hauteur+hauteur*0.5)
				graphics.lineTo(l*(i)-Deplacement+vent,-h*brins[i]+y/600*hauteur+hauteur*0.5)
			}
		}
		function plusUn(){
			couleurs.push(GrassColor())
			if(brins[brins.length-1]!=0||Math.random()<0.95){
				brins.push(0);
			} else {
				brins.push(Math.random()*0.7+0.3)
			}
		}
		function GrassColor():uint{
			var h:Number = Math.random();
			var r:int = Math.round(GC1/256/256*h)+Math.round(GC2/256/256*(1-h));
			var v:int = Math.round((GC1/256)%256*h)+Math.round((GC2/256)%256*(1-h));
			var b:int = Math.round(GC1%256*h)+Math.round(GC2%256*(1-h));
			return randomizeColor(r*256*256+v*256+b,GR);
		}
		function randomizeColor(color:uint, difmax:int):uint{
			var r:int = Bornes(color/256/256+Math.floor(Math.random()*difmax*2-difmax));
			var v:int = Bornes(color/256%256+Math.floor(Math.random()*difmax*2-difmax));
			var b:int = Bornes(color%256+Math.floor(Math.random()*difmax*2-difmax));
			return r*256*256+v*256+b;
		}
		function Bornes(a:int){
			if(a>256)a=256;
			if(a<0)a=0;
			return a;
		}


	}
	
}
