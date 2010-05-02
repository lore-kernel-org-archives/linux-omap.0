From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v9] board-omap3-beagle: add DSS2 support
Date: Sun, 2 May 2010 18:58:59 +0300
Message-ID: <l2l94a0d4531005020858l1a79e4f3hf632a7fab4e4ff33@mail.gmail.com>
References: <1271924622-21043-1-git-send-email-koen@dominion.thruhere.net>
	 <0BA15D46-D494-4402-9EC8-574AD5D7BAE8@dominion.thruhere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bw0-f219.google.com ([209.85.218.219]:64017 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757139Ab0EBP7B convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 2 May 2010 11:59:01 -0400
Received: by bwz19 with SMTP id 19so904078bwz.21
        for <linux-omap@vger.kernel.org>; Sun, 02 May 2010 08:59:00 -0700 (PDT)
In-Reply-To: <0BA15D46-D494-4402-9EC8-574AD5D7BAE8@dominion.thruhere.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Koen Kooi <koen@dominion.thruhere.net>
Cc: "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Tony Lindgren <tony@atomide.com>

On Tue, Apr 27, 2010 at 10:58 AM, Koen Kooi <koen@dominion.thruhere.net=
> wrote:
> No more comments? Can it go in?
>
> Op 22 apr 2010, om 10:23 heeft Koen Kooi het volgende geschreven:
>
>> This patch adds DSS2 support to the beagleboard boardfile. DVI and T=
V-out are supported.
>>
>> Signed-off-by: Koen Kooi <koen@dominion.thruhere.net>
>> ---
>> Changes since v1:
>> =C2=A0 =C2=A0* removed beagle_panel_enable_tv() and beagle_panel_dis=
able_tv()
>> Changes since v2:
>> =C2=A0 =C2=A0* changed to REGULATOR_SUPPLY(_name, _dev_name) for dss=
 regulators
>> Changes since v3:
>> =C2=A0 =C2=A0* really remove beagle_panel_enable_tv() and beagle_pan=
el_disable_tv()
>> =C2=A0 =C2=A0* moved comments to this section
>> Changes since v4:
>> =C2=A0 =C2=A0* remove trailing whitespace
>> Changes since v5:
>> =C2=A0 =C2=A0* fix semicolon typo
>> Changes since v6:
>> =C2=A0 =C2=A0* use gpio_is_valid(dssdev->reset_gpio)
>> Changes since v8:
>> =C2=A0 =C2=A0* fix missing whitespace before __init omap3_beagle_map=
_io(){}
>>
>> arch/arm/mach-omap2/board-omap3beagle.c | =C2=A0101 ++++++++++++++++=
+++++++--------
>> 1 files changed, 75 insertions(+), 26 deletions(-)

I also have these changes in one of my trees backported from Tomi
Valkeinen's tree. I'm attaching the diff; some of these are cosmetic,
but I think the gpio changes make sense, although I don't know if
omap_mux_init_gpio is really needed.

I think the current proposed patch should go in already, I don't know
what we are waiting for.

--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -39,11 +39,11 @@

 #include <plat/board.h>
 #include <plat/common.h>
-#include <plat/display.h>
 #include <plat/gpmc.h>
 #include <plat/nand.h>
 #include <plat/usb.h>
 #include <plat/timer-gp.h>
+#include <plat/display.h>

 #include "mux.h"
 #include "mmc-twl4030.h"
@@ -169,6 +169,10 @@ static void __init beagle_display_init(void)
 {
 	int r;

+#if 0
+	/* is this really needed? */
+	omap_mux_init_gpio(beagle_dvi_device.reset_gpio, OMAP_PIN_INPUT);
+#endif
 	r =3D gpio_request(beagle_dvi_device.reset_gpio, "DVI reset");
 	if (r < 0) {
 		printk(KERN_ERR "Unable to get DVI reset GPIO\n");
@@ -279,6 +283,7 @@ static struct regulator_init_data beagle_vdac =3D {
 	.constraints =3D {
 		.min_uV			=3D 1800000,
 		.max_uV			=3D 1800000,
+		.apply_uV		=3D true,
 		.valid_modes_mask	=3D REGULATOR_MODE_NORMAL
 					| REGULATOR_MODE_STANDBY,
 		.valid_ops_mask		=3D REGULATOR_CHANGE_MODE
@@ -414,9 +419,9 @@ static void __init omap3_beagle_init_irq(void)
 }

 static struct platform_device *omap3_beagle_devices[] __initdata =3D {
+	&beagle_dss_device,
 	&leds_gpio,
 	&keys_gpio,
-	&beagle_dss_device,
 };

 static void __init omap3beagle_flash_init(void)
@@ -485,20 +490,14 @@ static void __init omap3_beagle_init(void)
 			ARRAY_SIZE(omap3_beagle_devices));
 	omap_serial_init();

-	omap_mux_init_gpio(170, OMAP_PIN_INPUT);
-	gpio_request(170, "DVI_nPD");
-	/* REVISIT leave DVI powered down until it's needed ... */
-	gpio_direction_output(170, true);
-
 	usb_musb_init();
 	usb_ehci_init(&ehci_pdata);
 	omap3beagle_flash_init();
+	beagle_display_init();

 	/* Ensure SDRC pins are mux'd for self-refresh */
 	omap_mux_init_signal("sdrc_cke0", OMAP_PIN_OUTPUT);
 	omap_mux_init_signal("sdrc_cke1", OMAP_PIN_OUTPUT);
-
-	beagle_display_init();
 }

 static void __init omap3_beagle_map_io(void)

--=20
=46elipe Contreras
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
