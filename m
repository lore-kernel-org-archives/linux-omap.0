From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [PATCH 09/23] USB: MUSB: checkpatch.pl fixed to musb_core.c
Date: Fri, 11 Apr 2008 11:28:22 +0300
Message-ID: <1207902516-6374-10-git-send-email-felipe.balbi@nokia.com>
References: <1207902516-6374-1-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-2-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-3-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-4-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-5-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-6-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-7-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-8-git-send-email-felipe.balbi@nokia.com>
 <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:26596 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757495AbYDKIaJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 11 Apr 2008 04:30:09 -0400
Received: from esebh106.NOE.Nokia.com (esebh106.ntc.nokia.com [172.21.138.213])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3B8TpF4021901
	for <linux-omap@vger.kernel.org>; Fri, 11 Apr 2008 11:30:07 +0300
In-Reply-To: <1207902516-6374-9-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Felipe Balbi <felipe.balbi@nokia.com>

Misc cleanup patch.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/musb_core.c |   35 ++++++++++++++++-------------------
 1 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index fb37e2c..c5816a2 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -97,8 +97,7 @@
 #include <linux/list.h>
 #include <linux/kobject.h>
 #include <linux/platform_device.h>
-
-#include <asm/io.h>
+#include <linux/io.h>
 
 #ifdef	CONFIG_ARM
 #include <asm/arch/hardware.h>
@@ -180,7 +179,7 @@ void musb_write_fifo(struct musb_hw_ep *hw_ep, u16 len, const u8 *src)
 				index += len & ~0x03;
 			}
 			if (len & 0x02) {
-				musb_writew(fifo, 0, *(u16*)&src[index]);
+				musb_writew(fifo, 0, *(u16 *)&src[index]);
 				index += 2;
 			}
 		} else {
@@ -218,7 +217,7 @@ void musb_read_fifo(struct musb_hw_ep *hw_ep, u16 len, u8 *dst)
 				index = len & ~0x03;
 			}
 			if (len & 0x02) {
-				*(u16*)&dst[index] = musb_readw(fifo, 0);
+				*(u16 *)&dst[index] = musb_readw(fifo, 0);
 				index += 2;
 			}
 		} else {
@@ -388,9 +387,9 @@ void musb_hnp_stop(struct musb *musb)
 
 #define STAGE0_MASK (MUSB_INTR_RESUME | MUSB_INTR_SESSREQ \
 		| MUSB_INTR_VBUSERROR | MUSB_INTR_CONNECT \
-		| MUSB_INTR_RESET )
+		| MUSB_INTR_RESET)
 
-static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
+static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
@@ -710,7 +709,7 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
  * @param devctl
  * @param power
  */
-static irqreturn_t musb_stage2_irq(struct musb * musb, u8 int_usb,
+static irqreturn_t musb_stage2_irq(struct musb *musb, u8 int_usb,
 				u8 devctl, u8 power)
 {
 	irqreturn_t handled = IRQ_NONE;
@@ -1221,13 +1220,13 @@ static int __init ep_config_from_table(struct musb *musb)
 		u8	epn = cfg->hw_ep_num;
 
 		if (epn >= MUSB_C_NUM_EPS) {
-			pr_debug( "%s: invalid ep %d\n",
+			pr_debug("%s: invalid ep %d\n",
 					musb_driver_name, epn);
 			continue;
 		}
 		offset = fifo_setup(musb, hw_ep + epn, cfg++, offset);
 		if (offset < 0) {
-			pr_debug( "%s: mem overrun, ep %d\n",
+			pr_debug("%s: mem overrun, ep %d\n",
 					musb_driver_name, epn);
 			return -EINVAL;
 		}
@@ -1242,7 +1241,7 @@ static int __init ep_config_from_table(struct musb *musb)
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (!musb->bulk_ep) {
-		pr_debug( "%s: missing bulk\n", musb_driver_name);
+		pr_debug("%s: missing bulk\n", musb_driver_name);
 		return -EINVAL;
 	}
 #endif
@@ -1309,7 +1308,7 @@ static int __init ep_config_from_hw(struct musb *musb)
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 	if (!musb->bulk_ep) {
-		pr_debug( "%s: missing bulk\n", musb_driver_name);
+		pr_debug("%s: missing bulk\n", musb_driver_name);
 		return -EINVAL;
 	}
 #endif
@@ -1340,9 +1339,8 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 	reg = musb_readb(mbase, 0x10 + MUSB_CONFIGDATA);
 
 	strcpy(aInfo, (reg & MUSB_CONFIGDATA_UTMIDW) ? "UTMI-16" : "UTMI-8");
-	if (reg & MUSB_CONFIGDATA_DYNFIFO) {
+	if (reg & MUSB_CONFIGDATA_DYNFIFO)
 		strcat(aInfo, ", dyn FIFOs");
-	}
 	if (reg & MUSB_CONFIGDATA_MPRXE) {
 		strcat(aInfo, ", bulk combine");
 #ifdef C_MP_RX
@@ -1367,9 +1365,8 @@ static int __init musb_core_init(u16 musb_type, struct musb *musb)
 		strcat(aInfo, ", HB-ISO Tx");
 		strcat(aInfo, " (X)");		/* no driver support */
 	}
-	if (reg & MUSB_CONFIGDATA_SOFTCONE) {
+	if (reg & MUSB_CONFIGDATA_SOFTCONE)
 		strcat(aInfo, ", SoftConn");
-	}
 
 	printk(KERN_DEBUG "%s: ConfigData=0x%02x (%s)\n",
 			musb_driver_name, reg, aInfo);
@@ -1748,12 +1745,12 @@ static ssize_t
 musb_srp_store(struct device *dev, struct device_attribute *attr,
 		const char *buf, size_t n)
 {
-	struct musb	*musb=dev_to_musb(dev);
+	struct musb	*musb = dev_to_musb(dev);
 	unsigned short	srp;
 
 	if (sscanf(buf, "%hu", &srp) != 1
 			|| (srp != 1)) {
-		printk (KERN_ERR "SRP: Value must be 1\n");
+		printk(KERN_ERR "SRP: Value must be 1\n");
 		return -EINVAL;
 	}
 
@@ -1921,7 +1918,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 #ifdef CONFIG_USB_MUSB_OTG
 		break;
 #else
-	bad_config:
+bad_config:
 #endif
 	default:
 		dev_err(dev, "incompatible Kconfig role setting\n");
@@ -1997,7 +1994,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	INIT_WORK(&musb->irq_work, musb_irq_work);
 
 	/* attach to the IRQ */
-	if (request_irq (nIrq, musb->isr, 0, dev->bus_id, musb)) {
+	if (request_irq(nIrq, musb->isr, 0, dev->bus_id, musb)) {
 		dev_err(dev, "request_irq %d failed!\n", nIrq);
 		status = -ENODEV;
 		goto fail2;
-- 
1.5.5.23.g2a5fe

