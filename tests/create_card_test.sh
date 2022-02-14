source ../library/generate_site.sh
source assert_expectations.sh

function create_card_test_cases () {
  local description="should create card for given details"
  local records="1|bulbasaur|grass,poison|45|45|64|49|49|69"
  local card_template=`cat card_template.html`
  local expected=`cat expected/create_card`

  local actual=$( create_card "$records" "$card_template" )
  assert_expectation "$records card_template" "$actual" "$expected" "$description"
 }

# create_card_test_cases
# generate_report