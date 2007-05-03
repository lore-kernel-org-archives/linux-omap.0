From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH] musb_hdrc: Stop host session on BABBLE
Date: Thu,  3 May 2007 16:41:57 +0000
Message-ID: <117821052378-git-send-email-tony@atomide.com>
References: musb-2007-05-03-164131
	<11782105181141-git-send-email-tony@atomide.com>
	<11782105222073-git-send-email-tony@atomide.com>
	<11782105223370-git-send-email-tony@atomide.com>
	<11782105221042-git-send-email-tony@atomide.com>
	<11782105222902-git-send-email-tony@atomide.com>
	<11782105231172-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11782105231172-git-send-email-tony@atomide.com>
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

Babble is a non-recoverable error condition and we
need to fix whatever causes it. Stop the session on BABBLE
to make debugging the cause of BABBLE possible.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/plat_uds.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/plat_uds.c b/drivers/usb/musb/plat_uds.c
index 14fbeba..86dd6b2 100644
--- a/drivers/usb/musb/plat_uds.c
+++ b/drivers/usb/musb/plat_uds.c
@@ -534,19 +534,14 @@ static irqreturn_t musb_stage0_irq(struct musb * pThis, u8 bIntrUSB,
 	 */
 	if (bIntrUSB & MGC_M_INTR_RESET) {
 		if (devctl & MGC_M_DEVCTL_HM) {
-			DBG(1, "BABBLE\n");
-
-			/* REVISIT it's unclear how to handle this.  Mentor's
-			 * code stopped the whole USB host, which is clearly
-			 * very wrong.  Docs say (15.1) that babble ends the
-			 * current sesssion, so shutdown _with restart_ would
-			 * be appropriate ... except that seems to be wrong,
-			 * at least some lowspeed enumerations trigger the
-			 * babbles without aborting the session!
-			 *
-			 * (A "babble" IRQ seems quite pointless...)
+			/*
+			 * BABBLE is an error condition, so the solution is
+			 * to avoid babble in the first place and fix whatever
+			 * causes BABBLE. When BABBLE happens we can only stop
+			 * the session.
 			 */
-
+			ERR("Stopping host session because of babble\n");
+			musb_writeb(pBase, MGC_O_HDRC_DEVCTL, 0);
 		} else {
 			DBG(1, "BUS RESET\n");
 
-- 
1.4.4.2
