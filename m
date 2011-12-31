From: Sebastian Reichel <sre@debian.org>
Subject: RX51 modem support
Date: Sat, 31 Dec 2011 22:24:06 +0100
Message-ID: <20111231212406.GA17188@earth.universe>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9jxsPFA5p3P2qPhR"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comu.ring0.de ([46.4.151.82]:49621 "EHLO smtp.ring0.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753071Ab1LaVYR (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 31 Dec 2011 16:24:17 -0500
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Carlos Chinea <carlos.chinea@nokia.com>
Cc: linux-omap@vger.kernel.org


--9jxsPFA5p3P2qPhR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Carlos,

The HSI framework is in linux-next and should go into 3.3 in the
next weeks. You wrote, that you will take care of SSI & rx51,
once the framework is in the kernel [0].

What's the current status of this? Will this work be ready
for 3.4?

[0] https://lkml.org/lkml/2011/6/8/42

-- Sebastian

--9jxsPFA5p3P2qPhR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBCAAGBQJO/312AAoJENju1/PIO/qaKMAP/1AO1Hn0Y8082s8CVtNmP8da
zxRxbCR6MlG2AdRWdcyEE+EslNqXQPfq0scI/rkM+fF/XAEufnUROCr0b3DVTDTT
w0kZqyBrM+En5ZuwQE6NmUUH+8M8imHMeM4gvu+C+OWdXqD7rK4i+rPEzt+1iM8E
z4YBqJ7IbmsQOaLvUwvIjdTvZna6kr3VBs67QtzNcQTucEwpE6wwgU0d3v/S1F+8
f3wtVzWduJVi1uRBKy7VCVXSK68Bi58koe2hidOXbmfpF0jlc1hzeqWUQorlDhK4
mjWjLErwWh1nl4n7VlzvyZt7p4p1jPidt2drtBFeubMUb/2LBCXJ/HTy9HWxHtLx
axCZgVDaYpz3Hec2fBHk5cW560W79ramHIA02+B8JCFDRD13biqxCLr1wvvYfS9k
IKfkgA3bM/DJsuCS02/AH2nBZA3dKSKm/9frFDRrPSJk0hUbpDsDf+OZbge/S+4G
rIwVFhcnV83RCay9i0TSgWgXxfhbYqGeVe8EXNyADney2NQDp7G5vrI7QXKpaDSC
116xWMEdxGmIFmtdrD43QpiPYgngqnsA0/hhmfSR2iZlxSvIOkA4Dk26TbP9nxNX
651w00lOCcgruiZZB5R6sbAaU5Fd2TFUSNxE8Eq3qLfhHuHc73ILfE0mb91NDExh
oyQm1psBOqXa+a8FAAhk
=yXwn
-----END PGP SIGNATURE-----

--9jxsPFA5p3P2qPhR--
