From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 5/9] usb: dwc3: core: make dual-role work with OTG irq
Date: Wed, 8 Jul 2015 13:36:46 +0300
Message-ID: <1436351806-28600-1-git-send-email-rogerq@ti.com>
References: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436351524-28385-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If the ID pin event is not available over extcon
then we rely on the OTG controller to provide us ID and VBUS
information.

We still don't support any OTG features but just
dual-role operation.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c | 225 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/usb/dwc3/core.h |  14 +++
 2 files changed, 223 insertions(+), 16 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 7b33d7b..138847f 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -706,6 +706,63 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
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
+	if (id != dwc->fsm->id || vbus != dwc->fsm->vbus) {
+		dev_dbg(dwc->dev, "id %d vbus %d\n", id, vbus);
+		dwc->fsm->id = id;
+		dwc->fsm->vbus = vbus;
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
@@ -730,10 +787,35 @@ static int dwc3_drd_start_host(struct otg_fsm *fsm, int on)
 {
 	struct device *dev = usb_otg_fsm_to_dev(fsm);
 	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 reg;
 
 	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
-	if (on)
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+	if (dwc->edev) {
+		if (on)
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_HOST);
+
+		return 0;
+	}
+
+	/* switch OTG core */
+	if (on) {
+		/* OCTL.PeriMode = 0 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* unconditionally turn on VBUS */
+		reg |= DWC3_OCTL_PRTPWRCTL;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+	} else {
+		/* turn off VBUS */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~DWC3_OCTL_PRTPWRCTL;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* OCTL.PeriMode = 1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+	}
 
 	return 0;
 }
@@ -742,11 +824,42 @@ static int dwc3_drd_start_gadget(struct otg_fsm *fsm, int on)
 {
 	struct device *dev = usb_otg_fsm_to_dev(fsm);
 	struct dwc3 *dwc = dev_get_drvdata(dev);
+	u32 reg;
 
 	dev_dbg(dwc->dev, "%s: %d\n", __func__, on);
-	if (on) {
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+	if (on)
 		dwc3_event_buffers_setup(dwc);
+
+	if (dwc->edev) {
+		if (on)
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
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
+	} else {
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
 	}
 
 	return 0;
@@ -767,13 +880,35 @@ static int dwc3_drd_notifier(struct notifier_block *nb,
 	return NOTIFY_DONE;
 }
 
+static int dwc3_drd_register(struct dwc3 *dwc)
+{
+	int ret;
+
+	/* register parent as DRD device with OTG core */
+	dwc->fsm = usb_otg_register(dwc->dev, &dwc3_drd_ops, true);
+	if (IS_ERR(dwc->fsm)) {
+		ret = PTR_ERR(dwc->fsm);
+		if (ret == -ENOSYS)
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
+	u32 reg;
+	struct dwc3_hwparams *parms = &dwc->hwparams;
 
+	/* If extcon device is not present we rely on OTG core for ID event */
 	if (!dwc->edev) {
-		dev_err(dwc->dev, "No extcon device found for OTG mode\n");
-		return -ENODEV;
+		dev_dbg(dwc->dev, "No extcon device found for OTG mode\n");
+		goto try_otg_core;
 	}
 
 	dwc->otg_nb.notifier_call = dwc3_drd_notifier;
@@ -801,17 +936,9 @@ static int dwc3_drd_init(struct dwc3 *dwc)
 		goto fail;
 	}
 
-	/* register parent as DRD device with OTG core */
-	dwc->fsm = usb_otg_register(dwc->dev, &dwc3_drd_ops, true);
-	if (IS_ERR(dwc->fsm)) {
-		ret = PTR_ERR(dwc->fsm);
-		if (ret == -ENOSYS)
-			dev_err(dwc->dev, "CONFIG_USB_OTG needed for dual-role\n");
-		else
-			dev_err(dwc->dev, "Failed to register with OTG core\n");
-
+	ret = dwc3_drd_register(dwc);
+	if (ret)
 		goto fail;
-	}
 
 	dwc3_drd_fsm_sync(dwc);
 
@@ -822,6 +949,72 @@ extcon_fail:
 	extcon_unregister_notifier(dwc->edev, EXTCON_USB, &dwc->otg_nb);
 
 	return ret;
+
+try_otg_core:
+	/* get OTG capabilities */
+	dwc->otg_has_hnp_rsp = !!(parms->hwparams6 & DWC3_GHWPARAMS6_HNPSUPPORT);
+	dwc->otg_has_srp = !!(parms->hwparams6 & DWC3_GHWPARAMS6_SRPSUPPORT);
+	dwc->otg_has_adp = !!(parms->hwparams6 & DWC3_GHWPARAMS6_ADPSUPPORT);
+	dwc->otg_has_bc = !!(parms->hwparams6 & DWC3_GHWPARAMS6_BCSUPPORT);
+	dwc->otg_has_otg3 = !!(parms->hwparams6 & DWC3_GHWPARAMS6_OTG3SUPPORT);
+
+	dev_dbg(dwc->dev, "otg v%s - srp: %d, hnp/rsp:%d, adp:%d, bc:%d\n",
+		 dwc->otg_has_otg3 ? "3.0":"2.0",
+		 dwc->otg_has_srp, dwc->otg_has_hnp_rsp,
+		 dwc->otg_has_adp, dwc->otg_has_bc);
+
+	ret = dwc3_drd_register(dwc);
+	if (ret)
+		return ret;
+
+	/* disable all irqs */
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
+	/* clear all events */
+	dwc3_writel(dwc->regs, DWC3_OEVT, ~0);
+
+	ret = request_threaded_irq(dwc->otg_irq, dwc3_otg_irq, dwc3_otg_thread_irq,
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
index c3431b2..744a5ff 100644
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
@@ -805,6 +806,11 @@ struct dwc3_scratchpad_array {
  * 	1	- -3.5dB de-emphasis
  * 	2	- No de-emphasis
  * 	3	- Reserved
+ * @otg_has_srp: set if otg core supports SRP
+ * @otg_has_hnp_rsp: set if otg core supports HNP/RSP
+ * @otg_has_adp: set if otg core supports ADP
+ * @otg_has_bc: set if otg core supports BC
+ * @otg_has_otg3: set if otg core supports OTG v3.0
  */
 struct dwc3 {
 	struct usb_ctrlrequest	*ctrl_req;
@@ -857,6 +863,8 @@ struct dwc3 {
 	u32			dcfg;
 	u32			gctl;
 
+	u32			oevten;
+
 	u32			nr_scratch;
 	u32			num_event_buffers;
 	u32			u1u2;
@@ -939,6 +947,12 @@ struct dwc3 {
 
 	unsigned		tx_de_emphasis_quirk:1;
 	unsigned		tx_de_emphasis:2;
+
+	unsigned		otg_has_srp:1;
+	unsigned		otg_has_hnp_rsp:1;
+	unsigned		otg_has_adp:1;
+	unsigned		otg_has_bc:1;
+	unsigned		otg_has_otg3:1;
 };
 
 /* -------------------------------------------------------------------------- */
-- 
2.1.4
