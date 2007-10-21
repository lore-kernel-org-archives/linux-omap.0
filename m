From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/6] musb_hdrc: Improve tusb clock handling
Date: Sun, 21 Oct 2007 16:20:53 -0700
Message-ID: <11930088601320-git-send-email-tony@atomide.com>
References: musb-2007-10-21 <119300885686-git-send-email-tony@atomide.com>
	<11930088583835-git-send-email-tony@atomide.com>
	<11930088592326-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11930088592326-git-send-email-tony@atomide.com>
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

Do not disable clock until in tusb_allow_idle()

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/tusb6010.c |   20 +++++++++++++-------
 1 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 85afdd2..c3285ac 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -277,13 +277,10 @@ static int tusb_draw_power(struct otg_transceiver *x, unsigned mA)
 	/*
 	 * Keep clock active when enabled. Note that this is not tied to
 	 * drawing VBUS, as with OTG mA can be less than musb->min_power.
+	 * Note that peripheral osc_ck gets disabled in tusb_allow_idle().
 	 */
-	if (musb->set_clock) {
-		if (mA)
+	if (musb->set_clock && mA)
 			musb->set_clock(musb->clock, 1);
-		else
-			musb->set_clock(musb->clock, 0);
-	}
 
 	/* tps65030 seems to consume max 100mA, with maybe 60mA available
 	 * (measured on one board) for things other than tps and tusb.
@@ -342,6 +339,9 @@ static void tusb_set_clock_source(struct musb *musb, unsigned mode)
 	void __iomem	*tbase = musb->ctrl_base;
 	u32		reg;
 
+	if (musb->set_clock && (mode == 1))
+		musb->set_clock(musb->clock, 1);
+
 	reg = musb_readl(tbase, TUSB_PRCM_CONF);
 	reg &= ~TUSB_PRCM_CONF_SYS_CLKSEL(0x3);
 
@@ -374,6 +374,9 @@ void tusb_allow_idle(struct musb *musb, u32 wakeup_enables)
 		tusb_wbus_quirk(musb, 1);
 
 	tusb_set_clock_source(musb, 0);
+	if ((musb_platform_get_vbus_status(musb) == 0)
+		&& (musb->xceiv.state == OTG_STATE_B_IDLE))
+			musb->set_clock(musb->clock, 0);
 
 	wakeup_enables |= TUSB_PRCM_WNORCS;
 	musb_writel(tbase, TUSB_PRCM_WAKEUP_MASK, ~wakeup_enables);
@@ -587,8 +590,8 @@ static void tusb_source_power(struct musb *musb, int is_on)
 
 		devctl &= ~MUSB_DEVCTL_SESSION;
 		conf &= ~TUSB_DEV_CONF_USB_HOST_MODE;
-		if (musb->set_clock)
-			musb->set_clock(musb->clock, 0);
+
+		/* Host osc_ck gets released in tusb_allow_idle() */
 	}
 	prcm &= ~(TUSB_PRCM_MNGMT_15_SW_EN | TUSB_PRCM_MNGMT_33_SW_EN);
 
@@ -984,6 +987,9 @@ void musb_platform_disable(struct musb *musb)
 
 	del_timer(&musb_idle_timer);
 
+	if (musb->set_clock)
+		musb->set_clock(musb->clock, 0);
+
 	if (is_dma_capable() && !dma_off) {
 		printk(KERN_WARNING "%s %s: dma still active\n",
 				__FILE__, __FUNCTION__);
-- 
1.5.2.5
