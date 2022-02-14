source ../library/generate_site.sh
source assert_expectations.sh

function get_unique_types_test_cases () {
    local description="should give all unique types"
    local records="1|lucky|grass,flying
                   2|dileep|poison,ghost,flying"
    local expected="flying ghost grass poison"

    local actual="$( get_unique_types "$records" )"

    assert_expectation "$records" "$actual" "$expected" "$description"
}