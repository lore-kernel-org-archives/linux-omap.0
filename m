From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCHv7 20/23] i2c: omap: switch to threaded IRQ support
Date: Tue, 11 Sep 2012 23:51:12 +0200
Message-ID: <20120911215112.GA27031@pengutronix.de>
References: <1347356538-23835-1-git-send-email-shubhrajyoti@ti.com>
 <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:38055 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756633Ab2IKVvR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Sep 2012 17:51:17 -0400
Content-Disposition: inline
In-Reply-To: <1347356538-23835-21-git-send-email-shubhrajyoti@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Shubhrajyoti D <shubhrajyoti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org, ben-linux@fluff.org, tony@atomide.com, Felipe Balbi <balbi@ti.com>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 11, 2012 at 03:12:15PM +0530, Shubhrajyoti D wrote:
> From: Felipe Balbi <balbi@ti.com>
>=20
> for OMAP2, we can easily switch over to threaded
> IRQs on the I2C driver. This will allow us to
> spend less time in hardirq context.
>=20
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [Trivial formating changes]
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
>  drivers/i2c/busses/i2c-omap.c |   43 +++++++++++++++++++++++++++++++++++=
-----
>  1 files changed, 37 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index 4a696bd..e391370 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -176,6 +176,7 @@ enum {
>  #define I2C_OMAP_ERRATA_I462		(1 << 1)
> =20
>  struct omap_i2c_dev {
> +	spinlock_t		lock;		/* IRQ synchronization */
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> @@ -854,9 +855,30 @@ static int omap_i2c_transmit_data(struct omap_i2c_de=
v *dev, u8 num_bytes,
>  }
> =20
>  static irqreturn_t
> -omap_i2c_isr(int this_irq, void *dev_id)
> +omap_i2c_isr(int irq, void *dev_id)
>  {
>  	struct omap_i2c_dev *dev =3D dev_id;
> +	irqreturn_t ret =3D IRQ_HANDLED;

Shouldn't that be IRQ_NONE?

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlBPslAACgkQD27XaX1/VRvRlACglyuLQPTCOw4f1p3lnlMIWSIY
losAmwbN+8V2gSiRb5KJqd0U4DDbaZ5e
=FxGm
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
