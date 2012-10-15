From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] i2c: omap: revert "i2c: omap: switch to threaded IRQ
 support"
Date: Mon, 15 Oct 2012 10:16:57 +0300
Message-ID: <20121015071657.GA22818@arwen.pp.htv.fi>
References: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54599 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262Ab2JOHWo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 15 Oct 2012 03:22:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210150148080.16624@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-i2c@vger.kernel.org, Felipe Balbi <balbi@ti.com>, Shubhrajyoti D <shubhrajyoti@ti.com>, Wolfram Sang <w.sang@pengutronix.de>, Ben Dooks <ben-linux@fluff.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Oct 15, 2012 at 01:51:08AM +0000, Paul Walmsley wrote:
>=20
> Commit 3b2f8f82dad7d1f79cdc8fc05bd1c94baf109bde ("i2c: omap: switch to
> threaded IRQ support") causes communication with I2C devices to fail
> after system suspend/resume on all OMAP3 devices:
>=20
> ...
> [   40.228576] PM: noirq resume of devices complete after 3.723 msecs
> [   40.233184] PM: early resume of devices complete after 3.173 msecs
> [   40.242736] [sched_delayed] sched: RT throttling activated
> [   41.235046] omap_i2c omap_i2c.1: controller timed out

instead of just reverting the patch, I'd rather try to figure out why
controller times out in that situation.

It should make no difference if you're running an IRQ thread or not.

Do you have any extra debugging information which might help figuring
out what the issue really is ?

If the thread is actually at fault, then we need to add IRQF_NO_THREAD
to the IRQ flags, otherwise same issue will appear if we boot with
"threadirqs" kernel parameter.

> [   41.235351] twl: i2c_read failed to transfer all messages
> [   41.235382] omap_hsmmc omap_hsmmc.0: could not set regulator OCR (-110)
> [   41.396453] mmc0: error -110 during resume (card was removed?)
> [   42.391754] omap_i2c omap_i2c.1: controller timed out
> [   42.391876] twl: i2c_write failed to transfer all messages
> [   42.391906] twl_rtc: Could not write TWLregister F - error -110
> [   43.391326] omap_i2c omap_i2c.1: controller timed out
> [   43.391479] twl: i2c_read failed to transfer all messages
> [   43.391510] twl_rtc: Could not read TWLregister D - error -110
> [   43.391540] twl_rtc twl_rtc: twl_rtc_read_time: reading CTRL_REG, erro=
r -110
> [   43.392364] PM: resume of devices complete after 3158.935 msecs
>=20
> When the root filesystem is on MMC, as in the above example, the
> card's voltage regulator is not re-enabled and the filesystem becomes
> inaccessible after resume.

but it fails because I2C times out and I'd like to understand why,
before just reverting the patch.

> Fix by reverting the conversion to a threaded IRQ handler.
>=20
> Signed-off-by: Paul Walmsley <paul@pwsan.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Shubhrajyoti D <shubhrajyoti@ti.com>
> Cc: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  drivers/i2c/busses/i2c-omap.c |   44 +++++++----------------------------=
------
>  1 file changed, 7 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/i2c/busses/i2c-omap.c b/drivers/i2c/busses/i2c-omap.c
> index db31eae..e001c2a 100644
> --- a/drivers/i2c/busses/i2c-omap.c
> +++ b/drivers/i2c/busses/i2c-omap.c
> @@ -180,7 +180,6 @@ enum {
>  #define I2C_OMAP_ERRATA_I462		(1 << 1)
> =20
>  struct omap_i2c_dev {
> -	spinlock_t		lock;		/* IRQ synchronization */
>  	struct device		*dev;
>  	void __iomem		*base;		/* virtual */
>  	int			irq;
> @@ -865,35 +864,13 @@ static int omap_i2c_transmit_data(struct omap_i2c_d=
ev *dev, u8 num_bytes,
>  }
> =20
>  static irqreturn_t
> -omap_i2c_isr(int irq, void *dev_id)
> +omap_i2c_isr(int this_irq, void *dev_id)
>  {
>  	struct omap_i2c_dev *dev =3D dev_id;
> -	irqreturn_t ret =3D IRQ_HANDLED;
> -	u16 mask;
> -	u16 stat;
> -
> -	spin_lock(&dev->lock);
> -	mask =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
> -	stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> -
> -	if (stat & mask)
> -		ret =3D IRQ_WAKE_THREAD;
> -
> -	spin_unlock(&dev->lock);
> -
> -	return ret;
> -}
> -
> -static irqreturn_t
> -omap_i2c_isr_thread(int this_irq, void *dev_id)
> -{
> -	struct omap_i2c_dev *dev =3D dev_id;
> -	unsigned long flags;
>  	u16 bits;
>  	u16 stat;
>  	int err =3D 0, count =3D 0;
> =20
> -	spin_lock_irqsave(&dev->lock, flags);
>  	do {
>  		bits =3D omap_i2c_read_reg(dev, OMAP_I2C_IE_REG);
>  		stat =3D omap_i2c_read_reg(dev, OMAP_I2C_STAT_REG);
> @@ -907,7 +884,7 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
> =20
>  		if (!stat) {
>  			/* my work here is done */
> -			goto out;
> +			return IRQ_HANDLED;
>  		}
> =20
>  		dev_dbg(dev->dev, "IRQ (ISR =3D 0x%04x)\n", stat);
> @@ -1016,8 +993,6 @@ omap_i2c_isr_thread(int this_irq, void *dev_id)
>  	omap_i2c_complete_cmd(dev, err);
> =20
>  out:
> -	spin_unlock_irqrestore(&dev->lock, flags);
> -
>  	return IRQ_HANDLED;
>  }
> =20
> @@ -1062,6 +1037,7 @@ omap_i2c_probe(struct platform_device *pdev)
>  		pdev->dev.platform_data;
>  	struct device_node	*node =3D pdev->dev.of_node;
>  	const struct of_device_id *match;
> +	irq_handler_t isr;
>  	int irq;
>  	int r;
> =20
> @@ -1110,8 +1086,6 @@ omap_i2c_probe(struct platform_device *pdev)
>  	dev->dev =3D &pdev->dev;
>  	dev->irq =3D irq;
> =20
> -	spin_lock_init(&dev->lock);
> -
>  	platform_set_drvdata(pdev, dev);
>  	init_completion(&dev->cmd_complete);
> =20
> @@ -1166,14 +1140,10 @@ omap_i2c_probe(struct platform_device *pdev)
>  	/* reset ASAP, clearing any IRQs */
>  	omap_i2c_init(dev);
> =20
> -	if (dev->rev < OMAP_I2C_OMAP1_REV_2)
> -		r =3D devm_request_irq(&pdev->dev, dev->irq, omap_i2c_omap1_isr,
> -				IRQF_NO_SUSPEND, pdev->name, dev);
> -	else
> -		r =3D devm_request_threaded_irq(&pdev->dev, dev->irq,
> -				omap_i2c_isr, omap_i2c_isr_thread,
> -				IRQF_NO_SUSPEND | IRQF_ONESHOT,
> -				pdev->name, dev);
> +	isr =3D (dev->rev < OMAP_I2C_OMAP1_REV_2) ? omap_i2c_omap1_isr :
> +								   omap_i2c_isr;
> +	r =3D devm_request_irq(&pdev->dev, dev->irq, isr, IRQF_NO_SUSPEND,
> +			     pdev->name, dev);
> =20
>  	if (r) {
>  		dev_err(dev->dev, "failure requesting irq %i\n", dev->irq);
> --=20
> 1.7.10.4

--=20
balbi

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQe7hpAAoJEIaOsuA1yqRExcYQAK/nvzpgeDGdE82KKvBmmv2k
aSpN5y9Tngw+c91QEHNs72Rh41uRoQgUuGuaSrj40mYi1oW05rTjd4eo9w5Srh9e
LW2Qz4lokSs+7Wqi/0wacTM/XTgU8YaxfM7XbSo5yCmoL5hdjy+EXtAypkOsfxqj
MUmz5htdcfSoPES6xKTP6mDNPykwwzEfopj0cPDzfQjl18eRNGd1fwVpvlx+gMtO
PU/nwOvNYKWxz0mjme6KttljcYiATH1nTEqJTN/O3tT8GliCji4uReGynaNdUJto
4u5HR3qPdpo2eEuEVCnokYP9UJHbAyfJEIaBUlXRIMuGf7lIEky+AGhayswqfVuw
HHlUKQNCrLO2s6jIM9WgCHJq2abO1Wm5ufiAgsmE8z+o531IHuKDw06V+OnBdhL8
EYGapaOmiSGUUuToBqZ3NEMjr+LrMdFWGpRBEVmJf1ETEfRGaoLBmPr+oofFFh31
ldGYmvDMhI2FnCqbTlEQC0ek5WhgtkSpRmITl27tOo2vYydbDTF/rIdB1HOYeDDM
UtFVBWCtVEsMkATXE8Gx+rnXrkiyIPfXeReqZXHcd1so3vViK8u0vob56KsIPQqC
mJMuFwugu3oYkTywQgHVGIK+67hKxB2Xn+ywT4ODdnHXnXEgHoObnU1hSJGWbLAj
H7ajr7/oBGN0XjXkoQeZ
=3a2d
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
