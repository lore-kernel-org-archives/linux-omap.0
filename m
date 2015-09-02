From: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v4 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Wed, 2 Sep 2015 17:24:20 +0300
Message-ID: <1441203864-15786-6-git-send-email-rogerq@ti.com>
References: <1441203864-15786-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1441203864-15786-1-git-send-email-rogerq-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, Joao.Pinto-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, peter.chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org, jun.li-KZfg59tc24xl57MIdRCFDg@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

If the ID pin event is not available over extcon
then we rely on the OTG controller to provide us ID and VBUS
information.

We still don't support any OTG features but just
dual-role operation.

Signed-off-by: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
---
 drivers/usb/dwc3/core.c | 217 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/usb/dwc3/core.h |   3 +
 2 files changed, 205 insertions(+), 15 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 38b31df..632ee53 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -704,6 +704,63 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+/* Get OTG events and sync it to OTG fsm */
+static void dwc3_otg_fsm_sync(struct dwc3 *dwc)
+{
+	u32 reg;
+	int id, vbus;
+
+	reg = dwc3_readl(dwc->regs, DWC3_OSTS);
+	dev_dbg(dwc->dev, "otgstatus 0x%x\n", reg);
+
+	id = !!(reg & DWC3_OSTS_CONIDSTS);
+	vbus = !!(reg & DWC3_OSTS_BSESVLD);
+
+	if (id != dwc->fsm->id || vbus != dwc->fsm->b_sess_vld) {
+		dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
+		dwc->fsm->id = id;
+		dwc->fsm->b_sess_vld = vbus;
+		usb_otg_sync_inputs(dwc->fsm);
+	}
+}
+
+static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+	unsigned long flags;
+	irqreturn_t ret = IRQ_NONE;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_otg_fsm_sync(dwc);
+	/* unmask interrupts */
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return ret;
+}
+
+static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+	irqreturn_t ret = IRQ_NONE;
+	u32 reg;
+
+	spin_lock(&dwc->lock);
+
+	reg = dwc3_readl(dwc->regs, DWC3_OEVT);
+	if (reg) {
+		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
+		/* mask interrupts till processed */
+		dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+		dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	spin_unlock(&dwc->lock);
+
+	return ret;
+}
+
 /* --------------------- Dual-Role management ------------------------------- */
 
 static void dwc3_drd_fsm_sync(struct dwc3 *dwc)
@@ -728,15 +785,44 @@ static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
 {
 	struct device *dev = usb_otg_fsm_to_dev(fsm);
 	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 reg;
 
 	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
+	if (dwc->edev) {
+		if (on) {
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+			/* start the HCD */
+			usb_otg_start_host(fsm, true);
+		} else {
+			/* stop the HCD */
+			usb_otg_start_host(fsm, false);
+		}
+
+		return 0;
+	}
+
+	/* switch OTG core */
 	if (on) {
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+		/* OCTL.PeriMode = 0 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* unconditionally turn on VBUS */
+		reg |= DWC3_OCTL_PRTPWRCTL;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
 		/* start the HCD */
 		usb_otg_start_host(fsm, true);
 	} else {
 		/* stop the HCD */
 		usb_otg_start_host(fsm, false);
+		/* turn off VBUS */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~DWC3_OCTL_PRTPWRCTL;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* OCTL.PeriMode = 1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
 	}
 
 	return 0;
@@ -746,15 +832,48 @@ static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
 {
 	struct device *dev = usb_otg_fsm_to_dev(fsm);
 	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 reg;
 
 	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
-	if (on) {
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	if (on)
 		dwc3_event_buffers_setup(dwc);
 
+	if (dwc->edev) {
+		if (on) {
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+			usb_otg_start_gadget(fsm, true);
+		} else {
+			usb_otg_start_gadget(fsm, false);
+		}
+
+		return 0;
+	}
+
+	/* switch OTG core */
+	if (on) {
+		/* OCTL.PeriMode = 1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* GUSB2PHYCFG0.SusPHY = 1 */
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
 		/* start the UDC */
 		usb_otg_start_gadget(fsm, true);
 	} else {
+		/* GUSB2PHYCFG0.SusPHY=0 */
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
+		/* OCTL.PeriMode = 1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
 		/* stop the UDC */
 		usb_otg_start_gadget(fsm, false);
 	}
@@ -777,10 +896,30 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int dwc3_drd_register(struct dwc3 *dwc)
+{
+	int ret;
+
+	/* register parent as DRD device with OTG core */
+	dwc->fsm = usb_otg_register(dwc->dev, &dwc->otg_config);
+	if (IS_ERR(dwc->fsm)) {
+		ret = PTR_ERR(dwc->fsm);
+		if (ret == -ENOTSUPP)
+			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
+		else
+			dev_err(dwc->dev, "Failed to register with OTG core\n");
+
+		return ret;
+	}
+
+	return 0;
+}
+
 static int dwc3_drd_init(struct dwc3 *dwc)
 {
 	int ret, id, vbus;
 	struct usb_otg_caps *otgcaps = &dwc->otg_config.otg_caps;
+	u32 reg;
 
 	otgcaps->otg_rev = 0;
 	otgcaps->hnp_support = false;
@@ -788,9 +927,10 @@ static int dwc3_drd_init(struct dwc3 *dwc)
 	otgcaps->adp_support = false;
 	dwc->otg_config.fsm_ops = &dwc3_drd_ops;
 
+	/* If extcon device is not present we rely on OTG core for ID event */
 	if (!dwc->edev) {
-		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
-		return -ENODEV;
+		dev_dbg(dwc->dev, "No extcon device found for OTG mode\n");
+		goto try_otg_core;
 	}
 
 	dwc->otg_nb.notifier_call = dwc3_drd_notifier;
@@ -818,17 +958,9 @@ static int dwc3_drd_init(struct dwc3 *dwc)
 		goto fail;
 	}
 
-	/* register as DRD device with OTG core */
-	dwc->fsm = usb_otg_register(dwc->dev, &dwc->otg_config);
-	if (IS_ERR(dwc->fsm)) {
-		ret = PTR_ERR(dwc->fsm);
-		if (ret == -ENOTSUPP)
-			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
-		else
-			dev_err(dwc->dev, "Failed to register with OTG core\n");
-
+	ret = dwc3_drd_register(dwc);
+	if (ret)
 		goto fail;
-	}
 
 	dwc3_drd_fsm_sync(dwc);
 
@@ -839,6 +971,61 @@ extcon_fail:
 	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
 
 	return ret;
+
+try_otg_core:
+	ret = dwc3_drd_register(dwc);
+	if (ret)
+		return ret;
+
+	/* disable all irqs */
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
+	/* clear all events */
+	dwc3_writel(dwc->regs, DWC3_OEVT, ~0);
+
+	ret = request_threaded_irq(dwc->otg_irq, dwc3_otg_irq,
+				   dwc3_otg_thread_irq,
+				   IRQF_SHARED, "dwc3-otg", dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+			dwc->otg_irq, ret);
+		ret = -ENODEV;
+		goto error;
+	}
+
+	/* we need to set OTG to get events from OTG core */
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+	/* GUSB2PHYCFG0.SusPHY=0 */
+	if (!dwc->dis_u2_susphy_quirk) {
+		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+	}
+
+	/* Initialize OTG registers */
+	/*
+	 * Prevent host/device reset from resetting OTG core.
+	 * If we don't do this then xhci_reset (USBCMD.HCRST) will reset
+	 * the signal outputs sent to the PHY, the OTG FSM logic of the
+	 * core and also the resets to the VBUS filters inside the core.
+	 */
+	reg = DWC3_OCFG_SFTRSTMASK;
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+	/* Enable ID event interrupt */
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, DWC3_OEVTEN_CONIDSTSCHNGEN |
+			DWC3_OEVTEN_BDEVVBUSCHNGE |
+			DWC3_OEVTEN_BDEVSESSVLDDETEN);
+	/* OCTL.PeriMode = 1 */
+	dwc3_writel(dwc->regs, DWC3_OCTL, DWC3_OCTL_PERIMODE);
+
+	dwc3_otg_fsm_sync(dwc);
+	usb_otg_sync_inputs(dwc->fsm);
+
+	return 0;
+
+error:
+	usb_otg_unregister(dwc->dev);
+
+	return ret;
 }
 
 static void dwc3_drd_exit(struct dwc3 *dwc)
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index bd32cb2..129ef37 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -736,6 +736,7 @@ struct dwc3_scratchpad_array {
  * @gadget_driver: pointer to the gadget driver
  * @regs: base address for our registers
  * @regs_size: address space size
+ * @oevten: otg interrupt enable mask copy
  * @nr_scratch: number of scratch buffers
  * @num_event_buffers: calculated number of event buffers
  * @u1u2: only used on revisions <1.83a for workaround
@@ -858,6 +859,8 @@ struct dwc3 {
 	u32			dcfg;
 	u32			gctl;
 
+	u32			oevten;
+
 	u32			nr_scratch;
 	u32			num_event_buffers;
 	u32			u1u2;
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
