From: Koen Kooi <k.kooi@student.utwente.nl>
Subject: Re: [REVIEW  PATCH 8/9] DSS: support for Beagle Board
Date: Thu, 6 Nov 2008 09:30:51 +0100
Message-ID: <3833079A-AA89-423E-9A23-DC00EA26DC03@student.utwente.nl>
References: <20081104160946.19071.44903.stgit@tubuntu> <20081104161038.19071.98198.stgit@tubuntu> <20081105122725.cb1c0b2f.jarkko.nikula@nokia.com> <200811051521.48924.david-b@pacbell.net> <1225959787.8052.27.camel@tubuntu>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-16-692431776"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp2.utsp.utwente.nl ([130.89.2.9]:54885 "EHLO smtp.utwente.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753260AbYKFIbX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 6 Nov 2008 03:31:23 -0500
In-Reply-To: <1225959787.8052.27.camel@tubuntu>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: ext David Brownell <david-b@pacbell.net>, linux-fbdev-devel@lists.sourceforge.net, linux-omap@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-16-692431776
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit


Op 6 nov 2008, om 09:23 heeft Tomi Valkeinen het volgende geschreven:
>
> However, the bootloader turns the DVI chip on (at least the default
> beagle board u-boot).

Only the old and broken TI u-boots do that, recent ones (2008.10) with  
the patches that are going upstream don't touch the DVI chip (nor the  
audio chips for that matter.

regards,

Koen

--Apple-Mail-16-692431776
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)

iD8DBQFJEqs9MkyGM64RGpERAt2LAJ4yutXFMC12wwQfXaScA48MmmD3YgCggcOC
7NpxoskE7eyIwgOW4RtvCJ8=
=zflr
-----END PGP SIGNATURE-----

--Apple-Mail-16-692431776--
