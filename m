From: David Anders <x0132446@ti.com>
Subject: [PATCH 4/4] omap4: pandaboard: enable the ehci port on pandaboard
Date: Tue, 21 Sep 2010 16:24:04 -0500
Message-ID: <1285104244-32274-5-git-send-email-x0132446@ti.com>
References: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:53951 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756704Ab0IUVYH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Sep 2010 17:24:07 -0400
In-Reply-To: <1285104244-32274-1-git-send-email-x0132446@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: jayabharath@ti.com, gadiyar@ti.com, vpasam@ti.com, tony@atomide.com, linux-omap@vger.kernel.org
Cc: David Anders <x0132446@ti.com>

The OMAP4 PandaBoard has EHCI port1 hooked up to an external
SMSC3320 transciever. GPIO 1 is used to power on the transceiver
and GPIO 62 for reset on the transceiver.

Signed-off-by: David Anders <x0132446@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/mach-omap2/board-omap4panda.c |   54 ++++++++++++++++++++++++++++++++
 1 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap4panda.c b/arch/arm/mach-omap2/board-omap4panda.c
index 94e819c..6163a59 100644
--- a/arch/arm/mach-omap2/board-omap4panda.c
+++ b/arch/arm/mach-omap2/board-omap4panda.c
@@ -39,6 +39,8 @@
 #include <plat/mmc.h>
 #include "hsmmc.h"
 
+#define GPIO_HUB_POWER		1
+#define GPIO_HUB_NRESET		62
 
 static void __init omap4_panda_init_irq(void)
 {
@@ -280,6 +282,57 @@ static int __init omap4_panda_i2c_init(void)
 	omap_register_i2c_bus(4, 400, NULL, 0);
 	return 0;
 }
+
+static const struct ehci_hcd_omap_platform_data ehci_pdata __initconst = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.phy_reset  = false,
+	.reset_gpio_port[0]  = -EINVAL,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
+static void __init omap4_ehci_init(void)
+{
+	int ret;
+
+
+	/* disable the power to the usb hub prior to init */
+	ret = gpio_request(GPIO_HUB_POWER, "hub_power");
+	if (ret) {
+		pr_err("Cannot request GPIO %d\n", GPIO_HUB_POWER);
+		goto error1;
+	}
+	gpio_export(GPIO_HUB_POWER, 0);
+	gpio_direction_output(GPIO_HUB_POWER, 0);
+	gpio_set_value(GPIO_HUB_POWER, 0);
+
+	/* reset phy+hub */
+	ret = gpio_request(GPIO_HUB_NRESET, "hub_nreset");
+	if (ret) {
+		pr_err("Cannot request GPIO %d\n", GPIO_HUB_NRESET);
+		goto error2;
+	}
+	gpio_export(GPIO_HUB_NRESET, 0);
+	gpio_direction_output(GPIO_HUB_NRESET, 0);
+	gpio_set_value(GPIO_HUB_NRESET, 0);
+	gpio_set_value(GPIO_HUB_NRESET, 1);
+
+	usb_ehci_init(&ehci_pdata);
+
+	/* enable power to hub */
+	gpio_set_value(GPIO_HUB_POWER, 1);
+	return;
+
+error2:
+	gpio_free(GPIO_HUB_POWER);
+error1:
+	pr_err("Unable to initialize EHCI power/reset\n");
+	return;
+
+}
+
 static void __init omap4_panda_init(void)
 {
 	omap4_panda_i2c_init();
@@ -287,6 +340,7 @@ static void __init omap4_panda_init(void)
 	omap4_twl6030_hsmmc_init(mmc);
 	/* OMAP4 Panda uses internal transceiver so register nop transceiver */
 	usb_nop_xceiv_register();
+	omap4_ehci_init();
 	/* FIXME: allow multi-omap to boot until musb is updated for omap4 */
 	if (!cpu_is_omap44xx())
 		usb_musb_init(&musb_board_data);
-- 
1.7.0.4

