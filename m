From: Koen Kooi <koen@beagleboard.org>
Subject: Re: [PATCH] ARM: OMAP: board-omap3beagle: set i2c-3 to 100kHz
Date: Fri, 23 Jan 2009 11:48:38 +0100
Message-ID: <196A1830-3227-48D0-B3BE-C7D935601BF5@beagleboard.org>
References: <1232047837-23052-1-git-send-email-koen@openembedded.net> <A11F15D6-F171-4D62-ADB9-1508B57037E4@beagleboard.org> <200901230152.17239.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3-997448320"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f20.google.com ([209.85.219.20]:41153 "EHLO
	mail-ew0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753363AbZAWKss (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 23 Jan 2009 05:48:48 -0500
Received: by ewy13 with SMTP id 13so3383947ewy.13
        for <linux-omap@vger.kernel.org>; Fri, 23 Jan 2009 02:48:46 -0800 (PST)
In-Reply-To: <200901230152.17239.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Beagle Board <beagleboard@googlegroups.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3-997448320
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 jan 2009, om 10:52 heeft David Brownell het volgende geschreven:

> On Friday 23 January 2009, Koen Kooi wrote:
>>
>> Op 15 jan 2009, om 20:30 heeft Koen Kooi het volgende geschreven:
>>
>>> From: Koen Kooi <koen@beagleboard.org>
>>>
>>> Changing it to 100kHz is needed to make more devices works properly.
>>> Controlling the TI DLP Pico projector[1] doesn't work properly at
>>> 400kHz, 100kHz and lower work fine. EDID readout is unaffected by
>>> this change.
>>>
>>> [1] http://focus.ti.com/dlpdmd/docs/dlpdiscovery.tsp?sectionId=60&tabId=2234
>>>
>>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>>
>> Any comments on this patch?
>
> I2C-3 is only used for talking on DVI, right?
> Which means EDID ... and maybe DLP/Pico, unless
> someone uses it as an I2C adapter.  (Which some
> folk hack together on PCs...)
>
> Seems harmless to me, but I'd add a comment
> explaining why just 100 MHz.  (The Pico manual
> says 400 KHz should work.)

The updated manual will say 400kHz won't work, the TI DLP engineers  
were the ones that designed the pico that pointed the i2c speed  
problem out to me :)
I'd be happy to change the patch if needed, but I think the updated  
manual will take care of most issues.

regards,

Koen

>
>
> - Dave
>
>
>>
>> regards,
>>
>> Koen
>>
>>
>>
>>
>>>
>>> ---
>>> arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/ 
>>> mach-
>>> omap2/board-omap3beagle.c
>>> index fe97bab..f279404 100644
>>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>>> @@ -227,7 +227,7 @@ static int __init omap3_beagle_i2c_init(void)
>>> #ifdef CONFIG_I2C2_OMAP_BEAGLE
>>> 	omap_register_i2c_bus(2, 400, NULL, 0);
>>> #endif
>>> -	omap_register_i2c_bus(3, 400, NULL, 0);
>>> +	omap_register_i2c_bus(3, 100, NULL, 0);
>>> 	return 0;
>>> }
>>>
>>> -- 
>>> 1.5.6.3


--Apple-Mail-3-997448320
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJeaCIMkyGM64RGpERAq0EAJwKkYOmAlQGW9EFmUGdD/xErqQLUACfe7Ft
V7zvusapJTc+DFUEkAaTB3c=
=C0GH
-----END PGP SIGNATURE-----

--Apple-Mail-3-997448320--
