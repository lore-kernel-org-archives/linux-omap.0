From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Thu, 8 Mar 2018 10:46:52 +0100
Message-ID: <20180308094652.qg4atjw5c3hayaz3@earth.universe>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="apgfiynhdwpmzzxl"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180307163211.rytfli5tb47yhtug@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--apgfiynhdwpmzzxl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, Mar 07, 2018 at 04:32:11PM +0000, Lee Jones wrote:
> On Fri, 23 Feb 2018, Sebastian Reichel wrote:
> > +static const struct mfd_cell cpcap_mfd_devices[] =3D {

[...]

> > +	}, {
> > +		.name          =3D "cpcap-led",
> > +		.id            =3D 4,
> > +		.of_compatible =3D "motorola,cpcap-led-cp",
> > +	}, {
> > +		.name          =3D "cpcap-codec",
> > +	}
> > +};
>=20
> With none of the entries containing platform_data /me wonders why you
> can't still use devm_of_platform_populate()?

Because devm_of_platform_populate works with compatible properties and
cpcap-codec does not have one after I removed it for Mark.

-- Sebastian

> >  static int cpcap_probe(struct spi_device *spi)
> >  {
> >  	const struct of_device_id *match;
> > @@ -260,7 +308,8 @@ static int cpcap_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	return devm_of_platform_populate(&cpcap->spi->dev);
> > +	return devm_mfd_add_devices(&spi->dev, 0, cpcap_mfd_devices,
> > +				    ARRAY_SIZE(cpcap_mfd_devices), NULL, 0, NULL);
> >  }
> > =20
> >  static struct spi_driver cpcap_driver =3D {
>=20
> --=20
> Lee Jones
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--apgfiynhdwpmzzxl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqhBnsACgkQ2O7X88g7
+pqSmBAAgX8CzEdb4wxp/qgqjQaEcdjL7sz7MkodTGO2PkqWChQCuWYK+IDa2k36
KcJ+YZ/cEw0QgD1cmMz+swhz9UrvDYriqsBZ0A4Bcu8Tbc0JR12QIQEjVWYrvhQi
Tj5nMbsF7t70J3Eg6i3Eorkx5ipyON5L/Uu08Mog8xZOK46aAeG5W6K44pg6GJ8v
ov1EE7ubCZIL1gPXOkjXjbl9uetAAXWDYvKURSELm+EeRtrvcfB8iSQy8IF2QPOh
Nk1p+eRuOTw2ZCBypqDF8o1TGciKLeS3RRGN4hhCV+j+EDc/tmIY/a70MqaVqywh
Vw514RImpP6B5X2UZqxZg7SSg1ERx2CYPNE7ctZCDpGg+jIJ5YAHHzyJlcTJQHl2
AxEQF6sLgFfPp/f2wCAjf5wlp+a2SkWlKfM34JPT1+gUNW8Tw/lUwuAVBmFBTOzp
1DOGROzoeVwrKINAueyzf3FHyuGZ8f60IKMyU3kOwJRaOK/tww2KcltdilcjVx3V
ESlbEB0XuLn5mbgC61JuCagsIFIBc9d6OTGHfar/DKU2+oE5Kqg7rW4SSwGThEim
/ivMveujAR7c9NWgkyukzeiNG1o5XYj74c9AUljqBKdnRWTbIkmNwjlcQgHl7OxR
lhVfMGJu0EvVbcKBoQXeM0W3YoibCRZwx2Vabzc/d1zIEK+O0Ww=
=dxXu
-----END PGP SIGNATURE-----

--apgfiynhdwpmzzxl--
