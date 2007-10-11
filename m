From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/12] musb_hdrc: Fix host suspend handling,
	remove earlier hacks
Date: Thu, 11 Oct 2007 10:05:18 -0700
Message-ID: <11921223311131-git-send-email-tony@atomide.com>
References: <1192122325531-git-send-email-tony@atomide.com>
	<11921223262203-git-send-email-tony@atomide.com>
	<11921223272557-git-send-email-tony@atomide.com>
	<11921223283749-git-send-email-tony@atomide.com>
	<11921223301447-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11921223301447-git-send-email-tony@atomide.com>
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

If A-cable was connected and a gadget module was reloaded, root hub
suspend would fail.

This the problem by managing musb inactive state better. The patch also adds
more debug info for cases where suspend is attempted in active state.

Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 79518ae..091ae8f 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2128,9 +2128,11 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 {
 	struct musb	*musb = hcd_to_musb(hcd);
 
-	if (is_host_active(musb) && musb->is_active)
+	if (is_host_active(musb) && musb->is_active) {
+		WARN("trying to suspend as %s is_active=%i\n",
+			otg_state_string(musb), musb->is_active);
 		return -EBUSY;
-	else
+	} else
 		return 0;
 }
 
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index b123d8e..22b1d5e 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -190,6 +190,7 @@ void musb_root_disconnect(struct musb *musb)
 	case OTG_STATE_A_HOST:
 	case OTG_STATE_A_SUSPEND:
 		musb->xceiv.state = OTG_STATE_A_WAIT_BCON;
+		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
 		musb->xceiv.state = OTG_STATE_B_IDLE;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 5026f2b..b3e745d 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -430,7 +430,7 @@ static void musb_do_idle(unsigned long _musb)
 			DBG(4, "Nothing connected %s, turning off VBUS\n",
 					otg_state_string(musb));
 			tusb_source_power(musb, 0);
-			musb->xceiv.state = OTG_STATE_A_IDLE;
+			musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
 			musb->is_active = 0;
 		}
 		break;
@@ -551,16 +551,14 @@ static void tusb_source_power(struct musb *musb, int is_on)
 		if (!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS)) {
 			switch (musb->xceiv.state) {
 			case OTG_STATE_A_WAIT_VFALL:
-				musb->is_active = 1;
 				break;
 			case OTG_STATE_A_WAIT_VRISE:
-				musb->is_active = 1;
 				musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
 				break;
 			default:
-				musb->is_active = 0;
 				musb->xceiv.state = OTG_STATE_A_IDLE;
 			}
+			musb->is_active = 0;
 			musb->xceiv.default_a = 1;
 			MUSB_HST_MODE(musb);
 		} else {
@@ -778,11 +776,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 					break;
 				}
 				musb->xceiv.state = OTG_STATE_A_WAIT_BCON;
-				/* CONNECT can wake if a_wait_bcon is set */
-				if (musb->a_wait_bcon != 0)
-					musb->is_active = 0;
-				else
-					musb->is_active = 1;
+				musb->is_active = 0;
 				idle_timeout = jiffies
 					+ msecs_to_jiffies(musb->a_wait_bcon);
 			} else {
-- 
1.5.2.5
