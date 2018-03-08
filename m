From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Thu, 8 Mar 2018 13:54:08 +0100
Message-ID: <20180308125408.45jyq2poz7najqze@earth.universe>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
 <20180308102757.jyi7uo566n6nuct5@earth.universe>
 <20180308104831.fflq2arj5dxgntia@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6dfljmtajcc6f3jx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308104831.fflq2arj5dxgntia@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--6dfljmtajcc6f3jx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 08, 2018 at 10:48:31AM +0000, Lee Jones wrote:
> On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> > On Thu, Mar 08, 2018 at 09:53:15AM +0000, Lee Jones wrote:
> > > On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> > > > On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> > > > > On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > > > > > +static const struct mfd_cell cpcap_mfd_devices[] =3D {
> > > >=20
> > > > [...]
> > > >=20
> > > > > > +	}, {
> > > > > > +		.name          =3D "cpcap-led",
> > > > > > +		.id            =3D 4,
> > > > > > +		.of_compatible =3D "motorola,cpcap-led-cp",
> > > > > > +	}, {
> > > > > > +		.name          =3D "cpcap-codec",
> > > > > > +	}
> > > > > > +};
> > > > >=20
> > > > > With none of the entries containing platform_data /me wonders why=
 you
> > > > > can't still use devm_of_platform_populate()?
> > > >=20
> > > > Because devm_of_platform_populate works with compatible properties =
and
> > > > cpcap-codec does not have one after I removed it for Mark.
> > >=20
> > > Sorry, I missed that conversation.  Why was it removed?
> >=20
> > I had it in PATCHv1-PATCHv4. It was removed, since Mark didn't want
> > to have it in the DT ABI.
>=20
> Right, but why?  Is it not a hardware device?  I think converting from
> devm_of_platform_populate() for one sub-device is a bit drastic.

This must be answered by Mark. Personally I think it makes more sense
to have the compatible, since all other cpcap sub-devices have them
and it should be consistent IMHO. I changed it to avoid bikeshedding.

The previous discussion was here: https://patchwork.kernel.org/patch/102200=
35/

-- Sebastian

--6dfljmtajcc6f3jx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqhMmwACgkQ2O7X88g7
+prfYg/9FYwcfRW/eU9T8Df/aIaWZ58mBd2CIwpxUSksodKBaSKWJfWIr+p9/Mvp
kra3a4NVF+DdE7rAn9IyVp5jgbwkf0vdhvzekakHVpT0jhxaZr+bWCa0q96B2FWR
P3jGB7J1Ic0jnGP0Iwb2yZdub++oTVEBf6tDELzWLBzkVJctQJwGdrlReIMxHYsN
Rw5LOLd9OiWuWWYNpL5Qu4r7SYWx7flkMC8oD5DlEQyUakvCc8Ls+eciNdrenwnw
UQTYtkhmorYuWvd+C5sx3OaZmBdUAnuAMBKSjvo9u4pnz9NO+FMrm4MHyLiM3O0m
MFlA6EdeKZcavff/46HCZvdAMYJqBFSqDRTTqYekPU4mN3G+wHRnn4i39DgIlFI9
+eX7DH8yq/ZALV3QTcyXNADExyAuJqsuBvlCxLgDnVgP78+Ne/3/t3DS5156VJ0O
/djJRUreDR9W2Bd9KvYB1/c5/aqgqlqnE95GNhZ7m1gYKSzzLvcpLDxX3bRVuPgh
5OjzNvHY5Wh1f0IXZYJwX3G6eMmDED0v2iUUpqeCvr+CgLqpHwz35SoVRa1ZUl7L
t4Th3NxxSuTTSJT4xH3wcJ1uFwZ9GRiOEGJ5uxa7YEuCBlZo2ZjTwXO+8zgu329x
tSUmK/fdqg1YhJR5WHV0HG+Sujh5z/8q7+jRWODvT68jbCqcVTI=
=Zpsm
-----END PGP SIGNATURE-----

--6dfljmtajcc6f3jx--
