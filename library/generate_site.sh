
function generate_html () {
  local tag=$1
  local class=$2
  local content=$3

  echo "<${tag} class=\"${class}\">${content}</${tag}>"
}

function extract_field () {
  local records=$1
  local field_number=$2

  local field_value=$( cut -f"${field_number}" -d"|" <<< "${records}" )
  echo "${field_value}"
}

function capitalize () {
  local word=$1

  local capitalized_word=$( tr '[:lower:]' '[:upper:]' <<< ${word:0:1} )${word:1}
  echo "${capitalized_word}"
}

function generate_types_html () {
  local types=($1)
  local capitalized_type types_html

  for type in ${types[*]}
  do
    capitalized_type=$( capitalize "${type}" )
    types_html+=$( generate_html "p" "${type}" "${capitalized_type}" )
  done

  echo "${types_html}"
}

function get_id () {
  local record=$1
  extract_field "${record}" 1
}

function get_name () {
  local record=$1
  extract_field "${record}" 2
}

function get_types () {
  local record=$1
  extract_field "${record}" 3 | tr "," " "
}

function get_speed () {
  local record=$1
  extract_field "${record}" 4
}

function get_hp () {
  local record=$1
  extract_field "${record}" 5
}

function get_xp () {
  local record=$1
  extract_field "${record}" 6
}

function get_attack () {
  local record=$1
  extract_field "${record}" 7
}

function get_defense () {
  local record=$1
  extract_field "${record}" 8
}

function get_weight () {
  local record=$1
  extract_field "${record}" 9
}

function create_card () {
  local record=$1
  local card_template=$2

  local id=$( get_id "${record}" )
  local name=$( get_name "${record}" ) 
  local header=$( capitalize "${name}" )
  local types=($( get_types "${record}" ))
  local speed=$( get_speed "${record}" )
  local hp=$( get_hp "${record}" )
  local xp=$( get_xp "${record}" )
  local attack=$( get_attack "${record}" )
  local defense=$( get_defense "${record}" )
  local weight=$( get_weight "${record}" )
  
  local types_html=$( generate_types_html "${types[*]}" )

  local card=$(
    sed "s:__ID__:${id}: ;
         s:__NAME__:${name}:g ;
         s:__HEADER__:${header}: ;
         s:__TYPES__:${types_html}: ;
         s:__SPEED__:${speed}: ;
         s:__HP__:${hp}: ;
         s:__XP__:${xp}: ;
         s:__ATTACK__:${attack}: ;
         s:__DEFENSE__:${defense}: ;
         s:__WEIGHT__:${weight}: " <<< "${card_template}" )

  echo "${card}"
}

function generate_cards () {
  local records=($1)
  local card_template=$2
  local cards

  for record in ${records[*]}
  do
    cards+=$( create_card "${record}" "${card_template}" )
  done

  echo  "${cards}"
}

function generate_anchor_tag () {
  local reference=$1
  local class=$2

  echo "<a href=\"${reference}.html\" class=\"${class}\">${reference}</a>"
}

function generate_sidebar () {
  local all_types=($1)
  local selected_type=$2

  for type in ${all_types[*]}
  do
    local li_class="" anchor_class=""
    if [[ "${selected_type}" == "${type}" ]]
    then
      anchor_class="selected"
      li_class="${type}"
    fi
    anchor=$( generate_anchor_tag "${type}" "${anchor_class}" )
    list+=$( generate_html "li" "${li_class}" "${anchor}" )
  done

  sidebar=$( generate_html "ul" "" "${list}" )
  echo "${sidebar}"
}

function create_page () {
  local webpage_template=$1
  local card_template=$2
  local records=($3)
  local types=($4)
  local selected_type=$5

  local sidebar=$( generate_sidebar "${types[*]}" "${selected_type}" )
  local cards=$( generate_cards "${records[*]}" "${card_template}" )

  cards=$( tr "\n" " " <<< ${cards} )

  local page=$( 
    sed "s:__SIDEBAR__:${sidebar}: ;
         s:__CARDS__:${cards}:" <<< "${webpage_template}" )

  echo "${page}"
}

function get_unique_types () {
  local records=$1

  local all_types=$( extract_field "${records}" "3" )
  local unique_types=(`tr "," "\n" <<< "${all_types}" | sort | uniq`)
  
  echo "${unique_types[*]}"
}

function filter_records () {
  local records=$1
  local type=$2

  if [[ "${type}" == "all" ]]
  then
    echo "${records}"
    return
  fi

  local filtered_records=$( grep "^.*|.*|.*${type}.*|.*" <<< "${records}" )
  echo "${filtered_records}"
}

function generate_site () {
  local webpage_template=$1
  local card_template=$2
  local records=$3
  local html_path=$4
  local pokemons_of_type page
  
  local all_types=(all $( get_unique_types "${records}" ))
  
  for type in ${all_types[*]}
  do
    pokemons_of_type=$( filter_records "${records}" "${type}" )
    echo "creating ${type}.html"
    time page=$( create_page "${webpage_template}" "${card_template}" "${pokemons_of_type}" "${all_types[*]}" "${type}" )
    echo "${page}" > "${html_path}/${type}.html"
  done
}

function main () {
  local webpage_template=`cat templates/webpage_template.html`
  local card_template=`cat templates/card_template.html`
  local pokemons=`tail +2 resources/data/sample_pokemon.csv`
  local html_path="html"
  
  rm -rf "${html_path}" 2> /dev/null
  mkdir -p "${html_path}" 
  cp -r resources/{css,images} ${html_path}
  
  generate_site "${webpage_template}" "${card_template}" "${pokemons}" "${html_path}"
}