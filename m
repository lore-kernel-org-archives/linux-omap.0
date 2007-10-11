From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 8/12] musb_hdrc: Add timer for returning to host mode from
	HNP
Date: Thu, 11 Oct 2007 10:05:21 -0700
Message-ID: <11921223352146-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223331118-git-send-email-tony@atomide.com>
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

This seems like the only way to deal with interrupted HNP if waiting
as a_wait_bcon.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index b438036..efaa4fb 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -309,11 +309,17 @@ void musb_otg_timer_func(unsigned long data)
 	unsigned long	flags;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	if (musb->xceiv.state == OTG_STATE_B_WAIT_ACON) {
-		DBG(1, "HNP: B_WAIT_ACON timeout; back to B_PERIPHERAL\n");
+	switch (musb->xceiv.state) {
+	case OTG_STATE_B_WAIT_ACON:
+		DBG(1, "HNP: b_wait_acon timeout; back to b_peripheral\n");
 		musb_g_disconnect(musb);
 		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
 		musb->is_active = 0;
+		break;
+	case OTG_STATE_A_WAIT_BCON:
+		DBG(1, "HNP: a_wait_bcon timeout; back to a_host\n");
+		musb_hnp_stop(musb);
+		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
@@ -649,10 +655,17 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 		} else if (is_peripheral_capable()) {
 			DBG(1, "BUS RESET as %s\n", otg_state_string(musb));
 			switch (musb->xceiv.state) {
-			case OTG_STATE_A_PERIPHERAL:
+#ifdef CONFIG_USB_OTG
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
+				DBG(1, "HNP: Setting timer as a_wait_bcon\n");
+				musb_otg_timer.data = (unsigned long)musb;
+				mod_timer(&musb_otg_timer, jiffies
+					+ msecs_to_jiffies(100));
+				break;
+			case OTG_STATE_A_PERIPHERAL:
 				musb_hnp_stop(musb);
 				break;
+#endif
 			case OTG_STATE_B_IDLE:
 				musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
 				/* FALLTHROUGH */
-- 
1.5.2.5
