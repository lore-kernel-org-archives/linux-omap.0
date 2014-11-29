From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7.1 00/19] Rework OMAP4+ HDMI audio support
Date: Sat, 29 Nov 2014 11:59:57 +0000
Message-ID: <20141129115957.GE7712@sirena.org.uk>
References: <cover.1415803064.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E9xT1P6Q9DbJSWaX"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:43160 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751477AbaK2MAF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 29 Nov 2014 07:00:05 -0500
Content-Disposition: inline
In-Reply-To: <cover.1415803064.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, tomi.valkeinen@ti.com


--E9xT1P6Q9DbJSWaX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 04:40:51PM +0200, Jyri Sarha wrote:
> The patches are based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git for-next
>=20
> The base, the patches, and couple of additional not-to-be-merged
> omap2plus_defconfig patches can be found here:
> https://github.com/jsarha/linux.git omap-hdmi-audio

I guess I'm OK with these so

Reviewed-by: Mark Brown <broonie@kernel.org>

but like I said in reply to the patch adding the new driver I think
we're going to want to generalize this a bit.

--E9xT1P6Q9DbJSWaX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUebU8AAoJECTWi3JdVIfQ78IH/2AdWVLRYBvFDrw9S/whhca+
B79+Nh36/btjkb8YuAtjFnd+VjQtEbkSSHLa5sZ3Y0R/LSu3bmHsslRtJs+m3RVG
ds041/+3sbIkJtTxrcYHJEVhOxUDbT9poKtIE8Tkh2/1ZERrzSY2qgTFNVu2SMYM
MAskTD81ns/DKZb7vv+5VbQqyA8sbWMckBdpdYK3ssKPGt+d0yQ+4XJ9J73oxljd
3TudKYFRfP/TyFgdHeTu/W4dB+GjYmaFTo5X9mtYP47t53N1QoGYQw/6rTkuTlW9
Jq4fCTN4sG//mvluThUnT5HuIdBjydP/lPjUI83ysibxjQen7ECUKGwwl5oLrw8=
=6fpC
-----END PGP SIGNATURE-----

--E9xT1P6Q9DbJSWaX--
