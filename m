From: srinath@mistralsolutions.com
Subject: [Patch v3] AM35xx: Craneboard: Add USB EHCI support
Date: Wed,  1 Dec 2010 22:28:50 +0530
Message-ID: <1291222730-17614-1-git-send-email-srinath@mistralsolutions.com>
References: <[PATCH] Craneboard: Add USB EHCI Support>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <[PATCH] Craneboard: Add USB EHCI Support>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: jdk@ti.com, tony@atomide.com, linux-kernel@vger.kernel.org, linux@arm.linux.org.uk, linux-arm-kernel@lists.infradead.org, khilman@deeprootsystems.com, nm@ti.com, nagendra@mistralsolutions.com, umeshk@mistralsolutions.com, Srinath <srinath@mistralsolutions.com>
List-Id: linux-omap@vger.kernel.org

From: Srinath <srinath@mistralsolutions.com>

AM3517/05 Craneboard has one EHCI interface on board using port1.

GPIO35 is used as power enable.
GPIO38 is used as port1 PHY reset.

History:
http://marc.info/?l=linux-omap&w=2&r=1&s=Craneboard%3A+Add+USB+EHCI+support&q=t

Signed-off-by: Srinath <srinath@mistralsolutions.com>
---
 arch/arm/mach-omap2/board-am3517crane.c |   40 +++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-am3517crane.c b/arch/arm/mach-omap2/board-am3517crane.c
index 13ead33..6fd5dfe 100644
--- a/arch/arm/mach-omap2/board-am3517crane.c
+++ b/arch/arm/mach-omap2/board-am3517crane.c
@@ -28,8 +28,13 @@
 
 #include <plat/board.h>
 #include <plat/common.h>
+#include <plat/usb.h>
 
 #include "mux.h"
+#include "control.h"
+
+#define GPIO_USB_POWER		35
+#define GPIO_USB_NRESET		38
 
 /* Board initialization */
 static struct omap_board_config_kernel am3517_crane_config[] __initdata = {
@@ -53,10 +58,45 @@ static void __init am3517_crane_init_irq(void)
 	omap_gpio_init();
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
+	omap_mux_init_gpio(GPIO_USB_POWER, OMAP_PIN_OUTPUT);
+
+	ret = gpio_request(GPIO_USB_POWER, "usb_ehci_enable");
+	if (ret < 0) {
+		pr_err("Cannot request GPIO %d\n", GPIO_USB_POWER);
+		return;
+	}
+
+	ret = gpio_direction_output(GPIO_USB_POWER, 1);
+	if (ret < 0)
+		goto err;
+
+	omap_mux_init_gpio(GPIO_USB_NRESET, OMAP_PIN_OUTPUT);
+	usb_ehci_init(&ehci_pdata);
+	return;
+
+err:
+	gpio_free(GPIO_USB_POWER);
+	pr_err("Unable to initialize EHCI power\n");
+	return;
 }
 
 MACHINE_START(CRANEBOARD, "AM3517/05 CRANEBOARD")
-- 
1.7.1.226.g770c5
