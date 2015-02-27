From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] usb: musb: fix Kconfig regression
Date: Fri, 27 Feb 2015 14:21:59 -0600
Message-ID: <20150227202159.GC22641@saruman.tx.rr.com>
References: <20150217185518.GA3825@amd>
 <20150226230307.GA27809@fuloong-minipc.musicnaut.iki.fi>
 <20150227153809.GS11056@atomide.com>
 <7445620.7S2XydQea5@wuerfel>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7445620.7S2XydQea5@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, ivo.g.dimitrov.75@gmail.com, khilman@kernel.org, sre@debian.org, kernel list <linux-kernel@vger.kernel.org>, sre@ring0.de, Sakari Ailus <sakari.ailus@iki.fi>, Pavel Machek <pavel@ucw.cz>, pali.rohar@gmail.com, linux-omap@vger.kernel.org, patrikbachan@gmail.com
List-Id: linux-omap@vger.kernel.org

--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 27, 2015 at 09:12:45PM +0100, Arnd Bergmann wrote:
> A recent bug fix I did that was marked for stable backports
> introduced a slightly wrong dependency on CONFIG_OMAP_CONTROL_PHY.
>=20
> I was missing the fact that the PHY driver already stubs out the
> omap_control_usb_set_mode, and we only need to add a dependency
> to prevent the musb-omap2430 driver from being built-in when
> the phy driver is a loadable module, but we should not prevent it
> from being built altogether when the phy driver is disabled.
>=20
> This changes the dependency to allow OMAP_CONTROL_PHY to
> be disabled, but to disallow USB_MUSB_OMAP2PLUS from being
> built-in if OMAP_CONTROL_PHY is a loadable module.
>=20
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: ca784be36cc725 ("usb: start using the control module driver")
> Cc: <stable@vger.kernel.org> # v3.9+
> Cc: Felipe Balbi <balbi@ti.com>

please resend with linux-usb in Cc and myself in Cc too ;-)

--=20
balbi

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU8NHnAAoJEIaOsuA1yqRErfMP/2LNkfwaTejAo3A7psjdPgFH
fSgPbuYrJIF998O5efPg78csim6pgel6aFiylWjUJMoXY68e8IpHMS0tOTBVDr4n
gucSh33becLtsGKOhz+5l4+T/p472FJpp2K+CURy/2/+LAk/2FV6rIX8X0qwpMkm
KhLbiQf0Zt3vELNtFy1uNNnJzs3IoCB32O6jFwtLPrYvpkioX/+YhadlLVgx0yCt
UF9VTcKfPXrCgfoZ8htnQE2HUpuWV0FbSKtDVgluvf5CAIP1wQoqqfPtEH3/qVJE
joUrlixvRaAQkv7pZdPJtWNyZQb77fPgXFe+xkbgcHZlyp3O5/0x4IoLQaZQLXw1
5WOsOr2vNJwEkIrNjuAyn1v3OneUT9Cme/pLflCyIcPDg+ERpdxbxwbVM+ZkN2sV
tNOxP1x0DvQkIW/ohldTMLwWekU8myuQB1Z2RE96TrIc3elgLjRtlEXnR0KFUWWf
KO4u2s0LTolspy9zIEQKLI4C29JidkikKb6LGYqECT7YZ8uCmtTNPGfYh/bzr9LT
HUL6Yj8YAqXtaO+UQGEYBY9OymdQHpA2+l+qT+WjQ1QSpuvyYTCDrH99Ds/WjhdK
TYNJzfTKp34HwpihyF/IDlLdBW1mpjX7E/5oi3MhY7tIfJin6kSQXXhInSoPu5zs
Nm3vtOc1r3k9jRe4jI6B
=kXk/
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
