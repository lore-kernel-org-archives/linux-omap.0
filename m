From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 9/9] i2c: move twl4030-madc to new registration style
Date: Fri, 26 Sep 2008 12:50:50 -0700
Message-ID: <200809261250.50893.david-b@pacbell.net>
References: <1222427996-7018-1-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-9-git-send-email-felipe.balbi@nokia.com> <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp125.sbc.mail.sp1.yahoo.com ([69.147.65.184]:46971 "HELO
	smtp125.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752187AbYIZTux (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 26 Sep 2008 15:50:53 -0400
In-Reply-To: <1222427996-7018-10-git-send-email-felipe.balbi@nokia.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <felipe.balbi@nokia.com>
Cc: linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Mikko Ylinen <mikko.k.ylinen@nokia.com>, Steve Sakoman <sakoman@gmail.com>

On Friday 26 September 2008, Felipe Balbi wrote:
> =A0arch/arm/mach-omap2/board-omap3beagle.c | =A0 =A06 +
> =A0arch/arm/mach-omap2/board-overo.c =A0 =A0 =A0 | =A0 =A06 +

=46or the record:  this reverts those two little evil additions;
build fix, and correctness update for at least Beagle.

Steve, if Overo wires out any of the ADC channels on that
one connector, you may want to come up with a better fox.

- Dave

=3D=3D=3D=3D=3D=3D SNIP!
--- beagle.orig/arch/arm/mach-omap2/board-omap3beagle.c	2008-09-26 12:4=
7:36.000000000 -0700
+++ beagle/arch/arm/mach-omap2/board-omap3beagle.c	2008-09-26 09:55:50.=
000000000 -0700
@@ -114,11 +114,6 @@ static struct twl4030_usb_data beagle_us
 	.usb_mode	=3D T2_USB_MODE_ULPI,
 };
=20
-static struct twl4030_madc_platform_data beagle_madc_data =3D {
-	.imr		=3D TWL4030_MADC_IMR1,
-	.isr		=3D TWL4030_MADC_ISR1,
-};
-
 static struct twl4030_gpio_platform_data beagle_gpio_data =3D {
 	.gpio_base	=3D OMAP_MAX_GPIO_LINES,
 	.irq_base	=3D TWL4030_GPIO_IRQ_BASE,
@@ -135,7 +130,6 @@ static struct twl4030_platform_data beag
 	.irq_end	=3D TWL4030_IRQ_END,
=20
 	/* platform_data for children goes here */
-	.madc		=3D &beagle_madc_data,
 	.usb		=3D &beagle_usb_data,
 	.gpio		=3D &beagle_gpio_data,
 };
--- beagle.orig/arch/arm/mach-omap2/board-overo.c	2008-09-26 12:47:36.0=
00000000 -0700
+++ beagle/arch/arm/mach-omap2/board-overo.c	2008-09-26 10:02:29.000000=
000 -0700
@@ -152,16 +152,10 @@ static struct twl4030_gpio_platform_data
 	.irq_end	=3D TWL4030_GPIO_IRQ_END,
 };
=20
-static struct twl4030_madc_platform_data overo_madc_data =3D {
-	.imr		=3D TWL4030_MADC_IMR1,
-	.isr		=3D TWL4030_MADC_ISR1,
-};
-
 static struct twl4030_platform_data overo_twldata =3D {
 	.irq_base	=3D TWL4030_IRQ_BASE,
 	.irq_end	=3D TWL4030_IRQ_END,
 	.gpio		=3D &overo_gpio_data,
-	.madc		=3D &overo_madc_data,
 };
=20
 static struct i2c_board_info __initdata overo_i2c_boardinfo[] =3D {
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
