From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Configuring a TWL GPIO pin as an interrupt
Date: Sat, 21 Feb 2009 11:33:43 +0100
Message-ID: <58B26312-2687-4BF8-AE17-D4D0D5FAA136@student.utwente.nl>
References: <2C7D3DF36ADFFC479B44490D912B616705D6329B7D@dlee07.ent.ti.com> <20090221023924.GD6224@gandalf>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-10--792814210"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:33024 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753189AbZBUKd6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 21 Feb 2009 05:33:58 -0500
In-Reply-To: <20090221023924.GD6224@gandalf>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: me@felipebalbi.com
Cc: "Lopez Cruz, Misael" <x0052729@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-10--792814210
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 21 feb 2009, om 03:39 heeft Felipe Balbi het volgende geschreven:

> On Fri, Feb 20, 2009 at 08:27:54PM -0600, Lopez Cruz, Misael wrote:
>> Hi,
>>
>> I'm interested in bringing headset detection feature for audio. The  
>> detection is done through TWL GPIO_2. How can I configure a GPIO  
>> pin to generate an interrupt? Is there any API? Could you please  
>> point out another driver using that functionality so I can use as  
>> reference?
>
> gpio_request(GPIO_NUMBER, "Headset IRQ");
> gpio_direction_input(GPIO_NUMBER);
> request_irq(client->irq, lm8323_irq, flags | IRQF_SHARED,  
> DRIVER_NAME, dev);
>
> that should do it :-)

Don't forget to use the proper API for it: http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=blob;f=include/sound/jack.h;hb=master

regards,

Koen

--Apple-Mail-10--792814210
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJn9iJMkyGM64RGpERAqIbAKCb7oq7TJw3BYmuKeiQ3ZN7gTqmyACeK28G
KjS8Z9VF59aGrAH1FVTkKhQ=
=7hwZ
-----END PGP SIGNATURE-----

--Apple-Mail-10--792814210--
