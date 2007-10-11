From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/12] musb_hdrc: Improve tusb host state handling for a_idle
Date: Thu, 11 Oct 2007 10:05:19 -0700
Message-ID: <11921223321890-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
	<11921223311131-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
In-Reply-To: <11921223311131-git-send-email-tony@atomide.com>
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

This patch makes the changes happen based on vbus change.
This also seems to make enumeration work better.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index b3e745d..16eaa48 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -422,18 +422,15 @@ static void musb_do_idle(unsigned long _musb)
 
 	switch (musb->xceiv.state) {
 	case OTG_STATE_A_WAIT_BCON:
-	case OTG_STATE_A_WAIT_VRISE:
-	case OTG_STATE_A_IDLE:
 		if ((musb->a_wait_bcon != 0)
 			&& (musb->idle_timeout == 0
 				|| time_after(jiffies, musb->idle_timeout))) {
 			DBG(4, "Nothing connected %s, turning off VBUS\n",
 					otg_state_string(musb));
-			tusb_source_power(musb, 0);
-			musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
-			musb->is_active = 0;
 		}
-		break;
+		/* FALLTHROUGH */
+	case OTG_STATE_A_IDLE:
+		tusb_source_power(musb, 0);
 	default:
 		break;
 	}
@@ -533,7 +530,6 @@ static void tusb_source_power(struct musb *musb, int is_on)
 	if (is_on) {
 		if (musb->set_clock)
 			musb->set_clock(musb->clock, 1);
-		musb->is_active = 1;
 		timer = OTG_TIMER_MS(OTG_TIME_A_WAIT_VRISE);
 		musb->xceiv.default_a = 1;
 		musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
@@ -550,11 +546,13 @@ static void tusb_source_power(struct musb *musb, int is_on)
 		otg_stat = musb_readl(tbase, TUSB_DEV_OTG_STAT);
 		if (!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS)) {
 			switch (musb->xceiv.state) {
-			case OTG_STATE_A_WAIT_VFALL:
-				break;
 			case OTG_STATE_A_WAIT_VRISE:
+			case OTG_STATE_A_WAIT_BCON:
 				musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
 				break;
+			case OTG_STATE_A_WAIT_VFALL:
+				musb->xceiv.state = OTG_STATE_A_IDLE;
+				break;
 			default:
 				musb->xceiv.state = OTG_STATE_A_IDLE;
 			}
@@ -798,6 +796,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			break;
 		}
 	}
+	schedule_work(&musb->irq_work);
 
 	return idle_timeout;
 }
-- 
1.5.2.5
