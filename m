From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 1/2] Add support for GPIO LEDs on pandora
Date: Thu, 8 Jan 2009 15:56:07 +0100
Message-ID: <03538FC0-A9B7-4770-B799-6730E9F09899@student.utwente.nl>
References: <1227780163-5879-1-git-send-email-notasas@gmail.com> <20090108143232.GO27566@atomide.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4--283703209"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:57569 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751932AbZAHO40 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Jan 2009 09:56:26 -0500
In-Reply-To: <20090108143232.GO27566@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Grazvydas Ignotas <notasas@gmail.com>, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Richard Purdie <rpurdie@rpsys.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4--283703209
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 8 jan 2009, om 15:32 heeft Tony Lindgren het volgende geschreven:

> * Grazvydas Ignotas <notasas@gmail.com> [081127 12:04]:
>> Pandora has some LEDs and backlights connected to OMAP
>> GPIOs and TWL4030/TPS65950 LED/PWM signals. This patch
>> registers them all with leds-gpio driver. TWL4030/TPS65950
>> controlled ones will be switched to PWM driver when it's ready.
>
> Pushing to l-o tree and adding to omap3-upstream queue for next
> merge window. Not adding the defconfig changes to upstream queue
> right now as the patch does not apply.
>>
>> +		.name			= "pandora::lcd_bl",
>> +		.default_trigger	= "backlight",
>> +		.gpio			= -EINVAL,
>>

That's a wrong usage of the 'backlight' trigger, which shouldn't get  
into mainline since it sets a bad example. The backlight trigger is  
meant to sync leds with the backlight (e.g. dim keypad leds), not to  
make leds a backlight.

regards,

Koen

--Apple-Mail-4--283703209
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJZhQIMkyGM64RGpERAuQXAJ0XnvQbuA0dcvZTDu60gNw/QYKpzACgmG+a
8lrmD1rNx4atENuhQFpPT9g=
=xfUy
-----END PGP SIGNATURE-----

--Apple-Mail-4--283703209--
