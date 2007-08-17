From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/7] musb_hdrc: Keep state as b_idle if disconnected as
	b_idle
Date: Fri, 17 Aug 2007 04:44:43 -0700
Message-ID: <11873510973002-git-send-email-tony@atomide.com>
References: <118735108469-git-send-email-tony@atomide.com>
	<11873510862981-git-send-email-tony@atomide.com>
	<11873510882998-git-send-email-tony@atomide.com>
	<11873510911954-git-send-email-tony@atomide.com>
	<11873510931624-git-send-email-tony@atomide.com>
	<11873510951742-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11873510951742-git-send-email-tony@atomide.com>
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

Otherwise OPT FS B TD.5.6 can fail.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_gadget.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 86a256a..88757ce 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1962,6 +1962,8 @@ void musb_g_disconnect(struct musb *musb)
 	switch (musb->xceiv.state) {
 	default:
 #ifdef	CONFIG_USB_MUSB_OTG
+		DBG(2, "Unhandled disconnect %s, setting a_idle\n",
+			otg_state_string(musb));
 		musb->xceiv.state = OTG_STATE_A_IDLE;
 		break;
 	case OTG_STATE_A_PERIPHERAL:
@@ -1971,6 +1973,7 @@ void musb_g_disconnect(struct musb *musb)
 	case OTG_STATE_B_HOST:
 #endif
 	case OTG_STATE_B_PERIPHERAL:
+	case OTG_STATE_B_IDLE:
 		musb->xceiv.state = OTG_STATE_B_IDLE;
 		break;
 	case OTG_STATE_B_SRP_INIT:
-- 
1.5.2.3
