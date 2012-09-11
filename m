From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 07/17] Input: omap-keypad: Remove dependencies to mach
 includes
Date: Tue, 11 Sep 2012 08:57:13 +0300
Message-ID: <20120911055709.GB17865@arwen.pp.htv.fi>
References: <20120911052934.29637.9190.stgit@muffinssi.local>
 <20120911053059.29637.22108.stgit@muffinssi.local>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Return-path: <linux-input-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20120911053059.29637.22108.stgit@muffinssi.local>
Sender: linux-input-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input@vger.kernel.org, Sourav Poddar <sourav.poddar@ti.com>
List-Id: linux-omap@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Sep 10, 2012 at 10:30:59PM -0700, Tony Lindgren wrote:
> We can't build CONFIG_ARCH_OMAP1 set with ARCH_OMAP2PLUS because
> of different compiler flags needed, so we can define omap_kp_24xx()
> instead of using cpu_is_omap24xx(). This way we can remove
> depency to plat and mach headers which is needed for ARM common
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
> ---
>  drivers/input/keyboard/omap-keypad.c |   34 ++++++++++++++++++----------=
------
>  1 file changed, 18 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/omap-keypad.c b/drivers/input/keyboar=
d/omap-keypad.c
> index a0222db..171d739 100644
> --- a/drivers/input/keyboard/omap-keypad.c
> +++ b/drivers/input/keyboard/omap-keypad.c
> @@ -35,16 +35,19 @@
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
> +#ifdef CONFIG_ARCH_OMAP1
> +#define omap_kp_24xx()		0
> +#else
> +#define omap_kp_24xx()		1
> +#endif

I would rather use revision detection or different driver names (if
revision register is broken).

> +static struct omap_kp *omap_kp;

please don't. This will prevent multiple instances of this driver. Even
though I don't think we will ever have an omap with multiple keypad
instances, it's still not a good practice IMHO.

Also, this ends up being "hidden" (if you have a better work let me
know) in most functions since they either pass omap_kp as argument or
define a local omap_kp variable.

Sourav, is the revision register on this IP working fine across multiple
OMAPs ?

>  static void omap_kp_tasklet(unsigned long);
>  static void omap_kp_timer(unsigned long);
> =20
> @@ -99,7 +102,7 @@ static irqreturn_t omap_kp_interrupt(int irq, void *de=
v_id)
>  	struct omap_kp *omap_kp =3D dev_id;
> =20
>  	/* disable keyboard interrupt and schedule for handling */
> -	if (cpu_is_omap24xx()) {
> +	if (omap_kp_24xx()) {
>  		int i;
> =20
>  		for (i =3D 0; i < omap_kp->rows; i++) {
> @@ -134,7 +137,7 @@ static void omap_kp_scan_keypad(struct omap_kp *omap_=
kp, unsigned char *state)
>  	int col =3D 0;
> =20
>  	/* read the keypad status */
> -	if (cpu_is_omap24xx()) {
> +	if (omap_kp_24xx()) {
>  		/* read the keypad status */
>  		for (col =3D 0; col < omap_kp->cols; col++) {
>  			set_col_gpio_val(omap_kp, ~(1 << col));
> @@ -222,7 +225,7 @@ static void omap_kp_tasklet(unsigned long data)
>  		mod_timer(&omap_kp_data->timer, jiffies + delay);
>  	} else {
>  		/* enable interrupts */
> -		if (cpu_is_omap24xx()) {
> +		if (omap_kp_24xx()) {
>  			int i;
>  			for (i =3D 0; i < omap_kp_data->rows; i++)
>  				enable_irq(gpio_to_irq(row_gpios[i]));
> @@ -253,9 +256,9 @@ static ssize_t omap_kp_enable_store(struct device *de=
v, struct device_attribute
>  	mutex_lock(&kp_enable_mutex);
>  	if (state !=3D kp_enable) {
>  		if (state)
> -			enable_irq(INT_KEYBOARD);
> +			enable_irq(omap_kp->irq);
>  		else
> -			disable_irq(INT_KEYBOARD);
> +			disable_irq(omap_kp->irq);

GREAT!! :-)

>  		kp_enable =3D state;
>  	}
>  	mutex_unlock(&kp_enable_mutex);
> @@ -286,7 +289,6 @@ static int omap_kp_resume(struct platform_device *dev)
> =20
>  static int __devinit omap_kp_probe(struct platform_device *pdev)
>  {
> -	struct omap_kp *omap_kp;

???? I don't see the point for that global omap_kp, actually ...

>  	struct input_dev *input_dev;
>  	struct omap_kp_platform_data *pdata =3D  pdev->dev.platform_data;
>  	int i, col_idx, row_idx, irq_idx, ret;
> @@ -314,7 +316,7 @@ static int __devinit omap_kp_probe(struct platform_de=
vice *pdev)
>  	omap_kp->input =3D input_dev;
> =20
>  	/* Disable the interrupt for the MPUIO keyboard */
> -	if (!cpu_is_omap24xx())
> +	if (!omap_kp_24xx())
>  		omap_writew(1, OMAP1_MPUIO_BASE + OMAP_MPUIO_KBD_MASKIT);
> =20
>  	if (pdata->delay)
> @@ -328,7 +330,7 @@ static int __devinit omap_kp_probe(struct platform_de=
vice *pdev)
>  	omap_kp->rows =3D pdata->rows;
>  	omap_kp->cols =3D pdata->cols;
> =20
> -	if (cpu_is_omap24xx()) {
> +	if (omap_kp_24xx()) {
>  		/* Cols: outputs */
>  		for (col_idx =3D 0; col_idx < omap_kp->cols; col_idx++) {
>  			if (gpio_request(col_gpios[col_idx], "omap_kp_col") < 0) {
> @@ -394,7 +396,7 @@ static int __devinit omap_kp_probe(struct platform_de=
vice *pdev)
> =20
>  	/* scan current status and enable interrupt */
>  	omap_kp_scan_keypad(omap_kp, keypad_state);
> -	if (!cpu_is_omap24xx()) {
> +	if (!omap_kp_24xx()) {
>  		omap_kp->irq =3D platform_get_irq(pdev, 0);
>  		if (omap_kp->irq >=3D 0) {
>  			if (request_irq(omap_kp->irq, omap_kp_interrupt, 0,
> @@ -439,7 +441,7 @@ static int __devexit omap_kp_remove(struct platform_d=
evice *pdev)
> =20
>  	/* disable keypad interrupt handling */
>  	tasklet_disable(&kp_tasklet);
> -	if (cpu_is_omap24xx()) {
> +	if (omap_kp_24xx()) {
>  		int i;
>  		for (i =3D 0; i < omap_kp->cols; i++)
>  			gpio_free(col_gpios[i]);
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
balbi

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQTtK1AAoJEIaOsuA1yqRErNYP/RhzImVmxYhBZCG6rh+XXJ+y
Ks1cYiKh42ieTr1ZbWZnnzWFAAtlihD2Sw0cqaLULkSner7+xqWMxABKiFSThigx
x6DV/x2Fu2pySLTaPltF7qx3kfVvah43StEV7TJ3S3GYHMpoGEmpKBVHQqzRX/SN
XkmE9t+IkGr0pDSWGRLxh2UvXgRbb0k5r0C//Ah6BmliPzU3YW/GH9dvmjNFZG1k
em/zcLvGPsLqrI83ivKACH73/OWMIxbOA2mYW1OhFJParn7lrDiEE9HTMbj9szvy
Uib44r+gcJphiWEpJuXzIpYfA/h3PkgF/4coxOiDm6iCCsns0b5+d9BUJEv7Wi7q
3c/tSKkd4v8LSfqV5gkoP3u2Gj8RgZ1GkF1w8XuY4lbiVFR52atihFMdR4WsN3j6
QjMUlBKZ/P44Jw8KqHxH603ymazNR60pUWEyUTLoXOQzl+37de6cG4k909AP7Q0u
6H9j7SKlZvNBpDx+9HRvzS8Pdo5pIWDX+Qc/GJb0Xm5IZcL4wIwRYIqv79qWttye
Umd+lcHnYRuAdDfu6/3497tb46/2h0LyoQNHsRQcRjBCGoErUzESQBxwSK9t78AC
g1L01S+/VMYH84i6aNQ5fGfPMn1U+iCGrNA6K+XdVJmbSLH1e0iG6tIKfcGrhIED
QR7Mq7aqsN7P3D+fQuMe
=0uDd
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
