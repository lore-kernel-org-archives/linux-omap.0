From: "Maximilian Schwerin" <Maximilian.Schwerin-Uf0zVKHSUsGzQB+pC5nmwQ@public.gmane.org>
Subject: AW: USB problem on beagleboard clone
Date: Wed, 19 Sep 2012 08:22:44 +0200
Message-ID: <5448984682E7954C9BFF27F747A9C6CA56E33A@dolphin.TIGRIS.local>
References: <alpine.DEB.2.00.1209190122520.13435@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="=-c3FJ7//R5U/nF4DCoSVn"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1209190122520.13435-rwI8Ez+7Ko+d5PgPZx9QOdBPR1lH4CV8@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Paul Walmsley <paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--=-c3FJ7//R5U/nF4DCoSVn
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

> -----Urspr=FCngliche Nachricht-----
> Von: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org=20
> [mailto:linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org] Im Auftrag von Paul Walmsley
> Gesendet: Mittwoch, 19. September 2012 03:24
> An: Maximilian Schwerin
> Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Betreff: Re: USB problem on beagleboard clone
>=20
> Hi
>=20
> On Fri, 14 Sep 2012, Maximilian Schwerin wrote:
>=20
> > we've designed two beagle board clones (two different=20
> layouts) for a=20
> > customer. After quite some time without any problems they=20
> are now seeing=20
> > USB problems on some of the boards. I have so far not been able to=20
> > reproduce the problem...
> >=20
> > The USB port of the OMAP the problems appear on is=20
> connected through a=20
> > TPS65950 to a LAN9514 USB Hub + Ethernet Chip. Attached is=20
> the kernel=20
> > output. I'm not even sure if this is related to our board,=20
> or if this=20
> > might be a misbehaving device?!
> >=20
> > If someone has an idea what this could be and what I could=20
> do to fix or=20
> > at least further debug the problem please speak up.
>=20
> Are these BeagleBoard 3530 or BeagleBoard XM 3730 clones?
>=20
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe=20
> linux-usb" in
> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

They're BeagleBoard XM clones. We're still trying to find out what the =
real problem is. The problem persists across three separate layouts =
using the same USB device and application. We're currently trying to see =
if this is related to MUSB only by using an EHCI port on the same board =
with the same device and application.

Regards, m.

--=-c3FJ7//R5U/nF4DCoSVn
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAlBZZNgACgkQ6nqkzTWctv4Y6ACgzR4lczwfOoowQZ1snoXKkiuU
zaYAn2GbQe5wi+Aq2GRcZ8jCZkbLin2a
=iNIZ
-----END PGP SIGNATURE-----

--=-c3FJ7//R5U/nF4DCoSVn--
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
