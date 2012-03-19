From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 4/5 RESEND] ARM: OMAP: USB: Invoke the TLL driver from USB HS core driver
Date: Mon, 19 Mar 2012 12:18:34 +0530
Message-ID: <1332139715-1495-5-git-send-email-keshava_mgowda@ti.com>
References: <1332139715-1495-1-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-2-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-3-git-send-email-keshava_mgowda@ti.com>
 <1332139715-1495-4-git-send-email-keshava_mgowda@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1332139715-1495-4-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org, govindraj.raja-l0cyMroinI0@public.gmane.org, paul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, b-cousson-l0cyMroinI0@public.gmane.org, Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Keshava Munegowda <Keshava_mgowda-l0cyMroinI0@public.gmane.org>

The usbhs driver invokes the enable/disable APIs of the
usb tll driver in the runtime resume/suspend callbacks
of the runtime get sync and put sync of the usbhs driver.

Signed-off-by: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Reviewed-by: Partha Basak <parthab-PpE0FKYn9XJWk0Htik3J/w@public.gmane.org>
---
 arch/arm/plat-omap/include/plat/usb.h |    1 +
 drivers/mfd/omap-usb-host.c           |    7 +++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/usb.h b/arch/arm/plat-omap/include/plat/usb.h
index eb1e47d..3b8f139 100644
--- a/arch/arm/plat-omap/include/plat/usb.h
+++ b/arch/arm/plat-omap/include/plat/usb.h
@@ -3,6 +3,7 @@
 #ifndef	__ASM_ARCH_OMAP_USB_H
 #define	__ASM_ARCH_OMAP_USB_H
 
+#include <linux/platform_device.h>
 #include <linux/usb/musb.h>
 #include <plat/board.h>
 
diff --git a/drivers/mfd/omap-usb-host.c b/drivers/mfd/omap-usb-host.c
index 4de87c6..9d84339 100644
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
@@ -285,6 +284,7 @@ static int usbhs_runtime_resume(struct device *dev)
 		return  -ENODEV;
 	}
 
+	omap_tll_enable();
 	spin_lock_irqsave(&omap->lock, flags);
 
 	if (omap->ehci_logic_fck && !IS_ERR(omap->ehci_logic_fck))
@@ -330,6 +330,7 @@ static int usbhs_runtime_suspend(struct device *dev)
 		clk_disable(omap->ehci_logic_fck);
 
 	spin_unlock_irqrestore(&omap->lock, flags);
+	omap_tll_disable();
 
 	return 0;
 }
@@ -655,8 +656,10 @@ static int __init omap_usbhs_drvinit(void)
  * init before ehci and ohci drivers;
  * The usbhs core driver should be initialized much before
  * the omap ehci and ohci probe functions are called.
+ * this usbhs core driver should be initialized after
+ * usb tll driver.
  */
-fs_initcall(omap_usbhs_drvinit);
+fs_initcall_sync(omap_usbhs_drvinit);
 
 static void __exit omap_usbhs_drvexit(void)
 {
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
