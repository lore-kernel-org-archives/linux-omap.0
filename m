From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 5/6] musb_hdrc: Add musb_platform_wakeup()
Date: Sun, 21 Oct 2007 16:20:55 -0700
Message-ID: <11930088633238-git-send-email-tony@atomide.com>
References: musb-2007-10-21 <119300885686-git-send-email-tony@atomide.com>
	<11930088583835-git-send-email-tony@atomide.com>
	<11930088592326-git-send-email-tony@atomide.com>
	<11930088601320-git-send-email-tony@atomide.com>
	<11930088611788-git-send-email-tony@atomide.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11930088611788-git-send-email-tony@atomide.com>
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

If we access tusb registers when tusb is in idle mode, tusb
registers may not be immediately available. In most cases
an interrupt will wake the system, but at least sending
SRP can fail tusb registers are accessed via sysfs.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/usb/musb/musb_core.h   |    2 ++
 drivers/usb/musb/musb_gadget.c |    2 +-
 drivers/usb/musb/tusb6010.c    |   15 +++++++++++++++
 3 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
index 332d39d..1ea0849 100644
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -477,10 +477,12 @@ extern void musb_platform_disable(struct musb *musb);
 extern void musb_hnp_stop(struct musb *musb);
 
 #ifdef CONFIG_USB_TUSB6010
+extern void musb_platform_wakeup(struct musb *musb);
 extern void musb_platform_try_idle(struct musb *musb, unsigned long timeout);
 extern int musb_platform_get_vbus_status(struct musb *musb);
 extern void musb_platform_set_mode(struct musb *musb, u8 musb_mode);
 #else
+#define musb_platform_wakeup(x)			do {} while (0)
 #define musb_platform_try_idle(x, y)		do {} while (0)
 #define musb_platform_get_vbus_status(x)	0
 #define musb_platform_set_mode(x, y)		do {} while (0)
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 0fb9635..4b25b0a 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1394,7 +1394,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 	int		retries;
 
 	spin_lock_irqsave(&musb->lock, flags);
-
+	musb_platform_wakeup(musb);
 	switch (musb->xceiv.state) {
 	case OTG_STATE_B_PERIPHERAL:
 		/* NOTE:  OTG state machine doesn't include B_SUSPENDED;
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index c3285ac..7cbd50c 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -359,6 +359,21 @@ static void tusb_set_clock_source(struct musb *musb, unsigned mode)
 }
 
 /*
+ * Wake-up tusb from idle. Caller must take care of locking.
+ */
+void musb_platform_wakeup(struct musb *musb)
+{
+	void __iomem	*tbase = musb->ctrl_base;
+	u32		int_src;
+
+	tusb_lock_pll(musb);
+	tusb_set_clock_source(musb, 1);
+	int_src = musb_readl(tbase, TUSB_INT_SRC) & ~TUSB_INT_SRC_RESERVED_BITS;
+	if (int_src & TUSB_INT_SRC_DEV_WAKEUP)
+		musb_writel(tbase, TUSB_INT_SRC_CLEAR, TUSB_INT_SRC_DEV_WAKEUP);
+}
+
+/*
  * Idle TUSB6010 until next wake-up event; NOR access always wakes.
  * Other code ensures that we idle unless we're connected _and_ the
  * USB link is not suspended ... and tells us the relevant wakeup
-- 
1.5.2.5
