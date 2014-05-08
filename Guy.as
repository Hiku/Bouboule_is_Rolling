package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	
	public class Guy extends MovieClip {
		var left:Boolean = false;
		var up:Boolean = false;
		var right:Boolean = false;
		var down:Boolean = false;
		var space:Boolean = false;
		const Sol:int = 470;
		var speedX:Number = 0;
		var speedY:Number = 0;
		var gravity:Number = 1.8;
		var game:Object;
		var Rolling:Boolean =false;
		var timerSaut:int;
		var timershoot:int=0;
		var couleurvitesse:Array = [0xFFFFFF,0xFFCCCC,0xFFAAAA,0xFF8888,0xFF6666,0xFF4444,0xFF2222,0xFF0000,0xCC0000,0xAA0000,0x880000,0x660000,0x440000,0x220000]
		public function Guy(jeu:Object) {
			game=jeu;
			addEventListener(Event.ADDED_TO_STAGE, init)

		}
		function init(e:Event){
			addEventListener(Event.ENTER_FRAME, eFrame)
			stage.addEventListener(KeyboardEvent.KEY_DOWN, checkKeysDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, checkKeysUp);
		}
		function eFrame(e:Event){
			timershoot--;
			if(space && timershoot<=0){
				game.f.Bulleter(x,y-(500-y)/4)
				timershoot=1;
			}
			if(up&&auSol()){
				timerSaut = 8;
				speedY-=15
			}
			if(timerSaut>=0){
				timerSaut--;
				if(up){
					speedY-=10
					speedX*=0.90
				}
			}
			if(right){
				speedX+=1;
			}
			if(left){
				speedX-=1;
			}
			
			if(!auSol()){
				speedY+=gravity;
				speedY*=0.95;
			}
			//trace(speedX)
			var i:int = 0;
			while(speedX>10*(i+1)){
				if(Math.random()<0.2){
					var v:Vitesse=new Vitesse(i<couleurvitesse.length?couleurvitesse[i]:0)
					v.x =x+50;
					v.y =y;
					game.addChild(v)
				}
				i++;

			}
			if(!right&&!left){
				speedX*=0.90
			} else {
				speedX*=0.97
			}
			y+=speedY;
			if(Rolling){
				Tete.y += (-20-Tete.y)/10;
				rotation+=speedX*1.5;
				if(speedX<4&&speedX>-4){
					Rolling=false
					//Tete.y = -35;
					//rotation = 0;
				}

			} else {
				Tete.y += (-35-Tete.y)/10;
				if(rotation>180)rotation-=360;
				rotation*=0.9;
				if(speedX>6||speedX<-6){
					Rolling=true
				}
			}
			x+=speedX;
			if(x>=30&&speedX>0){
				var nX:Number = x+(30-x)/5
				game.slide += x-nX;
				x = nX;
			} else {
				if(x<=60&&speedX<0&&game.slide>=0){
					var nX2:Number = x+(60-x)/5
					game.slide += x-nX2;
					if(game.slide<0){
						game.slide=0;
					} else {
						x = nX2;
					}
				}
			}
			if(x<0)x=0;
			game.hauteur = (500-y)/2;
			if(auSol())y=SolAuDessous();
		}
		function auSol():Boolean{
			return y>=Sol
		}
		function SolAuDessous():int{
			return Sol
		}
		function checkKeysDown(event:KeyboardEvent):void{
			if(event.keyCode == 37 || event.keyCode == 81){
				left = true;
			}
			if(event.keyCode == 38 || event.keyCode == 90){
				up = true;
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				right = true;
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				down = true;
			}
			if(event.keyCode == 32){
				space = true;
			}
		
		}
		function checkKeysUp(event:KeyboardEvent):void{
			//making the booleans false based on the keycode
			if(event.keyCode == 37 || event.keyCode == 81){
				left = false;
			}
			if(event.keyCode == 38 || event.keyCode == 90){
				up = false;
			}
			if(event.keyCode == 39 || event.keyCode == 68){
				right = false;
			}
			if(event.keyCode == 40 || event.keyCode == 83){
				down = false;
			}
			if(event.keyCode == 32){
				space = false;
			}
		}

	}
	
}
