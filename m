From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 7/7] musb_hdrc: Fix doing HNP multiple times
Date: Fri, 17 Aug 2007 04:44:44 -0700
Message-ID: <11873511001036-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
	<11873510911954-git-send-email-tony@atomide.com>
	<11873510931624-git-send-email-tony@atomide.com>
	<11873510951742-git-send-email-tony@atomide.com>
	<11873510973002-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11873510973002-git-send-email-tony@atomide.com>
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

Without this patch OPT HS B TD.6.15 fails if run multiple
times in a row.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/virthub.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/musb/virthub.c b/drivers/usb/musb/virthub.c
index 3509aa0..757da5e 100644
--- a/drivers/usb/musb/virthub.c
+++ b/drivers/usb/musb/virthub.c
@@ -85,11 +85,14 @@ static void musb_port_suspend(struct musb *musb, u8 bSuspend)
 					&& musb->xceiv.host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
+#ifdef	CONFIG_USB_MUSB_OTG
 		case OTG_STATE_B_HOST:
-			musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
-			MUSB_DEV_MODE(musb);
-			/* REVISIT restore setting of MUSB_DEVCTL_HR */
+			musb->xceiv.state = OTG_STATE_B_WAIT_ACON;
+			musb->is_active = is_otg_enabled(musb)
+					&& musb->xceiv.host->b_hnp_enable;
+			musb_platform_try_idle(musb, 0);
 			break;
+#endif
 		default:
 			DBG(1, "bogus rh suspend? %s\n",
 				otg_state_string(musb));
@@ -113,6 +116,12 @@ static void musb_port_reset(struct musb *musb, u8 bReset)
 	void __iomem	*mbase = musb->mregs;
 
 #ifdef CONFIG_USB_MUSB_OTG
+	if (musb->xceiv.state == OTG_STATE_B_IDLE) {
+		DBG(2, "HNP: Returning from HNP, not resetting hub as b_idle\n");
+		musb->port1_status &= ~USB_PORT_STAT_RESET;
+		return;
+	}
+
 	/* REVISIT this looks wrong for HNP */
 	u8 devctl = musb_readb(mbase, MUSB_DEVCTL);
 
-- 
1.5.2.3
