From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: OMAP [TV] video
Date: Wed, 11 Feb 2009 14:04:20 +0100
Message-ID: <34415E2D-6B94-4849-9A76-EE6AFF5EC5D1@student.utwente.nl>
References: <19F8576C6E063C45BE387C64729E739403FA81B912@dbde02.ent.ti.com> <4992C3C1.50709@mlbassoc.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-6-499706563"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mx2.utsp.utwente.nl ([130.89.2.13]:51102 "EHLO mx.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751789AbZBKNFE (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 11 Feb 2009 08:05:04 -0500
In-Reply-To: <4992C3C1.50709@mlbassoc.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Gary Thomas <gary@mlbassoc.com>
Cc: "Hiremath, Vaibhav" <hvaibhav@ti.com>, Linux OMAP <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-6-499706563
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 11 feb 2009, om 13:25 heeft Gary Thomas het volgende geschreven:

> Hiremath, Vaibhav wrote:
>>
>> Thanks,
>> Vaibhav Hiremath
>>> -----Original Message-----
>>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>>> owner@vger.kernel.org] On Behalf Of Gary Thomas
>>> Sent: Tuesday, February 10, 2009 9:35 PM
>>> To: Linux OMAP
>>> Subject: OMAP [TV] video
>>>
>>> I'm trying to get TV [S-Video] working on my 3530 board.
>>> The settings in the current kernel don't seem to work very
>>> well on my TV (U.S. NTSC, standard).  Comparing the video
>>> encoder setup with the suggested values in the manual, I
>>> find many differences, mostly with respect to the framing
>>> (signal shaping).
>>>
>>> Questions:
>>> * Are the settings in the kernel tree known to work [as is]?
>>> * Why the divergence from the recommended values?
>>>
>>> Any ideas or helpful pointers would be graciously accepted
>>>
>> [Hiremath, Vaibhav] Can you provide some more details like,
>>
>> Which kernel version are you using?
>
> I started with the "official" OMAP tree (git://git.omapzoom.org/repo/ 
> omapkernel.git)
>
> If there is a better starting point, I'd certainly like to know.

The right one is at http://git.kernel.org/?p=linux/kernel/git/tmlind/linux-omap-2.6.git;a=shortlog

regards,

Koen


--Apple-Mail-6-499706563
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJkszWMkyGM64RGpERAjmhAKCsJy7/WERLa2KUM4M+fTqg/mj5EACfVpOn
b6BP1hMcW7V1BQx26Ipia4c=
=4jeI
-----END PGP SIGNATURE-----

--Apple-Mail-6-499706563--
