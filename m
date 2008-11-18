From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor. second version.
Date: Tue, 18 Nov 2008 18:26:25 +0100
Message-ID: <3C99D441-8493-4394-A69F-3D56D33A613B@student.utwente.nl>
References: <20080519135629.GB5040@codecarver.research.nokia.com> <20080523104942.GB4976@codecarver.research.nokia.com> <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl> <20080528231228.GB8013@atomide.com> <46EB7024-F979-48A9-AA23-5B33C4A85F85@student.utwente.nl> <20080529124222.GJ5025@codecarver.research.nokia.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-2--386117161"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:42173 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752692AbYKRR0j (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 18 Nov 2008 12:26:39 -0500
In-Reply-To: <20080529124222.GJ5025@codecarver.research.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-2--386117161
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable


Op 29 mei 2008, om 14:42 heeft Peter 'p2' De Schrijver het volgende =20
geschreven:

> Hi,
>
>>>> root@beagleboard:/sys/class/hwmon/hwmon0/device# cat temp1_input
>>>> 96
>>>>
>>>> does anyone from TI have a hint if the chip is really that hot, or
>>>> that we need to scale the value?
>>>
>>> Maybe it's in Fahrenheit?
>>
>> That was my first thought, but looking that the omap3530 TRM
>> (spruf98.pdf) on page 836:
>>
>> ADC code  Temperature =B0C
>>                    =46rom    To
>> 0                 -40         -40
>> 32               -0.7        0.8
>> 64                44.9      46.3
>> 96                89.3      90.6
>>
>> And that maps to the adc_to_temp var at line 69 from =
http://source.mvista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dblob;f=3D=
drivers/hwmon/omap34xx_temp.c
>> Even if it didn't map, the raw ADC value is  only =B16 =B0C off from =
the
>> real temperature around that point. So the adc value the kernel reads
>> gets translated correctly to =B0C, so if we think it's incorrect, the
>> kernel might be reading the ADC wrong.
>>
>
> The driver basically does what's described in figure 7-16 of the
> omap3430 TRM. Ie, rise SOC, wait until EOCZ rises, lower SOC, wait =20
> EOCZ
> goes low, read result. The timeouts are taken directly from this =20
> figure.
> So I can't really see what the driver would be doing wrong, unless
> obviously the hardware doesn't work the way the TRM describes :)

Some interesting observations:

root@beagleboard:~# cat /sys/devices/platform/omap34xx_temp/temp1_input
45
root@omap3evm:~# cat /sys/devices/platform/omap34xx_temp/temp1_input
80

The beagle is using an ES3.0 omap3, the evm an ES2.1 omap3, so I =20
suspect something got fixed in between :)

regards,

Koen=

--Apple-Mail-2--386117161
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJIvrDMkyGM64RGpERArZ9AKClAAhkqNYkXAeVfZTWvtm8NumPRQCfRv9+
7FB0A1AS09K2lVc0Q+taUgA=
=sScw
-----END PGP SIGNATURE-----

--Apple-Mail-2--386117161--
