From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] usb: phy: phy-generic: No need to call
 gpiod_direction_output() twice
Date: Tue, 3 Feb 2015 14:52:17 -0600
Message-ID: <20150203205217.GA27736@saruman.tx.rr.com>
References: <1422653236-7142-1-git-send-email-festevam@gmail.com>
 <20150130215939.GC30049@saruman.tx.rr.com>
 <CAOMZO5A=J7HF+AR8aB2CA+we7knoas-vDtLMbh3gVNvgb1aEAg@mail.gmail.com>
 <CAOMZO5DeyqtjDq0a4_qX2SPbaDZunQbSJimrH23gju1mmdA7vQ@mail.gmail.com>
 <20150201173750.GA16306@saruman.tx.rr.com>
 <CAOMZO5AOevmZLKNSRygeWEGzQp-MLkp8pg8Jr536Y-xXPPTKZw@mail.gmail.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5AOevmZLKNSRygeWEGzQp-MLkp8pg8Jr536Y-xXPPTKZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 03, 2015 at 06:21:24PM -0200, Fabio Estevam wrote:
> Hi Felipe,
>=20
> On Sun, Feb 1, 2015 at 3:37 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
>=20
> > I like this, very much. Two comments though. We requested the gpio with
> > _optional(), and NULL is a valid gpio_desc, this if (nop->gpiod_reset)
> > is unnecessary. And also, since we don't have anymore the assert
>=20
> But if the reset-gpios property is not present in the dts, then
> nop->gpiod_reset is NULL, and it is better not to call
> 'gpiod_direction_output(nop->gpiod_reset, 1)'  in this case, right?

it doesn't make a difference though, right ?
gpiod_direction_output(NULL, 1) won't do anything.

/me goes look at code

Man this is messed up. If you follow gpiod_get_optional, you'll end up
at gpiod_get_index_optional() which I quote below:

1989 struct gpio_desc *__must_check __gpiod_get_index_optional(struct devic=
e *dev,
1990                                                         const char *co=
n_id,
1991                                                         unsigned int i=
ndex,
1992                                                         enum gpiod_fla=
gs flags)
1993 {
1994         struct gpio_desc *desc;
1995=20
1996         desc =3D gpiod_get_index(dev, con_id, index, flags);
1997         if (IS_ERR(desc)) {
1998                 if (PTR_ERR(desc) =3D=3D -ENOENT)
1999                         return NULL;
2000         }
2001=20
2002         return desc;
2003 }
2004 EXPORT_SYMBOL_GPL(__gpiod_get_index_optional);

So, if the error code is -ENOENT it returns NULL, that tells me NULL is
a valid gpio descriptor. If you follow gpiod_direction_output() however,
what you get is:

1072 int gpiod_direction_output(struct gpio_desc *desc, int value)
1073 {
1074         if (!desc || !desc->chip) {
1075                 pr_warn("%s: invalid GPIO\n", __func__);
1076                 return -EINVAL;
1077         }
1078         if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
1079                 value =3D !value;
1080         return _gpiod_direction_output_raw(desc, value);
1081 }
1082 EXPORT_SYMBOL_GPL(gpiod_direction_output);

That pr_warn() tells me NULL is *not* a valid gpio descriptor. Linus, is
that just something that was missed until now ?

> > argument, we should rename nop_reset_set() to nop_reset.
>=20
> Agreed, will change it in v2.

Thanks

--=20
balbi

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU0TUBAAoJEIaOsuA1yqREtzEQAJrzlrE6/Gro18a07n7xO/Uv
Kf9A4dttv+uKv6LDExG6ciQFOqLgPeDvkWVQARUZb3PZGL5paw1+t3yGnysRo8Uk
i3kD/GQbKvPWuHwDCCTjkDkJI2vU/M2Scn6mkPIbdbnLgsE4Xk5nsjLCIG+I5s4a
7juGeib/XJDmPHHnUXpslCbTPiq/HTX8NCc9w49RzVlTxk5bDupGrfGpUKPtlSbz
vauUgmiWCC7l/aq07/U0cwSPWrbvNnwVtAMnvCYYlYn15Pflj3WAeZQvFU2C0M15
vNMsZ+4BfilrKpJrM9dij2KkkRrzkHh5tnqQACmA3yAKW4fdWCKHB1ZnT89GqGAC
bLe6I660suyixe4IdoYNVoF56yqhwWDSJVyky+oi3sdxqp6PdgnCpx9IjU4S4p9M
eA806LDjzILvYLanLC5DEjvdQHtRFdpgJKSPH0s3A5VO1JGoqYTTVfsSHwzfTiPS
TNV2hu2kJOSUju4mXOX41E4BMBubFMpY7zuvM8VtOVMYmSxV0aiL1GedxZqEx7ie
xl54blbCaspwTX28aA9FDM2bswiCerguBCjdNGm8yptT/pTYBhPjgz1oAXuYYus2
Op6OyiCj09GwY/lZ7+cX4RaFAgnFDS2vcL7IRuqOCZaUISv+Te6Ex59tXyvSc3Yy
OGsMTKvrME/HnZF02Phz
=Ohjh
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
