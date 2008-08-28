From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: Enabling MUSB support
Date: Thu, 28 Aug 2008 09:58:00 +0200
Message-ID: <21722675-22F7-43A5-83A6-B426B092CC89@student.utwente.nl>
References: <1f11a5490808270626t5b4aa599i18b730d12a6c4667@mail.gmail.com> <20080827133825.GC7354@gandalf.research.nokia.com> <200808272354.28531.david-b@pacbell.net>
Mime-Version: 1.0 (Apple Message framework v926)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-3--1062571364"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:57079 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751615AbYH1H6M (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Aug 2008 03:58:12 -0400
In-Reply-To: <200808272354.28531.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-3--1062571364
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 28 aug 2008, om 08:54 heeft David Brownell het volgende geschreven:
> p.s. FWIW my beagle identifies itself as 3430 ES2.2
>     not as 3530.

You sadly can't detect the cpu revision in software (es2.2 doesn't  
exist for 3530 afaik), see the threads on linux-omap about adding that  
info to KConfig.

regards,

Koen

--Apple-Mail-3--1062571364
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFItlqKMkyGM64RGpERArkzAJ4tN/Chs8ePpPm7UbkjJYdanQR0GQCdHszX
h1Q6MCApimZJ5czkRebvTd0=
=fGAD
-----END PGP SIGNATURE-----

--Apple-Mail-3--1062571364--
