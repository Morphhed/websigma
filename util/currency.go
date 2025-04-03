package util

const (
	USD = "USD"
	EUR = "EUR"
	CAD = "CAD"
	IDR = "IDR"
)

func IsSupporttedCurrency(currency string) bool {
	switch currency {
	case USD, EUR, CAD, IDR:
		return true
	}
	return false
}
