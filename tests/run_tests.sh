source ../library/generate_site.sh
source assert_expectations.sh

source create_card_test.sh
source extract_field_test.sh
source generate_html_test.sh
source generate_types_html_test.sh
source generate_cards_test.sh
source generate_sidebar_test.sh
source generate_anchor_tag_test.sh
source capitalize_test.sh
source create_page_test.sh
source get_unique_types_test.sh
source filter_records_test.sh

function all_test_cases () {

    echo -e "\nextract_field"
    extract_field_test_cases

    echo -e "\ngenerate_html"
    generate_html_test_cases

    echo -e "\ngenerate_types_html"
    generate_types_html_test_cases
    
    echo -e "\ncapitalize"
    capitalize_test_cases

    echo -e "\ncreate_card"
    create_card_test_cases

    echo -e "\ngenerate_cards"
    generate_cards_test_cases
   
    echo -e "\ngenerate_anchor_tag"
    generate_anchor_tag_test_cases 

    echo -e "\ngenerate_sidebar"
    generate_sidebar_test_cases

    echo -e "\ncreate_page"
    create_page_test_cases

    echo -e "\nget_unique_types"
    get_unique_types_test_cases

    echo -e "\nfilter_records"
    filter_records_test_cases
}

function run_tests () {
    functions=(all extract_field generate_html generate_types_html capitalize create_card generate_cards generate_anchor_tag generate_sidebar create_page get_unique_types filter_records)

    PS3="select a function to test : "

    select FUNCTION in ${functions[@]}
    do
        echo -e "\n\n${FUNCTION}\n"
        ${FUNCTION}_test_cases
        break
    done
}


run_tests
generate_report
