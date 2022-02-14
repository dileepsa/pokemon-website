source ../library/generate_site.sh
source assert_expectations.sh

function test_generate_sidebar_with_single_type () {
    local description="should generate sidebar for single type"
    local all_types=(all)
    local selected_type="all"
    local expected="<ul class=\"\"><li class=\"all\"><a href=\"all.html\" class=\"selected\">all</a></li></ul>"

    local actual=$(generate_sidebar "${all_types[@]}" "$selected_type")

    assert_expectation "$all_types" "$actual" "$expected" "$description"
}

function test_generate_sidebar_with_multiple_types () {
    local description="should generate sidebar for multiple types"
    local all_types=(all bug)
    local selected_type="bug"
    local expected="<ul class=\"\"><li class=\"\"><a href=\"all.html\" class=\"\">all</a></li><li class=\"bug\"><a href=\"bug.html\" class=\"selected\">bug</a></li></ul>"

    local actual=$(generate_sidebar "${all_types[*]}" "$selected_type")

    assert_expectation "$all_types" "$actual" "$expected" "$description"
}
function generate_sidebar_test_cases () {
    test_generate_sidebar_with_single_type
    test_generate_sidebar_with_multiple_types
}
