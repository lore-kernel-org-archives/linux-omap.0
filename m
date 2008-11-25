From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 21:30:36 +0100
Message-ID: <2F17FBB3-1626-40FC-B9CE-C5C85C000B19@student.utwente.nl>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com> <26A46655-D823-4AE1-A058-79A769051398@student.utwente.nl> <200811251046.45693.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-41-229733288"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:42255 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751287AbYKYUdA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 15:33:00 -0500
In-Reply-To: <200811251046.45693.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>
Cc: David Brownell <david-b@pacbell.net>, Richard Purdie <rpurdie@rpsys.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-41-229733288
Content-Type: multipart/mixed; boundary=Apple-Mail-40-229733251


--Apple-Mail-40-229733251
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 nov 2008, om 19:46 heeft David Brownell het volgende geschreven:

> On Tuesday 25 November 2008, Koen Kooi wrote:
>> Regardless of what implementation you choose, it would be *great* if
>> people used the backlight class for things like backlights. /sys/ 
>> class/
>> backlight/<foo>/brightness is such a nice standard that lots and lots
>> of usespace tools rely on it.
>
> How about a standard LED driver (optionally with a brightness
> control) and the newish "backlight" trigger?


I googled a bit and poked Richard Purdie (CC'ed) and he says:
"Thats not what the trigger was supposed to be used for 
--Apple-Mail-40-229733251
Content-Disposition: inline;
	filename=Sad.png
Content-Type: image/png;
	x-unix-mode=0666;
	name="Sad.png"
Content-Transfer-Encoding: base64

iVBORw0KGgoAAAANSUhEUgAAABMAAAATCAYAAAByUDbMAAAACXBIWXMAAAsTAAALEwEAmpwYAAAE
F0lEQVQ4jW2US2xUdRTGf/9779yZzrS105khdrQPodKmtNGYFAoxPNTAiqAuSCQmLEyUFW4MCxfu
iAk7A5HECGJ0oQETxMSykKg8Yi2FNExbpCTTKZ1SOgWmnU7nTu/9P1xUGgTO7uTk+87Jd75zBM8I
13W7W5rifZ1t0Z5X1tmd6cZq6k4hXBjN6VvjU5XR3HRxwPf9G0/ixBN5esP69LvvbI/u/uRA005R
U4tTE8GyLaTn4y8u4pcqHPv+/u9nL3vnRm/NnAHyT5G50LVtS9v+00ebD4WSKaQdQ6ARwmAbiTAK
lEZLn+WSx8LMAh8eLn7x51D+a9/3RwDsRxO9saXtozPH1x4i1YISLoiVPkIYsMACjNYIY7BDgmi9
y45u0zcyGdHZO8UMULIBNqxP7z9/ou2wSLUwk33AHz+NMX59hrq4Q31jDIFBoJkcf8iFX/LczMwT
izmk0y5969TGSxl3tvCgdMVxXbf77e3R3aHGJBIYupDj7KlVGXhhbQJhARqGLs3+r9a8J04iEWLX
Rnf3P9nQb1ZLU7zv0IGmndqNYAnN4FgpsxToYjkw84NjpYwQBjBgWK0tBbo4OFbKYAw1Edj3Vvj1
9tbkVqujNbYBt2ZVbDD0T5fj56cXG8AgBNhag5aAoH+6HO+fLscBUBqjDbVRi9bna7qdV9utLica
QRiNxjzlFktL0BrMfxM+7iqlUVIRCRteTOp2J91YTQlhgVJYQmDVhe8e3Nu8YpeG8CxK9RitQCvq
E27x4N7mDBhSKaeipARtcG1FTShodPL3wwXpVXAiEbAEn3/WswthgdEAPSiF0QqU4tOPX95qlET7
y4jlZYKqj1GaiicoV8MLVibH7WDJW9FErYCQEiMVRkqMlKAkaIVRaoXID5C+REuFUpqFsmDmoZVz
xifLGX/RI1IbBaHBshAY5m4vUS74XD01s6pS774ksQZNQxOoQKGkAqOZm7eYLFQz9mIlCEKEOnu7
wy85IQFaM/HXAle+nObucJne91N07Kgj2eYy9MNDclerROpsahMSoxTFksWJX6sDF6/f+8rxff/G
2SveuQ/2LO5wQxqE4Oq3s/S+l6C1N4zQGq0UDWsE6c7nuDMsGf65TFNHGGME2RnB4E3T73nBgA0w
96Ccv5mPOtu62BQNC7rejFK/BrQMkMsKHUiUr9BBQF1C0b7ZxiAYyVoc+VF+MzA8cQwoPjr00tS9
Sn40F5GbO9gkkFhIlL+yCB0olNQYo8FAsWwzkhUcOS1PXr42eVxrPfr410ApVchOzY9dGgnfKxZV
rDnhNPu+QRiwhMarCubmBRPTFif7vb+/u6BODlzPHn1E9KznCEAoFHqtvTW5tS0d62lqkOti4aBx
0XPn7xatianC8mguP3vR84KBJ3H/At+dK4ToMHYCAAAAAElFTkSuQmCC

--Apple-Mail-40-229733251
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit


Anyone using /sys/class/leds for backlight functionality is doing it  
plain wrong"

The backlight trigger was added for supporting non-backlight leds that  
'need' to get turned on/off together with the backlight, not being the  
backlight itself.

There's a thread at [1] where Pavel Machek tries to make the same  
point. Having a led driver for the PWMs is neat, but please have the  
backlight one use the backlight class (e.g. KConfig option, runtime  
check, etc).
As I said in my other mail having 2 different ways to control  
backlights will be *hell* for distributions and userspace. Just look  
at the the trouble the serial port names are causing on ARM.

regards,

Koen
[1] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/threads.html#02359
--Apple-Mail-40-229733251--

--Apple-Mail-41-229733288
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLGBuMkyGM64RGpERAj2rAJwKa80Y25XMALYb8LjorNd5N5NCLwCeKzqf
SaXjho8tY2GYtxa2jvhCLw4=
=2rBR
-----END PGP SIGNATURE-----

--Apple-Mail-41-229733288--
