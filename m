From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/5] usb: musb: cleanup
Date: Tue, 12 Jun 2012 13:48:32 +0300
Message-ID: <20120612104831.GE10901@arwen.pp.htv.fi>
References: <1338889118-10032-1-git-send-email-kishon@ti.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jKBxcB1XkHIR0Eqt"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1338889118-10032-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: gregkh@linuxfoundation.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, balbi@ti.com
List-Id: linux-omap@vger.kernel.org


--jKBxcB1XkHIR0Eqt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2012 at 03:08:33PM +0530, Kishon Vijay Abraham I wrote:
> Most part of this patch series was obtained by splitting
> [RFC PATCH 2/3] usb: musb: omap glue: use omap-usb2 as the phy driver.
>=20
> TO DO:
> * dt adaptation of musb omap glue, twl4030, twl6030.
> * Use control module driver API to write to control module registers
>  (mailbox and power control of phy)
> * send usb2 phy driver
> * make musb omap glue make use of usb2 phy driver and make twl630
>  as a comparator driver.
>=20
> Patch series depends on
> [PATCH v4 0/3] usb: multi-phy support
>=20
> Performed device mode testing in omap4 panda and omap3 beagle

here too, we need a new version.

--=20
balbi

--jKBxcB1XkHIR0Eqt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP1x5/AAoJEIaOsuA1yqREiZgP/0gxCeLB+VsJ6TTSmEwPDaBW
SPRrGNTejgFMwtvqyTfNSWFiPtxBc/xAxc2xLJClPLX+M/NbdQ07vDrD4/IeeSMw
f3xNQnQuSY+e2ou4FDAPPV8bJcwsEzebNgN744itAnodC1xQkZ78NHIgVQMVCm3y
U3iIkJDBUDn+cMK+3kUlD9rCKs2PD/Iu1/a9x4TPVGBkneYy8tKHt9bVtgE6ZgZ/
qKNaQvPy2mTPwU7OUdUiB7nRRauQyOdG0FAOVHR0LQXxzG6s2tHZs9jFSphgJgWs
HWrEpYmoaOQNipxLPQI7WIea0f3hY/vZQgC5HzFD0QZymfZdUFmEnicBWsg/ft7Q
gAssL7tpFUnRhtwL32KM8UPHBbKmRHlVKWjyNiVMf6cUn/HL1H3VzMhl4Rh36AuI
QPenjbXivGXN2ZFTciDZH8WUOdupGvO+Xb4NDBXcLbse4C0yU2ZI4Zq0oOS/V9P6
UvgFVWaOPoUbxZbVWHCgWW8PgX6Ym+JwOha1hgXJNLuuUNYp+YQE5PtAughMVk0/
II0AnCAE87QKV6+E8X1NRWV2a1ZSupZuQxTiPVZzyx3OjIo0t055hD0F570lRAOb
IWEK84uhw6uex5M6e/VvuZCI2XNeYLMQ7IFoYqn0p+jBPMrhkGUML4x+yamIDsKX
Pi29Uufj+DYQWseXg9+/
=U0/w
-----END PGP SIGNATURE-----

--jKBxcB1XkHIR0Eqt--
