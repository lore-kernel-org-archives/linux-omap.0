From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 22:37:31 +0100
Message-ID: <6E06CC71-AE33-4482-8E14-3FABD4BFE552@student.utwente.nl>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251206.54848.david-b@pacbell.net> <612C6524-68F3-43C0-A127-4531F6B9B58F@student.utwente.nl> <200811251326.36259.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-44-233748597"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:38418 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754035AbYKYVhp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 16:37:45 -0500
In-Reply-To: <200811251326.36259.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-44-233748597
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 nov 2008, om 22:26 heeft David Brownell het volgende geschreven:

> On Tuesday 25 November 2008, Koen Kooi wrote:
>>
>> Op 25 nov 2008, om 21:06 heeft David Brownell het volgende  
>> geschreven:
>>
>>> On Tuesday 25 November 2008, Koen Kooi wrote:
>>>>>
>>>>> How about a standard LED driver (optionally with a brightness
>>>>> control) and the newish "backlight" trigger?
>>>>
>>>> Does the backlight trigger hook into the backlight class?
>>>
>>> It doesn't seem to call backlight_device_register(), though
>>> I don't know why not.  It just looks like it hooks into the
>>> same notification events the backlight class does.
>
> Re "why not" ... partial answer:  because it doesn't have
> a way to associate itself with the panel whose backlight
> it's supplying.  Seems like that should be solvable.

Most userspace doesn't support more than one panel, it takes the first  
entry that has a 'brightness' node. Fragile, but valid for almost all  
current devices. Things like the BUG with an option for 2 LCD panels  
will break that assumption, but lets cross that bridge when we get  
there.

>>> If you think that's trouble, it would probably be a good
>>> thing to bring that up with the author of that new trigger
>>> code (drivers/leds/ledtrig-backlight.c) ... it's very new,
>>> and I'd expect such userspace interface goofs still ought
>>> to be fixable.
>>
>> Our mails on this subject crossed eachother :)
>>
>> Short recap: the backlight trigger is usefull for turnign on/off e.g.
>> status leds at the same the the backlight goes on/off, but shouldn't
>> be (ab)used for backlight control.
>
> That's not what its Kconfig description says.  So I think
> that if you care about this, you should raise the issue
> with someone more involved.

 From a conversation earlier tonight:

Koen: Maybe the doc entry of the triggers needs a warning :)
Richard Purdie: Yes, we probably need to try and stop this before it  
starts...

So the led tree will warn against improper use of the backlight  
trigger soon :)

regards,

Koen

>> Mark Brown in that thread [1] does raise an interesting use-case,
>
> i.e [2] ... a simpler situation than we have with TWL4030,
> where we have LED signals supporting
>
> - real LEDs
>
>    * simple leds that don't really need PWM brightness
>      controls:  Beagle LEDB == pmu_stat
>
>    * backlights which probably *do* want PWM controls:  on
>      those two EVMs, LEDA == backlight, using more of its
>      peak 160 mA current draw
>
>  - general GPIO usage, where PWM capability "must not"
>    kick in:  Beagle LEDA == nEN_USB_PWR
>
> His comment focussed on the two "real LEDs" cases.
>
>
>> since we are in the same boat. A solution is needed, but I guess the
>> wolfson people can work it out :)
>
> Or maybe the Pandora people.  ;)
>
> If they're using the LEDA or LEDB PWMs, providing and exporting
> a brightness control would be easy.  If they're using the other
> two PWMs, it'd be more work.
>
> - Dave
>
>
>> [1] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/threads.html#02359
>>
>
> [2] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/msg02610.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-44-233748597
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLHAeMkyGM64RGpERAjUNAJ4sBQw/oVyUJwslC4KROgGFlK4REgCgislP
keDsB3vI6asGYUppL+sMcC0=
=HXX6
-----END PGP SIGNATURE-----

--Apple-Mail-44-233748597--
