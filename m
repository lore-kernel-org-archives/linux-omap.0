From: Mark Brown <broonie@kernel.org>
Subject: Re: OMAP 4430 SDP: rather sick with recent kernels
Date: Thu, 18 Dec 2014 11:49:49 +0000
Message-ID: <20141218114949.GY11764@sirena.org.uk>
References: <20141217095252.GH11502@n2100.arm.linux.org.uk>
 <20141217172333.GE23854@atomide.com>
 <20141217185155.GI11502@n2100.arm.linux.org.uk>
 <5491F0B6.4090904@ti.com>
 <20141218101618.GJ11502@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BDxzPORWdYZ2c9Sq"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:35514 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751378AbaLRLuK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 18 Dec 2014 06:50:10 -0500
Content-Disposition: inline
In-Reply-To: <20141218101618.GJ11502@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jyri Sarha <jsarha@ti.com>, Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Peter Rosin <peda@axentia.se>


--BDxzPORWdYZ2c9Sq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 18, 2014 at 10:16:18AM +0000, Russell King - ARM Linux wrote:

> So that doesn't work - but importantly, it does point towards a
> possible culpret - snd_soc_of_parse_audio_routing().

> This is obvious when you stop and think about what it's doing, this is
> truely where this bug lies, and it /is/ in generic ASoC code.

> The problem is that this function doesn't consider the implications of
> deferred probing.  Let's see what happens if we defer, and re-do the
> ABE initialisation, including calling this function:

Right, spot on - I'll send a revert for that upstream.  Thanks for
tracking this down.

--BDxzPORWdYZ2c9Sq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUkr9dAAoJECTWi3JdVIfQK6EH/1ZzDeYWBfQa/gCWLqa3LfFn
0gwKO5pRHYljKadGmETSemucOCwYlhs92Iq3g1v7VlHfI4T43fN0ZfVJ8F8vJNdV
aYCUVDBgTh78wvnRUy9ttQA6veNkWN7cN+9jGc/zQA9WlUGeA5Yqf+D6YqDFoNh9
F3EflWWYXfQGq8pQrHHaVPQIIDbfTYM7qyCw/N8GYtjyom29oDpRujh3WcAEU735
1o0Kl6l8cNd+zkl9IuqZPAm6n33ELentj39Ghq+ewjNDeLneJfWo1TnbZYQI00Qi
P75hewdinxV4kyqkOkc4jy5KSdemroE2AyGGITgNp4diBCTnKwHvH3LD+I7DHSk=
=Gd66
-----END PGP SIGNATURE-----

--BDxzPORWdYZ2c9Sq--
