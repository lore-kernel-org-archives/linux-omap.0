From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Load triton2 scripts.
Date: Thu, 11 Sep 2008 10:26:20 +0200
Message-ID: <22BCE749-790A-4FA2-AD24-F57C431D9A3D@student.utwente.nl>
References: <1219660277-27178-1-git-send-email-ext-kalle.jokiniemi@nokia.com> <20080911000843.GZ21163@atomide.com> <5e088bd90809102020m6eec5a1er4ee5850cb4ce0e72@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2-148728198"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx1.utsp.utwente.nl ([130.89.2.12]:52691 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753879AbYIKI1H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 11 Sep 2008 04:27:07 -0400
Received: from [172.20.1.5] (vpn006012.vpn.utwente.nl [130.89.6.12])
          by mx.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m8B8QMDf029525
          for <linux-omap@vger.kernel.org>; Thu, 11 Sep 2008 10:26:22 +0200
In-Reply-To: <5e088bd90809102020m6eec5a1er4ee5850cb4ce0e72@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2-148728198
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 11 sep 2008, om 05:20 heeft Steve Sakoman het volgende geschreven:

> On Wed, Sep 10, 2008 at 5:08 PM, Tony Lindgren <tony@atomide.com>  
> wrote:
>> * Kalle Jokiniemi <ext-kalle.jokiniemi@nokia.com> [080825 03:28]:
>>> From: ext Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
>>>
>>> This patch loads the triton2 (twl4030) with scripts that will cut  
>>> off VDD1
>>> and VDD2 voltages when SYS_OFF_MODE signal is set.
>>
>> Pushing today. I guess we should remove the CONFIG_DISABLE_HFCLK at
>> some point?
>
> This patch causes a build error due to a missing define:
>
> |   CC      drivers/i2c/chips/twl4030-power.o
> | drivers/i2c/chips/twl4030-power.c:152: error: 'RES_TYPE_R7'
> undeclared here (not in a function)

Same here:

make[3]: Entering directory `/OE/angstrom-dev/work/beagleboard- 
angstrom-linux-gnueabi/linux-omap-2.6.26+2.6.27- 
rc6+r1+gite9e9988a4ded6acee1d5387debb39f006f4c11a3-r1/git'
   CC      drivers/i2c/chips/twl4030-power.o
drivers/i2c/chips/twl4030-power.c:152: error: 'RES_TYPE_R7' undeclared  
here (not in a function)
drivers/i2c/chips/twl4030-power.c: In function  
'config_sleep_wake_sequence':
drivers/i2c/chips/twl4030-power.c:215: warning: unused variable 'data'
drivers/i2c/chips/twl4030-power.c: In function  
'config_warmreset_sequence':
drivers/i2c/chips/twl4030-power.c:275: error: 't2_wrst_seq' undeclared  
(first use in this function)
drivers/i2c/chips/twl4030-power.c:275: error: (Each undeclared  
identifier is reported only once
drivers/i2c/chips/twl4030-power.c:275: error: for each function it  
appears in.)
drivers/i2c/chips/twl4030-power.c:275: error: invalid operands to  
binary /
drivers/i2c/chips/twl4030-power.c:284: error: invalid operands to  
binary /
drivers/i2c/chips/twl4030-power.c:284: warning: passing argument 3 of  
'twl4030_write_script' makes integer from pointer without a cast
make[3]: *** [drivers/i2c/chips/twl4030-power.o] Error 1

regards,

Koen




>
>
>
> Steve
> --
> To unsubscribe from this list: send the line "unsubscribe linux- 
> omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--Apple-Mail-2-148728198
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIyNYuMkyGM64RGpERAo1wAKCn0xCh+6gqYLZdI4J4dn8oJWJ4MQCeK2al
AxZf77jt++QDNgL7gH8529c=
=GTMf
-----END PGP SIGNATURE-----

--Apple-Mail-2-148728198--
