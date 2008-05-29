From: "Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com>
Subject: Re: [PATCH] Driver for omap34xx temperature sensor. second version.
Date: Thu, 29 May 2008 15:42:22 +0300
Message-ID: <20080529124222.GJ5025@codecarver.research.nokia.com>
References: <20080519135629.GB5040@codecarver.research.nokia.com> <20080523104942.GB4976@codecarver.research.nokia.com> <B5748808-2B1B-4849-8324-844B4BF56F33@student.utwente.nl> <20080528231228.GB8013@atomide.com> <46EB7024-F979-48A9-AA23-5B33C4A85F85@student.utwente.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:37899 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751896AbYE2MnO (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 May 2008 08:43:14 -0400
Content-Disposition: inline
In-Reply-To: <46EB7024-F979-48A9-AA23-5B33C4A85F85@student.utwente.nl>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: ext Koen Kooi <k.kooi@student.utwente.nl>
Cc: linux-omap@vger.kernel.org

Hi,

>>> root@beagleboard:/sys/class/hwmon/hwmon0/device# cat temp1_input
>>> 96
>>>
>>> does anyone from TI have a hint if the chip is really that hot, or
>>> that we need to scale the value?
>>
>> Maybe it's in Fahrenheit?
>
> That was my first thought, but looking that the omap3530 TRM =20
> (spruf98.pdf) on page 836:
>
> ADC code  Temperature =B0C
>                     From    To
> 0                 -40         -40
> 32               -0.7        0.8
> 64                44.9      46.3
> 96                89.3      90.6
>
> And that maps to the adc_to_temp var at line 69 from http://source.mv=
ista.com/git/gitweb.cgi?p=3Dlinux-omap-2.6.git;a=3Dblob;f=3Ddrivers/hwm=
on/omap34xx_temp.c
> Even if it didn't map, the raw ADC value is  only =B16 =B0C off from =
the =20
> real temperature around that point. So the adc value the kernel reads=
 =20
> gets translated correctly to =B0C, so if we think it's incorrect, the=
 =20
> kernel might be reading the ADC wrong.
>

The driver basically does what's described in figure 7-16 of the
omap3430 TRM. Ie, rise SOC, wait until EOCZ rises, lower SOC, wait EOCZ
goes low, read result. The timeouts are taken directly from this figure=
=2E
So I can't really see what the driver would be doing wrong, unless
obviously the hardware doesn't work the way the TRM describes :)

Cheers,

Peter.
--=20
goa is a state of mind
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
