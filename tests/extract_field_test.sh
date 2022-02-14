source ../library/generate_site.sh
source assert_expectations.sh

function extract_field_test_cases () {
    local description="should extract specified field"
    local details="2|bulbasaur"
    local field_number=2
    local delimiter="|"
    local expected="bulbasaur"

    local actual=$(extract_field "$details" "$field_number" "$delimiter")
    assert_expectation "$details $field_number $delimiter" "$actual" "$expected" "$description"
}
