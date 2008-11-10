From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [PATCH 02/03] OMAP3 PM: CPUFreq driver for OMAP3
Date: Mon, 10 Nov 2008 17:51:42 +0100
Message-ID: <E5AA89C2-5194-4FE8-872E-59BCA2D83AC0@student.utwente.nl>
References: <00c901c94327$ba6b0090$LocalHost@wipultra1382>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-7-1068083321"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.utsp.utwente.nl ([130.89.2.8]:44528 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262AbYKJQzb (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 10 Nov 2008 11:55:31 -0500
In-Reply-To: <00c901c94327$ba6b0090$LocalHost@wipultra1382>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Rajendra Nayak <rnayak@ti.com>
Cc: linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-7-1068083321
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 10 nov 2008, om 12:30 heeft Rajendra Nayak het volgende geschreven:
>
> +#elif defined(CONFIG_ARCH_OMAP3) && !defined(CONFIG_OMAP_PM_NONE)\
> +	&& defined(CONFIG_MACH_OMAP_3430SDP)

Could this be changed to machine_is_<foo>() so multi-omap kernels  
work? And if not, doesn't CONFIG_MACH_OMAP_3430SDP imply  
CONFIG_ARCH_OMAP3?

regards,

Koen

--Apple-Mail-7-1068083321
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJGGahMkyGM64RGpERApZrAJ942RgR577dztuamzmh/VAEDfoHnQCeMBDy
u2Wul+cohZhCJWSkFSY1+0E=
=lkEN
-----END PGP SIGNATURE-----

--Apple-Mail-7-1068083321--
