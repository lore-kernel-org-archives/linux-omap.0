From: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv1 3/6] HSI: hsi-char: add Device Tree support
Date: Thu, 27 Feb 2014 01:24:20 +0100
Message-ID: <20140227002420.GA25804@earth.universe>
References: <1393199401-27197-1-git-send-email-sre@debian.org>
 <1393199401-27197-4-git-send-email-sre@debian.org>
 <20140224151301.GJ28555@e106331-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7JfCtLOvnd9MIVvH"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140224151301.GJ28555-NuALmloUBlrZROr8t4l/smS4ubULX0JqMm0uRHvK7Nw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Carlos Chinea <cch.devel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org" <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <Pawel.Moll-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, =?utf-8?B?0JjQstCw0LnQu9C+INCU0LjQvNC40YLRgNC+0LI=?= <freemangordon-uiMcrn6V0Vs@public.gmane.org>, Joni Lapilainen <joni.lapilainen-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org


--7JfCtLOvnd9MIVvH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2014 at 03:13:01PM +0000, Mark Rutland wrote:
> On Sun, Feb 23, 2014 at 11:49:58PM +0000, Sebastian Reichel wrote:
> > Add of_match_table to hsi_char driver, so that it can
> > be referenced from Device Tree.
> >=20
> > Signed-off-by: Sebastian Reichel <sre-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
> > ---
> >  drivers/hsi/clients/hsi_char.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >=20
> > diff --git a/drivers/hsi/clients/hsi_char.c b/drivers/hsi/clients/hsi_c=
har.c
> > index e61e5f9..7f64bed 100644
> > --- a/drivers/hsi/clients/hsi_char.c
> > +++ b/drivers/hsi/clients/hsi_char.c
> > @@ -42,6 +42,7 @@
> >  #include <linux/stat.h>
> >  #include <linux/hsi/hsi.h>
> >  #include <linux/hsi/hsi_char.h>
> > +#include <linux/of_device.h>
> > =20
> >  #define HSC_DEVS		16 /* Num of channels */
> >  #define HSC_MSGS		4
> > @@ -758,12 +759,22 @@ static int hsc_remove(struct device *dev)
> >  	return 0;
> >  }
> > =20
> > +#ifdef CONFIG_OF
> > +static const struct of_device_id hsi_char_of_match[] =3D {
> > +	{ .compatible =3D "ssi-char", },
>=20
> This string is undocumented.
>=20
> > +	{ .compatible =3D "hsi-char", },
>=20
> I'm not sure either string makes sense though; this feels like a binding
> for the sake of the driver rather than describing the device and
> allowing the driver to pick it up if it makes sense to do so.
>=20
> What exactly is a "ssi-char" device or a "hsi-char" device?

mh. I guess I will update the hsi framework, so that it simply loads
the client driver for each registered port. This is indeed only a
binding to load the driver.

-- Sebastian

--7JfCtLOvnd9MIVvH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTDoW0AAoJENju1/PIO/qaw4UP/jd4zbh+Q04KmMn1YwCNXFHu
mF1xM6QxScm2sSCSRiYNaqf947u6FfKg7CE6zByQ5fcSTztSqmJsicEmNtxAI6/g
s4gV6p+HdUjXmp2nULOx/wZcqLC2RCE4m3XvT24rKkiDrymCOXIrAgy5+TNQRXXx
Q1lgShNYL7KPd42B9hlJIovM55zMxrSWwt4iidJtAxHYJy9z4H9MWTl5q2sLyypH
9SAnfwWBIpf34MeFj4B66PBS+S7aTvkoXJuvWD9VWSjx8Qei4UZ4LbxR5iNavISG
KVwTF0q10zBZO0q3QECdnaxoqfsJCmrUT8Y7N0C5Tlz3sHbna0WtlMjgjBXhc5hy
lTlf14ydRg6R1uWai30wwhzDAsvnsyBySxusyoT4IQ3GfgBF097wtPkTnUZu+oC8
jfVCMijyv0mDb5vA4JRRL/i014NPVC0G+C5JN376GueDX6XiX9ANe4oEgVMnYMl4
ZzR1OkvvTQkoaWUlwxIxZIbqNrX/H+jGcqbi2JfdnCG+Blu8Tqj0Jy2Hjdxg4E73
YmtR5uwKLkxqbfK8JbFhsBeNuC23DSRU+ckjOHGopAFhJ71PfPW7uXG3ypsGKiKp
SHRUPh0lLMuOjfDALF1Ynu1dingvyshGHZbbFvNSbcsBNC5XkR4m5T/l3KQTFtWY
ph0GfKj1AcvCSmlBLwa5
=nTF4
-----END PGP SIGNATURE-----

--7JfCtLOvnd9MIVvH--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
