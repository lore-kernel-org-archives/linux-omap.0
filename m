From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH v3 1/4] ARM: OMAP1: USB: move omap_usb_config to platform data
Date: Tue, 18 Jun 2013 20:06:58 +0300
Message-ID: <1371575221-360-2-git-send-email-aaro.koskinen@iki.fi>
References: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:59929 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933339Ab3FRRHy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Jun 2013 13:07:54 -0400
In-Reply-To: <1371575221-360-1-git-send-email-aaro.koskinen@iki.fi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Move omap_usb_config to platform data, so that OTG driver can include it.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/include/mach/usb.h  | 38 +-----------------------
 include/linux/platform_data/usb-omap1.h | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/platform_data/usb-omap1.h

diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 45e5ac7..2c26305 100644
--- a/arch/arm/mach-omap1/include/mach/usb.h
+++ b/arch/arm/mach-omap1/include/mach/usb.h
@@ -8,43 +8,7 @@
 #define	is_usb0_device(config)	0
 #endif
 
-struct omap_usb_config {
-	/* Configure drivers according to the connectors on your board:
-	 *  - "A" connector (rectagular)
-	 *	... for host/OHCI use, set "register_host".
-	 *  - "B" connector (squarish) or "Mini-B"
-	 *	... for device/gadget use, set "register_dev".
-	 *  - "Mini-AB" connector (very similar to Mini-B)
-	 *	... for OTG use as device OR host, initialize "otg"
-	 */
-	unsigned	register_host:1;
-	unsigned	register_dev:1;
-	u8		otg;	/* port number, 1-based:  usb1 == 2 */
-
-	u8		hmc_mode;
-
-	/* implicitly true if otg:  host supports remote wakeup? */
-	u8		rwc;
-
-	/* signaling pins used to talk to transceiver on usbN:
-	 *  0 == usbN unused
-	 *  2 == usb0-only, using internal transceiver
-	 *  3 == 3 wire bidirectional
-	 *  4 == 4 wire bidirectional
-	 *  6 == 6 wire unidirectional (or TLL)
-	 */
-	u8		pins[3];
-
-	struct platform_device *udc_device;
-	struct platform_device *ohci_device;
-	struct platform_device *otg_device;
-
-	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
-	u32 (*usb1_init)(unsigned nwires);
-	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
-
-	int (*ocpi_enable)(void);
-};
+#include <linux/platform_data/usb-omap1.h>
 
 void omap_otg_init(struct omap_usb_config *config);
 
diff --git a/include/linux/platform_data/usb-omap1.h b/include/linux/platform_data/usb-omap1.h
new file mode 100644
index 0000000..8c7764d
--- /dev/null
+++ b/include/linux/platform_data/usb-omap1.h
@@ -0,0 +1,51 @@
+/*
+ * Platform data for OMAP1 USB
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License. See the file "COPYING" in the main directory of this archive for
+ * more details.
+ */
+#ifndef __LINUX_USB_OMAP1_H
+#define __LINUX_USB_OMAP1_H
+
+#include <linux/platform_device.h>
+
+struct omap_usb_config {
+	/* Configure drivers according to the connectors on your board:
+	 *  - "A" connector (rectagular)
+	 *	... for host/OHCI use, set "register_host".
+	 *  - "B" connector (squarish) or "Mini-B"
+	 *	... for device/gadget use, set "register_dev".
+	 *  - "Mini-AB" connector (very similar to Mini-B)
+	 *	... for OTG use as device OR host, initialize "otg"
+	 */
+	unsigned	register_host:1;
+	unsigned	register_dev:1;
+	u8		otg;	/* port number, 1-based:  usb1 == 2 */
+
+	u8		hmc_mode;
+
+	/* implicitly true if otg:  host supports remote wakeup? */
+	u8		rwc;
+
+	/* signaling pins used to talk to transceiver on usbN:
+	 *  0 == usbN unused
+	 *  2 == usb0-only, using internal transceiver
+	 *  3 == 3 wire bidirectional
+	 *  4 == 4 wire bidirectional
+	 *  6 == 6 wire unidirectional (or TLL)
+	 */
+	u8		pins[3];
+
+	struct platform_device *udc_device;
+	struct platform_device *ohci_device;
+	struct platform_device *otg_device;
+
+	u32 (*usb0_init)(unsigned nwires, unsigned is_device);
+	u32 (*usb1_init)(unsigned nwires);
+	u32 (*usb2_init)(unsigned nwires, unsigned alt_pingroup);
+
+	int (*ocpi_enable)(void);
+};
+
+#endif /* __LINUX_USB_OMAP1_H */
-- 
1.8.3.1

