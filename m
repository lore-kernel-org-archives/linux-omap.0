From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 3/6] usb: musb: Fix PM for hub disconnect
Date: Fri, 11 Nov 2016 10:42:59 -0800
Message-ID: <20161111184302.2438-4-tony@atomide.com>
References: <20161111184302.2438-1-tony@atomide.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161111184302.2438-1-tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Cc: Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

With a USB hub disconnected, devctl can be 0x19 for about a second
on am335x and will stay forever on at least omap3. And we get no
further interrupts when devctl session bit clears. This keeps
PM runtime active.

Let's fix the issue by polling devctl until the session bit clears
or times out. We can do this by making musb->irq_work into
delayed_work.

And with the polling implemented, we can now also have the quirk
for invalid VBUS it to avoid disconnecting too early while VBUS
is ramping up.

Fixes: 467d5c980709 ("usb: musb: Implement session bit based runtime
PM for musb-core")
Fixes: 65b3f50ed6fa ("usb: musb: Add PM runtime support for MUSB DSPS
Tested-by: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Tested-by: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 drivers/usb/musb/musb_core.c   | 29 +++++++++++++++++++----------
 drivers/usb/musb/musb_core.h   |  4 ++--
 drivers/usb/musb/musb_gadget.c |  6 +++---
 drivers/usb/musb/tusb6010.c    |  6 +++---
 4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -986,7 +986,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 	}
 #endif
 
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 	return handled;
 }
@@ -1855,14 +1855,23 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 		MUSB_DEVCTL_HR;
 	switch (devctl & ~s) {
 	case MUSB_QUIRK_B_INVALID_VBUS_91:
-		if (!musb->session && !musb->quirk_invalid_vbus) {
-			musb->quirk_invalid_vbus = true;
+		if (musb->quirk_retries--) {
 			musb_dbg(musb,
-				 "First invalid vbus, assume no session");
+				 "Poll devctl on invalid vbus, assume no session");
+			schedule_delayed_work(&musb->irq_work,
+					      msecs_to_jiffies(1000));
+
 			return;
 		}
-		break;
 	case MUSB_QUIRK_A_DISCONNECT_19:
+		if (musb->quirk_retries--) {
+			musb_dbg(musb,
+				 "Poll devctl on possible host mode disconnect");
+			schedule_delayed_work(&musb->irq_work,
+					      msecs_to_jiffies(1000));
+
+			return;
+		}
 		if (!musb->session)
 			break;
 		musb_dbg(musb, "Allow PM on possible host mode disconnect");
@@ -1886,9 +1895,9 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 		if (error < 0)
 			dev_err(musb->controller, "Could not enable: %i\n",
 				error);
+		musb->quirk_retries = 3;
 	} else {
 		musb_dbg(musb, "Allow PM with no session: %02x", devctl);
-		musb->quirk_invalid_vbus = false;
 		pm_runtime_mark_last_busy(musb->controller);
 		pm_runtime_put_autosuspend(musb->controller);
 	}
@@ -1899,7 +1908,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 /* Only used to provide driver mode change events */
 static void musb_irq_work(struct work_struct *data)
 {
-	struct musb *musb = container_of(data, struct musb, irq_work);
+	struct musb *musb = container_of(data, struct musb, irq_work.work);
 
 	musb_pm_runtime_check_session(musb);
 
@@ -2288,7 +2297,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_generic_disable(musb);
 
 	/* Init IRQ workqueue before request_irq */
-	INIT_WORK(&musb->irq_work, musb_irq_work);
+	INIT_DELAYED_WORK(&musb->irq_work, musb_irq_work);
 	INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);
 	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_host_finish_resume);
 
@@ -2385,7 +2394,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_host_cleanup(musb);
 
 fail3:
-	cancel_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->irq_work);
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	if (musb->dma_controller)
@@ -2452,7 +2461,7 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 
-	cancel_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->irq_work);
 	cancel_delayed_work_sync(&musb->finish_resume_work);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	pm_runtime_get_sync(musb->controller);
diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -310,7 +310,7 @@ struct musb {
 	struct musb_context_registers context;
 
 	irqreturn_t		(*isr)(int, void *);
-	struct work_struct	irq_work;
+	struct delayed_work	irq_work;
 	struct delayed_work	deassert_reset_work;
 	struct delayed_work	finish_resume_work;
 	struct delayed_work	gadget_work;
@@ -381,7 +381,7 @@ struct musb {
 
 	int			port_mode;	/* MUSB_PORT_MODE_* */
 	bool			session;
-	bool			quirk_invalid_vbus;
+	unsigned long		quirk_retries;
 	bool			is_host;
 
 	int			a_wait_bcon;	/* VBUS timeout in msecs */
diff --git a/drivers/usb/musb/musb_gadget.c b/drivers/usb/musb/musb_gadget.c
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1114,7 +1114,7 @@ static int musb_gadget_enable(struct usb_ep *ep,
 			musb_ep->dma ? "dma, " : "",
 			musb_ep->packet_sz);
 
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 fail:
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -1158,7 +1158,7 @@ static int musb_gadget_disable(struct usb_ep *ep)
 	musb_ep->desc = NULL;
 	musb_ep->end_point.desc = NULL;
 
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 	spin_unlock_irqrestore(&(musb->lock), flags);
 
@@ -1994,7 +1994,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
 	 */
 
 	/* Force check of devctl register for PM runtime */
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 	pm_runtime_mark_last_busy(musb->controller);
 	pm_runtime_put_autosuspend(musb->controller);
diff --git a/drivers/usb/musb/tusb6010.c b/drivers/usb/musb/tusb6010.c
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -724,7 +724,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
 				usb_otg_state_string(musb->xceiv->otg->state), otg_stat);
 			idle_timeout = jiffies + (1 * HZ);
-			schedule_work(&musb->irq_work);
+			schedule_delayed_work(&musb->irq_work, 0);
 
 		} else /* A-dev state machine */ {
 			dev_dbg(musb->controller, "vbus change, %s, otg %03x\n",
@@ -814,7 +814,7 @@ tusb_otg_ints(struct musb *musb, u32 int_src, void __iomem *tbase)
 			break;
 		}
 	}
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 	return idle_timeout;
 }
@@ -864,7 +864,7 @@ static irqreturn_t tusb_musb_interrupt(int irq, void *__hci)
 		musb_writel(tbase, TUSB_PRCM_WAKEUP_CLEAR, reg);
 		if (reg & ~TUSB_PRCM_WNORCS) {
 			musb->is_active = 1;
-			schedule_work(&musb->irq_work);
+			schedule_delayed_work(&musb->irq_work, 0);
 		}
 		dev_dbg(musb->controller, "wake %sactive %02x\n",
 				musb->is_active ? "" : "in", reg);
-- 
2.10.2
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
