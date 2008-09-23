From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] OMAP3EVM: TWL4030 Keypad irq error fix
Date: Tue, 23 Sep 2008 13:37:02 +0200
Message-ID: <102CAAD1-D554-4CAD-B26F-DBFB2C418E9A@student.utwente.nl>
References: <c656a4d20809192351x39f71fach7145236a9e8e0552@mail.gmail.com> <200809201022.49350.david-b@pacbell.net> <20080923110001.GL5102@atomide.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-26--950513231"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:58467 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750806AbYIWLhM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Sep 2008 07:37:12 -0400
Received: from [172.20.1.5] (vpn006015.vpn.utwente.nl [130.89.6.15])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8NBb4I2004172
          for <linux-omap@vger.kernel.org>; Tue, 23 Sep 2008 13:37:05 +0200
In-Reply-To: <20080923110001.GL5102@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-26--950513231
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 23 sep 2008, om 13:00 heeft Tony Lindgren het volgende geschreven:

> * David Brownell <david-b@pacbell.net> [080920 20:23]:
>> On Friday 19 September 2008, arun c wrote:
>>> without this the below error messages were coming continuously
>>>
>>> TWL4030 module irq 369 is disabled but can't be masked!
>>
>> I can see how it would fix that.  :)
>>
>> But this is also a good illustration of why this keypad device
>> should be initialized differently ... this particular data is
>> not board-specific, and the root cause of the problem was that
>> the device wasn't set up as part of twl4030 setup.
>>
>> The clean fix requires twl4030 to be a "new style" driver.
>> Fix not yet available. :(
>
> Pushing until we have a better fix.

But twl4030 now is a "new style" driver, so we have a start :)

regards,

Koen


>
>
> Tony
>
>>
>> - Dave
>>
>>
>>> Signed-off-by: Arun C <arunedarath@mistralsolutions.com>
>>> ---
>>> arch/arm/mach-omap2/board-omap3evm.c |    2 ++
>>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-omap2/board-omap3evm.c
>>> b/arch/arm/mach-omap2/board-omap3evm.c
>>> index 92f70ce..f9fd06b 100644
>>> --- a/arch/arm/mach-omap2/board-omap3evm.c
>>> +++ b/arch/arm/mach-omap2/board-omap3evm.c
>>> @@ -22,6 +22,7 @@
>>> #include <linux/input.h>
>>> #include <linux/spi/spi.h>
>>> #include <linux/spi/ads7846.h>
>>> +#include <linux/i2c/twl4030.h>
>>>
>>> #include <mach/hardware.h>
>>> #include <asm/mach-types.h>
>>> @@ -176,6 +177,7 @@ static struct omap_kp_platform_data  
>>> omap3evm_kp_data = {
>>> 	.keymap 	= omap3evm_keymap,
>>> 	.keymapsize	= ARRAY_SIZE(omap3evm_keymap),
>>> 	.rep		= 1,
>>> +	.irq		= TWL4030_MODIRQ_KEYPAD,
>>> };
>>>
>>> static struct platform_device omap3evm_kp_device = {
>>> -- 
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux- 
>> omap" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-26--950513231
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFI2NTgMkyGM64RGpERAstyAJ400QFaRpGJY91/uHynFfXl6/kWYACgn+Nh
IBZYGGscW0KsVtn78oaOOCk=
=G1ih
-----END PGP SIGNATURE-----

--Apple-Mail-26--950513231--
