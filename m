From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: [RFC PATCH 4/5] USB: MUSB: Always allow musb to idle
Date: Tue, 13 May 2008 15:29:55 +0300
Message-ID: <1210681796-1984-5-git-send-email-felipe.balbi@nokia.com>
References: <1210681796-1984-1-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-2-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-3-git-send-email-felipe.balbi@nokia.com>
 <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:42469 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754279AbYEMMbQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 May 2008 08:31:16 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m4DCUvIi020626
	for <linux-omap@vger.kernel.org>; Tue, 13 May 2008 15:31:13 +0300
In-Reply-To: <1210681796-1984-4-git-send-email-felipe.balbi@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: ext Felipe Balbi <felipe.balbi@nokia.com>

From: ext Felipe Balbi <felipe.balbi@nokia.com>

We can conserve more power if we always let it idle
when there's nothing using the bus.

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/usb/musb/omap2430.c |   28 ++++------------------------
 drivers/usb/musb/tusb6010.c |   31 +++++++------------------------
 2 files changed, 11 insertions(+), 48 deletions(-)

diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 36f1739..5c948e5 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -46,6 +46,7 @@
 #endif
 
 #define MUSB_TIMEOUT_A_WAIT_BCON	1100
+#define MUSB_DEFAULT_TIMEOUT		500
 
 static struct timer_list musb_idle_timer;
 
@@ -109,34 +110,12 @@ static void musb_do_idle(unsigned long _musb)
 
 void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
 {
-	unsigned long		default_timeout = jiffies + msecs_to_jiffies(3);
-	static unsigned long	last_timer;
-
-	if (timeout == 0)
-		timeout = default_timeout;
-
-	/* Never idle if active, or when VBUS timeout is not set as host */
-	if (musb->is_active || ((musb->a_wait_bcon == 0)
-			&& (musb->xceiv.state == OTG_STATE_A_WAIT_BCON))) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
-		del_timer(&musb_idle_timer);
-		last_timer = jiffies;
-		return;
-	}
-
-	if (time_after(last_timer, timeout)) {
-		if (!timer_pending(&musb_idle_timer))
-			last_timer = timeout;
-		else {
-			DBG(4, "Longer idle timer already pending, ignoring\n");
-			return;
-		}
-	}
-	last_timer = timeout;
+	unsigned long		default_timeout = musb->idle_timeout;
 
 	DBG(4, "%s inactive, for idle timer for %lu ms\n",
 		otg_state_string(musb),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
+
 	mod_timer(&musb_idle_timer, timeout);
 }
 
@@ -246,6 +225,7 @@ int __init musb_platform_init(struct musb *musb)
 	if (is_peripheral_enabled(musb))
 		musb->xceiv.set_power = omap_set_power;
 	musb->a_wait_bcon = MUSB_TIMEOUT_A_WAIT_BCON;
+	musb->idle_timeout = MUSB_DEFAULT_TIMEOUT;
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 14220d9..ecdf41e 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -30,6 +30,8 @@ static void tusb_source_power(struct musb *musb, int is_on);
 #define TUSB_REV_MAJOR(reg_val)		((reg_val >> 4) & 0xf)
 #define TUSB_REV_MINOR(reg_val)		(reg_val & 0xf)
 
+#define MUSB_DEFAULT_TIMEOUT		500
+
 /*
  * Checks the revision. We need to use the DMA register as 3.0 does not
  * have correct versions for TUSB_PRCM_REV or TUSB_INT_CTRL_REV.
@@ -476,34 +478,12 @@ done:
  */
 void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
 {
-	unsigned long		default_timeout = jiffies + msecs_to_jiffies(3);
-	static unsigned long	last_timer;
-
-	if (timeout == 0)
-		timeout = default_timeout;
-
-	/* Never idle if active, or when VBUS timeout is not set as host */
-	if (musb->is_active || ((musb->a_wait_bcon == 0)
-			&& (musb->xceiv.state == OTG_STATE_A_WAIT_BCON))) {
-		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
-		del_timer(&musb_idle_timer);
-		last_timer = jiffies;
-		return;
-	}
-
-	if (time_after(last_timer, timeout)) {
-		if (!timer_pending(&musb_idle_timer))
-			last_timer = timeout;
-		else {
-			DBG(4, "Longer idle timer already pending, ignoring\n");
-			return;
-		}
-	}
-	last_timer = timeout;
+	unsigned long		default_timeout = musb->idle_timeout;
 
 	DBG(4, "%s inactive, for idle timer for %lu ms\n",
 		otg_state_string(musb),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
+
 	mod_timer(&musb_idle_timer, timeout);
 }
 
@@ -1128,6 +1108,9 @@ int __init musb_platform_init(struct musb *musb)
 	if (is_peripheral_enabled(musb))
 		musb->xceiv.set_power = tusb_draw_power;
 
+	/* Default idle_timeout in ms */
+	musb->idle_timeout = MUSB_DEFAULT_TIMEOUT;
+
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 
 	return ret;
-- 
1.5.5.1.125.gc697a

