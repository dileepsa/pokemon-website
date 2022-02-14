source ../library/generate_site.sh
source assert_expectations.sh

function capitalize_test_cases () {
    local description="should capitalize the first letter of the word"
    local word="happy"
    local expected="Happy"

    local actual=$( capitalize "$word" )
    assert_expectation "$word" "$actual" "$expected" "$description"
}