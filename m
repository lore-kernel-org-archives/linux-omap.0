From: Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c: omap: Fix error handlign for clk_get()
Date: Wed, 18 Oct 2017 00:08:53 +0200
Message-ID: <20171017220853.jhy6hzgsayi4rszu@ninjato>
References: <20171016210614.15842-1-tony@atomide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="huiji65l654xkaec"
Return-path: <linux-i2c-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171016210614.15842-1-tony@atomide.com>
Sender: linux-i2c-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-i2c@vger.kernel.org, linux-omap@vger.kernel.org, Claudio Foellmi <claudio.foellmi@ergon.ch>, Grygorii Strashko <grygorii.strashko@ti.com>, Tero Kristo <t-kristo@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org


--huiji65l654xkaec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 02:06:14PM -0700, Tony Lindgren wrote:
> Otherwise we can get the following if the fck alias is missing:
>=20
> Unable to handle kernel paging request at virtual address fffffffe
> ...
> PC is at clk_get_rate+0x8/0x10
> LR is at omap_i2c_probe+0x278/0x6ec
> ...
> [<c056eb08>] (clk_get_rate) from [<c06f4f08>] (omap_i2c_probe+0x278/0x6ec)
> [<c06f4f08>] (omap_i2c_probe) from [<c0610944>] (platform_drv_probe+0x50/=
0xb0)
> [<c0610944>] (platform_drv_probe) from [<c060e900>] (driver_probe_device+=
0x264/0x2ec)
> [<c060e900>] (driver_probe_device) from [<c060cda0>] (bus_for_each_drv+0x=
70/0xb8)
> [<c060cda0>] (bus_for_each_drv) from [<c060e5b0>] (__device_attach+0xcc/0=
x13c)
> [<c060e5b0>] (__device_attach) from [<c060db10>] (bus_probe_device+0x88/0=
x90)
> [<c060db10>] (bus_probe_device) from [<c060df68>] (deferred_probe_work_fu=
nc+0x4c/0x14c)
>=20
> Cc: Claudio Foellmi <claudio.foellmi@ergon.ch>
> Cc: Grygorii Strashko <grygorii.strashko@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>

Applied to for-current, thanks!


--huiji65l654xkaec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlnmf3EACgkQFA3kzBSg
KbaPnBAAlNtYsVccTypoqXfXpONaK8HnVpqV6v1eOXu32dNHokXcMSTSFKS+jVg1
fs8fstQfmRuzuEkvpKPIz7Az28DhzhXnyByxUTCvNVZ/T0GTWh806maJV7Di0DwO
8PMOilo34bPQgrDSElQ/9fMfcuuMlsCqt0THNlBlLYXAGfMabTdNbPw4w+xRGrrk
5J/q4hCFIXnp11DLACBtgKYt88UqjA9Eus1shkwgimrjSLIa1qefaPRVP3yK41qk
Y6ZEmXhCMRRSHZ6p/1+hOk56EL2PeJPi3QanDH7WFiMTyKvmUE0HqY50/iAv7rFC
grQeDLTECyR3xhOtmn+Rm5xd0etR/ErnGYxe1Drkry8HgMgn3G9IRoJ3bYijoAwu
3vSxYRS2HvJURfdphqsy1q+WyBGx1waQik63Q1GbkIQzbmjDgg2WXUo692jaTqNM
J8b/BALksdZhZ3Y4rsRqi3XVSp86FPYhgL+EcChY1FNk43QQxEcHfXOCcnr5jTtG
OYNamMGauynzrRMS4G09MHD7IL7Rn5ys0jDqQsq1AxDmbvD+x/lKZrJi7HHKpSDK
2v++oI3OGBAZ//UAQQr73FzRDyKwKL2qlDKHHKrrefxDKxlBL8SEAwLwlcvjWdsY
zLLRDELeL8iBNeSDTiyvKY1WAQLWPU1lofMQ+OBhu53y3jaq+tA=
=XNDl
-----END PGP SIGNATURE-----

--huiji65l654xkaec--
