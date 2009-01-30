From: Koen Kooi <koen@beagleboard.org>
Subject: Re: Beagle PM hangs
Date: Fri, 30 Jan 2009 22:34:17 +0100
Message-ID: <ABB3227E-1B40-47F0-BD79-FE974FDEF4CE@beagleboard.org>
References: <345163910901280814nb847b34pca50f4ee6e49929d@mail.gmail.com> <87zlhbqtrv.fsf@deeprootsystems.com> <87skn3qq6x.fsf@deeprootsystems.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--506496160"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f21.google.com ([209.85.219.21]:61963 "EHLO
	mail-ew0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbZA3VeZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 16:34:25 -0500
Received: by ewy14 with SMTP id 14so992494ewy.13
        for <linux-omap@vger.kernel.org>; Fri, 30 Jan 2009 13:34:23 -0800 (PST)
In-Reply-To: <87skn3qq6x.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--506496160
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 28 jan 2009, om 18:46 heeft Kevin Hilman het volgende geschreven:

> Kevin Hilman <khilman@deeprootsystems.com> writes:
>
>> Peter Reid <ppeter.reid@gmail.com> writes:
>>
>>> Hi Kevin,
>>>   I get hangs after boot on beagle with latest PM tree i have  
>>> quite a
>>> few scripts that run on boot.
>>>
>>>   have you seen this before?
>>
>> I have not, but I believe Koen has see something similar.  I've  
>> mainly
>> been testing just a minimal rootfs and a minimal set of drivers on
>> Beagle so I can hit full-chip off in idle.
>>
>> It would help if you could desribe your setup in more detail.  What
>> kernel config are you using, what rootfs are you using?  Does it hang
>> in the same spot every time?  If so, what is going on when it hangs?
>> Have you written anything to any of the /sys/power/* files?
>>
>
> Just a thought, do you still see these problems when using the CPUfreq
> performance governor instead of the ondemand governor?
>
> It could be pointing to some bugs in the switching of operating  
> points.

Speaking of operating points, is there a reason why cpufreq only goes  
to 550MHz? It's disappointing that omap3 gets marketed with "600MHz",  
but that TI won't let it run at that speed with their cpufreq drivers.

regards,

Koen


--Apple-Mail-1--506496160
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJg3JcMkyGM64RGpERArLTAKCCSoI5I9kWm75q3QVRQ4MmYH/9LQCeJ1bC
AS6dTimh+yNLLJq/GKh/+HM=
=YVUs
-----END PGP SIGNATURE-----

--Apple-Mail-1--506496160--
