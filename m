From: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Subject: [PATCH v4 1/4] ARM: OMAP1: USB: move omap_usb_config to platform data
Date: Fri,  6 Dec 2013 16:13:04 +0200
Message-ID: <1386339187-28466-2-git-send-email-aaro.koskinen@iki.fi>
References: <1386339187-28466-1-git-send-email-aaro.koskinen@iki.fi>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1386339187-28466-1-git-send-email-aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Move omap_usb_config to platform data, so that OTG driver can include it.

Signed-off-by: Aaro Koskinen <aaro.koskinen-X3B1VOXEql0@public.gmane.org>
Acked-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/mach-omap1/include/mach/usb.h  | 38 +-----------------------
 include/linux/platform_data/usb-omap1.h | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 37 deletions(-)
 create mode 100644 include/linux/platform_data/usb-omap1.h

diff --git a/arch/arm/mach-omap1/include/mach/usb.h b/arch/arm/mach-omap1/include/mach/usb.h
index 45e5ac707cbb..2c263051dc51 100644
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
index 000000000000..8c7764ddd284
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
1.8.4.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
