From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH] ARM: OMAP3: cm-t35: add support for power off
Date: Wed, 28 Mar 2012 11:51:18 +0200
Message-ID: <1332928278-6582-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:44169
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757954Ab2C1Jvd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Mar 2012 05:51:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

Enable the power off feature of the TPS65930 on-board PMIC.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t35.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
index 8770be1..46275c6 100644
--- a/arch/arm/mach-omap2/board-cm-t35.c
+++ b/arch/arm/mach-omap2/board-cm-t35.c
@@ -499,6 +499,10 @@ static struct twl4030_gpio_platform_data cm_t35_gpio_data = {
 	.setup          = cm_t35_twl_gpio_setup,
 };
 
+static struct twl4030_power_data cm_t35_power_data = {
+	.use_poweroff	= true,
+};
+
 static struct twl4030_platform_data cm_t35_twldata = {
 	/* platform_data for children goes here */
 	.keypad		= &cm_t35_kp_data,
@@ -506,6 +510,7 @@ static struct twl4030_platform_data cm_t35_twldata = {
 	.vmmc1		= &cm_t35_vmmc1,
 	.vsim		= &cm_t35_vsim,
 	.vio		= &cm_t35_vio,
+	.power		= &cm_t35_power_data,
 };
 
 static void __init cm_t35_init_i2c(void)
-- 
1.7.3.4

