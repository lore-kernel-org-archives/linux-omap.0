From: Felipe Balbi <balbi@ti.com>
Subject: [RFC/PATCH 1/4] arm: omap: use hwmod to create a dwc3 device
Date: Mon, 15 Aug 2011 18:57:22 +0300
Message-ID: <1313423845-2288-2-git-send-email-balbi@ti.com>
References: <1313423845-2288-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:45750 "EHLO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752657Ab1HOP5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 15 Aug 2011 11:57:33 -0400
In-Reply-To: <1313423845-2288-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Felipe Balbi <balbi@ti.com>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/mach-omap2/Makefile          |    3 ++
 arch/arm/mach-omap2/usb-dwc3.c        |   49 +++++++++++++++++++++++++++++++++
 arch/arm/plat-omap/include/plat/usb.h |    6 ++++
 3 files changed, 58 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/usb-dwc3.c

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index f343365..a9408c5 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -260,6 +260,9 @@ obj-$(CONFIG_MACH_TI8168EVM)		+= board-ti8168evm.o
 usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o
+ifneq ($(CONFIG_USB_DWC3),)
+obj-y					+= usb-dwc3.o
+endif
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
 obj-y					+= usb-host.o
 
diff --git a/arch/arm/mach-omap2/usb-dwc3.c b/arch/arm/mach-omap2/usb-dwc3.c
new file mode 100644
index 0000000..622bbbc
--- /dev/null
+++ b/arch/arm/mach-omap2/usb-dwc3.c
@@ -0,0 +1,49 @@
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+
+#include <plat/usb.h>
+#include <plat/omap_device.h>
+
+static u64 dwc3_dmamask = DMA_BIT_MASK(32);
+
+static struct omap_device_pm_latency omap_dwc3_latency[] = {
+	{
+		.deactivate_func        = omap_device_idle_hwmods,
+		.activate_func          = omap_device_enable_hwmods,
+		.flags                  = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	},
+};
+
+void __init usb_dwc3_init(void)
+{
+	struct omap_hwmod	*oh;
+	struct omap_device	*od;
+	struct platform_device	*pdev;
+	int			bus_id = -1;
+	const char		*oh_name, *name;
+
+	oh_name = "usb_otg_ss";
+	name = "omap-dwc3";
+
+	oh = omap_hwmod_lookup(oh_name);
+	if (!oh) {
+		pr_err("Could not lookup hwmod for %s\n", oh_name);
+		return;
+	}
+
+	od = omap_device_build(name, bus_id, oh,
+			NULL, 0,
+			omap_dwc3_latency, ARRAY_SIZE(omap_dwc3_latency),
+			false);
+	if (IS_ERR(od)) {
+		pr_err("Could not build omap_device for %s %s\n",
+				name, oh_name);
+		return;
+	}
+
+	pdev = &od->pdev;
+	get_device(&pdev->dev);
+	pdev->dev.dma_mask = &dwc3_dmamask;
+	pdev->dev.coherent_dma_mask = dwc3_dmamask;
+	put_device(&pdev->dev);
+}
diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index 17d3c93..ec69f10 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -293,4 +293,10 @@ static inline u32 omap1_usb2_init(unsigned nwires, unsigned alt_pingroup)
 }
 #endif
 
+#if defined(CONFIG_USB_DWC3) || defined(CONFIG_USB_DWC3_MODULE)
+void usb_dwc3_init(void);
+#else
+static inline void usb_dwc3_init(void) {}
+#endif
+
 #endif	/* __ASM_ARCH_OMAP_USB_H */
-- 
1.7.6.396.ge0613

