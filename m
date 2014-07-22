From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH] pinctrl: dra: dt-bindings: Fix pull enable/disable
Date: Tue, 22 Jul 2014 11:47:52 -0500
Message-ID: <20140722164752.GJ20588@saruman.home>
References: <1406043594-14181-1-git-send-email-nm@ti.com>
Reply-To: <balbi-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="2VXyA7JGja7B50zs"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1406043594-14181-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Benoit Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--2VXyA7JGja7B50zs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2014 at 10:39:54AM -0500, Nishanth Menon wrote:
> The DRA74/72 control module pins have a weak pull up and pull down.
> This is configured by bit offset 17. if BIT(17) is 1, a pull up is
> selected, else a pull down is selected.
>=20
> However, this pull resisstor is applied based on BIT(16) -
> PULLUDENABLE - if BIT(18) is *0*, then pull as defined in BIT(17) is
> applied, else no weak pulls are applied. We defined this in reverse.
>=20
> Reference: Table 18-5 (Description of the pad configuration register
> bits) in Technical Reference Manual Revision (DRA74x revision Q:
> SPRUHI2Q Revised June 2014 and DRA72x revision F: SPRUHP2F - Revised
> June 2014)
>=20
> Fixes: 6e58b8f1daaf1a ("ARM: dts: DRA7: Add the dts files for dra7 SoC an=
d dra7-evm board")
> Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> ---

Tested on an upcoming board.

Tested-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
Acked-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>


--=20
balbi

--2VXyA7JGja7B50zs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTzpW4AAoJEIaOsuA1yqREdcYP+QFFwNR5fv30clGj0ReMB/UO
mVFU2Fxw7KdDBpVp2p36/ssI9rb6/ZOF1gzXC4ChRtf8KGyX65g3mGnQhB94Zfqt
pT79sVOp0iEoUBQjvFX9DSsO2IZB5yv00z06spB/xmfsNVsUQ8w7VaXgXy3maw6E
qJ3LcnXsdsUyi7c0N61osZYfIzBxdNNZasFnw2EzFzJ23VWnwpvkVERy6/HhthB1
lUxl/ygtCKuOn0CPJKuRxF17UQBgLJv2DswOzRdNTKH98yNXjwUfdgsAgpUUeJ0I
1breDEIOy+Gig1IpeSm6RX4Xp2j4B+h4A7n2jYtA8dt4XyR3yYxdJABNYh1zmFMh
+Emi/l1LsbnkHhq8QCeptJwb2EKK5agErO4vgigQa3A+FcopU/SuU5FXaGNb23cT
Gv7ZC8jg2+wDbBNF2LVOvxFnVCP6+VIp7XeshrJUY0v/pI7WGbM9DJ/PxGJYt8dx
FcSRM4jh2gIAC/tCtBTNlRC8JfX+rTMQR7e3oC0EMi/wUgalUeANVE4UlikvZmUM
AF1gcP1iwbq3UoMeZ90Fw9l8DUMKuY2KXLvwEpMv7c02Kl3lvYGdRvkkAnVTrzN2
DAtKL4wePLqQ8ELer4BjbZNfLcAE5S9qRO5LiKdD8IMQaq82MuGnILc6dg+NYTrQ
gIX6VRmAaZLcRWbm4G5O
=ODXH
-----END PGP SIGNATURE-----

--2VXyA7JGja7B50zs--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
