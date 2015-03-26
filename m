From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-evm: drop un-necessary remove function
Date: Thu, 26 Mar 2015 10:02:45 -0700
Message-ID: <20150326170245.GU3572@sirena.org.uk>
References: <1427377105-29044-1-git-send-email-jsarha@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oP9at/Ymg5VWhwKB"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:40180 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbCZRCS (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 Mar 2015 13:02:18 -0400
Content-Disposition: inline
In-Reply-To: <1427377105-29044-1-git-send-email-jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, Manish Badarkhe <manishvb@ti.com>


--oP9at/Ymg5VWhwKB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2015 at 03:38:25PM +0200, Jyri Sarha wrote:
> From: Manish Badarkhe <manishvb@ti.com>
>=20
> As davinci card gets registered using 'devm_' api
> there is no need to unregister the card in 'remove'
> function.
> Hence drop the 'remove' function.

Not only that but the current remove function creates a double free.
Applied, thanks.

--oP9at/Ymg5VWhwKB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVFDu0AAoJECTWi3JdVIfQ6l8H/2gFwM+v4yH0XNDakBA+LX4X
vg30j/rqvY2Pw5+VipbwNj4WCSu1EhPcAT77y+Lk7rzZ2v/NPTdh4fGItpJ4DLgi
dNUgM14SZKuNp6LClLIJiflri+xN5qZkhTHzy5ErXGDNM5jpw4UGqSK9nPfmFDqr
Fbnf+otYn/4H1c4RT15gm8HdeIP2qUxzP4+4nSyjW8nWIBi6nA6tmunzaROQiMbq
AnfD5+nA6/da42iMKMn6UprwRPPYfFvTyqrLlgtNMBuYiUH2lWEKTlT9aK+0o+LQ
3RzvFv1RTkRPnzgrPx+SXbzU9EoSCuNwJKRGIrFtmHRAI4iOtfjk9uhrUSbmWrk=
=dImL
-----END PGP SIGNATURE-----

--oP9at/Ymg5VWhwKB--
