From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH v2] ARM: OMAP3LOGIC: Adding DSS support
Date: Wed, 14 Dec 2011 10:39:07 +0200
Message-ID: <1323851947.1873.95.camel@deskari>
References: <1323762769-25045-1-git-send-email-alexg@meprolight.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-7/79tVSdVrVLkb3LEWqn"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog108.obsmtp.com ([74.125.149.199]:40167 "EHLO
	na3sys009aog108.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753420Ab1LNIjM (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 14 Dec 2011 03:39:12 -0500
Received: by mail-lpp01m010-f49.google.com with SMTP id c1so221382lah.8
        for <linux-omap@vger.kernel.org>; Wed, 14 Dec 2011 00:39:11 -0800 (PST)
In-Reply-To: <1323762769-25045-1-git-send-email-alexg@meprolight.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Alex <alexg@meprolight.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, tim.nordell@logicpd.com, baruch@tkos.co.il


--=-7/79tVSdVrVLkb3LEWqn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2011-12-13 at 09:52 +0200, Alex wrote:
> This patch adds DSS2 support to the LogicPD OMAP 35x Torpedo boardfile. L=
CD and
> TV-out are supported.
>=20
> Signed-off-by: Alex Gershgorin <alexg@meprolight.com>

Overall looks fine. A few questions below about the GPIOs, though.

<snip>

> +static void __init omap3logic_display_init(void)
> +{
> +	int r;
> +
> +	r =3D gpio_request_array(omap3logic_dss_gpios,
> +			       ARRAY_SIZE(omap3logic_dss_gpios));
> +	if (r) {
> +		printk(KERN_ERR "failed to get lcd_panel_* gpios\n");
> +		return;
> +	}
> +
> +	gpio_export(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_export(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);

Why do you want to export these GPIOs? They are handled here in the
board file, and I don't think there's any reason the userspace would
need to touch them.

> +	gpio_set_value(OMAP3_TORPEDO_LCD_BACKLIGHT_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_ENABLE_GPIO, 0);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 0);

These are already set to 0 in gpio_request_array, as you've defined the
flag "GPIOF_OUT_INIT_LOW".

> +
> +	msleep(50);
> +	gpio_set_value(OMAP3_TORPEDO_LCD_PWM_GPIO, 1);

What does this do, and why do you need msleep(50)? I understand
LCD_ENABLE gpio enables the LCD panel, but what exactly do LCD_BACKLIGHT
and LCD_PWM gpios do? Why don't you set/unset LCD_PWM in the panel
enable/disable functions like the other gpios?

 Tomi


--=-7/79tVSdVrVLkb3LEWqn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJO6GCrAAoJEPo9qoy8lh71tlIP/2zKK+X1/kcbY4CY2OeJXZ8n
h8LpiQaGeIi6gqW80Bm2RFYRbTOxskOBBv5xX1BI/owFWpgVOwa0fv9ngY0WuCfK
x7uieIdcyW5+v6MfR71yggd9FlnVOO7uSYBAYC5xWT0TWxIXFsOtnfBEVIwOKysj
PCmROmF3ZBogSlOoJe3KApGfmxHjkNmCnsRT9gVUxt5Tv5W3WlIjT3n6EPUQl/yn
KS9uf+pfi6NFRaRt3s1tpvyiXuMPlRBDm10DOaoCGmkgweoX/7QveER6W1xRXBfF
KC67s71PueMqfwkQWD6FaXnxrpger19SYeMgOaMQR/8DYnLO7th7l9ctRJW7UCbJ
qvLOiOGkqvK0rcniml5VhWTBS/HhjTjs3dMIVEw9p6cj3IBdJZ5M6gH/GDqO9g9n
ejq0wLHGan8Tv/NpC0I65ZyHbNiqWvet2Kw0uSnj73kcgn8S0kJLg37XdTQRjX0Z
mNjpzMMfgYg8XHdeFBLPn5eQJDuEEBtlsRGXe4+Mkzf0aL0oTBQy+w5MMJ9bsjg6
Ldy8cHopyznbPjPsGFaA5KF526ytH1PT/LGyDgMUmzuT80Nb4BfdJyrGM95EVK13
mBmDpm5Fd4b8vc3UdTh7yHNPmcsXf0tMlrsU+okf8LKDlqamoHUi7/rtKe/8VDvq
pcmaJPQxrSHaMpnxPxCg
=uvmC
-----END PGP SIGNATURE-----

--=-7/79tVSdVrVLkb3LEWqn--

