///////////
// MENUS //
///////////

::menu <- []
::cursor <- 0
::cursorOffset <- 0
::menuMax <- 7 //Maximum number of slots that can be shown on screen
::textMenu <- function(){
	//If no menu is loaded
	if(menu == []) return

	//Draw options
	//The number
	if(menu.len() > menuMax) for(local i = cursorOffset; i < cursorOffset + menuMax; i++) {
		if(cursor == i) {
			drawSprite(font2, 97, (screenW() / 2) - (menu[i].name().len() * 4) - 16, screenH() - 8 - (menuMax * 14) + ((i - cursorOffset) * 14))
			drawSprite(font2, 102, (screenW() / 2) + (menu[i].name().len() * 4) + 7, screenH() - 8 - (menuMax * 14) + ((i - cursorOffset) * 14))
		}
		drawText(font2, (screenW() / 2) - (menu[i].name().len() * 4), screenH() - 8 - (menuMax * 14) + ((i - cursorOffset) * 14), menu[i].name())
	}
	else for(local i = 0; i < menu.len(); i++) {
		if(cursor == i) {
			drawSprite(font2, 97, (screenW() / 2) - (menu[i].name().len() * 4) - 16, screenH() - 8 - (menu.len() * 14) + (i * 14))
			drawSprite(font2, 102, (screenW() / 2) + (menu[i].name().len() * 4) + 7, screenH() - 8 - (menu.len() * 14) + (i * 14))
		}
		drawText(font2, (screenW() / 2) - (menu[i].name().len() * 4), screenH() - 8 - (menu.len() * 14) + (i * 14), menu[i].name())
	}

	//Keyboard input
	if(getcon("down", "press")) {
		cursor++
		if(cursor >= cursorOffset + menuMax) cursorOffset++
		if(cursor >= menu.len()) {
			cursor = 0
			cursorOffset = 0
		}
	}

	if(getcon("up", "press")) {
		cursor--
		if(cursor < cursorOffset) cursorOffset--
		if(cursor < 0) {
			cursor = menu.len() - 1
			if(menu.len() > menuMax) cursorOffset = menu.len() - menuMax
		}
	}

	if(getcon("jump", "press") || getcon("accept", "press")) {
		menu[cursor].func()
	}
}

//Names are stored as functions because some need to change each time
//they're brought up again.
::meMain <- [
	{
		name = function() { return gvLangObj["main-menu"]["new"] },
		func = function() { game = clone(gameDefault); game.completed.clear(); game.allcoins.clear(); game.allenemies.clear(); game.allsecrets.clear(); game.besttime.clear(); gvDoIGT = false; startPlay("res/map/0-t0.json") }
	},
	{
		name = function() { return gvLangObj["main-menu"]["load"] },
		func = function() { return }
	},
	{
		name = function() { return gvLangObj["main-menu"]["contrib-levels"] },
		func = function() { cursor = 0; selectContrib(); }
	}
	{
		name = function() { return gvLangObj["main-menu"]["options"] },
		func = function() { cursor = 0; menu = meOptions }
	},
	{
		name = function() { return gvLangObj["main-menu"]["quit"] },
		func = function() { gvQuit = 1 }
	}
]

::mePausePlay <- [
	{
		name = function() { return gvLangObj["pause-menu"]["continue"]},
		func = function() { gvGameMode = gmPlay }
	},
	{
		name = function() { return gvLangObj["pause-menu"]["restart"]},
		func = function() { startPlay(gvMap.file) }
	}
	{
		name = function() { return gvLangObj["pause-menu"]["quit-level"]},
		func = function() { startOverworld(game.world); cursor = 0 }
	}
]

::mePauseOver <- [
	{
		name = function() { return gvLangObj["pause-menu"]["continue"]},
		func = function() { gvGameMode = gmOverworld }
	},
	{
		name = function() { return gvLangObj["pause-menu"]["character"]},
		func = function() {  }
	},
	{
		name = function() { return gvLangObj["pause-menu"]["quit-game"]},
		func = function() { startMain(); cursor = 0 }
	}
]

::meOptions <- [
	{
		name = function() { return gvLangObj["options-menu"]["keyboard"] },
		func = function() { rebindKeys() }
	},
	{
		name = function() { return gvLangObj["options-menu"]["joystick"] },
		func = function() { rebindGamepad() }
	},
	{
		name = function() { return gvLangObj["options-menu"]["language"] },
		func = function() { selectLanguage() }
	},
	{
		name = function() { return gvLangObj["options-menu"]["speedrun"] + ": " + (config.showigt ? gvLangObj["bool"]["on"] : gvLangObj["bool"]["off"]) },
		func = function() { config.showigt = !config.showigt}
	},
	{
		name = function() { return "Back" },
		func = function() { cursor = 0; menu = meMain; fileWrite("config.json", jsonWrite(config)) }
	}
]

::meDifficulty <- [
	{
		name = function() { return gvLangObj["difficulty-levels"]["easy"] },
		func = function() { game.difficulty = 0; cursor = 0; menu = meOptions }
	},
	{
		name = function() { return gvLangObj["difficulty-levels"]["normal"] },
		func = function() { game.difficulty = 1; cursor = 0; menu = meOptions }
	},
	{
		name = function() { return gvLangObj["difficulty-levels"]["hard"] },
		func = function() { game.difficulty = 2; cursor = 0; menu = meOptions }
	},
	{
		name = function() { return gvLangObj["difficulty-levels"]["super"] },
		func = function() { game.difficulty = 3; cursor = 0; menu = meOptions }
	}
]

::meLong <- [ //Just to test long menus
	{
		name = function() { return "A" },
		func = function() { print("A") }
	},
	{
		name = function() { return "B" },
		func = function() { print("B") }
	},
	{
		name = function() { return "C" },
		func = function() { print("C") }
	},
	{
		name = function() { return "D" },
		func = function() { print("D") }
	},
	{
		name = function() { return "E" },
		func = function() { print("E") }
	},
	{
		name = function() { return "F" },
		func = function() { print("F") }
	},
	{
		name = function() { return "G" },
		func = function() { print("G") }
	},
	{
		name = function() { return "H" },
		func = function() { print("H") }
	},
	{
		name = function() { return "I" },
		func = function() { print("I") }
	},
	{
		name = function() { return "J" },
		func = function() { print("J") }
	},
]