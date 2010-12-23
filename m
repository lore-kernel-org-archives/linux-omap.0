From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 1/2] arm: omap: craneboard: Add USB EHCI support
Date: Thu, 23 Dec 2010 10:50:30 +0200
Message-ID: <1293094231-3270-1-git-send-email-balbi@ti.com>
References: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:40850 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752633Ab0LWIui (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 23 Dec 2010 03:50:38 -0500
Received: by eyh6 with SMTP id 6so108860eyh.28
        for <linux-omap@vger.kernel.org>; Thu, 23 Dec 2010 00:50:36 -0800 (PST)
In-Reply-To: <20101223084734.GA3149@legolas.emea.dhcp.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Srinath <srinath@mistralsolutions.com>, Felipe Balbi <balbi@ti.com>

From: Srinath <srinath@mistralsolutions.com>

AM3517/05 Craneboard has one EHCI interface on board using port1.

GPIO35 is used as power enable.
GPIO38 is used as port1 PHY reset.

History:
http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%253A%2BAdd%2BUSB%2BEHCI%2Bsupport&q=b

Signed-off-by: Srinath <srinath@mistralsolutions.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |   48 +++++++++++++++++++++++++++++++
 1 files changed, 48 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 781ed25..71acb5a 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -19,6 +19,7 @@
 
 #include <linux/kernel.h>
 #include <linux/init.h>
+#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
@@ -27,8 +28,14 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 #include "mux.h"
+#include "control.h"
+
+#define GPIO_USB_POWER		35
+#define GPIO_USB_NRESET		38
+
 
 /* Board initialization */
 static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
@@ -52,10 +59,51 @@ static void __init am3517_crane_init_irq(void)
 	omap_init_irq();
 }
 
+static struct ehci_hcd_omap_platform_data ehci_pdata __initdata = {
+	.port_mode[0] = EHCI_HCD_OMAP_MODE_PHY,
+	.port_mode[1] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+	.port_mode[2] = EHCI_HCD_OMAP_MODE_UNKNOWN,
+
+	.phy_reset  = true,
+	.reset_gpio_port[0]  = GPIO_USB_NRESET,
+	.reset_gpio_port[1]  = -EINVAL,
+	.reset_gpio_port[2]  = -EINVAL
+};
+
 static void __init am3517_crane_init(void)
 {
+	int ret;
+
 	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
 	omap_serial_init();
+
+	/* Configure GPIO for EHCI port */
+	if (omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT)) {
+		pr_err("Can not configure mux for GPIO_USB_NRESET %d\n",
+			GPIO_USB_NRESET);
+		return;
+	}
+
+	if (omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT)) {
+		pr_err("Can not configure mux for GPIO_USB_POWER %d\n",
+			GPIO_USB_POWER);
+		return;
+	}
+
+	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	if (ret < 0) {
+		pr_err("Can not request GPIO %d\n", GPIO_USB_POWER);
+		return;
+	}
+
+	ret = gpio_direction_output(GPIO_USB_POWER, 1);
+	if (ret < 0) {
+		gpio_free(GPIO_USB_POWER);
+		pr_err("Unable to initialize EHCI power\n");
+		return;
+	}
+
+	usb_ehci_init(&ehci_pdata);
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-- 
1.7.3.4.598.g85356

