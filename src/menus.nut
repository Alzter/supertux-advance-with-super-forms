///////////
// MENUS //
///////////

::menu <- []
::cursor <- 0
::textMenu <- function(){
	//If no menu is loaded
	if(menu == []) return

	//Draw options
	for(local i = 0; i < menu.len(); i++) {
		if(cursor == i) drawText(font2, 144 -(menu[i].name().len() * 4), screenH() - 16 - (menu.len() * 14) + (i * 14), "> " + menu[i].name() + " <")
		else drawText(font2, 160 -(menu[i].name().len() * 4), screenH() - 16 - (menu.len() * 14) + (i * 14), menu[i].name())
	}

	//Keyboard input
	if(keyPress(k_down)) {
		cursor++
		if(cursor >= menu.len()) cursor = 0
	}

	if(keyPress(k_up)) {
		cursor--
		if(cursor < 0) cursor = menu.len() - 1
	}

	if(keyPress(config.key.jump) || keyPress(config.key.pause)) {
		menu[cursor].func()
	}
}

//Names are stored as functions because some need to change each time
//they're brought up again.
::meMain <- [
	{
		name = function() { return gvLangObj["main-menu"]["new"] },
		func = function() { startPlay("res/0-0.json") }
	},
	{
		name = function() { return gvLangObj["main-menu"]["load"] },
		func = function() { return }
	},
	{
		name = function() { return gvLangObj["main-menu"]["options"] },
		func = function() { cursor = 0; menu = meOptions }
	},
	{
		name = function() { return gvLangObj["main-menu"]["quit"] },
		func = function() { gvQuit = 1 }
	}
]

::meOptions <- [
	{
		name = function() { return "Difficulty: " + strDifficulty[config.difficulty] },
		func = function() { cursor = 0; menu = meDifficulty }

	},
	{
		name = function() { return "Controls" },
		func = function() {}
	},
	{
		name = function() { return "Back" },
		func = function() { cursor = 0; menu = meMain }
	}
]

::meDifficulty <- [
	{
		name = function() { return "Easy" },
		func = function() { config.difficulty = 0; cursor = 0; menu = meOptions }
	},
	{
		name = function() { return "Normal"; },
		func = function() { config.difficulty = 1; cursor = 0; menu = meOptions }
	},
	{
		name = function() { return "Hard"; },
		func = function() { config.difficulty = 2; cursor = 0; menu = meOptions }
	}
]


