From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH] cbus: Fix lines for Nokia 770
Date: Thu, 23 Feb 2012 10:46:34 +0200
Message-ID: <20120223084633.GB18463@legolas.emea.dhcp.ti.com>
References: <20120222220937.GM18185@atomide.com>
Reply-To: balbi@ti.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:44235 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750861Ab2BWIqi (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Feb 2012 03:46:38 -0500
Received: by mail-lpp01m010-f46.google.com with SMTP id u2so1433017lag.5
        for <linux-omap@vger.kernel.org>; Thu, 23 Feb 2012 00:46:37 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20120222220937.GM18185@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Feb 22, 2012 at 02:09:37PM -0800, Tony Lindgren wrote:
> From 54c4785b8d274f8d282b4243945ae0b17edf4686 Mon Sep 17 00:00:00 2001
> From: Tony Lindgren <tony@atomide.com>
> Date: Wed, 22 Feb 2012 13:03:07 -0800
> Subject: [PATCH] cbus: Fix lines for Nokia 770
>=20
> This makes retu and tahvo work again on Nokia 770 so it
> stays running.
>=20
> Signed-off-by: Tony Lindgren <tony@atomide.com>
>=20
> ---
>=20
> I applied this into cbus branch as it seems to fix retu
> watchdog for Nokia 770.
>=20
> --- a/arch/arm/mach-omap1/board-nokia770.c
> +++ b/arch/arm/mach-omap1/board-nokia770.c
> @@ -87,9 +87,9 @@ static struct platform_device nokia770_kp_device =3D {
>  #if defined(CONFIG_CBUS) || defined(CONFIG_CBUS_MODULE)
> =20
>  static struct cbus_host_platform_data nokia770_cbus_data =3D {
> -	.clk_gpio	=3D OMAP_MPUIO(11),
> +	.clk_gpio	=3D OMAP_MPUIO(9),
>  	.dat_gpio	=3D OMAP_MPUIO(10),
> -	.sel_gpio	=3D OMAP_MPUIO(9),
> +	.sel_gpio	=3D OMAP_MPUIO(11),
>  };
> =20
>  static struct platform_device nokia770_cbus_device =3D {

Has this been wrong since the beginning ? Looking at commit d64193bd, I
just moved whatever was on cbus.c to respective board-files.

Look at these snippets:

commit d64193bd89bad6a1dab55a62940808789d68ecc2
Author: Felipe Balbi <felipe.balbi@nokia.com>
Date:   Tue Aug 3 12:09:59 2010 +0300

    cbus: add platform_data to pass gpios
   =20
    also add the platform_data to the related
    board files.
   =20
    Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
    Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap1/board-nokia770.c b/arch/arm/mach-omap1/boa=
rd-nokia770.c
index 6423671..ce23990 100644
--- a/arch/arm/mach-omap1/board-nokia770.c
+++ b/arch/arm/mach-omap1/board-nokia770.c

[snip]

@@ -95,9 +96,18 @@ static struct platform_device nokia770_kp_device =3D {
 	.resource	=3D nokia770_kp_resources,
 };
=20
+static struct cbus_host_platform_data nokia770_cbus_data =3D {
+	.clk_gpio	=3D OMAP_MPUIO(11),
+	.dat_gpio	=3D OMAP_MPUIO(10),
+	.sel_gpio	=3D OMAP_MPUIO(9),
+};
+
 static struct platform_device nokia770_cbus_device =3D {
 	.name		=3D "cbus",
 	.id		=3D -1,
+	.dev		=3D {
+		.platform_data =3D &nokia770_cbus_data,
+	},
 };
=20
 static struct platform_device *nokia770_devices[] __initdata =3D {

[snip]

diff --git a/drivers/cbus/cbus.c b/drivers/cbus/cbus.c
index a35941e..00c3c32 100644
--- a/drivers/cbus/cbus.c
+++ b/drivers/cbus/cbus.c

[ snip]

@@ -234,31 +236,9 @@ static int __init cbus_bus_probe(struct platform_devic=
e *pdev)
=20
 	spin_lock_init(&chost->lock);
=20
-	/* REVISIT: Pass these from board-*.c files in platform_data */
-	if (machine_is_nokia770()) {
-		chost->clk_gpio =3D OMAP_MPUIO(11);
-		chost->dat_gpio =3D OMAP_MPUIO(10);
-		chost->sel_gpio =3D OMAP_MPUIO(9);
-	} else if (machine_is_nokia_n800() || machine_is_nokia_n810() ||
-			machine_is_nokia_n810_wimax()) {
-		chost->clk_gpio =3D 66;
-		chost->dat_gpio =3D 65;
-		chost->sel_gpio =3D 64;
-	} else {
-		printk(KERN_ERR "cbus: Unsupported board\n");
-		ret =3D -ENODEV;
-		goto exit1;
-	}
-
-#ifdef CONFIG_ARCH_OMAP1
-	if (!OMAP_GPIO_IS_MPUIO(chost->clk_gpio) ||
-	    !OMAP_GPIO_IS_MPUIO(chost->dat_gpio) ||
-	    !OMAP_GPIO_IS_MPUIO(chost->sel_gpio)) {
-		printk(KERN_ERR "cbus: Only MPUIO pins supported\n");
-		ret =3D -ENODEV;
-		goto exit1;
-	}
-#endif
+	chost->clk_gpio =3D pdata->clk_gpio;
+	chost->dat_gpio =3D pdata->dat_gpio;
+	chost->sel_gpio =3D pdata->sel_gpio;
=20
 	if ((ret =3D gpio_request(chost->clk_gpio, "CBUS clk")) < 0)
 		goto exit1;

--=20
balbi

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRfzpAAoJEIaOsuA1yqREI1UP/RxXcUaJw9jPrgBMCVnuj7qS
6y2MT2YofuOySghPw7ZkmTHFZDh2r4Lj/aVEsBDBuHDYQqgHUEd8/AtkELZjy7dm
bscHa3D7ywNGPRZd7q9NkMqxqJLAej9i1GS9MYau5DljA5z0xcdOuhoyApqLFNLg
qlDdGfpygMeXMRfFpBwMbtbvnqgJzlq6ZQrWqfgwksGjCTThRK47ynkqIQ8plVJj
IbCesldpVfOBxE+ZuMRZbgS1rxLlkueLzXEA7hhBxkKsmPtcW4y+I9kK6ZpQaUAu
T60LyjKH4+KoI+jkLlD7XwIAqaR39nyhqm/nhktjOmaTYxCS+DS4wnbLA9g5qLM4
XKgGF7BcgtW3/8Z1D89G34IZwL1yAxcYwhKwFOo5uz6Y4GICRkWqQrcdeNrZ7yQm
ofh4LZHT70QFhZF01pNf3b17BfwvTktbfu5F/4strAjwfj8eWmFe4YuorWDR5PVm
gLhLTLNiU/48Ei5puMcW+uPjXtYKniSWqF6aFG9ny5KZzcZHEg0VDi3/DGsH5kSx
zVs9llfn+94iyYOV6CLo+mPtRDs5nFQsobjtRxCdiP/xx3VfLhcLwF0lG4LceBva
vdJfptLNHlbjyzzMxhcynxYxrDr9m6w27Uzu3mO07EjLy8pvHXMW+YuOgWWm197i
kfcqZHrNTO4+JfnrkMPG
=N6Ib
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
