From: Mark Brown <broonie@kernel.org>
Subject: Re: LDP: next-20150402: twl4030 regression?
Date: Mon, 6 Apr 2015 14:45:41 +0100
Message-ID: <20150406134541.GE6023@sirena.org.uk>
References: <5522886D.5050409@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2+IiqX0tbFQDLF7Q"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:51955 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753252AbbDFNqD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Apr 2015 09:46:03 -0400
Content-Disposition: inline
In-Reply-To: <5522886D.5050409@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org


--2+IiqX0tbFQDLF7Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 06, 2015 at 08:21:49AM -0500, Nishanth Menon wrote:

> https://github.com/nmenon/kernel-test-logs/blob/next-20150401/omap2plus_defconfig/ldp.txt
> looks clean, but

> https://github.com/nmenon/kernel-test-logs/blob/next-20150402/omap2plus_defconfig/ldp.txt#L488
> seems to have picked up a regression in the regulator driver.

Please provide actual bug reports if you're trying to report something -
at least a description of the problem you're seeing and some attempt at
analysis.  For example say what the test was, and if there's logs paste
the relevant section into the e-mail.  Just randomly pasting a couple of
web links in and saying "there's a problem" isn't helpful.

Please also CC people responsible for relevant drivers and systems.

--2+IiqX0tbFQDLF7Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIo4EAAoJECTWi3JdVIfQ14QH/RMKCL4jytOqnN75UccFfRk4
q95ImRCDVfuqu8dLRn1ZrjBTFbza8EWhM19YUUjRyei5dBYYROvnS2XhhKZGNUyG
dJmhAtb7TjNBk+fH8m37xCJ8BoylPFipmUY9YnKNBy+E3pbHVWKk7fQHcEuwth3F
EaIWubrkqwO6HpZq4xswL7EgenOA6Isy1EUzjmwd4VewScW83F2zqUoMHLAGd/FM
VKJHI4z2fmoi0T/qa6084CsuIKjVtg7Wn/W1PitYf/c/UBk414159wHLHeeDaK9w
Y2C8PFnZj0tg4Mv39ZUoAqhGo0kFiCodbI4B0+9CuHJnCC776ViQxNDLyY4JH74=
=Wd74
-----END PGP SIGNATURE-----

--2+IiqX0tbFQDLF7Q--
