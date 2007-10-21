From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 6/6] musb_hdrc: Handle b_host in musb_otg_timer_func()
Date: Sun, 21 Oct 2007 16:20:56 -0700
Message-ID: <119300886467-git-send-email-tony@atomide.com>
References: musb-2007-10-21 <119300885686-git-send-email-tony@atomide.com>
	<11930088583835-git-send-email-tony@atomide.com>
	<11930088592326-git-send-email-tony@atomide.com>
	<11930088601320-git-send-email-tony@atomide.com>
	<11930088611788-git-send-email-tony@atomide.com>
	<11930088633238-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11930088633238-git-send-email-tony@atomide.com>
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

Otherwise we get warnings about unhandled mode.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 29732a8..4a2c85a 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -310,6 +310,8 @@ void musb_otg_timer_func(unsigned long data)
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv.state) {
+	case OTG_STATE_B_HOST:
+		break;
 	case OTG_STATE_B_WAIT_ACON:
 		DBG(1, "HNP: b_wait_acon timeout; back to b_peripheral\n");
 		musb_g_disconnect(musb);
-- 
1.5.2.5
