From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Subject: Re: [PATCHv5 3/5] mfd: motorola-cpcap: Add audio-codec support
Date: Fri, 9 Mar 2018 12:29:15 +0100
Message-ID: <20180309112915.bjnqi7tddgucdqjl@earth.universe>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-4-sebastian.reichel@collabora.co.uk>
 <20180307163211.rytfli5tb47yhtug@dell>
 <20180308094652.qg4atjw5c3hayaz3@earth.universe>
 <20180308170736.GN5799@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="c2zqi7fl2es4yu3a"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180308170736.GN5799@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Lee Jones <lee.jones@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
List-Id: linux-omap@vger.kernel.org


--c2zqi7fl2es4yu3a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Mar 08, 2018 at 09:07:36AM -0800, Tony Lindgren wrote:
> * Sebastian Reichel <sebastian.reichel@collabora.co.uk> [180308 09:47]:
> > Hi Lee,
> >=20
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
> How about keep devm_of_platform_populate() for the ones that
> already have compatible. Then add a table entry for cpcap-codec
> only and call devm_mfd_add_devices()?

This should work. I think it makes sense to wait for Rob Herring's
feedback on the binding. My understanding is, that he has the last
word on binding questions and I would like to avoid changing this
back and forth.

-- Sebastian

--c2zqi7fl2es4yu3a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlqicAoACgkQ2O7X88g7
+poeTBAAmJpoKAwVZfFaTdUvmxWsxwgdhZ7cKE74QycrYPYb/V8kQoCRb8kwXMLw
XH+HFo3OAUYkJ9zaU3vnhrDRbcwD2/fI96Ao70HPyqUQa3/lH/6RMrJ6lnmzECtp
Ag/9rW4/b6Y+PU526PkdIKOWV1mjQTIQ0EnWFB0z5fMUuqQ18Zis4wGeXm1ZOdfi
RB7sjBD9p1M/HjK1aTWhuYp+YapkbUBTbZI3dD4Hf4JnCjMnvnsXwy/LOvSpzpWk
a5BHdUBVEwjWNRBCgueBr9xFk6B0tJn5YiPuLD1Ii4u1MBti321b8ggrRkrU3d/O
7LOyXt31ROb9rGHhRBLC5RKChuK8nFUFKqwmlaQRxDMpvsPNOixWxtEIlZAmr0ir
lUA3XqvNoneyV/dVLfnF5yU80liV/R4j5XWfmIXFBCkYe+tAbMxwvokz3FEdZQ76
sfjA9uXk+jHy9VFkWPdCyIUFxqGbo3PmsO1s4xOIlMfbkU2Cy0mLatqT8Uu3JfYk
pca6iDWkKvhNOwJF0g+lC7NnFZIpuWE69K+oVX2hQgIpf3/wV1wyAynUrnMNt0Kt
y8yLYiePy7QiSqDoY57yQtXyVDWZufhjC0HESAhMQDPUoFbgrTb0ZmIn0ORP3/ez
QDEFAaYgmza52QpH0jeirG5B2jrgkTnk2SY8uN0hwVl6Mn8q4E0=
=+Ir8
-----END PGP SIGNATURE-----

--c2zqi7fl2es4yu3a--
