Config.passages.nobr = true;

Config.navigation.override = function (passage) {
	if (State.variables.genance >= 100) {
		return "Fin_Police";
	}
};
