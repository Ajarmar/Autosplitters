state("gv_win")
{
	int		loadingState	: 0xBB89F8, 0x0, 0x0, 0x0, 0x1E4;
	int		gameState	: 0xBB89F8, 0x0, 0x0, 0x0, 0x0, 0x4AC;
	float		igt		: 0x14E4CF4;
	int 		roomIndex	: 0xBD12F0;
	int		gunvoltHP 	: 0x14D0DEC;
	int 		bossHP 		: 0x14E6500, 0x18, 0x2D8;
}

init
{
	refreshRate = 30;
	vars.newGame = true;
	vars.scoreScreen = false;
}

update
{
	if (current.gameState == 22 && current.loadingState == 22)
	{
		vars.newGame = true;
	}
	
	if (!vars.newGame && current.gameState == 11 && current.loadingState != 2)
	{
		vars.scoreScreen = true;
	}
}
	
start
{
	var result = vars.newGame && current.loadingState == 12;
	if (result)
	{
		vars.newGame = false;
		vars.scoreScreen = false;
	}
	
	return result;
}

isLoading
{
	return current.loadingState == 2 || old.igt == current.igt;
}

reset
{
	return current.gameState == 22 && current.loadingState == 22;
}

split
{
	var result = vars.scoreScreen && old.loadingState != 2 && current.loadingState == 2;
	if (result)
	{
		vars.scoreScreen = false;
	}
	else
	{
		result = current.roomIndex == 38 && old.igt == current.igt && old.loadingState == 12 && current.loadingState == 12 && old.bossHP == 0 && current.bossHP == 0 && current.gunvoltHP != 0;
	}
	
	return result;
}