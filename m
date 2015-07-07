From: Sebastian Reichel <sre@kernel.org>
Subject: Re: rx51-battery.ko incompatiblity: board code vs DT
Date: Tue, 7 Jul 2015 17:02:30 +0200
Message-ID: <20150707150230.GB25405@earth>
References: <201507062144.22911@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aM3YZ0Iwxop3KEKx"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201507062144.22911@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>, Pavel Machek <pavel@ucw.cz>, Aaro Koskinen <aaro.koskinen@iki.fi>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


--aM3YZ0Iwxop3KEKx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 06, 2015 at 09:44:22PM +0200, Pali Roh=E1r wrote:
> now I found out that rx51-battery.ko driver register sysnode=20
> /sys/class/power_supply/rx51-battery/ when booting with legacy board=20
> code. But when booting DT kernel it register sysnode with different name=
=20
> /sys/class/power_supply/n900-battery/
>=20
> Sysfs node for DT kernel comes from Nokia N900 DTS file:=20
> arch/arm/boot/dts/omap3-n900.dts
>=20
> I would propose change which change DTS to "rx51-battery" to have it=20
> compatible with naming which is for legacy board code. It is just=20
> because to have compatibility and same naming scheme and also to make=20
> existing programs to work without needing patching them.
>=20
> What do you think?

Change the driver instead (in rx51_battery_probe):

-   di->bat.name =3D dev_name(&pdev->dev);
+   di->bat.name =3D "rx51-battery"

This will keep the DT ABI stable and avoid introducing the term rx51
in the device tree file.

-- Sebastian

--aM3YZ0Iwxop3KEKx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVm+oGAAoJENju1/PIO/qa/N4P/RppuQV4gbguGNRObXMmy93+
a9+k7bD1QqyHcD46NlZjh9HkDL+UXVM6vRzuN/wZxuhH7x0+CYQVFjkSphhYh15P
9UOaw79JJUjDoT3L8F6S15mZrGzAZ1NvJRHr6/lKXI3I3EUii77+iTLzEw6BpPuN
01eY6THJWAPDupBPSEkpaFefGuCOLDEUMBNEHxHq4+ILk8rITI1Y508E6daZrBQW
GGpyEzbRmIc24nB1xfVgcVcr9II0AYT0fsZblX2VCMV4+uXF0LzS8UZQ+6pNrp+r
uczY2ejtL+LT0HUMocn1A8KAsjJ4td0ZTucAKQgMVIHK0VIAApaDi4u0dggsGyn2
xxouxFohP1tsf2Gmb255LuDv+a8LAhujaTohiMjxZh4iUavwRFeNIgBuruLqtTay
lelyS+AvvYkRIAceih67XeNhA8stKs7XSsvdbgst9miJ5tPMp86VLDedDsEzfdFC
lpadCghSeqlR365tDk60mLaGB+Rg6TGmsA8rqEhgQ2Zp5Z/wW3MFWmKh2695P3hx
O5BuJL9OEUKl44AYnjzQI07dIpCbnVtcAPR+7Z3myrvVmrlZKhwiNon70hUhi8z1
HMKpv7Z+u48Mtw8HsZM9S1NQHdxI3aRQbHquEL9WYmG3f3I7vTBwj5hy8kYc6bsL
8WLqbsYFwMNW/zuhmNWP
=PZ+N
-----END PGP SIGNATURE-----

--aM3YZ0Iwxop3KEKx--
