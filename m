From: Ajay Kumar Gupta <ajay.gupta@ti.com>
Subject: [PATCH 2/3] omap3evm: ehci: Update EHCI support on OMAP3EVM (Rev >= E)
Date: Wed, 28 Oct 2009 20:42:37 +0530
Message-ID: <1256742758-32702-2-git-send-email-ajay.gupta@ti.com>
References: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:34275 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201AbZJ1PMp (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Oct 2009 11:12:45 -0400
In-Reply-To: <1256742758-32702-1-git-send-email-ajay.gupta@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: felipe.balbi@nokia.com, tony@atomide.com, Ajay Kumar Gupta <ajay.gupta@ti.com>

Added runtime programming for the differences in EHCI interface between
OMAP3EVM revisions (Rev >= E) and (Rev < E).

Changes:
	- EHCI PHY reset GPIO pin is 21 on Rev >= E while Rev < E
	  uses GPIO pin 135.
	- Rev >= E uses EHCI Vbus enable GPIO22 line.
	- Rev >= E uses GPIO61 to select EHCI port either on main board or
	  on Mistral Daughter Card (MDC). OMAP3EVM Rev < E doesn't have
	  EHCI port on main board.
	- Currently GPIO61 it programmed to enable EHCI port on main
	  board only.

Signed-off-by: Ajay Kumar Gupta <ajay.gupta@ti.com>
---
This patch is dependent on below patch,
[PATCH] omap3evm: Add board revision function

 arch/arm/mach-omap2/board-omap3evm.c |   29 ++++++++++++++++++++++++++---
 1 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3evm.c b/arch/arm/mach-omap2/board-omap3evm.c
index 0595ce8..a919f33 100644
--- a/arch/arm/mach-omap2/board-omap3evm.c
+++ b/arch/arm/mach-omap2/board-omap3evm.c
@@ -45,6 +45,8 @@
 #include "mmc-twl4030.h"
 
 #define OMAP3_EVM_TS_GPIO	175
+#define OMAP3_EVM_EHCI_VBUS	22
+#define OMAP3_EVM_EHCI_SELECT	61
 
 #define OMAP3EVM_ETHR_START	0x2c000000
 #define OMAP3EVM_ETHR_SIZE	1024
@@ -381,8 +383,9 @@ static struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
 	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
 
 	.phy_reset  = true,
+	/* PHY reset GPIO will be runtime programmed based on EVM version */
 	.reset_gpio_port[0]  = -EINVAL,
-	.reset_gpio_port[1]  = 135,
+	.reset_gpio_port[1]  = -EINVAL,
 	.reset_gpio_port[2]  = -EINVAL
 };
 
@@ -402,9 +405,29 @@ static void __init omap3_evm_init(void)
 	/* OMAP3EVM uses ISP1504 phy and so register nop transceiver */
 	usb_nop_xceiv_register();
 #endif
+	if (get_omap3_evm_rev() >= OMAP3EVM_BOARD_GEN_2) {
+		/* enable EHCI VBUS using GPIO22 */
+		omap_cfg_reg(AF9_34XX_GPIO22);
+		gpio_request(OMAP3_EVM_EHCI_VBUS, "enable EHCI VBUS");
+		gpio_direction_output(OMAP3_EVM_EHCI_VBUS, 0);
+		gpio_set_value(OMAP3_EVM_EHCI_VBUS, 1);
+
+		/* Select EHCI port on main board */
+		omap_cfg_reg(U3_34XX_GPIO61);
+		gpio_request(OMAP3_EVM_EHCI_SELECT, "select EHCI port");
+		gpio_direction_output(OMAP3_EVM_EHCI_SELECT, 0);
+		gpio_set_value(OMAP3_EVM_EHCI_SELECT, 0);
+
+		/* setup EHCI phy reset config */
+		omap_cfg_reg(AH14_34XX_GPIO21);
+		ehci_pdata.reset_gpio_port[1] = 21;
+
+	} else {
+		/* setup EHCI phy reset on MDC */
+		omap_cfg_reg(AF4_34XX_GPIO135_OUT);
+		ehci_pdata.reset_gpio_port[1] = 135;
+	}
 	usb_musb_init();
-	/* Setup EHCI phy reset padconfig */
-	omap_cfg_reg(AF4_34XX_GPIO135_OUT);
 	usb_ehci_init(&ehci_pdata);
 	ads7846_dev_init();
 }
-- 
1.6.2.4

