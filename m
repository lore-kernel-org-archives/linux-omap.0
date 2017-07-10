From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCH 1/2] regulator: cpcap: Fix standby mode
Date: Mon, 10 Jul 2017 15:45:10 +0200
Message-ID: <20170710134510.v3xvkvdjqxkyz5n5@earth>
References: <20170707200813.20371-1-sebastian.reichel@collabora.co.uk>
 <20170707200813.20371-2-sebastian.reichel@collabora.co.uk>
 <20170710122345.i7q2z7sbjhsthn5g@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xp3v5mrxdxivecwd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170710122345.i7q2z7sbjhsthn5g@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--xp3v5mrxdxivecwd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 10, 2017 at 01:23:45PM +0100, Mark Brown wrote:
> On Fri, Jul 07, 2017 at 10:08:12PM +0200, Sebastian Reichel wrote:
>=20
> > While working on the audio-codec I noticed, that the
> > low power mode of the regulators are not properly
> > supported. This fixes the issue for vaudio.
>=20
> In what way is it not properly supported and how does this change ensure
> that it is properly supported?
>=20
> > +static unsigned int cpcap_map_mode(unsigned int mode)
> > +{
> > +	switch (mode) {
> > +	case CPCAP_BIT_AUDIO_LOW_PWR:
> > +		return REGULATOR_MODE_STANDBY;
> > +	default:
> > +		return REGULATOR_MODE_NORMAL;
> > +	}
> > +}
>=20
> This function is being added but is never referenced AFAICT, it should
> either be removed or used.

You probably skipped over the patch to fast, it is referenced in the
patch section before the one adding the function:

+               .of_map_mode =3D cpcap_map_mode,                          \

> If it is being used it should be changed so that it doesn't accept
> the default case but instead accepts only specific values so that
> the mapping of modes to regulator modes stays 1:1, unknown modes
> should error out.

Fair point.

-- Sebastian

--xp3v5mrxdxivecwd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlljhOYACgkQ2O7X88g7
+pr6Dw//YoJpHZKnuJGDOgj3m9u4rFz9IoA3HfOMfGDDK5NpdclHEIlAXxdWPvgZ
absjAYJ1csMOvbq9UVI282mfZwjAv2PPRNhGL368WW1GX5EFeOfmd6H+p5G0VNTK
9Z9EVFHL2xXXzE5uF4gR3SC34DcgPZrnX0Dyv/gvDCrkNP8PRSF+IB7WAxYilKtQ
Wjsam7uvcSrvuvS/f82n0tKZuuRnFMrg6kSiPkb0EYcvHw3QbmyBhiTjo7fR1uRC
2FlJat6vP3LqzTANOOyBdd28XHaNbYsFL8ppX/Fqk5iq5TCkqHLddqOc9v8sLpbG
QqDXsKy+ufuZNd1rMaDmfecOHRu2fGkfJ0WcLYMl8an7sXm77RgmTxFGA7xq7iK7
rYsfD+AgoHo7WfDq6q3O66rWsr8Lb+96askgf1lfyHJ9q+LApPSIsCuBiEmjlJQm
FaYmaL7732TGpSVk3q7dv4tYr9TSqmTGBivvR8GWCokGu+QuGujvaj5asTxovsDc
o0X8N8XIkgOjV9MUpRHmcf28pztrj3Ry38RIbBr1u68+c6F8DxpWH305ES1EnOrg
qEvHodHNQZ6mr3NRyDlosKJzSuxW/bI8tjhJk1nZC7TzA+XOu3IX+412eQ6vA8y9
HMHSVDDODUdtAbRqF0M//qKfiUSDhAmLiE25EEvxi2RefQKu6z4=
=7E8D
-----END PGP SIGNATURE-----

--xp3v5mrxdxivecwd--
