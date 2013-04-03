From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Subject: Re: [PATCH 05/33] arm: omap: board-cm-t35: use generic dpi panel's
 gpio handling
Date: Wed, 3 Apr 2013 15:02:02 +0300
Message-ID: <515C1A3A.6050906@ti.com>
References: <1360765345-19312-1-git-send-email-archit@ti.com> <1360765345-19312-6-git-send-email-archit@ti.com> <511BAE50.2090507@compulab.co.il> <511BB113.3020108@ti.com> <511BB87E.60003@ti.com> <511C8A83.5070407@compulab.co.il> <511C8D8F.9060805@ti.com> <511CA247.80606@compulab.co.il> <511CA9B3.70401@ti.com> <511CB1B3.80605@compulab.co.il> <511CC37C.3020706@ti.com> <511CDA91.1050300@compulab.co.il> <511CDE12.60701@ti.com> <511CEBC4.6050400@compulab.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigE7C1FCF36BA9F8727FAA4D83"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:35326 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758776Ab3DCMCH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Apr 2013 08:02:07 -0400
In-Reply-To: <511CEBC4.6050400@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Archit Taneja <archit@ti.com>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tony Lindgren <tony@atomide.com>

--------------enigE7C1FCF36BA9F8727FAA4D83
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-02-14 15:51, Igor Grinberg wrote:
> On 02/14/13 14:52, Tomi Valkeinen wrote:
>> On 2013-02-14 14:37, Igor Grinberg wrote:
>>> On 02/14/13 12:59, Tomi Valkeinen wrote:
>>>> On 2013-02-14 11:43, Igor Grinberg wrote:
>>>
>>>>>> True, it's generic, but does it work reliably? The panel hardware =
is now
>>>>>> partly handled in the backlight driver, and partly in the omap's p=
anel
>>>>>> driver (and wherever on other platforms).
>>>>>
>>>>> It works reliably on other platforms, but not on OMAP - because
>>>>> we need to cope with the OMAP specific framework...
>>>
>>>> How do you handle the gpios on other platform? Those are the ones
>>>> causing the issues here, right?
>>>
>>> Well, I'm also talking about something that is a history already.
>>> Remember, we had multiple panel drivers inside the
>>> video/omap2/displays and then they were consolidated into the
>>> "generic dpi/dsi/whatever".
>=20
>> Sorry, I miss the point. Was that a bad thing? Didn't it simplify the
>> task for you with simple panels? It could've been taken even further,
>> though (see below).
>=20
> Yes it was a good thing (I have already told this below).
>=20
>=20
>>> And yes you are right, on the platforms I'm aware of, the GPIO is not=

>>> handled. Apparently its hardware default (pull resistor) is always on=
=2E..
>=20
>> Ok, so the simple fix of setting the GPIOs only in the board file is
>> acceptable for now.
>=20
> Yep. I also told this already in one of the previous emails.
>=20
>=20
>> Can the LCD_BL_GPIO be handled by the omap panel driver? Otherwise the=

>> backlight will supposedly be always on. Is it just a simple switch for=

>> the BL power, which does not affect the SPI in any way?
>=20
> Yes, it can for now.
> Also, I think we should also take into account the backlight framework,=

> including PMW.

I've updated this patch to set the LCD EN gpio once at boot time, and pas=
s the
LCD BL gpio to the panel driver. Updated patch below.

---

commit a58a72363aa4359cdb75878de1517bd50faf9eb4
Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date:   Mon Dec 3 16:05:06 2012 +0530

    arm: omap: board-cm-t35: use generic dpi panel's gpio handling
   =20
    The cm-t35 board file currently requests gpios required to configure =
the tdo35s
    panel, and provides platform_enable/disable callbacks to configure th=
em.
   =20
    These tasks have been moved to the generic dpi panel driver itself an=
d shouldn't
    be done in the board files.
   =20
    Remove the gpio requests and the platform callbacks from the board fi=
le.
    Add the gpio information to generic dpi panel's platform data so that=
 it's
    passed to the panel driver.
   =20
    Note: Only BL enable gpio is handled in the panel driver. The LCD ena=
ble
    GPIO is handled in the board file at init time, as there's a 50 ms de=
lay
    required when using the GPIO, and the panel driver doesn't know about=

    that.
   =20
    Cc: Tony Lindgren <tony@atomide.com>
    Cc: Igor Grinberg <grinberg@compulab.co.il>
    Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/boa=
rd-cm-t35.c
index bccd3e5..cccbfea 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -190,32 +190,6 @@ static inline void cm_t35_init_nand(void) {}
 #define CM_T35_LCD_BL_GPIO 58
 #define CM_T35_DVI_EN_GPIO 54
=20
-static int lcd_enabled;
-static int dvi_enabled;
-
-static int cm_t35_panel_enable_lcd(struct omap_dss_device *dssdev)
-{
-	if (dvi_enabled) {
-		printk(KERN_ERR "cannot enable LCD, DVI is enabled\n");
-		return -EINVAL;
-	}
-
-	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
-	gpio_set_value(CM_T35_LCD_BL_GPIO, 1);
-
-	lcd_enabled =3D 1;
-
-	return 0;
-}
-
-static void cm_t35_panel_disable_lcd(struct omap_dss_device *dssdev)
-{
-	lcd_enabled =3D 0;
-
-	gpio_set_value(CM_T35_LCD_BL_GPIO, 0);
-	gpio_set_value(CM_T35_LCD_EN_GPIO, 0);
-}
-
 static int cm_t35_panel_enable_tv(struct omap_dss_device *dssdev)
 {
 	return 0;
@@ -227,8 +201,10 @@ static void cm_t35_panel_disable_tv(struct omap_dss_=
device *dssdev)
=20
 static struct panel_generic_dpi_data lcd_panel =3D {
 	.name			=3D "toppoly_tdo35s",
-	.platform_enable	=3D cm_t35_panel_enable_lcd,
-	.platform_disable	=3D cm_t35_panel_disable_lcd,
+	.num_gpios		=3D 1,
+	.gpios			=3D {
+		CM_T35_LCD_BL_GPIO,
+	},
 };
=20
 static struct omap_dss_device cm_t35_lcd_device =3D {
@@ -292,11 +268,6 @@ static struct spi_board_info cm_t35_lcd_spi_board_in=
fo[] __initdata =3D {
 	},
 };
=20
-static struct gpio cm_t35_dss_gpios[] __initdata =3D {
-	{ CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,  "lcd enable"    },
-	{ CM_T35_LCD_BL_GPIO, GPIOF_OUT_INIT_LOW,  "lcd bl enable" },
-};
-
 static void __init cm_t35_init_display(void)
 {
 	int err;
@@ -304,23 +275,21 @@ static void __init cm_t35_init_display(void)
 	spi_register_board_info(cm_t35_lcd_spi_board_info,
 				ARRAY_SIZE(cm_t35_lcd_spi_board_info));
=20
-	err =3D gpio_request_array(cm_t35_dss_gpios,
-				 ARRAY_SIZE(cm_t35_dss_gpios));
+
+	err =3D gpio_request_one(CM_T35_LCD_EN_GPIO, GPIOF_OUT_INIT_LOW,
+			"lcd bl enable");
 	if (err) {
-		pr_err("CM-T35: failed to request DSS control GPIOs\n");
+		pr_err("CM-T35: failed to request LCD EN GPIO\n");
 		return;
 	}
=20
-	gpio_export(CM_T35_LCD_EN_GPIO, 0);
-	gpio_export(CM_T35_LCD_BL_GPIO, 0);
-
 	msleep(50);
 	gpio_set_value(CM_T35_LCD_EN_GPIO, 1);
=20
 	err =3D omap_display_init(&cm_t35_dss_data);
 	if (err) {
 		pr_err("CM-T35: failed to register DSS device\n");
-		gpio_free_array(cm_t35_dss_gpios, ARRAY_SIZE(cm_t35_dss_gpios));
+		gpio_free(CM_T35_LCD_EN_GPIO);
 	}
 }
=20



--------------enigE7C1FCF36BA9F8727FAA4D83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXBo6AAoJEPo9qoy8lh718gcP/1EiSLj1wZR33i9Rhpk6aFOp
+GzHpv2vZG+P8n9v0GnfPXsvfX1sEMjUZIMznm4qnqXzWLUW8fS0eZvcZ/T4cKM9
v83h6yF7jRHH2FBMzcmnIksNyEnrKfmBpJQ0e9Zqluzu8cBTZwtg739/PF1n5rCb
IXxIsPsPA8GtrYrp7jKoLSN7jVKr776zptpkwP/76VWJG7r11SfKAKV7UT3nqn9J
Y/w3/4YPJSbPVqV77EfHQ3hOWjGsIaRoFGsT+NZe4zZXQ32ljr5jNgZ+A4AFgfIi
cBVIbIlkhEBfAADi/JTbdPfouWr59vNZYzAYAIjWaemWUsAIgaaQ0EbI2mCwjwvQ
gyffV+4kAOSOntWYxk3rmL17ryzNZZwBGjSe1kgWZZpZOpMfeMrUsZiu2yMhqrVv
cz9zVNA2BDsZPBkhygESGR3owRNW7ZhWIPVApgSmnG2H+17X4MHs+HGiVNubLEgf
KXoeJpLljo5i6MP0p/OIz4DZiUqBwXxfIb010OQtZeCzKpYAKMVRt11Kvwyitr+a
jUD2VogKjKRvJbddbdaJRrixJ0/7nhGyDDznQGliRTRj42/GWlZOg3FxeUjgWr0f
vtbtEQDhs0XJQMV/RJI0LmSCc0yzTGe8evugh42+QvABZv9Z27yZimxlArjHFw0z
5WU+kuyDAFoP94zuPs0d
=TaHV
-----END PGP SIGNATURE-----

--------------enigE7C1FCF36BA9F8727FAA4D83--
