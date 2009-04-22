From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: lcd rotation in omapfb_main.c
Date: Wed, 22 Apr 2009 15:32:48 +0200
Message-ID: <23F7BF92-6752-4E9C-9020-FA35D76F4263@student.utwente.nl>
References: <dbdb2ea60904211518o2539b4e1y80750587bebc30a1@mail.gmail.com> <200904220029.30297.marek.vasut@gmail.com> <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-106963777"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:38209 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751246AbZDVO0g (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Apr 2009 10:26:36 -0400
In-Reply-To: <dbdb2ea60904220539y61bc6dadgb895c4122f892b24@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: twebb <taliaferro62@gmail.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4-106963777
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 22 apr 2009, om 14:39 heeft twebb het volgende geschreven:

> On Tue, Apr 21, 2009 at 6:29 PM, Marek Vasut <marek.vasut@gmail.com>  
> wrote:
>> On Wednesday 22 of April 2009 00:18:54 twebb wrote:
>>> I'm trying to start up the LCD panel on a new omap35xx-based  
>>> platform
>>> in portrait mode, though the native orientation of the display is
>>> landscape.  I'm running linux-2.6.27-omap1.  However, when I change
>>> "def_rotate" to 90 in omapfb_main.c, it doesn't seem to make any
>>> difference in the orientation of the display.  Any ideas why this
>>> might be happening?  Could there be outstanding fixes/patches I  
>>> need?
>>
>> change it to 1 or something ... btw. this should be configurable  
>> through some
>> platform_data. Also, dont bring up new platform on deprecated kernel.
>>>
>
> Since when is linux-omap v2.6.27-omap1 deprecated?

It got deprecated when 2.6.28 was released

>  It's only 5 months
> old!  Am I missing something here?

Yes, it seems you have missed the release of 2.6.28 and 2.6.29.

regards,

Koen

--Apple-Mail-4-106963777
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJ7xyDMkyGM64RGpERAtCvAKCr62zxqgCHOaSTH4vuNGWVLUWtNgCeJ0i7
pjsHPxW4EswzSgjrcU4hsNY=
=23Vu
-----END PGP SIGNATURE-----

--Apple-Mail-4-106963777--
