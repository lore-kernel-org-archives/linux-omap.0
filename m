From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 20:46:12 +0100
Message-ID: <89DAA6D4-9105-480E-9884-B94DE28C2C61@student.utwente.nl>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <6ed0b2680811250859x179afb67l5cca390d3b1e4de1@mail.gmail.com> <26A46655-D823-4AE1-A058-79A769051398@student.utwente.nl> <200811251046.45693.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-21-227069944"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:49168 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751847AbYKYTqZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 14:46:25 -0500
In-Reply-To: <200811251046.45693.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-21-227069944
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
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

Does the backlight trigger hook into the backlight class? I really  
don't want to check all userspace code and ask upstream to add support  
for non backlight class methods. I did that in the 2.4 era and it's  
not fun. HAL takes some of the work out of it ("just write an .fdi"),  
but not all userspace hooks into hal.
Things like seperate backlight controls for each machine are the  
reason if refuse to support kernel 2.4, let's not repeat such a mess  
in 2.6.

regards,

Koen

>
>
> Of course, the packaging (led driver and trigger, vs. backlight
> control) can be independent of the controls that are exported.
>
> - Dave
>


--Apple-Mail-21-227069944
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLFYGMkyGM64RGpERAtdnAKCci3iqIuvqqcsRR7iZo68KajYPxwCfcYRN
DotU80XBGG40BHLUXjJioiA=
=AlXg
-----END PGP SIGNATURE-----

--Apple-Mail-21-227069944--
