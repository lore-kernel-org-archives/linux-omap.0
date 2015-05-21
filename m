From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Fix native cs with new set_cs
Date: Thu, 21 May 2015 22:16:38 +0100
Message-ID: <20150521211638.GN21577@sirena.org.uk>
References: <1431452337-19280-1-git-send-email-mwelling@ieee.org>
 <20150512191758.GX3066@sirena.org.uk>
 <20150521020709.GA14258@deathray>
 <20150521101857.GR21577@sirena.org.uk>
 <20150521210411.GA5406@deathray>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tbBCmy51UvWhYeBI"
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150521210411.GA5406@deathray>
Sender: linux-next-owner@vger.kernel.org
To: Michael Welling <mwelling@ieee.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-next@vger.kernel.org, linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--tbBCmy51UvWhYeBI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 21, 2015 at 04:04:11PM -0500, Michael Welling wrote:

> Do you want to revert the patch and apply a new one or should I provide a
> patch that reverts the changes and fixes it all in one?

Can you please send me separate revert and re-add patches, that's
probably going to be easier to review.

--tbBCmy51UvWhYeBI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXks1AAoJECTWi3JdVIfQzQAH/23DnhxaJhVqDgMZffB2BTEd
4WX6M080N0glhqnBcwi98TCxK5f7DwCys+ULKS0XKOpQQjsXHKrCHrPtfx+KuemN
Q+Dw18RvSr6nRlK5ddLrcFrrzJ5hevjkpGixB5Ct5LDBpmV27ijLGwQ4s+kc7Igc
KP1PQFW/IjItHQmVe8cpLK0fm8MPBlhxMOFOglxKR+OM+fua+VqL+zQeRBVVAYo1
KrKcrLk4uMuhTrwrqjhkQc0rCIpBKrhl2sLIMfRzk5LAhFdx43ZVGv++kpX2MK5Y
ASqJQCJ7r79s8Drwq7QiFK373+lhvsCfr56qtUH0ojXp2GyNCnjAXUu7JKk+E0Y=
=BCIv
-----END PGP SIGNATURE-----

--tbBCmy51UvWhYeBI--
