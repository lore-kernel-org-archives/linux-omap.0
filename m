From: Igor Grinberg <grinberg@compulab.co.il>
Subject: [PATCH 3/5] omap3: cm-t3517: add support for usb host.
Date: Tue, 21 Sep 2010 18:03:11 +0200
Message-ID: <1285084993-27683-4-git-send-email-grinberg@compulab.co.il>
References: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from compulab.co.il ([67.18.134.219]:37423 "EHLO compulab.co.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754838Ab0IUQD1 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 21 Sep 2010 12:03:27 -0400
In-Reply-To: <1285084993-27683-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Igor Grinberg <grinberg@compulab.co.il>

add support for hsusb host ports 1, 2 and on-module usb hub.

Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
---
 arch/arm/mach-omap2/board-cm-t3517.c |   50 ++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 2b41c6d..2c7082d 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -25,6 +25,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/rtc-v3020.h>
@@ -36,6 +37,7 @@
 #include <plat/board.h>
 #include <plat/common.h>
 #include <plat/control.h>
+#include <plat/usb.h>
 
 #include "mux.h"
 
@@ -100,6 +102,47 @@ static void __init cm_t3517_init_rtc(void)
 static inline void cm_t3517_init_rtc(void) {}
 #endif
 
+#if defined(CONFIG_USB_EHCI_HCD) || defined(CONFIG_USB_EHCI_HCD_MODULE)
+#define HSUSB1_RESET_GPIO	(146)
+#define HSUSB2_RESET_GPIO	(147)
+#define USB_HUB_RESET_GPIO	(152)
+
+static struct ehci_hcd_omap_platform_data cm_t3517_ehci_pdata __initdata = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = HSUSB1_RESET_GPIO,
+	.reset_gpio_port[1]  = HSUSB2_RESET_GPIO,
+	.reset_gpio_port[2]  = -EINVAL,
+};
+
+static int cm_t3517_init_usbh(void)
+{
+	int err;
+
+	err = gpio_request(USB_HUB_RESET_GPIO, "usb hub rst");
+	if (err) {
+		pr_err("CM-T3517: usb hub rst gpio request failed: %d\n", err);
+	} else {
+		gpio_direction_output(USB_HUB_RESET_GPIO, 0);
+		udelay(10);
+		gpio_set_value(USB_HUB_RESET_GPIO, 1);
+		msleep(1);
+	}
+
+	usb_ehci_init(&cm_t3517_ehci_pdata);
+
+	return 0;
+}
+#else
+static inline int cm_t3517_init_usbh(void)
+{
+	return 0;
+}
+#endif
+
 static struct omap_board_config_kernel cm_t3517_config[] __initdata = {
 };
 
@@ -121,6 +164,12 @@ static struct omap_board_mux board_mux[] __initdata = {
 	OMAP3_MUX(MCBSP4_DX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 	OMAP3_MUX(MCBSP_CLKS, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
 	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT),
+	/* HSUSB1 RESET */
+	OMAP3_MUX(UART2_TX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* HSUSB2 RESET */
+	OMAP3_MUX(UART2_RX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
+	/* CM-T3517 USB HUB nRESET */
+	OMAP3_MUX(MCBSP4_CLKX, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
 
 	{ .reg_offset = OMAP_MUX_TERMINATOR },
 };
@@ -131,6 +180,7 @@ static void __init cm_t3517_init(void)
 	omap_serial_init();
 	cm_t3517_init_leds();
 	cm_t3517_init_rtc();
+	cm_t3517_init_usbh();
 }
 
 MACHINE_START(CM_T3517, "Compulab CM-T3517")
-- 
1.7.1

