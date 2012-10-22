From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 0/8] I2C patches for v3.8 merge window
Date: Mon, 22 Oct 2012 16:30:23 +0300
Message-ID: <20121022133023.GC14033@arwen.pp.htv.fi>
References: <1350899218-13624-1-git-send-email-balbi@ti.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y/A/1bIHS6WQt0eA"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:37155 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754198Ab2JVNgU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 22 Oct 2012 09:36:20 -0400
Content-Disposition: inline
In-Reply-To: <1350899218-13624-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: linux-i2c@vger.kernel.org, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, w.sang@pengutronix.de, ben-linux@fluff.org, Shubhrajyoti Datta <shubhrajyoti@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

--y/A/1bIHS6WQt0eA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 22, 2012 at 12:46:50PM +0300, Felipe Balbi wrote:
> Hi guys,
>=20
> here's another series for OMAP I2C driver. There are a few cleanups
> and one very nice new feature: we can now report how many bytes
> we transferred until NACK.
>=20
> Note that the implemementation for OMAP-I2C turned out to be a
> little more complex then I expected, mainly because of the way
> I2C_CNT register behaves and because of the very buggy register
> usage on that driver.
>=20
> I have boot tested all patches on beagle xM (3630) and pandaboard
> rev A3 (4430), will send boot-logs if anyone wants to see.
>=20
> All patches are available at [1] if anyone wants an easy way to
> test the patches.
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git i2c-trans=
ferred-bytes-on-NACK

forgot to mention, with [1] I could veridy suspend to ram with boards
mentioned above.

[1] http://marc.info/?l=3Dlinux-arm-kernel&m=3D135090724817604&w=3D2

> Felipe Balbi (7):
>   i2c: omap: no need to access platform_device
>   i2c: omap: reorder exit path of omap_i2c_xfer_msg()
>   i2c: omap: fix error checking
>   i2c: omap: also complete() when stat becomes zero
>   i2c: omap: introduce and use OMAP_I2C_IP_VERSION_3
>   i2c: omap: wait for transfer completion before sending STP bit
>   i2c: omap: implement handling for 'transferred' bytes
>=20
> Shubhrajyoti D (1):
>   i2c: add 'transferred' field to struct i2c_msg
>=20
>  arch/arm/mach-omap2/i2c.c                  |   3 +-
>  arch/arm/mach-omap2/omap_hwmod_44xx_data.c |   2 +-
>  drivers/i2c/busses/i2c-omap.c              | 156 ++++++++++++++++-------=
------
>  include/linux/i2c-omap.h                   |   1 +
>  include/uapi/linux/i2c.h                   |   1 +
>  5 files changed, 89 insertions(+), 74 deletions(-)
>=20
> --=20
> 1.8.0.rc0
>=20

--=20
balbi

--y/A/1bIHS6WQt0eA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQhUpvAAoJEIaOsuA1yqRE6oQP/i7ClKc6nFTZj+JlQf9smQMm
mjIoyOAJ1i7CdEnS3dmqCv/OXzEXOq0cDeIJ3bcx002ZRCAALGTK7wTR5RHUUjJy
BLevqk8S1T+udS6nT8C/n348CAlWAt6vctDERERMP7A9tSarpGSjnQRFW18Zvbd6
LYjxxDFUe5Oacq1cGkwupYFuRPndvpdQHozFp781idijFgMUcLUXysgs8vM5RpIl
rODk3rzPSkM/cf2e/7QFRqBsHmy77r2sGZ5+90EbHfhGEybevxp6gBepvi7J9Hs6
dDvtAb6yhCdCpu+wPg8ixXvrHbsBZVKFJqmde83yzhxPx1NicXUC4oUhf/wk2Ib2
XUHuTOAKTh2L0w2y1ZLdUB4qQlEkLQiGBJlEX7NF6KwcOGm+gmUOps2wTjdEgsMq
JJIfl4vMSWiT7fuufIXEKHBEEz3YVmkbEgyg983CnA6XazXYbgjfqcDaf//Dm1o1
YJwP31j8houmJ5/iykOfbd/gwgBt9h644aBO8rQowcyqHYv5kenrfO/5lnES5O65
7hC3bkzuMhZhg40dkXV7vV3eES1Wb7h2P8sa0dgt5mn1izM5n+t15Af4qzrWbzCS
PGmYjLMlNZyjxIOfwK/03CZ4FriIizxWtxTNFW/2qxuskw1gHDzn+XJBsI6AYBWW
W+lNER6wgJBbyw56EaIV
=LDED
-----END PGP SIGNATURE-----

--y/A/1bIHS6WQt0eA--
