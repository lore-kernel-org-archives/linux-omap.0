From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [ANNOUNCE] updated PM branch
Date: Thu, 18 Dec 2008 10:15:50 +0100
Message-ID: <A6D1DEDA-DBA9-44A6-A879-F26A5C44D3B1@student.utwente.nl>
References: <87k5a098zd.fsf@deeprootsystems.com> <87myeu1whz.fsf@deeprootsystems.com> <764864D8-4A22-44B9-ABF2-42664AC6583D@student.utwente.nl> <494990DC.5080407@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-12-28963393"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:57568 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751364AbYLRJQF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 18 Dec 2008 04:16:05 -0500
In-Reply-To: <494990DC.5080407@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-12-28963393
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 18 dec 2008, om 00:53 heeft Kevin Hilman het volgende geschreven:

> Koen Kooi wrote:
>> Op 17 dec 2008, om 19:34 heeft Kevin Hilman het volgende geschreven:
>>> Kevin Hilman <khilman@deeprootsystems.com> writes:
>>>
>>>> The PM branch has been consolidated and rebased against today's
>>>> linux-omap HEAD.  I've also included a few patches that were  
>>>> posted to
>>>> the list that had fallen through the cracks.
>>>
>>> I did a couple minor updates to to the pm branch, and rebased it to
>>> current HEAD.  The updates include
>>>
>>> - more patch consolidation
>>> - VDD2 patch from Rajendra
>>> - updated IVA2 reset patch which actually works :)
>>> - included the GPTIMER12 fixes for Beagle
>>>
>>> I also tested on Beagle.  Here are some results when using a minimal
>>> defconfig (attached) and using an initramfs.  I had to disable MMC  
>>> and
>>> USB as they are currently preventing the low-level chip retention:
>>>
>>> I tested this on the latest PM branch of linux-omap:
>>>
>>> - boot idle: 342 mA
>>>
>>> - screen blank: 238 mA
>>> # echo 3 > /sys/class/graphics/fb0/blank
>>>
>>> - suspend: 85 mA
>>> # echo 1 > /sys/power/clocks_off_while_idle
>>> # echo mem > /sys/power/state
>>>
>>> - sleep-while-idle: 85 mA
>>> - this same state as suspend, but happens in idle
>>> # echo 1 > /sys/power/sleep_while_idle
>>>
>>> This is with current PM branch of linux-omap.  I understand that
>>> Tomi's new DSS tree has support to turn off the DVI framer which
>>> should save even more power, but I have not tested that.
>> Try toggling GPIO 170 manually, current consumption should drop  
>> with 60-80mA.
>
> That didn't seem to change anything for me.
>
> Looking closer, drivers/video/omap/lcd_omap3beagle.c is already  
> toggling
> GPIO 170 in current linux-omap.

Ah, so I did a better job with copy/pasting together the lcd driver  
than I thought :)

>  So the ~80mA drop above between 'boot idle' and 'screen blank' is  
> probably already counting the DVI framer.

I suspected  the 80mA drop was a bit much for just putting the DSS  
system into sleep, hence my gpio suggestion :) Thanks for confirming it.

regards,

Koen

>
>
> Kevin
>


--Apple-Mail-12-28963393
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJShTIMkyGM64RGpERApLsAJ9Xs3RSKO114dCocfxsLIS2n2ipDACffmYo
rBsBUdXO8S+vNHxacTP0ULQ=
=0Rma
-----END PGP SIGNATURE-----

--Apple-Mail-12-28963393--
