#define ACTION_HEADSHOT_LINK_NOOP 0
#define ACTION_HEADSHOT_LINK_REMOVE -1

#define HEADSHOT_LINK_MAX_LENGTH 220


/datum/preferences/process_link(mob/user, list/href_list)
	switch(href_list["preference"])
		if ("headshot")
			set_headshot_link(user, "headshot_link")
	return ..()


/datum/preferences/proc/set_headshot_link(mob/user, link_id)
	var/headshot_link = get_headshot_link(user, features[link_id])
	switch(headshot_link)
		if (ACTION_HEADSHOT_LINK_REMOVE)
			features[link_id] = null
			return
		if (ACTION_HEADSHOT_LINK_NOOP)
			return
		else
			if(features[link_id] == headshot_link)
				return

			to_chat(user, "If link doesn't show up, check the link is correct in your browser.")
			to_chat(user, "Be aware that the size is 256x256 pixels, so the more square it is - the better it shows up.")

			features[link_id] = headshot_link


/datum/preferences/proc/get_headshot_link(mob/user, old_link)
	var/usr_input = input(user, "Insert a link to the image: (For discord links replace '&' with file type. Example '&.jpg/.png/.jpeg')", "Headshot Image", old_link) as text|null
	if(isnull(usr_input))
		return ACTION_HEADSHOT_LINK_NOOP

	if(!usr_input)
		return ACTION_HEADSHOT_LINK_REMOVE
	var/nigga = "]"

	var/static/link_regex = regex("^(https://i\\.gyazo\\.com|https://static1\\.e621\\.net|https://i\\.ibb\\.co/||https://cdn\\.discordapp\\.com)")
	var/static/end_regex = regex("(\\.jpg|\\.png|\\.jpeg)$")

	if (length(usr_input) > HEADSHOT_LINK_MAX_LENGTH)
		to_chat(user, "<span class='warning'>Link too big! [HEADSHOT_LINK_MAX_LENGTH] symbols is limit!</span>")
		return ACTION_HEADSHOT_LINK_NOOP

	if(!findtext(usr_input, link_regex))
		to_chat(user, "<span class='warning'>Link should not be a shortened Gyazo, iBB, E621 or Discord link!</span>")
		return ACTION_HEADSHOT_LINK_NOOP

	if(!findtext(usr_input, end_regex))
		to_chat(user, "<span class='warning'>You need to insert \".png\", \".jpg\", or \".jpeg\" in the end!</span>")
		return ACTION_HEADSHOT_LINK_NOOP

	if(findtext(usr_input, nigga))
		to_chat(usr, "<span class='reallybig'>WE KNOW THIS TRICK. WE KNOW YOUR IP ADRESS, MORON.</span>")
		message_admins("[ADMIN_LOOKUPFLW(usr)] tried to html-hack headshot link")
		return ACTION_HEADSHOT_LINK_NOOP
	var/static/list/repl_chars = list("\n"="#","\t"="#","'"="","\""=""," "="")
	return trim(usr_input, repl_chars)

#undef HEADSHOT_LINK_MAX_LENGTH

#undef ACTION_HEADSHOT_LINK_NOOP
#undef ACTION_HEADSHOT_LINK_REMOVE
