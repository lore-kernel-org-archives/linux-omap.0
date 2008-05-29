From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor. second version.
Date: Thu, 29 May 2008 09:22:07 +0200
Message-ID: <46EB7024-F979-48A9-AA23-5B33C4A85F85@student.utwente.nl>
References: <20080519135629.GB5040@codecarver.research.nokia.com> <20080523104942.GB4976@codecarver.research.nokia.com> <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl> <20080528231228.GB8013@atomide.com>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:37862 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751288AbYE2HWT convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 03:22:19 -0400
Received: from [172.20.1.5] (vpn006023.vpn.utwente.nl [130.89.6.23])
          by smtp.utwente.nl (8.12.10/SuSE Linux 0.7) with ESMTP id m4T7MAcW012865
          for <linux-omap@vger.kernel.org>; Thu, 29 May 2008 09:22:10 +0200
In-Reply-To: <20080528231228.GB8013@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Op 29 mei 2008, om 01:12 heeft Tony Lindgren het volgende geschreven:

> * Koen Kooi <k.kooi@student.utwente.nl> [080528 16:08]:
>>
>> Op 23 mei 2008, om 12:49 heeft Peter 'p2' De Schrijver het volgende
>> geschreven:
>>
>>> Hi,
>>>
>>> This patch adds a hwmon driver for the OMAP34xx internal temperatur=
e
>>> sensor. I get unusually high values (80 degrees and more) from this
>>> sensor though.
>>
>> Same high values here as well:
>>
>> root@beagleboard:/sys/class/hwmon/hwmon0/device# cat temp1_input
>> 96
>>
>> does anyone from TI have a hint if the chip is really that hot, or
>> that we need to scale the value?
>
> Maybe it's in Fahrenheit?

That was my first thought, but looking that the omap3530 TRM =20
(spruf98.pdf) on page 836:

ADC code  Temperature =B0C
                     From    To
0                 -40         -40
32               -0.7        0.8
64                44.9      46.3
96                89.3      90.6

And that maps to the adc_to_temp var at line 69 from http://source.mvis=
ta.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dblob;f=3Ddrivers/hwmon=
/omap34xx_temp.c
Even if it didn't map, the raw ADC value is  only =B16 =B0C off from th=
e =20
real temperature around that point. So the adc value the kernel reads =20
gets translated correctly to =B0C, so if we think it's incorrect, the =20
kernel might be reading the ADC wrong.

regards,

Koen


>
>
> Tony
>

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFIPlmiMkyGM64RGpERAgfsAJ9H6kOLLP3T4Nlt03UwmwXMsl4lBQCfcJVz
j8wEOY13ggcCsXY4rU7FOuA=3D
=3D//co
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
