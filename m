From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 0/2] musb-fixes for v4.9-rc2
Date: Thu, 3 Nov 2016 15:55:32 -0700
Message-ID: <20161103225532.GD21430@atomide.com>
References: <1476896620-15432-1-git-send-email-b-liu@ti.com>
 <20161020082318.GA2903@localhost.localdomain>
 <20161020123524.oepmqvlhzzu7elgj@atomide.com>
 <20161020193612.GA29736@localhost.localdomain>
 <20161021071722.2cetd2mt23t245ao@atomide.com>
 <20161024180708.kpx6s2jb7dpg6xfx@atomide.com>
 <20161101211358.GA2597@localhost.localdomain>
 <20161103205902.GB21430@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161103205902.GB21430-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>
Cc: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> [161103 13:59]:
> * Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org> [161101 14:14]:
> > > cacaaf80c3a6 ("usb: musb: Call pm_runtime from musb_gadget_queue")
> > > d8e5f0eca1e8 ("usb: musb: Fix hardirq-safe hardirq-unsafe lock order error")
> > 
> > tested with v4.9-rc3 which have these included.
> 
> OK thanks.

So here's something to test, v4.9-rc3 + the PHY patch I
posted + the patch below.

> Hmm yeah playing with a hub connected devices don't always enumerate.
> When that happens, I get this:
> 
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: reset high-speed USB device number 45 using musb-hdrc
> usb 1-1: USB disconnect, device number 45
> usb 1-1: new high-speed USB device number 47 using musb-hdrc
> usb 1-1: new high-speed USB device number 48 using musb-hdrc
> ...
> 
> And that keeps on going until I reconnect the hub.

The patch below seems to work with PM for me, except I
the dsps glue layer won't go to idle after disconnecting
the hub. On 2430 glue layer things idle for me properly
and I don't seem to get any more vbus errors.

Regards,

Tony

8< ------------------
diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -987,7 +987,7 @@ static irqreturn_t musb_stage0_irq(struct musb *musb, u8 int_usb,
 	}
 #endif
 
-	schedule_work(&musb->irq_work);
+	schedule_delayed_work(&musb->irq_work, 0);
 
 	return handled;
 }
@@ -1864,12 +1864,8 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 		}
 		break;
 	case MUSB_QUIRK_A_DISCONNECT_19:
-		if (!musb->session)
-			break;
-		musb_dbg(musb, "Allow PM on possible host mode disconnect");
-		pm_runtime_mark_last_busy(musb->controller);
-		pm_runtime_put_autosuspend(musb->controller);
-		musb->session = false;
+		musb_dbg(musb, "Poll devctl on possible host mode disconnect");
+		schedule_delayed_work(&musb->irq_work, msecs_to_jiffies(1000));
 		return;
 	default:
 		break;
@@ -1900,7 +1896,7 @@ static void musb_pm_runtime_check_session(struct musb *musb)
 /* Only used to provide driver mode change events */
 static void musb_irq_work(struct work_struct *data)
 {
-	struct musb *musb = container_of(data, struct musb, irq_work);
+	struct musb *musb = container_of(data, struct musb, irq_work.work);
 
 	musb_pm_runtime_check_session(musb);
 
@@ -2274,7 +2270,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_generic_disable(musb);
 
 	/* Init IRQ workqueue before request_irq */
-	INIT_WORK(&musb->irq_work, musb_irq_work);
+	INIT_DELAYED_WORK(&musb->irq_work, musb_irq_work);
 	INIT_DELAYED_WORK(&musb->deassert_reset_work, musb_deassert_reset);
 	INIT_DELAYED_WORK(&musb->finish_resume_work, musb_pending_work);
 
@@ -2370,7 +2366,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
 	musb_host_cleanup(musb);
 
 fail3:
-	cancel_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->irq_work);
 	musb_cancel_resume_work(musb);
 	cancel_delayed_work_sync(&musb->deassert_reset_work);
 	if (musb->dma_controller)
@@ -2437,7 +2433,7 @@ static int musb_remove(struct platform_device *pdev)
 	 */
 	musb_exit_debugfs(musb);
 
-	cancel_work_sync(&musb->irq_work);
+	cancel_delayed_work_sync(&musb->irq_work);
 	musb_cancel_resume_work(musb);
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
 	u16			hwvers;
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
 
@@ -1982,7 +1982,7 @@ static int musb_gadget_stop(struct usb_gadget *g)
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
