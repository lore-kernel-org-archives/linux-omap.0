From: Felipe Balbi <balbi@ti.com>
Subject: Re: DTR gpio handling removed by
 985bfd54c826c0ba873ca0adfd5589263e0c6ee2
Date: Fri, 15 Aug 2014 08:24:44 -0500
Message-ID: <20140815132444.GA11781@saruman.home>
References: <CAAfyv36aMkE5e6Bo1hy1md+Z5EjrZjP+foZTyncp5GFtnaL_sg@mail.gmail.com>
 <20140814225802.GA12109@saruman.home>
 <B18DC75F-EA0E-456F-996E-2F4BF496B68B@goldelico.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRRV7LY7NUeQGEoC"
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <B18DC75F-EA0E-456F-996E-2F4BF496B68B@goldelico.com>
Sender: linux-serial-owner@vger.kernel.org
To: "Dr. H. Nikolaus Schaller" <hns@goldelico.com>
Cc: balbi@ti.com, Belisko Marek <marek.belisko@gmail.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-serial@vger.kernel.org, NeilBrown <neilb@suse.de>
List-Id: linux-omap@vger.kernel.org

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Aug 15, 2014 at 08:08:44AM +0200, Dr. H. Nikolaus Schaller wrote:
> Hi Felipe,
>=20
> Am 15.08.2014 um 00:58 schrieb Felipe Balbi <balbi@ti.com>:
>=20
> > Hi,
> >=20
> > On Thu, Aug 14, 2014 at 11:04:58PM +0200, Belisko Marek wrote:
> >> during 3.15 release was removed by commit
> >> 985bfd54c826c0ba873ca0adfd5589263e0c6ee2 code which was added by
> >> 9574f36fb801035f6ab0fbb1b53ce2c12c17d100 by Neil Brown. We're using
> >> DTR gpio in gta04 device. I plan to post DT binding for DTR gpio +
> >> documentation and find out that Neil's code was removed by Felipe.
> >> Greg can you please revert mentioned commit? We're using DTR gpio in
> >> gta04 device. Or is there other way how to proceed? Thanks.
> >=20
> > there are *NO* users of that in tree, if you're using it, then please
> > add a proper DTS for your device and figure out a way of passing DTR
> > gpio through DT.
>=20
> In fact we are in the middle of preparing DT and driver patches for
> upstreaming the out of tree drivers Neil is mentioning. So there are
> no users *yet* and maybe we are the first one.

right, and that's why it was removed. How would we even know that the
code works when there are no users for it ?

> Neil has already completely argued and commented on that topic:
>=20
> https://lkml.org/lkml/2014/4/23/736
>=20
> Unfortunately he acked the removal with a completely non-technical
> argument:
>=20
> > Just at the moment I'm finding it hard to care.
> > So
> >  Acked-by: NeilBrown <neilb@suse.de>
>=20
> Now we have the problem that it got kicked out while we were preparing
> the other parts :(
>=20
> On the other hand, please consider that we don=E2=80=99t have the manpowe=
r and
> knowledge to modify bigger parts of Linux besides plumbing together
> parts that already exist and add drivers and DT nodes.
>=20
> So please consider again to re-add
> 9574f36fb801035f6ab0fbb1b53ce2c12c17d100.
>=20
> Or should we resubmit it together with our DT/drivers where we use it?

submit it together with your patches but it would be a lot better to see
that turned into something generic, which was commented on the same
thread IIRC.

cheers

--=20
balbi

--wRRV7LY7NUeQGEoC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT7gocAAoJEIaOsuA1yqREFM8P/2GGVsNuDDIuMWDyv7iX7Kwp
KoKSYHD/qkWrPu00E2NYhFUebMNbLe9gHoK3Sb5LPd1JdfS3weWA7U6e37RzT6kb
MbBeZR6ZljnJ/Cly2tvmZMji4TXJGnIPWmjD8Yvm64vzsQ9+M7McNazz3swb1QoR
0DWe2XOIDkUV+T7HBl9ncjbYPSNTNhRUtRiZeanEqhY8xk0nnHeuF1DEZ2ASpaa+
oxWR8rZxZGGM7pIM0LtNZsC7E3jaSTgupieExKGwog3mm9RaDjrD67MCytFBXLFH
MMfc6P0+34Xh7ijuUI3/3MZ1bY4GgmioyZhGf5nNU3cUHnUjhiAagCTpQc7PzK43
tNqvRXmEzWO7KTsMKBrR3najqKEYthspT5q8ZDpah9U6PZ2Zgt+JOI0SYTar32mR
vLjJpPPF+ThycJut7Pc6pXzd/ebnZcFLZUEHmqeIGryMblv2biuVkpp6XXSwiAlR
QdoVUOy9Wa0ygZaocg1oXevKCfUQJgIq3ItM9JO36H+kEMHZPxGJk+QYCoBjhVIQ
SeopbvfBch//nHYKbiFqdbWfhbmcjo2X1pUo4B0x3G3rZ5wFqo8lvOaKohvt8GEY
7WaJUT1j5lh0Cz7vfrMSeP1JjptSdq/DHVrlLgNOeX2riJAqCvUhCyds6TqLIxOa
twg2IWQkgwb+o3A7bbgS
=r6ji
-----END PGP SIGNATURE-----

--wRRV7LY7NUeQGEoC--
