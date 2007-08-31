From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: musb_vbus_store(): dont exit with spinlock held
Date: Fri, 31 Aug 2007 16:29:22 -0700
Message-ID: <20070831232922.937939666@mvista.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>

---
 drivers/usb/musb/musb_core.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: dev/drivers/usb/musb/musb_core.c
===================================================================
--- dev.orig/drivers/usb/musb/musb_core.c
+++ dev/drivers/usb/musb/musb_core.c
@@ -1683,11 +1683,12 @@ musb_vbus_store(struct device *dev, stru
 	unsigned long	flags;
 	unsigned long	val;
 
-	spin_lock_irqsave(&musb->lock, flags);
 	if (sscanf(buf, "%lu", &val) < 1) {
 		printk(KERN_ERR "Invalid VBUS timeout ms value\n");
 		return -EINVAL;
 	}
+
+	spin_lock_irqsave(&musb->lock, flags);
 	musb->a_wait_bcon = val;
 	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
 		musb->is_active = 0;
--
