From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 9/12] musb_hdrc: Make HNP more reliable
Date: Thu, 11 Oct 2007 10:05:22 -0700
Message-ID: <11921223372253-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
	<11921223321890-git-send-email-tony@atomide.com>
	<11921223331118-git-send-email-tony@atomide.com>
	<11921223352146-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11921223352146-git-send-email-tony@atomide.com>
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

Sometimes we get both SUSPEND and DISCONNECT the same time.
In that case DISCONNECT must be ignored or else the HNP connection
will break right away.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index efaa4fb..3d35a4e 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -321,6 +321,7 @@ void musb_otg_timer_func(unsigned long data)
 		musb_hnp_stop(musb);
 		break;
 	}
+	musb->ignore_disconnect = 0;
 	spin_unlock_irqrestore(&musb->lock, flags);
 }
 
@@ -656,8 +657,13 @@ static irqreturn_t musb_stage0_irq(struct musb * musb, u8 int_usb,
 			DBG(1, "BUS RESET as %s\n", otg_state_string(musb));
 			switch (musb->xceiv.state) {
 #ifdef CONFIG_USB_OTG
+			case OTG_STATE_A_SUSPEND:
+				musb->ignore_disconnect = 1;
+				musb_g_reset(musb);
+				/* FALLTHROUGH */
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
-				DBG(1, "HNP: Setting timer as a_wait_bcon\n");
+				DBG(1, "HNP: Setting timer as %s\n",
+						otg_state_string(musb));
 				musb_otg_timer.data = (unsigned long)musb;
 				mod_timer(&musb_otg_timer, jiffies
 					+ msecs_to_jiffies(100));
-- 
1.5.2.5
