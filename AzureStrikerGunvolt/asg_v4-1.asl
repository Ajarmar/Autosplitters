state("gv_win", "2020091700")
{
	int		loadingState	: 0xBC3C60, 0x0, 0x0, 0x0, 0x1E4;
	int		gameState	: 0xBC3C60, 0x0, 0x0, 0x0, 0x0, 0x4AC;
	float		igt		: 0x14EFF6C;
	int 		roomIndex	: 0xBDC558;
	int		gunvoltHP 	: 0x14DC054;
	int 		bossHP 		: 0x14F1778, 0x18, 0x2D8;
}

state("gv_win", "2020062200")
{
	int		loadingState	: 0xBBF550, 0x0, 0x0, 0x0, 0x1E4;
	int		gameState	: 0xBBF550, 0x0, 0x0, 0x0, 0x0, 0x4AC;
	float		igt		: 0x14EB85C;
	int 		roomIndex	: 0xBD7E48;
	int		gunvoltHP 	: 0x14D7944;
	int 		bossHP 		: 0x14ED068, 0x18, 0x2D8;
}

init
{
    if (modules.First().ModuleMemorySize == 0x15B2000)
    {
        version = "2020091700";
    }
    else if (modules.First().ModuleMemorySize == 0x15AE000)
    {
        version = "2020062200";
    }
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