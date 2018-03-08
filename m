From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Thu, 8 Mar 2018 11:27:57 +0100
Message-ID: <20180308102757.jyi7uo566n6nuct5@earth.universe>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308095315.mpcmx2ob6yhsnrm6@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zsrhboitvomsevkd"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308095315.mpcmx2ob6yhsnrm6@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--zsrhboitvomsevkd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 08, 2018 at 09:53:15AM +0000, Lee Jones wrote:
> On Thu, 08 Mar 2018, Sebastian Reichel wrote:
> > On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> > > On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > > > +static const struct mfd_cell cpcap_mfd_devices[] =3D {
> >=20
> > [...]
> >=20
> > > > +	}, {
> > > > +		.name          =3D "cpcap-led",
> > > > +		.id            =3D 4,
> > > > +		.of_compatible =3D "motorola,cpcap-led-cp",
> > > > +	}, {
> > > > +		.name          =3D "cpcap-codec",
> > > > +	}
> > > > +};
> > >=20
> > > With none of the entries containing platform_data /me wonders why you
> > > can't still use devm_of_platform_populate()?
> >=20
> > Because devm_of_platform_populate works with compatible properties and
> > cpcap-codec does not have one after I removed it for Mark.
>=20
> Sorry, I missed that conversation.  Why was it removed?

I had it in PATCHv1-PATCHv4. It was removed, since Mark didn't want
to have it in the DT ABI.

-- Sebastian

> > > >  static int cpcap_probe(struct spi_device *spi)
> > > >  {
> > > >  	const struct of_device_id *match;
> > > > @@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
> > > >  	if (ret)
> > > >  		return ret;
> > > > =20
> > > > -	return devm_of_platform_populate(&cpcap->spi->dev);
> > > > +	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> > > > +				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
> > > >  }
> > > > =20
> > > >  static struct spi_driver cpcap_driver =3D {
> > >=20
>=20
>=20
>=20
> --=20
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--zsrhboitvomsevkd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqhECkACgkQ2O7X88g7
+poVWw/+OSqG/ke08GEveyHvyECKhfxk6wW0ijT0H2UKBrs/8jO1ePyXLOrBlteV
RyXSGWg5Z3IUKeepp67ON9UgPfYI23oT8RulwRtVxs/Zhxv0nlRMrED3SSa3rC3P
i5ffXHxzyM8zMBqXJnLvDObUHORL+SRpEl3KmySr1oujiS6JS30eHJZSfIfneZ8O
7xM25vSquYCBWI/36leOljBuffRJM+S+p8Wtihn3EEFQ9MB0kyZ+4l7WSak+lmBf
AzLREilx+Y88vX6XSxvpHt2m+daK/VHhLI0I3biN4qfI6fUlh3PyiFEigdhmDmJL
Ip8SsNGnHvIc2GlyJ3VX5QwurgTXI7pqLknhbfT9nNORczesr+w7sRunBIX8xcqh
prHXvDtUBFY3jdIswcu49EFf5Bq5h3Aa3nCeHGYnC3Yx/y2szoOMZ4c/las4oTqZ
/wUJs3WiUm+q8W09pvbK16tExZIHdGPXsDX27bKslLrF2Fcye8lCEJcAgaZfP78A
hfAOD2IMF9a/v+bAQJz9o4HU46CWXEZ/kTD4ETJKXS5huT1oj1lAd6Mip5rMgWQt
cTfd+YCd0C/2fdRcy/xPtRDc9KKz4HobhGqQQBNjVrKKE6/9jzVSnrajgbqXLLU0
rpeVuih04pgjestGMcpDzDuQNKs5VzGCqY4D4JFEGeNa8O0EaJA=
=gES4
-----END PGP SIGNATURE-----

--zsrhboitvomsevkd--
