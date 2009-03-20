From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: mmc0 detection timing at kernel startup, linux-omap-2.6.27-omap1
Date: Fri, 20 Mar 2009 14:44:56 +0100
Message-ID: <C8CB7D0E-5690-4368-B2BB-60B09B37575D@student.utwente.nl>
References: <dbdb2ea60903200606y51d3fba0ia5c116a3c452c21a@mail.gmail.com> <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-1--596024462"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:36536 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753921AbZCTNpd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 20 Mar 2009 09:45:33 -0400
In-Reply-To: <1f11a5490903200634y57f91639r3aad815aa2ce5e92@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ashwin Bihari <abihari@gmail.com>
Cc: twebb <taliaferro62@gmail.com>, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-1--596024462
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 20 mrt 2009, om 14:34 heeft Ashwin Bihari het volgende geschreven:

> You need to add the Kernel option "rootdelay=1" to basically delay the
> Kernel for a moment while attempting to using the SDcard as the RFS
> mount point.

Since kernel 2.6.24 you can use 'rootwait', which will wait till it  
becomes available so you don't need to keep futzing the value for  
different SD cards.

regards,

Koen

--Apple-Mail-1--596024462
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: Dit deel van het bericht is digitaal ondertekend
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJw53aMkyGM64RGpERAobrAKC3RVYHohI2v1YLVT5kRR/Y5OipiwCbB7dX
rTwh/dQgS72NH+J6r/AROBU=
=WZ3M
-----END PGP SIGNATURE-----

--Apple-Mail-1--596024462--
