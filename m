From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 01/10] usb: otg: prefix otg_state_string with usb_
Date: Thu, 7 Mar 2013 11:36:00 +0200
Message-ID: <1362648969-13737-2-git-send-email-balbi@ti.com>
References: <1362648969-13737-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:36487 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755800Ab3CGJgc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Mar 2013 04:36:32 -0500
In-Reply-To: <1362648969-13737-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux USB Mailing List <linux-usb@vger.kernel.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, cbou@mail.ru, dwmw2@infradead.org, stern@rowland.harvard.edu, swarren@wwwdotorg.org, arnd@arndb.de, linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, Felipe Balbi <balbi@ti.com>

all other functions under drivers/usb/ start
with usb_, let's do the same thing.

This patch is in preparation for moving otg_state_string
to usb-common.c and deleting otg.c completely.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 drivers/usb/musb/am35x.c        |  8 ++++----
 drivers/usb/musb/blackfin.c     |  6 +++---
 drivers/usb/musb/da8xx.c        |  8 ++++----
 drivers/usb/musb/davinci.c      |  4 ++--
 drivers/usb/musb/musb_core.c    | 39 ++++++++++++++++++++-------------------
 drivers/usb/musb/musb_dsps.c    |  8 ++++----
 drivers/usb/musb/musb_gadget.c  |  8 ++++----
 drivers/usb/musb/musb_host.c    |  2 +-
 drivers/usb/musb/musb_virthub.c |  4 ++--
 drivers/usb/musb/omap2430.c     |  6 +++---
 drivers/usb/musb/tusb6010.c     | 14 +++++++-------
 drivers/usb/otg/fsl_otg.c       |  2 +-
 drivers/usb/otg/isp1301_omap.c  |  6 +++---
 drivers/usb/otg/otg.c           |  4 ++--
 drivers/usb/otg/otg_fsm.c       |  2 +-
 include/linux/usb/otg.h         |  4 ++--
 16 files changed, 63 insertions(+), 62 deletions(-)

diff --git a/drivers/usb/musb/am35x.c b/drivers/usb/musb/am35x.c
index 59eea21..2231850 100644
--- a/drivers/usb/musb/am35x.c
+++ b/drivers/usb/musb/am35x.c
@@ -149,7 +149,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
-		otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -195,7 +195,7 @@ static void am35x_musb_try_idle(struct musb *musb, unsigned long timeout)
 	if (musb->is_active || (musb->a_wait_bcon == 0 &&
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		del_timer(&otg_workaround);
 		last_timer = jiffies;
 		return;
@@ -208,7 +208,7 @@ static void am35x_musb_try_idle(struct musb *musb, unsigned long timeout)
 	last_timer = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&otg_workaround, timeout);
 }
@@ -298,7 +298,7 @@ static irqreturn_t am35x_musb_interrupt(int irq, void *hci)
 		/* NOTE: this must complete power-on within 100 ms. */
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				err ? " ERROR" : "",
 				devctl);
 		ret = IRQ_HANDLED;
diff --git a/drivers/usb/musb/blackfin.c b/drivers/usb/musb/blackfin.c
index dbb31b3..5e63b16 100644
--- a/drivers/usb/musb/blackfin.c
+++ b/drivers/usb/musb/blackfin.c
@@ -280,13 +280,13 @@ static void musb_conn_timer_handler(unsigned long _musb)
 		break;
 	default:
 		dev_dbg(musb->controller, "%s state not handled\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		break;
 	}
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	dev_dbg(musb->controller, "state is %s\n",
-		otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 }
 
 static void bfin_musb_enable(struct musb *musb)
@@ -307,7 +307,7 @@ static void bfin_musb_set_vbus(struct musb *musb, int is_on)
 
 	dev_dbg(musb->controller, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
 
diff --git a/drivers/usb/musb/da8xx.c b/drivers/usb/musb/da8xx.c
index 7c71769d..ea7e591 100644
--- a/drivers/usb/musb/da8xx.c
+++ b/drivers/usb/musb/da8xx.c
@@ -198,7 +198,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
-		otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -267,7 +267,7 @@ static void da8xx_musb_try_idle(struct musb *musb, unsigned long timeout)
 	if (musb->is_active || (musb->a_wait_bcon == 0 &&
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		del_timer(&otg_workaround);
 		last_timer = jiffies;
 		return;
@@ -280,7 +280,7 @@ static void da8xx_musb_try_idle(struct musb *musb, unsigned long timeout)
 	last_timer = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&otg_workaround, timeout);
 }
@@ -360,7 +360,7 @@ static irqreturn_t da8xx_musb_interrupt(int irq, void *hci)
 
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				err ? " ERROR" : "",
 				devctl);
 		ret = IRQ_HANDLED;
diff --git a/drivers/usb/musb/davinci.c b/drivers/usb/musb/davinci.c
index e040d91..bea6cc3 100644
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -215,7 +215,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = musb_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "poll devctl %02x (%s)\n", devctl,
-		otg_state_string(musb->xceiv->state));
+		usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -349,7 +349,7 @@ static irqreturn_t davinci_musb_interrupt(int irq, void *__hci)
 		davinci_musb_source_power(musb, drvvbus, 0);
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				err ? " ERROR" : "",
 				devctl);
 		retval = IRQ_HANDLED;
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
index 48609ea..b37bafc 100644
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -372,13 +372,13 @@ static void musb_otg_timer_func(unsigned long data)
 	case OTG_STATE_A_SUSPEND:
 	case OTG_STATE_A_WAIT_BCON:
 		dev_dbg(musb->controller, "HNP: %s timeout\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		musb_platform_set_vbus(musb, 0);
 		musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
 		break;
 	default:
 		dev_dbg(musb->controller, "HNP: Unhandled mode %s\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 	}
 	musb->ignore_disconnect = 0;
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -393,13 +393,14 @@ void musb_hnp_stop(struct musb *musb)
 	void __iomem	*mbase = musb->mregs;
 	u8	reg;
 
-	dev_dbg(musb->controller, "HNP: stop from %s\n", otg_state_string(musb->xceiv->state));
+	dev_dbg(musb->controller, "HNP: stop from %s\n",
+			usb_otg_state_string(musb->xceiv->state));
 
 	switch (musb->xceiv->state) {
 	case OTG_STATE_A_PERIPHERAL:
 		musb_g_disconnect(musb);
 		dev_dbg(musb->controller, "HNP: back to %s\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		break;
 	case OTG_STATE_B_HOST:
 		dev_dbg(musb->controller, "HNP: Disabling HR\n");
@@ -413,7 +414,7 @@ void musb_hnp_stop(struct musb *musb)
 		break;
 	default:
 		dev_dbg(musb->controller, "HNP: Stopping in unknown state %s\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 	}
 
 	/*
@@ -451,7 +452,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 	 */
 	if (int_usb & MUSB_INTR_RESUME) {
 		handled = IRQ_HANDLED;
-		dev_dbg(musb->controller, "RESUME (%s)\n", otg_state_string(musb->xceiv->state));
+		dev_dbg(musb->controller, "RESUME (%s)\n", usb_otg_state_string(musb->xceiv->state));
 
 		if (devctl & MUSB_DEVCTL_HM) {
 			void __iomem *mbase = musb->mregs;
@@ -493,7 +494,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			default:
 				WARNING("bogus %s RESUME (%s)\n",
 					"host",
-					otg_state_string(musb->xceiv->state));
+					usb_otg_state_string(musb->xceiv->state));
 			}
 		} else {
 			switch (musb->xceiv->state) {
@@ -522,7 +523,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 			default:
 				WARNING("bogus %s RESUME (%s)\n",
 					"peripheral",
-					otg_state_string(musb->xceiv->state));
+					usb_otg_state_string(musb->xceiv->state));
 			}
 		}
 	}
@@ -538,7 +539,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		}
 
 		dev_dbg(musb->controller, "SESSION_REQUEST (%s)\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 
 		/* IRQ arrives from ID pin sense or (later, if VBUS power
 		 * is removed) SRP.  responses are time critical:
@@ -603,7 +604,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 		}
 
 		dev_dbg(musb->controller, "VBUS_ERROR in %s (%02x, %s), retry #%d, port1 %08x\n",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				devctl,
 				({ char *s;
 				switch (devctl & MUSB_DEVCTL_VBUS) {
@@ -628,7 +629,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 
 	if (int_usb & MUSB_INTR_SUSPEND) {
 		dev_dbg(musb->controller, "SUSPEND (%s) devctl %02x\n",
-			otg_state_string(musb->xceiv->state), devctl);
+			usb_otg_state_string(musb->xceiv->state), devctl);
 		handled = IRQ_HANDLED;
 
 		switch (musb->xceiv->state) {
@@ -745,12 +746,12 @@ b_host:
 			usb_hcd_resume_root_hub(hcd);
 
 		dev_dbg(musb->controller, "CONNECT (%s) devctl %02x\n",
-				otg_state_string(musb->xceiv->state), devctl);
+				usb_otg_state_string(musb->xceiv->state), devctl);
 	}
 
 	if ((int_usb & MUSB_INTR_DISCONNECT) && !musb->ignore_disconnect) {
 		dev_dbg(musb->controller, "DISCONNECT (%s) as %s, devctl %02x\n",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				MUSB_MODE(musb), devctl);
 		handled = IRQ_HANDLED;
 
@@ -787,7 +788,7 @@ b_host:
 			break;
 		default:
 			WARNING("unhandled DISCONNECT transition (%s)\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 			break;
 		}
 	}
@@ -813,7 +814,7 @@ b_host:
 			}
 		} else {
 			dev_dbg(musb->controller, "BUS RESET as %s\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 			switch (musb->xceiv->state) {
 			case OTG_STATE_A_SUSPEND:
 				/* We need to ignore disconnect on suspend
@@ -826,7 +827,7 @@ b_host:
 			case OTG_STATE_A_WAIT_BCON:	/* OPT TD.4.7-900ms */
 				/* never use invalid T(a_wait_bcon) */
 				dev_dbg(musb->controller, "HNP: in %s, %d msec timeout\n",
-					otg_state_string(musb->xceiv->state),
+					usb_otg_state_string(musb->xceiv->state),
 					TA_WAIT_BCON(musb));
 				mod_timer(&musb->otg_timer, jiffies
 					+ msecs_to_jiffies(TA_WAIT_BCON(musb)));
@@ -838,7 +839,7 @@ b_host:
 				break;
 			case OTG_STATE_B_WAIT_ACON:
 				dev_dbg(musb->controller, "HNP: RESET (%s), to b_peripheral\n",
-					otg_state_string(musb->xceiv->state));
+					usb_otg_state_string(musb->xceiv->state));
 				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				musb_g_reset(musb);
 				break;
@@ -850,7 +851,7 @@ b_host:
 				break;
 			default:
 				dev_dbg(musb->controller, "Unhandled BUS RESET as %s\n",
-					otg_state_string(musb->xceiv->state));
+					usb_otg_state_string(musb->xceiv->state));
 			}
 		}
 	}
@@ -1634,7 +1635,7 @@ musb_mode_show(struct device *dev, struct device_attribute *attr, char *buf)
 	int ret = -EINVAL;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	ret = sprintf(buf, "%s\n", otg_state_string(musb->xceiv->state));
+	ret = sprintf(buf, "%s\n", usb_otg_state_string(musb->xceiv->state));
 	spin_unlock_irqrestore(&musb->lock, flags);
 
 	return ret;
diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
index 4b49874..1ea553d 100644
--- a/drivers/usb/musb/musb_dsps.c
+++ b/drivers/usb/musb/musb_dsps.c
@@ -225,7 +225,7 @@ static void otg_timer(unsigned long _musb)
 	 */
 	devctl = dsps_readb(mregs, MUSB_DEVCTL);
 	dev_dbg(musb->controller, "Poll devctl %02x (%s)\n", devctl,
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 
 	spin_lock_irqsave(&musb->lock, flags);
 	switch (musb->xceiv->state) {
@@ -274,7 +274,7 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 	if (musb->is_active || (musb->a_wait_bcon == 0 &&
 				musb->xceiv->state == OTG_STATE_A_WAIT_BCON)) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 		del_timer(&glue->timer[pdev->id]);
 		glue->last_timer[pdev->id] = jiffies;
 		return;
@@ -289,7 +289,7 @@ static void dsps_musb_try_idle(struct musb *musb, unsigned long timeout)
 	glue->last_timer[pdev->id] = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, starting idle timer for %u ms\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 			jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&glue->timer[pdev->id], timeout);
 }
@@ -378,7 +378,7 @@ static irqreturn_t dsps_interrupt(int irq, void *hci)
 		/* NOTE: this must complete power-on within 100 ms. */
 		dev_dbg(musb->controller, "VBUS %s (%s)%s, devctl %02x\n",
 				drvvbus ? "on" : "off",
-				otg_state_string(musb->xceiv->state),
+				usb_otg_state_string(musb->xceiv->state),
 				err ? " ERROR" : "",
 				devctl);
 		ret = IRQ_HANDLED;
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
index 376536e..ccc5872 100644
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1519,7 +1519,7 @@ static int musb_gadget_wakeup(struct usb_gadget *gadget)
 		goto done;
 	default:
 		dev_dbg(musb->controller, "Unhandled wake: %s\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		goto done;
 	}
 
@@ -1918,7 +1918,7 @@ void musb_g_resume(struct musb *musb)
 		break;
 	default:
 		WARNING("unhandled RESUME transition (%s)\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 	}
 }
 
@@ -1948,7 +1948,7 @@ void musb_g_suspend(struct musb *musb)
 		 * A_PERIPHERAL may need care too
 		 */
 		WARNING("unhandled SUSPEND transition (%s)\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 	}
 }
 
@@ -1982,7 +1982,7 @@ void musb_g_disconnect(struct musb *musb)
 	switch (musb->xceiv->state) {
 	default:
 		dev_dbg(musb->controller, "Unhandled disconnect %s, setting a_idle\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		musb->xceiv->state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
 		break;
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
index 1ce1fcf..51e9e8a 100644
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2453,7 +2453,7 @@ static int musb_bus_suspend(struct usb_hcd *hcd)
 
 	if (musb->is_active) {
 		WARNING("trying to suspend as %s while active\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 		return -EBUSY;
 	} else
 		return 0;
diff --git a/drivers/usb/musb/musb_virthub.c b/drivers/usb/musb/musb_virthub.c
index f705791..ef7d110 100644
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -95,7 +95,7 @@ static void musb_port_suspend(struct musb *musb, bool do_suspend)
 			break;
 		default:
 			dev_dbg(musb->controller, "bogus rh suspend? %s\n",
-				otg_state_string(musb->xceiv->state));
+				usb_otg_state_string(musb->xceiv->state));
 		}
 	} else if (power & MUSB_POWER_SUSPENDM) {
 		power &= ~MUSB_POWER_SUSPENDM;
@@ -203,7 +203,7 @@ void musb_root_disconnect(struct musb *musb)
 		break;
 	default:
 		dev_dbg(musb->controller, "host disconnect (%s)\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 	}
 }
 
diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
index 1762354..9977fd8 100644
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -117,7 +117,7 @@ static void omap2430_musb_try_idle(struct musb *musb, unsigned long timeout)
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
 			&& (musb->xceiv->state == OTG_STATE_A_WAIT_BCON))) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
 		return;
@@ -134,7 +134,7 @@ static void omap2430_musb_try_idle(struct musb *musb, unsigned long timeout)
 	last_timer = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, for idle timer for %lu ms\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&musb_idle_timer, timeout);
 }
@@ -200,7 +200,7 @@ static void omap2430_musb_set_vbus(struct musb *musb, int is_on)
 
 	dev_dbg(musb->controller, "VBUS %s, devctl %02x "
 		/* otg %3x conf %08x prcm %08x */ "\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
 
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
index 464bd23..7369ba3 100644
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -423,7 +423,7 @@ static void musb_do_idle(unsigned long _musb)
 			&& (musb->idle_timeout == 0
 				|| time_after(jiffies, musb->idle_timeout))) {
 			dev_dbg(musb->controller, "Nothing connected %s, turning off VBUS\n",
-					otg_state_string(musb->xceiv->state));
+					usb_otg_state_string(musb->xceiv->state));
 		}
 		/* FALLTHROUGH */
 	case OTG_STATE_A_IDLE:
@@ -478,7 +478,7 @@ static void tusb_musb_try_idle(struct musb *musb, unsigned long timeout)
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
 			&& (musb->xceiv->state == OTG_STATE_A_WAIT_BCON))) {
 		dev_dbg(musb->controller, "%s active, deleting timer\n",
-			otg_state_string(musb->xceiv->state));
+			usb_otg_state_string(musb->xceiv->state));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
 		return;
@@ -495,7 +495,7 @@ static void tusb_musb_try_idle(struct musb *musb, unsigned long timeout)
 	last_timer = timeout;
 
 	dev_dbg(musb->controller, "%s inactive, for idle timer for %lu ms\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		(unsigned long)jiffies_to_msecs(timeout - jiffies));
 	mod_timer(&musb_idle_timer, timeout);
 }
@@ -571,7 +571,7 @@ static void tusb_musb_set_vbus(struct musb *musb, int is_on)
 	musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 	dev_dbg(musb->controller, "VBUS %s, devctl %02x otg %3x conf %08x prcm %08x\n",
-		otg_state_string(musb->xceiv->state),
+		usb_otg_state_string(musb->xceiv->state),
 		musb_readb(musb->mregs, MUSB_DEVCTL),
 		musb_readl(tbase, TUSB_DEV_OTG_STAT),
 		conf, prcm);
@@ -678,13 +678,13 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 				musb->is_active = 0;
 			}
 			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
-				otg_state_string(musb->xceiv->state), otg_stat);
+				usb_otg_state_string(musb->xceiv->state), otg_stat);
 			idle_timeout = jiffies + (1 * HZ);
 			schedule_work(&musb->irq_work);
 
 		} else /* A-dev state machine */ {
 			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
-				otg_state_string(musb->xceiv->state), otg_stat);
+				usb_otg_state_string(musb->xceiv->state), otg_stat);
 
 			switch (musb->xceiv->state) {
 			case OTG_STATE_A_IDLE:
@@ -733,7 +733,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 		u8	devctl;
 
 		dev_dbg(musb->controller, "%s timer, %03x\n",
-			otg_state_string(musb->xceiv->state), otg_stat);
+			usb_otg_state_string(musb->xceiv->state), otg_stat);
 
 		switch (musb->xceiv->state) {
 		case OTG_STATE_A_WAIT_VRISE:
diff --git a/drivers/usb/otg/fsl_otg.c b/drivers/usb/otg/fsl_otg.c
index 37e8e15..72a2a00 100644
--- a/drivers/usb/otg/fsl_otg.c
+++ b/drivers/usb/otg/fsl_otg.c
@@ -992,7 +992,7 @@ static int show_fsl_usb2_otg_state(struct device *dev,
 	/* State */
 	t = scnprintf(next, size,
 		      "OTG state: %s\n\n",
-		      otg_state_string(fsl_otg_dev->phy.state));
+		      usb_otg_state_string(fsl_otg_dev->phy.state));
 	size -= t;
 	next += t;
 
diff --git a/drivers/usb/otg/isp1301_omap.c b/drivers/usb/otg/isp1301_omap.c
index af9cb11..8fe0c3b 100644
--- a/drivers/usb/otg/isp1301_omap.c
+++ b/drivers/usb/otg/isp1301_omap.c
@@ -236,7 +236,7 @@ isp1301_clear_bits(struct isp1301 *isp, u8 reg, u8 bits)
 
 static inline const char *state_name(struct isp1301 *isp)
 {
-	return otg_state_string(isp->phy.state);
+	return usb_otg_state_string(isp->phy.state);
 }
 
 /*-------------------------------------------------------------------------*/
@@ -481,7 +481,7 @@ static void check_state(struct isp1301 *isp, const char *tag)
 	if (isp->phy.state == state && !extra)
 		return;
 	pr_debug("otg: %s FSM %s/%02x, %s, %06x\n", tag,
-		otg_state_string(state), fsm, state_name(isp),
+		usb_otg_state_string(state), fsm, state_name(isp),
 		omap_readl(OTG_CTRL));
 }
 
@@ -1077,7 +1077,7 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
 
 	if (state != isp->phy.state)
 		pr_debug("  isp, %s -> %s\n",
-				otg_state_string(state), state_name(isp));
+				usb_otg_state_string(state), state_name(isp));
 
 #ifdef	CONFIG_USB_OTG
 	/* update the OTG controller state to match the isp1301; may
diff --git a/drivers/usb/otg/otg.c b/drivers/usb/otg/otg.c
index 358cfd9..fd9a4b7 100644
--- a/drivers/usb/otg/otg.c
+++ b/drivers/usb/otg/otg.c
@@ -11,7 +11,7 @@
 #include <linux/export.h>
 #include <linux/usb/otg.h>
 
-const char *otg_state_string(enum usb_otg_state state)
+const char *usb_otg_state_string(enum usb_otg_state state)
 {
 	switch (state) {
 	case OTG_STATE_A_IDLE:
@@ -44,4 +44,4 @@ const char *otg_state_string(enum usb_otg_state state)
 		return "UNDEFINED";
 	}
 }
-EXPORT_SYMBOL(otg_state_string);
+EXPORT_SYMBOL(usb_otg_state_string);
diff --git a/drivers/usb/otg/otg_fsm.c b/drivers/usb/otg/otg_fsm.c
index ade131a..1f729a1 100644
--- a/drivers/usb/otg/otg_fsm.c
+++ b/drivers/usb/otg/otg_fsm.c
@@ -119,7 +119,7 @@ int otg_set_state(struct otg_fsm *fsm, enum usb_otg_state new_state)
 	state_changed = 1;
 	if (fsm->otg->phy->state == new_state)
 		return 0;
-	VDBG("Set state: %s\n", otg_state_string(new_state));
+	VDBG("Set state: %s\n", usb_otg_state_string(new_state));
 	otg_leave_state(fsm, fsm->otg->phy->state);
 	switch (new_state) {
 	case OTG_STATE_B_IDLE:
diff --git a/include/linux/usb/otg.h b/include/linux/usb/otg.h
index e8a5fe8..9f9fb39 100644
--- a/include/linux/usb/otg.h
+++ b/include/linux/usb/otg.h
@@ -37,9 +37,9 @@ struct usb_otg {
 };
 
 #ifdef CONFIG_USB_OTG_UTILS
-extern const char *otg_state_string(enum usb_otg_state state);
+extern const char *usb_otg_state_string(enum usb_otg_state state);
 #else
-static inline const char *otg_state_string(enum usb_otg_state state)
+static inline const char *usb_otg_state_string(enum usb_otg_state state)
 {
 	return NULL;
 }
-- 
1.8.1.rc1.5.g7e0651a

