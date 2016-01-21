From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] regulator: ltc3589: make IRQ optional
Date: Thu, 21 Jan 2016 11:11:15 +0000
Message-ID: <20160121111115.GJ6588@sirena.org.uk>
References: <1453292992-1788-1-git-send-email-LW@KARO-electronics.de>
 <1453292992-1788-2-git-send-email-LW@KARO-electronics.de>
 <20160120164258.GF6588@sirena.org.uk>
 <20160121080524.27af489f@ipc1.ka-ro>
 <20160121102015.GI6588@sirena.org.uk>
 <20160121112611.34e17cb2@ipc1.ka-ro>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qb+6gLdVH5itmOEb"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160121112611.34e17cb2-VjFSrY7JcPWvSplVBqRQBQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW-bxm8fMRDkQLDiMYJYoSAnRvVK+yQ3ZXh@public.gmane.org>
Cc: =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org


--qb+6gLdVH5itmOEb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 21, 2016 at 11:26:11AM +0100, Lothar Wa=DFmann wrote:
> > On Thu, Jan 21, 2016 at 08:05:24AM +0100, Lothar Wa=DFmann wrote:
> > > > On Wed, Jan 20, 2016 at 01:29:51PM +0100, Lothar Wa=DFmann wrote:

> > > > > This pin is used as IRQ pin for the LTC3589 PMIC on the Ka-Ro
> > > > > electronics TX48 module. Make the IRQ optional in the driver and =
use a
> > > > > polling routine instead if no IRQ is specified in DT.
> > > > > Otherwise the driver will continuously generate interrupts and ma=
ke
> > > > > the system unusable.

> > > > How will the driver generate interrupts if there is no interrupt
> > > > physically present in the system?

> > > It's using timer interrupts to poll the LTC3589 state.

> > I know that is what your patch does, my question is why you say in your
> > commit log that "Otherwise the driver will continuously generate
> > interrupts and make the system unusable".

> Because the interrupt is level triggered and the polarity of the
> EXTINT pin is inverted, the interrupt will be constantly active when
> the IRQ pin of the LTC3589 is inactive.

So, to repeat my original question, how will that generate interrupts if
there is no interrupt physically present in the system?

--qb+6gLdVH5itmOEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoLzSAAoJECTWi3JdVIfQJWUH/0kdI/s2MwYDzQXwZm+kxQ1u
WeDpAM6O7jupQgg050TXcVq7aP4+0zl4tNEZT7/jB+eUDf3Xt6tNPgcIKcml7TyV
q3HXshTUGhTtg8qw6WzfFAv3f3QZNR0EX2RUQ8LcTGusJWalfBQHlpw/7dZr/ykY
jG8hanmJZMkuyVBnCJeqqu3zzwdQF09zRLyXdx5mahS2fisEx9zqcf2WCO3qt9su
jgTakmLvzVTdCcmdE6QxWIaR5tcTGtdWYu8xwuLrDUS8/I4BMJsj9/LHdhuHd8uN
ZgX36s8SEXA01yBDcBwG0rc33lsDBhlkXx88VW2SfM+KdU3laxfsdcqe+Rtvl8c=
=kI6C
-----END PGP SIGNATURE-----

--qb+6gLdVH5itmOEb--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
