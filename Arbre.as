package  {
	import flash.geom.Point;
	import flash.display.MovieClip;
	
	public class Arbre extends MovieClip {
		var fList:Array = new Array()
		var distMin:int = 4
		var distMax:int = 12
		var diffAngles:int = 15;
		var LC1:uint;
		var LC2:uint;
		var LR:int;
		var TC1:uint;
		var TC2:uint;
		var TR:int;
		var Taille:int;
		var RangMax:int;
		var FSize:int = 5;
		public function Arbre(Epaisseur:int, Rang:int, Couleur1Feuilles:uint, Couleur2Feuilles:uint,RandomnessFeuilles:int, Couleur1Tronc:uint, Couleur2Tronc:uint,RandomnessTronc:int,diffRot:int,TailleFeuilles:int){
			Taille = Epaisseur;
			RangMax = Rang;
			LC1=Couleur1Feuilles;
			LC2=Couleur2Feuilles;
			TC1=Couleur1Tronc;
			TC2=Couleur2Tronc;
			LR = RandomnessFeuilles;
			TR = RandomnessTronc;
			diffAngles = diffRot;
			FSize = TailleFeuilles;
			//Couleur1Feuilles, Couleur2Feuilles, Couleur1Tronc, Couleur2Tronc, Epaisseur, Rang
			CreerArbre()
		}
		function CreerArbre(){
			while(true){
				Render(12,TreeColor(),10-Math.random()*20,10-Math.random()*20,0,-50)
				Branche(0,-50,-Math.PI/2,0,RangMax,Taille)
				if((fList.length>Math.pow(RangMax,2)&&fList.length<Math.pow(RangMax,2)*2)||RangMax<7){
					//trace(1)
					/*for(var m:int = 0; m<fList.length; m++){
						Feuille(fList[m].x,fList[m].y,Math.random()*15+5)
					}*/
					break;
					
				} else {
					fList = []
					this.graphics.clear()
					//trace(2)
				}
			}
		}
		function LeafColor():uint{
			var h:Number = Math.random();
			var r:int = Math.round(LC1/256/256*h)+Math.round(LC2/256/256*(1-h));
			var v:int = Math.round((LC1/256)%256*h)+Math.round((LC2/256)%256*(1-h));
			var b:int = Math.round(LC1%256*h)+Math.round(LC2%256*(1-h));
			return randomizeColor(r*256*256+v*256+b,LR);
		}
		function TreeColor():uint{
			var h:Number = Math.random();
			var r:int = Math.round(TC1/256/256*h)+Math.round(TC2/256/256*(1-h));
			var v:int = Math.round((TC1/256)%256*h)+Math.round((TC2/256)%256*(1-h));
			var b:int = Math.round(TC1%256*h)+Math.round(TC2%256*(1-h));
			return randomizeColor(r*256*256+v*256+b,TR);
		}
		function Branche(X:int,Y:int,angle:Number,rang:int,rangMax:int,taille:int){
			var nb:int = (rangMax-rang)/Math.pow(rang+1,0.5)*Math.random()
			if(nb<=1){
				fList.push(new Point(X,Y))
				Feuille(X,Y,(Math.random()*3+1)*FSize)
			}
			for(var i:int = 0; i<nb;i++){
				var dist:int = Math.floor((Math.random()*(distMax-distMin)+distMin)*Math.pow(taille,1/2)/5)
				var newAngle:Number = angle+(Math.random()-0.5)/Math.pow(taille,1/3)*diffAngles;
				var newX:int = X+Math.floor(Math.cos(newAngle)*dist)
				var newY:int = Y+Math.floor(Math.sin(newAngle)*dist)
				Render(Math.pow(taille,1/3),TreeColor(),X,Y,newX,newY)
				var newTaille:int = Math.floor(Math.random()*taille+1)
				if(newTaille!=0&&rang<rangMax)Branche(newX,newY,newAngle,rang+1,rangMax,newTaille)
			}
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
		function Render(Epaiss:int,color:uint,X:int,Y:int,newX:int,newY:int){
			graphics.lineStyle(Epaiss,color)
			graphics.moveTo(X,Y)
			graphics.lineTo(newX,newY)
		}
		function Feuille(X:int,Y:int,taille:Number){
			var color:uint = LeafColor();
			taille=Math.floor(taille)
			graphics.lineStyle()
			graphics.beginFill(color)
			//graphics.drawRect(X-taille,Y-taille, taille*2, taille*2)
			graphics.drawEllipse(X-taille,Y-taille,taille*2,taille*2)
			graphics.endFill()
		}
	}
	
}
