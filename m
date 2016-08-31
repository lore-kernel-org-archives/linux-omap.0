From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Applied "mfd: tps65218: add version check to the PMIC probe" to
 the regulator tree
Date: Wed, 31 Aug 2016 12:41:05 +0100
Message-ID: <20160831114105.GH3950@sirena.org.uk>
References: <1466412218-5906-8-git-send-email-j-keerthy@ti.com>
 <E1bXZjd-0000YR-7n@debutante>
 <20160831083114.GP10121@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="F55Y67F01HNW3AgB"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160831083114.GP10121@dell>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Tero Kristo <t-kristo-l0cyMroinI0@public.gmane.org>, Dave Gerlach <d-gerlach-l0cyMroinI0@public.gmane.org>, Keerthy <j-keerthy-l0cyMroinI0@public.gmane.org>, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, russ.dill-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--F55Y67F01HNW3AgB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 31, 2016 at 09:31:14AM +0100, Lee Jones wrote:
> On Wed, 10 Aug 2016, Mark Brown wrote:

> > The patch

> >    mfd: tps65218: add version check to the PMIC probe

> Why did you take this patch?

You acked it, that's saying that you're OK with the patch and are
expecting someone else to apply it.

> I now have a merge conflict.

> Did you provide a pull-request that I can use to resolve?

The following changes since commit 29b4817d4018df78086157ea3a55c1d9424a7cfc:

  Linux 4.8-rc1 (2016-08-07 18:18:00 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/tps65218-ver-check

for you to fetch changes up to f11fa1796a4b4f8c6d4ced37e8824276ec57057d:

  mfd: tps65218: add version check to the PMIC probe (2016-08-10 18:21:55 +0100)

----------------------------------------------------------------
mfd: tps65218: Add hardware version check

This will be used for quirks by some function drivers.

----------------------------------------------------------------
Tero Kristo (1):
      mfd: tps65218: add version check to the PMIC probe

 drivers/mfd/tps65218.c       | 9 +++++++++
 include/linux/mfd/tps65218.h | 1 +
 2 files changed, 10 insertions(+)

--F55Y67F01HNW3AgB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCAAGBQJXxsJQAAoJECTWi3JdVIfQRwQH/RskRyRnUv2DC5rjX8Yvb00E
jZkGbzxRsj6jlGrMnzSgZrTGPjc1l+DgRkfHdUSKYivsM1hoKYDHO3cAonGwf42E
XSf+WCKyXMY25U+76uTYwGe90+PnQJlwEw8qBUIIXg0WsIqnNfmI5uN9D/rLzo98
Ffc7U2beQFyPQEG+0qXHflB+SomaXc01fZNLOXVHl0FDVIx1AEiAciaTfc8Dp7yJ
qxJHJ7q0QHzw4ZD6zUDYIqQBCmrcxTGtThrtZnLwWAfE4lSoINsDyXgrI2trudmD
zZiHPRHLdMXDNco+DNPgwUUbQGy+JFVEuF81e27k+m5e1D2ZjWOjU7uMcHdICaA=
=vgbh
-----END PGP SIGNATURE-----

--F55Y67F01HNW3AgB--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
