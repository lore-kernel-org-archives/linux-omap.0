From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/17] Input: omap-keypad: Remove dependencies to mach
 includes
Date: Tue, 11 Sep 2012 21:27:02 +0300
Message-ID: <20120911182659.GD10706@arwen.pp.htv.fi>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053059.29637.22108.stgit@muffinssi.local>
 <20120911055709.GB17865@arwen.pp.htv.fi>
 <20120911061652.GA23092@atomide.com>
 <20120911175633.GG23092@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qrgsu6vtpU/OV/zm"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog133.obsmtp.com ([74.125.149.82]:48911 "EHLO
	na3sys009aog133.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756622Ab2IKSbg (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Sep 2012 14:31:36 -0400
Received: by eekc1 with SMTP id c1so518164eek.1
        for <linux-omap@vger.kernel.org>; Tue, 11 Sep 2012 11:31:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120911175633.GG23092@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <balbi@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>


--Qrgsu6vtpU/OV/zm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Sep 11, 2012 at 10:56:34AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [120910 23:17]:
> > * Felipe Balbi <balbi@ti.com> [120910 23:02]:
> > =20
> > > >  static int __devinit omap_kp_probe(struct platform_device *pdev)
> > > >  {
> > > > -	struct omap_kp *omap_kp;
> > >=20
> > > ???? I don't see the point for that global omap_kp, actually ...
> >=20
> > Yes you're right. Will send an updated one tomorrow.
>=20
> Here's the updated patch that just removes all omap2+ code,
> and does not use the global omap_kp.
>=20
> Regards,
>=20
> Tony
>=20
>=20
> From: Tony Lindgren <tony@atomide.com>
> Date: Fri, 7 Sep 2012 13:27:58 -0700
> Subject: [PATCH] Input: omap-keypad: Remove dependencies to mach includes
>=20
> Remove support for omap2+ as it's no longer needed since
> it's using matrix-keypad. This way we can remove depency
> to plat and mach headers which is needed for ARM common
> zImage support.
>=20
> Also remove INT_KEYBOARD by using omap_kp->irq.
>=20
> Note that this patch depends on an earlier patch
> "ARM: OMAP: Move gpio.h to include/linux/platform_data".
>=20
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: linux-input@vger.kernel.org
> Signed-off-by: Tony Lindgren <tony@atomide.com>

This looks ok to me from a code standpoint. Sourav how does this look to
you ?

FWIW:

Reviewed-by: Felipe Balbi <balbi@ti.com>

>=20
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -533,7 +533,7 @@ config KEYBOARD_DAVINCI
> =20
>  config KEYBOARD_OMAP
>  	tristate "TI OMAP keypad support"
> -	depends on (ARCH_OMAP1 || ARCH_OMAP2)
> +	depends on ARCH_OMAP1
>  	select INPUT_MATRIXKMAP
>  	help
>  	  Say Y here if you want to use the OMAP keypad.
> diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboar=
d/omap-keypad.c
> index a0222db..2bda5f0b 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -35,13 +35,9 @@
>  #include <linux/mutex.h>
>  #include <linux/errno.h>
>  #include <linux/slab.h>
> -#include <asm/gpio.h>
> +#include <linux/gpio.h>
> +#include <linux/platform_data/gpio-omap.h>
>  #include <plat/keypad.h>
> -#include <plat/menelaus.h>
> -#include <asm/irq.h>
> -#include <mach/hardware.h>
> -#include <asm/io.h>
> -#include <plat/mux.h>
> =20
>  #undef NEW_BOARD_LEARNING_MODE
> =20
> @@ -96,28 +92,8 @@ static u8 get_row_gpio_val(struct omap_kp *omap_kp)
> =20
>  static irqreturn_t omap_kp_interrupt(int irq, void *dev_id)
>  {
> -	struct omap_kp *omap_kp =3D dev_id;
> -
>  	/* disable keyboard interrupt and schedule for handling */
> -	if (cpu_is_omap24xx()) {
> -		int i;
> -
> -		for (i =3D 0; i < omap_kp->rows; i++) {
> -			int gpio_irq =3D gpio_to_irq(row_gpios[i]);
> -			/*
> -			 * The interrupt which we're currently handling should
> -			 * be disabled _nosync() to avoid deadlocks waiting
> -			 * for this handler to complete.  All others should
> -			 * be disabled the regular way for SMP safety.
> -			 */
> -			if (gpio_irq =3D=3D irq)
> -				disable_irq_nosync(gpio_irq);
> -			else
> -				disable_irq(gpio_irq);
> -		}
> -	} else
> -		/* disable keyboard interrupt and schedule for handling */
> -		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> =20
>  	tasklet_schedule(&kp_tasklet);
> =20
> @@ -133,33 +109,22 @@ static void omap_kp_scan_keypad(struct omap_kp *oma=
p_kp, unsigned char *state)
>  {
>  	int col =3D 0;
> =20
> -	/* read the keypad status */
> -	if (cpu_is_omap24xx()) {
> -		/* read the keypad status */
> -		for (col =3D 0; col < omap_kp->cols; col++) {
> -			set_col_gpio_val(omap_kp, ~(1 << col));
> -			state[col] =3D ~(get_row_gpio_val(omap_kp)) & 0xff;
> -		}
> -		set_col_gpio_val(omap_kp, 0);
> -
> -	} else {
> -		/* disable keyboard interrupt and schedule for handling */
> -		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +	/* disable keyboard interrupt and schedule for handling */
> +	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> =20
> -		/* read the keypad status */
> -		omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> -		for (col =3D 0; col < omap_kp->cols; col++) {
> -			omap_writew(~(1 << col) & 0xff,
> -				    OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> +	/* read the keypad status */
> +	omap_writew(0xff, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> +	for (col =3D 0; col < omap_kp->cols; col++) {
> +		omap_writew(~(1 << col) & 0xff,
> +			    OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> =20
> -			udelay(omap_kp->delay);
> +		udelay(omap_kp->delay);
> =20
> -			state[col] =3D ~omap_readw(OMAP1_MPUIO_BASE +
> -						 OMAP_MPUIO_KBR_LATCH) & 0xff;
> -		}
> -		omap_writew(0x00, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> -		udelay(2);
> +		state[col] =3D ~omap_readw(OMAP1_MPUIO_BASE +
> +					 OMAP_MPUIO_KBR_LATCH) & 0xff;
>  	}
> +	omap_writew(0x00, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBC);
> +	udelay(2);
>  }
> =20
>  static void omap_kp_tasklet(unsigned long data)
> @@ -222,14 +187,8 @@ static void omap_kp_tasklet(unsigned long data)
>  		mod_timer(&omap_kp_data->timer, jiffies + delay);
>  	} else {
>  		/* enable interrupts */
> -		if (cpu_is_omap24xx()) {
> -			int i;
> -			for (i =3D 0; i < omap_kp_data->rows; i++)
> -				enable_irq(gpio_to_irq(row_gpios[i]));
> -		} else {
> -			omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> -			kp_cur_group =3D -1;
> -		}
> +		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +		kp_cur_group =3D -1;
>  	}
>  }
> =20
> @@ -242,6 +201,7 @@ static ssize_t omap_kp_enable_show(struct device *dev,
>  static ssize_t omap_kp_enable_store(struct device *dev, struct device_at=
tribute *attr,
>  				    const char *buf, size_t count)
>  {
> +	struct omap_kp *omap_kp =3D dev_get_drvdata(dev);
>  	int state;
> =20
>  	if (sscanf(buf, "%u", &state) !=3D 1)
> @@ -253,9 +213,9 @@ static ssize_t omap_kp_enable_store(struct device *de=
v, struct device_attribute
>  	mutex_lock(&kp_enable_mutex);
>  	if (state !=3D kp_enable) {
>  		if (state)
> -			enable_irq(INT_KEYBOARD);
> +			enable_irq(omap_kp->irq);
>  		else
> -			disable_irq(INT_KEYBOARD);
> +			disable_irq(omap_kp->irq);
>  		kp_enable =3D state;
>  	}
>  	mutex_unlock(&kp_enable_mutex);
> @@ -289,7 +249,7 @@ static int __devinit omap_kp_probe(struct platform_de=
vice *pdev)
>  	struct omap_kp *omap_kp;
>  	struct input_dev *input_dev;
>  	struct omap_kp_platform_data *pdata =3D  pdev->dev.platform_data;
> -	int i, col_idx, row_idx, irq_idx, ret;
> +	int i, col_idx, row_idx, ret;
>  	unsigned int row_shift, keycodemax;
> =20
>  	if (!pdata->rows || !pdata->cols || !pdata->keymap_data) {
> @@ -314,8 +274,7 @@ static int __devinit omap_kp_probe(struct platform_de=
vice *pdev)
>  	omap_kp->input =3D input_dev;
> =20
>  	/* Disable the interrupt for the MPUIO keyboard */
> -	if (!cpu_is_omap24xx())
> -		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> =20
>  	if (pdata->delay)
>  		omap_kp->delay =3D pdata->delay;
> @@ -328,31 +287,8 @@ static int __devinit omap_kp_probe(struct platform_d=
evice *pdev)
>  	omap_kp->rows =3D pdata->rows;
>  	omap_kp->cols =3D pdata->cols;
> =20
> -	if (cpu_is_omap24xx()) {
> -		/* Cols: outputs */
> -		for (col_idx =3D 0; col_idx < omap_kp->cols; col_idx++) {
> -			if (gpio_request(col_gpios[col_idx], "omap_kp_col") < 0) {
> -				printk(KERN_ERR "Failed to request"
> -				       "GPIO%d for keypad\n",
> -				       col_gpios[col_idx]);
> -				goto err1;
> -			}
> -			gpio_direction_output(col_gpios[col_idx], 0);
> -		}
> -		/* Rows: inputs */
> -		for (row_idx =3D 0; row_idx < omap_kp->rows; row_idx++) {
> -			if (gpio_request(row_gpios[row_idx], "omap_kp_row") < 0) {
> -				printk(KERN_ERR "Failed to request"
> -				       "GPIO%d for keypad\n",
> -				       row_gpios[row_idx]);
> -				goto err2;
> -			}
> -			gpio_direction_input(row_gpios[row_idx]);
> -		}
> -	} else {
> -		col_idx =3D 0;
> -		row_idx =3D 0;
> -	}
> +	col_idx =3D 0;
> +	row_idx =3D 0;
> =20
>  	setup_timer(&omap_kp->timer, omap_kp_timer, (unsigned long)omap_kp);
> =20
> @@ -394,27 +330,16 @@ static int __devinit omap_kp_probe(struct platform_=
device *pdev)
> =20
>  	/* scan current status and enable interrupt */
>  	omap_kp_scan_keypad(omap_kp, keypad_state);
> -	if (!cpu_is_omap24xx()) {
> -		omap_kp->irq =3D platform_get_irq(pdev, 0);
> -		if (omap_kp->irq >=3D 0) {
> -			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
> -					"omap-keypad", omap_kp) < 0)
> -				goto err4;
> -		}
> -		omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> -	} else {
> -		for (irq_idx =3D 0; irq_idx < omap_kp->rows; irq_idx++) {
> -			if (request_irq(gpio_to_irq(row_gpios[irq_idx]),
> -					omap_kp_interrupt,
> -					IRQF_TRIGGER_FALLING,
> -					"omap-keypad", omap_kp) < 0)
> -				goto err5;
> -		}
> +	omap_kp->irq =3D platform_get_irq(pdev, 0);
> +	if (omap_kp->irq >=3D 0) {
> +		if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
> +				"omap-keypad", omap_kp) < 0)
> +			goto err4;
>  	}
> +	omap_writew(0, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +
>  	return 0;
> -err5:
> -	for (i =3D irq_idx - 1; i >=3D0; i--)
> -		free_irq(row_gpios[i], omap_kp);
> +
>  err4:
>  	input_unregister_device(omap_kp->input);
>  	input_dev =3D NULL;
> @@ -423,7 +348,6 @@ err3:
>  err2:
>  	for (i =3D row_idx - 1; i >=3D0; i--)
>  		gpio_free(row_gpios[i]);
> -err1:
>  	for (i =3D col_idx - 1; i >=3D0; i--)
>  		gpio_free(col_gpios[i]);
> =20
> @@ -439,18 +363,8 @@ static int __devexit omap_kp_remove(struct platform_=
device *pdev)
> =20
>  	/* disable keypad interrupt handling */
>  	tasklet_disable(&kp_tasklet);
> -	if (cpu_is_omap24xx()) {
> -		int i;
> -		for (i =3D 0; i < omap_kp->cols; i++)
> -			gpio_free(col_gpios[i]);
> -		for (i =3D 0; i < omap_kp->rows; i++) {
> -			gpio_free(row_gpios[i]);
> -			free_irq(gpio_to_irq(row_gpios[i]), omap_kp);
> -		}
> -	} else {
> -		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> -		free_irq(omap_kp->irq, omap_kp);
> -	}
> +	omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> +	free_irq(omap_kp->irq, omap_kp);
> =20
>  	del_timer_sync(&omap_kp->timer);
>  	tasklet_kill(&kp_tasklet);

--=20
balbi

--Qrgsu6vtpU/OV/zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQT4JzAAoJEIaOsuA1yqREp/EQAJh75r+e/tdjs3lERvy266B6
oFqhwrEUxSsH8XK30xqPcjyUmBZHWymQmrvBOJjL6qbSPTYLuJgX0Rc3twxj1P7T
i1xAV/7MUOInp2ZwoaI3rOs9BwDTRlfT4ckvNJOKl7/px++yXeX77THZnTVdD6Gd
kHXP73MpdyoPV0Qljm0lW0+8vjMscqvOcoqzFj8HwMdVQWRV1eu4/e4/81nWjILM
ghz4H8VcEUTnNVVSOqXqOWcjZjGmU9Mkm1utRuW6xCAl+kG6lTTxX2/3kpCoGrUv
ZNqVPEb8pkMVBryB3TQ0ly+N8rvGamw1Za+qyHatTsVdnfYZ+q0+o34kKHimSSyJ
say0KJbxXln2TflUfJ1hJKDFmDNGtb0t0RPgqdTi+TS0dzvqAIwGFfWoT95FCKsv
IyrwIrxR/Yo6am1DQF4BoKgtQgWSXEJOUfsBNrRs+6YmF/ABJWsyde70GpLY7ZGB
R1iP5wCr8ln3uAZ09nS0nttsYi+grpL8/NGZ57D3Y+U7tOd8VL0QVFhv926ibE0g
s5/7gmSCOiNVCK/YXtFBDwNqa6rouRWcW1sGypT1mFXF85vU9eDyE6JCrPeTp19F
t49lyuNdqvChfFWFW9d8froqd7WZ6XJ7WEa++FTzJhM9rEd6NsC1bxYRMGeZRQUm
ImI4PGBwCuODO3xE07Y3
=uMUC
-----END PGP SIGNATURE-----

--Qrgsu6vtpU/OV/zm--
