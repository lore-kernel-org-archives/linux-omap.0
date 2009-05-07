From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH] OMAP_LDP: Support LCD display as a FB device on ZOOM MDK (Re: LDP support)
Date: Thu, 7 May 2009 20:45:46 +0200
Message-ID: <B8B58CDF-6F13-45AA-804D-9FA8E3608464@dominion.thruhere.net>
References: <20090428220712.GF29277@n2100.arm.linux.org.uk> <20090428224237.GT22457@atomide.com> <20090505195231.GB8004@n2100.arm.linux.org.uk> <20090506040015.GM5593@atomide.com> <20090506224917.GS5593@atomide.com> <4A02F7CF.1050803@windriver.com> <20090507161936.GA26106@n2100.arm.linux.org.uk> <20090507162833.GZ5593@atomide.com> <DE514120-BF18-4DB7-9B0F-D17F495B75B2@student.utwente.nl> <20090507171857.GC5593@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--725741955"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:49855 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZEGSpw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 May 2009 14:45:52 -0400
Received: by fxm2 with SMTP id 2so971717fxm.37
        for <linux-omap@vger.kernel.org>; Thu, 07 May 2009 11:45:51 -0700 (PDT)
In-Reply-To: <20090507171857.GC5593@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap List <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--725741955
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 7 mei 2009, om 19:18 heeft Tony Lindgren het volgende geschreven:

> * Koen Kooi <koen@dominion.thruhere.net> [090507 09:57]:
>>
>> Op 7 mei 2009, om 18:28 heeft Tony Lindgren het volgende geschreven:
>>
>>> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090507 09:19]:
>>>> On Thu, May 07, 2009 at 11:01:35PM +0800, stanley.miao wrote:
>>>>> Hi, Tony,
>>>>>
>>>>> Now the kernel can't boot on LDP. The attached file is the boot  
>>>>> log.
>>>>
>>>> No boot log found.
>>>>
>>>> My master branch, based upon 2.6.29-rc3 boots fine on the LDP.
>>>>
>>>> Uncompressing
>>>> Linux.............................................................
>>>> ............................................ done, booting the
>>>> kernel.
>>>> Linux version 2.6.29-rc3 (rmk@dyn-67.arm.linux.org.uk) (gcc version
>>>> 4.3.2 (GCC)) #125 Mon Feb 2 22:22:54 GMT 2009
>>>
>>> <snip snip>
>>>
>>>> omapfb: configured for panel ldp
>>>> omapfb: DISPC version 3.0 initialized
>>>> omapfb: Framebuffer initialized. Total vram 614400 planes 1
>>>> omapfb: Pixclock 32000 kHz hfreq 60.3 kHz vfreq 93.7 Hz
>>>
>>> Can you see the penguin?
>>
>> 2.6.29 does this on my zoom:
>>
>> http://www.flickr.com/photos/koenkooi/3406819626/
>>
>> Boots into X and all :) That's with DSS1, not Tomi's DSS2. As I said
>> earlier, the touchscreen is unusable.
>
> Good to hear. What patches do you have applied?

None relating to DSS1, the rest are DSS2 patches (not enabled in  
defconfig), musb patches, etc.

> What exactly is wrong with the touchscreen?

It seems to have a reduced resolution with lots of noise, tslib is  
unable to calibrate it to a usable state. It might be the mcspi  
problem the evm had (has?) all over again, haven't looked into that.

> Got any patches for that?

none, sorry.

regards,

Koen

>
> Regards,
>
> Tony


--Apple-Mail-1--725741955
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFKAyxcMkyGM64RGpERAtYvAJ4miVd1TgOKvQj4oepvrU73WCurKQCffdBn
agDATQ/1tPdhcOFK7jL9fV8=
=3BM3
-----END PGP SIGNATURE-----

--Apple-Mail-1--725741955--
