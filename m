From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: PWM drivers for TWL4030
Date: Tue, 25 Nov 2008 21:36:06 +0100
Message-ID: <612C6524-68F3-43C0-A127-4531F6B9B58F@student.utwente.nl>
References: <6ed0b2680811250857p59195e4dh7dab4e1109769b0c@mail.gmail.com> <200811251046.45693.david-b@pacbell.net> <89DAA6D4-9105-480E-9884-B94DE28C2C61@student.utwente.nl> <200811251206.54848.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-42-230063507"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:42446 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751928AbYKYUg2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 25 Nov 2008 15:36:28 -0500
In-Reply-To: <200811251206.54848.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-42-230063507
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 25 nov 2008, om 21:06 heeft David Brownell het volgende geschreven:

> On Tuesday 25 November 2008, Koen Kooi wrote:
>>>
>>> How about a standard LED driver (optionally with a brightness
>>> control) and the newish "backlight" trigger?
>>
>> Does the backlight trigger hook into the backlight class?
>
> It doesn't seem to call backlight_device_register(), though
> I don't know why not.  It just looks like it hooks into the
> same notification events the backlight class does.
>
> If you think that's trouble, it would probably be a good
> thing to bring that up with the author of that new trigger
> code (drivers/leds/ledtrig-backlight.c) ... it's very new,
> and I'd expect such userspace interface goofs still ought
> to be fixable.

Our mails on this subject crossed eachother :)

Short recap: the backlight trigger is usefull for turnign on/off e.g.  
status leds at the same the the backlight goes on/off, but shouldn't  
be (ab)used for backlight control.
Mark Brown in that thread [1] does raise an interesting use-case,  
since we are in the same boat. A solution is needed, but I guess the  
wolfson people can work it out :)

[1] http://linux.derkeiler.com/Mailing-Lists/Kernel/2008-10/threads.html#02359

--Apple-Mail-42-230063507
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJLGG4MkyGM64RGpERAo/wAKCvtp10mmgrqByCZkynR4dKipyG6QCgoOdZ
J0OKsw27C7XkLyVeoufRWfg=
=Dx0G
-----END PGP SIGNATURE-----

--Apple-Mail-42-230063507--
