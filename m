From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] ARM: OMAP3: ZOOM MDK: Add FB support to board file
Date: Fri, 22 May 2009 15:44:17 -0700
Message-ID: <20090522224417.31586.81646.stgit@localhost>
References: <20090522223543.31586.44534.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:51373 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757646AbZEVWoZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 May 2009 18:44:25 -0400
In-Reply-To: <20090522223543.31586.44534.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: Imre Deak <imre.deak@nokia.com>, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

From: Imre Deak <imre.deak@nokia.com>

Based on an earlier patch by Stanley.Miao <stanley.miao@windriver.com>
with board-*.c changes split to avoid conflicts with other device updates.

Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
Signed-off-by: Imre Deak <imre.deak@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-ldp.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index da57b0f..59ac8ed 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -77,10 +77,6 @@ static struct platform_device ldp_smsc911x_device = {
 	},
 };
 
-static struct platform_device *ldp_devices[] __initdata = {
-	&ldp_smsc911x_device,
-};
-
 static inline void __init ldp_init_smsc911x(void)
 {
 	int eth_cs;
@@ -122,8 +118,18 @@ static struct omap_uart_config ldp_uart_config __initdata = {
 	.enabled_uarts	= ((1 << 0) | (1 << 1) | (1 << 2)),
 };
 
+static struct platform_device ldp_lcd_device = {
+	.name		= "ldp_lcd",
+	.id		= -1,
+};
+
+static struct omap_lcd_config ldp_lcd_config __initdata = {
+	.ctrl_name	= "internal",
+};
+
 static struct omap_board_config_kernel ldp_config[] __initdata = {
 	{ OMAP_TAG_UART,	&ldp_uart_config },
+	{ OMAP_TAG_LCD,		&ldp_lcd_config },
 };
 
 static struct twl4030_gpio_platform_data ldp_gpio_data = {
@@ -168,6 +174,11 @@ static struct twl4030_hsmmc_info mmc[] __initdata = {
 	{}	/* Terminator */
 };
 
+static struct platform_device *ldp_devices[] __initdata = {
+	&ldp_smsc911x_device,
+	&ldp_lcd_device,
+};
+
 static void __init omap_ldp_init(void)
 {
 	omap_i2c_init();

