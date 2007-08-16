From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: MUSB: fix compile for non-OTG modes
Date: Thu, 16 Aug 2007 11:18:01 -0700
Message-ID: <20070816181801.798599625@mvista.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/usb/musb/plat_uds.c |    2 ++
 1 file changed, 2 insertions(+)

Index: pristine/drivers/usb/musb/plat_uds.c
===================================================================
--- pristine.orig/drivers/usb/musb/plat_uds.c
+++ pristine/drivers/usb/musb/plat_uds.c
@@ -737,9 +737,11 @@ static irqreturn_t musb_stage2_irq(struc
 		handled = IRQ_HANDLED;
 
 		switch (musb->xceiv.state) {
+#ifdef	CONFIG_USB_MUSB_OTG
 		case OTG_STATE_A_PERIPHERAL:
 			musb_hnp_stop(musb);
 			break;
+#endif
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_suspend(musb);
 			musb->is_active = is_otg_enabled(musb)
--
