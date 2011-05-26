From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Get rid of section mismatch warnings
Date: Thu, 26 May 2011 06:37:32 -0700
Message-ID: <20110526133732.GD11352@atomide.com>
References: <1306414838-4330-1-git-send-email-silesh@ti.com>
 <4DDE4EEF.8070108@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:16224 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757523Ab1EZNhf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 26 May 2011 09:37:35 -0400
Content-Disposition: inline
In-Reply-To: <4DDE4EEF.8070108@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Silesh C V <silesh@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Santosh Shilimkar <santosh.shilimkar@ti.com> [110526 05:56]:
> On 5/26/2011 6:30 PM, Silesh C V wrote:
> >Get rid of the following and 8 other similar section mismatch
> >warnings
> >
> I send this [1] patch a month back. It's still not considered
> though even after reminder.
> 
> [1] https://patchwork.kernel.org/patch/684831/

Applying now into devel-fixes with additional fixes from Silesh.
Updated patch below.

Regards,

Tony


From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 4 Apr 2011 10:02:05 +0000
Subject: [PATCH] OMAP2+: Fix 9 section mismatch(es) warnings from mach-omap2/built-in.o

The serial*_data should have been marked as __initdata as per
it's usage in the board files. Fix the same to remove the
section mismatch warnings caused by it.

Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
Signed-off-by: Silesh C V <silesh@ti.com>
[tony@atomide.com: updated with additional fixes from Silesh]
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/board-3430sdp.c b/arch/arm/mach-omap2/board-3430sdp.c
index 52dbdf3..c710ad5 100644
--- a/arch/arm/mach-omap2/board-3430sdp.c
+++ b/arch/arm/mach-omap2/board-3430sdp.c
@@ -622,19 +622,19 @@ static struct omap_device_pad serial3_pads[] __initdata = {
 			 OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial1_data = {
+static struct omap_board_data serial1_data __initdata = {
 	.id		= 0,
 	.pads		= serial1_pads,
 	.pads_cnt	= ARRAY_SIZE(serial1_pads),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
diff --git a/arch/arm/mach-omap2/board-4430sdp.c b/arch/arm/mach-omap2/board-4430sdp.c
index ae3153c..da6c666 100644
--- a/arch/arm/mach-omap2/board-4430sdp.c
+++ b/arch/arm/mach-omap2/board-4430sdp.c
@@ -258,7 +258,7 @@ static struct gpio sdp4430_eth_gpios[] __initdata = {
 	{ ETH_KS8851_IRQ,	GPIOF_IN,		"eth_irq"	},
 };
 
-static int omap_ethernet_init(void)
+static int __init omap_ethernet_init(void)
 {
 	int status;
 
@@ -672,19 +672,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id		= 1,
 	.pads		= serial2_pads,
 	.pads_cnt	= ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id		= 2,
 	.pads		= serial3_pads,
 	.pads_cnt	= ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id		= 3,
 	.pads		= serial4_pads,
 	.pads_cnt	= ARRAY_SIZE(serial4_pads),
diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 5d7c0a3..2d52ee7 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -526,19 +526,19 @@ static struct omap_device_pad serial4_pads[] __initdata = {
 			 OMAP_PIN_OUTPUT | OMAP_MUX_MODE0),
 };
 
-static struct omap_board_data serial2_data = {
+static struct omap_board_data serial2_data __initdata = {
 	.id             = 1,
 	.pads           = serial2_pads,
 	.pads_cnt       = ARRAY_SIZE(serial2_pads),
 };
 
-static struct omap_board_data serial3_data = {
+static struct omap_board_data serial3_data __initdata = {
 	.id             = 2,
 	.pads           = serial3_pads,
 	.pads_cnt       = ARRAY_SIZE(serial3_pads),
 };
 
-static struct omap_board_data serial4_data = {
+static struct omap_board_data serial4_data __initdata = {
 	.id             = 3,
 	.pads           = serial4_pads,
 	.pads_cnt       = ARRAY_SIZE(serial4_pads),
diff --git a/arch/arm/mach-omap2/board-zoom-display.c b/arch/arm/mach-omap2/board-zoom-display.c
index ce53e82..d826242 100644
--- a/arch/arm/mach-omap2/board-zoom-display.c
+++ b/arch/arm/mach-omap2/board-zoom-display.c
@@ -26,7 +26,7 @@ static struct gpio zoom_lcd_gpios[] __initdata = {
 	{ LCD_PANEL_QVGA_GPIO,	GPIOF_OUT_INIT_HIGH, "lcd qvga"	 },
 };
 
-static void zoom_lcd_panel_init(void)
+static void __init zoom_lcd_panel_init(void)
 {
 	zoom_lcd_gpios[0].gpio = (omap_rev() > OMAP3430_REV_ES3_0) ?
 			LCD_PANEL_RESET_GPIO_PROD :
