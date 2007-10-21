From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/6] musb_hdrc: Move tusb PLL locking code into a separate
	function
Date: Sun, 21 Oct 2007 16:20:52 -0700
Message-ID: <11930088592326-git-send-email-tony@atomide.com>
References: musb-2007-10-21 <119300885686-git-send-email-tony@atomide.com>
	<11930088583835-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11930088583835-git-send-email-tony@atomide.com>
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

This needs to be also called when changing L3 speed with cpufreq.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010.c |   30 ++++++++++++++++++------------
 1 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 3008b6d..85afdd2 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -316,6 +316,23 @@ static int tusb_draw_power(struct otg_transceiver *x, unsigned mA)
 #define tusb_draw_power	NULL
 #endif
 
+/* There are issues re-locking the PLL on wakeup */
+static inline void tusb_lock_pll(struct musb *musb)
+{
+	void __iomem	*tbase = musb->ctrl_base;
+	u32		reg;
+	int		i;
+
+	for (i = 0xf7f7f7; i > 0xf7f7f7 - 1000; i--) {
+		musb_writel(tbase, TUSB_SCRATCH_PAD, 0);
+		musb_writel(tbase, TUSB_SCRATCH_PAD, i);
+		reg = musb_readl(tbase, TUSB_SCRATCH_PAD);
+		if (reg == i)
+			break;
+		DBG(6, "TUSB NOR not ready\n");
+	}
+}
+
 /* workaround for issue 13:  change clock during chip idle
  * (to be fixed in rev3 silicon) ... symptoms include disconnect
  * or looping suspend/resume cycles
@@ -824,22 +841,11 @@ static irqreturn_t tusb_interrupt(int irq, void *__hci)
 	/* Acknowledge wake-up source interrupts */
 	if (int_src & TUSB_INT_SRC_DEV_WAKEUP) {
 		u32	reg;
-		u32	i;
 
 		if (tusb_get_revision(musb) == TUSB_REV_30)
 			tusb_wbus_quirk(musb, 0);
 
-		/* there are issues re-locking the PLL on wakeup ... */
-
-		/* work around issue 8 */
-		for (i = 0xf7f7f7; i > 0xf7f7f7 - 1000; i--) {
-			musb_writel(tbase, TUSB_SCRATCH_PAD, 0);
-			musb_writel(tbase, TUSB_SCRATCH_PAD, i);
-			reg = musb_readl(tbase, TUSB_SCRATCH_PAD);
-			if (reg == i)
-				break;
-			DBG(6, "TUSB NOR not ready\n");
-		}
+		tusb_lock_pll(musb);
 
 		/* work around issue 13 (2nd half) */
 		tusb_set_clock_source(musb, 1);
-- 
1.5.2.5
