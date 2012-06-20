From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 4/5 V2 RESEND] ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
Date: Wed, 20 Jun 2012 17:38:13 +0530
Message-ID: <1340194094-26708-5-git-send-email-keshava_mgowda@ti.com>
References: <1340194094-26708-1-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:38974 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751813Ab2FTMIY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 20 Jun 2012 08:08:24 -0400
In-Reply-To: <1340194094-26708-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, sameo@linux.intel.com, parthab@india.ti.com, paul@pwsan.com, b-cousson@ti.com, sshtylyov@mvista.com

The usbhs driver invokes the enable/disable APIs of the
usb tll driver in the runtime resume/suspend callbacks
of the runtime get sync and put sync of the usbhs driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Reviewed-by: Partha Basak <parthab@india.ti.com>
---
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/mfd/omap-usb-host.c           |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index b8a9d5e..8eac78c 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -4,6 +4,7 @@
 #define	__ASM_ARCH_OMAP_USB_H
 
 #include <linux/io.h>
+#include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 #include <plat/board.h>
 
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index c1baf20..23cec57 100644
--- a/drivers/mfd/omap-usb-host.c
+++ b/drivers/mfd/omap-usb-host.c
@@ -21,7 +21,6 @@
 #include <linux/types.h>
 #include <linux/slab.h>
 #include <linux/delay.h>
-#include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
@@ -287,6 +286,7 @@ static int usbhs_runtime_resume(struct device *dev)
 		return  -ENODEV;
 	}
 
+	omap_tll_enable();
 	spin_lock_irqsave(&omap->lock, flags);
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
@@ -332,6 +332,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 		clk_disable(omap->ehci_logic_fck);
 
 	spin_unlock_irqrestore(&omap->lock, flags);
+	omap_tll_disable();
 
 	return 0;
 }
@@ -699,8 +700,10 @@ static int __init omap_usbhs_drvinit(void)
  * init before ehci and ohci drivers;
  * The usbhs core driver should be initialized much before
  * the omap ehci and ohci probe functions are called.
+ * This usbhs core driver should be initialized after
+ * usb tll driver
  */
-fs_initcall(omap_usbhs_drvinit);
+fs_initcall_sync(omap_usbhs_drvinit);
 
 static void __exit omap_usbhs_drvexit(void)
 {
-- 
1.7.9.5

