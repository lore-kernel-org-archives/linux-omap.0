From: Kevin Hilman <khilman@mvista.com>
Subject: [PATCH] ARM: OMAP: MUSB: peripheral compile fix
Date: Fri, 17 Aug 2007 09:12:52 -0700
Message-ID: <20070817161252.274402322@mvista.com>
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

Move error detection for "Stopping host session because of babble" 
inside host-ifdef since it doesn't apply (or compile) for gadget.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
---
 drivers/usb/musb/plat_uds.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: dev/drivers/usb/musb/plat_uds.c
===================================================================
--- dev.orig/drivers/usb/musb/plat_uds.c
+++ dev/drivers/usb/musb/plat_uds.c
@@ -598,7 +598,6 @@ static irqreturn_t musb_stage0_irq(struc
 		DBG(1, "CONNECT (%s) devctl %02x\n",
 				otg_state_string(musb), devctl);
 	}
-#endif	/* CONFIG_USB_MUSB_HDRC_HCD */
 
 	/* mentor saves a bit: bus reset and babble share the same irq.
 	 * only host sees babble; only peripheral sees bus reset.
@@ -627,6 +626,7 @@ static irqreturn_t musb_stage0_irq(struc
 
 		handled = IRQ_HANDLED;
 	}
+#endif	/* CONFIG_USB_MUSB_HDRC_HCD */
 
 	return handled;
 }
--
