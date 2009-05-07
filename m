From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK (Re: LDP support)
Date: Thu, 7 May 2009 18:56:33 +0200
Message-ID: <DE514120-BF18-4DB7-9B0F-D17F495B75B2@student.utwente.nl>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk> <20090507162833.GZ5593@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6--732295408"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:27775 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760994AbZEGQ4j (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 12:56:39 -0400
Received: by fg-out-1718.google.com with SMTP id 16so314870fgg.17
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 09:56:39 -0700 (PDT)
In-Reply-To: <20090507162833.GZ5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap List <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6--732295408
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 7 mei 2009, om 18:28 heeft Tony Lindgren het volgende geschreven:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:19]:
>> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>>> Hi, Tony,
>>>
>>> Now the kernel can't boot on LDP. The attached file is the boot log.
>>
>> No boot log found.
>>
>> My master branch, based upon 2.6.29-rc3 boots fine on the LDP.
>>
>> Uncompressing  
>> Linux.............................................................
>> ............................................ done, booting the  
>> kernel.
>> Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version  
>> 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
>
> <snip snip>
>
>> omapfb: configured for panel ldp
>> omapfb: DISPC version 3.0 initialized
>> omapfb: Framebuffer initialized. Total vram 614400 planes 1
>> omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
>
> Can you see the penguin?

2.6.29 does this on my zoom:

http://www.flickr.com/photos/koenkooi/3406819626/

Boots into X and all :) That's with DSS1, not Tomi's DSS2. As I said  
earlier, the touchscreen is unusable.

regards,

Koen



--Apple-Mail-6--732295408
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKAxLEMkyGM64RGpERAkk8AKCW5VWogSmaQwW4YApxSpeY8k9qPACgpicF
CCe48H0PijYeBbCWm0pCEKo=
=BTrR
-----END PGP SIGNATURE-----

--Apple-Mail-6--732295408--
