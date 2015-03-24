From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3] ASoC: davinci-mcasp: Set rule constraints if implicit
 BCLK divider is used
Date: Tue, 24 Mar 2015 10:19:57 -0700
Message-ID: <20150324171957.GT17265@sirena.org.uk>
References: <1426851068-26366-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:59345 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756029AbbCXRTa (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Mar 2015 13:19:30 -0400
Content-Disposition: inline
In-Reply-To: <1426851068-26366-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, lars@metafoo.de


--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 20, 2015 at 01:31:08PM +0200, Jyri Sarha wrote:
> Set rule constraints to allow only combinations of sample-rate,
> sample-format, and channels counts that can be played/captured with
> reasonable sample-rate accuracy.

Applied, thanks.

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEZy8AAoJECTWi3JdVIfQi7cH/0yBlDDmMdZWrwBrLH3wX1fC
8hqo3K8uf/IIdZYbCoztK+XqVlh2KUuQ5eb5HF8I7cahOk1HpZbkDn3oGMpNUd/8
Teh1Q6O5H1NR8NIVlzuLLVZJOuqvGv8FWINjKfalL9Wg/yjY6iqt0M5361a4GPhI
89P/0OzzvBr0yqro9mouY2AgT404frROW1PtOSLyaJ4nEN6rD79HZDL6TEMXw6Yh
G4QeUXU7P+657x5MIz2T2DHWzJGMmLb7IxKIzpFG47nKlUXjBZuo6GnYrpFyiBOG
yXmpITbVNpasvbpnkyLspu/Ascl6vrBRoJtEzkXKYCw0CQKpH+4a1zSn6CO+pbU=
=lqtu
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--
