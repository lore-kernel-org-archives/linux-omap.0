From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v7 2/4] usb: dwc3: add dual-role support
Date: Fri, 10 Jun 2016 16:17:28 +0300
Message-ID: <1465564650-27516-3-git-send-email-rogerq@ti.com>
References: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465564650-27516-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org
Cc: tony@atomide.com, Joao.Pinto@synopsys.com, sergei.shtylyov@cogentembedded.com, peter.chen@freescale.com, jun.li@freescale.com, grygorii.strashko@ti.com, yoshihiro.shimoda.uh@renesas.com, nsekhar@ti.com, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

Register with the USB OTG/DRD core. Since we don't support
OTG yet we just work as a dual-role device even
if device tree says "otg".

Get ID and VBUS information from the OTG controller
and kick the OTG state machine.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c   | 546 +++++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h   |  30 ++-
 drivers/usb/dwc3/gadget.c |   6 +-
 drivers/usb/dwc3/host.c   |   2 +
 4 files changed, 574 insertions(+), 10 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index d51c9a9..28d2da2 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -56,6 +56,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
+	dwc->current_mode = mode;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
@@ -756,6 +757,448 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+/* Get OTG events and sync it to OTG fsm */
+static void dwc3_otg_fsm_sync(struct dwc3 *dwc)
+{
+	u32 reg;
+	int id, vbus;
+
+	/*
+	 * calling usb_otg_sync_inputs() during resume breaks host
+	 * if adapter was removed during suspend as xhci driver
+	 * is not prepared to see hcd removal before xhci_resume.
+	 */
+	if (dwc->otg_prevent_sync)
+		return;
+
+	reg = dwc3_readl(dwc->regs, DWC3_OSTS);
+	dwc3_trace(trace_dwc3_core, "otgstatus 0x%x\n", reg);
+
+	id = !!(reg & DWC3_OSTS_CONIDSTS);
+	vbus = !!(reg & DWC3_OSTS_BSESVLD);
+
+	dwc3_trace(trace_dwc3_core, "id %d vbus %d\n", id, vbus);
+	dwc->otg->fsm.id = id;
+	dwc->otg->fsm.b_sess_vld = vbus;
+	usb_otg_sync_inputs(dwc->otg);
+}
+
+static void dwc3_otg_mask_irq(struct dwc3 *dwc)
+{
+	dwc->oevten = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, 0);
+}
+
+static void dwc3_otg_unmask_irq(struct dwc3 *dwc)
+{
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+}
+
+static void dwc3_otg_disable_events(struct dwc3 *dwc, u32 disable_mask)
+{
+	dwc->oevten &= ~(disable_mask);
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+}
+
+static void dwc3_otg_enable_events(struct dwc3 *dwc, u32 enable_mask)
+{
+	dwc->oevten |= (enable_mask);
+	dwc3_writel(dwc->regs, DWC3_OEVTEN, dwc->oevten);
+}
+
+#define DWC3_OTG_ALL_EVENTS	(DWC3_OEVTEN_XHCIRUNSTPSETEN | \
+		DWC3_OEVTEN_DEVRUNSTPSETEN | DWC3_OEVTEN_HIBENTRYEN | \
+		DWC3_OEVTEN_CONIDSTSCHNGEN | DWC3_OEVTEN_HRRCONFNOTIFEN | \
+		DWC3_OEVTEN_HRRINITNOTIFEN | DWC3_OEVTEN_ADEVIDLEEN | \
+		DWC3_OEVTEN_ADEVBHOSTENDEN | DWC3_OEVTEN_ADEVHOSTEN | \
+		DWC3_OEVTEN_ADEVHNPCHNGEN | DWC3_OEVTEN_ADEVSRPDETEN | \
+		DWC3_OEVTEN_ADEVSESSENDDETEN | DWC3_OEVTEN_BDEVHOSTENDEN | \
+		DWC3_OEVTEN_BDEVHNPCHNGEN | DWC3_OEVTEN_BDEVSESSVLDDETEN | \
+		DWC3_OEVTEN_BDEVVBUSCHNGE)
+
+static int dwc3_drd_start_host(struct usb_otg *otg, int on);
+static int dwc3_drd_start_gadget(struct usb_otg *otg, int on);
+static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	/*
+	 * this bit is needed for otg-host to work after system suspend/resume
+	 */
+	if ((dwc->otg->state == OTG_STATE_A_HOST) &&
+	    !(dwc->oevt & DWC3_OEVT_DEVICEMODE)) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		dwc3_drd_start_host(dwc->otg, true);
+		spin_lock_irqsave(&dwc->lock, flags);
+	}
+
+	dwc3_otg_fsm_sync(dwc);
+	dwc3_otg_unmask_irq(dwc);
+
+	dwc->oevt = 0;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t dwc3_otg_irq(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+	irqreturn_t ret = IRQ_NONE;
+	u32 reg;
+
+	reg = dwc3_readl(dwc->regs, DWC3_OEVT);
+	if (reg) {
+		dwc->oevt = reg;
+		dwc3_writel(dwc->regs, DWC3_OEVT, reg);
+		dwc3_otg_mask_irq(dwc);
+		ret = IRQ_WAKE_THREAD;
+	}
+
+	return ret;
+}
+
+/* --------------------- Dual-Role management ------------------------------- */
+static void dwc3_otgregs_init(struct dwc3 *dwc)
+{
+	u32 reg;
+
+	/*
+	 * Prevent host/device reset from resetting OTG core.
+	 * If we don't do this then xhci_reset (USBCMD.HCRST) will reset
+	 * the signal outputs sent to the PHY, the OTG FSM logic of the
+	 * core and also the resets to the VBUS filters inside the core.
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	reg |= DWC3_OCFG_SFTRSTMASK;
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+
+	/* Disable hibernation for simplicity */
+	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+	reg &= ~DWC3_GCTL_GBLHIBERNATIONEN;
+	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+	/*
+	 * Initialize OTG registers as per
+	 * Figure 11-4 OTG Driver Overall Programming Flow
+	 */
+	/* OCFG.SRPCap = 0, OCFG.HNPCap = 0 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+	reg &= ~(DWC3_OCFG_SRPCAP | DWC3_OCFG_HNPCAP);
+	dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+	/* OEVT = FFFF */
+	dwc3_writel(dwc->regs, DWC3_OEVT, ~0);
+	/* OEVTEN = 0 */
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/* OEVTEN.ConIDStsChngEn = 1. Instead we enable all events */
+	dwc3_otg_enable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/*
+	 * OCTL.PeriMode = 1, OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0,
+	 * OCTL.HNPReq = 0
+	 */
+	reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+	reg |= DWC3_OCTL_PERIMODE;
+	reg &= ~(DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN |
+		 DWC3_OCTL_HNPREQ);
+	dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+}
+
+static int dwc3_drd_start_host(struct usb_otg *otg, int on)
+{
+	struct dwc3 *dwc = dev_get_drvdata(otg->dev);
+	u32 reg;
+	unsigned long flags;
+
+	dwc3_trace(trace_dwc3_core, "%s: %d\n", __func__, on);
+
+	/* switch OTG core */
+	if (on) {
+		/* As per Figure 11-10 A-Device Flow Diagram */
+
+		spin_lock_irqsave(&dwc->lock, flags);
+		/* OCFG.HNPCap = 0, OCFG.SRPCap = 0 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+		reg &= ~(DWC3_OCFG_SRPCAP | DWC3_OCFG_HNPCAP);
+		dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+
+		/*
+		 * OCTL.PeriMode=0, OCTL.TermSelDLPulse = 0,
+		 * OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~(DWC3_OCTL_PERIMODE | DWC3_OCTL_TERMSELIDPULSE |
+			 DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN);
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+
+		/*
+		 * OCFG.DisPrtPwrCutoff = 0/1
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+		reg &= ~DWC3_OCFG_DISPWRCUTTOFF;
+		dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+
+		/* start the xHCI host driver */
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		usb_otg_start_host(otg, true);
+		spin_lock_irqsave(&dwc->lock, flags);
+
+		/*
+		 * OCFG.SRPCap = 1, OCFG.HNPCap = GHWPARAMS6.HNP_CAP
+		 * We don't want SRP/HNP for simple dual-role so leave
+		 * these disabled.
+		 */
+
+		/*
+		 * OEVTEN.OTGADevHostEvntEn = 1
+		 * OEVTEN.OTGADevSessEndDetEvntEn = 1
+		 * We don't want HNP/role-swap so leave these disabled.
+		 */
+
+		/* GUSB2PHYCFG.ULPIAutoRes = 1/0, GUSB2PHYCFG.SusPHY = 1 */
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
+
+		/* Set Port Power to enable VBUS: OCTL.PrtPwrCtl = 1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PRTPWRCTL;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+	} else {
+		/*
+		 * Exit from A-device flow as per
+		 * Figure 11-4 OTG Driver Overall Programming Flow
+		 */
+		/* stop the HCD */
+		usb_otg_start_host(otg, false);
+
+		spin_lock_irqsave(&dwc->lock, flags);
+		/*
+		 * OEVTEN.OTGADevBHostEndEvntEn=0, OEVTEN.OTGADevHNPChngEvntEn=0
+		 * OEVTEN.OTGADevSessEndDetEvntEn=0,
+		 * OEVTEN.OTGADevHostEvntEn = 0
+		 * But we don't disable any OTG events
+		 */
+
+		/* OCTL.HstSetHNPEn = 0, OCTL.PrtPwrCtl=0 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~(DWC3_OCTL_HSTSETHNPEN | DWC3_OCTL_PRTPWRCTL);
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+
+		/* Initialize OTG registers */
+		dwc3_otgregs_init(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+	}
+
+	return 0;
+}
+
+static int dwc3_drd_start_gadget(struct usb_otg *otg, int on)
+{
+	struct dwc3 *dwc = dev_get_drvdata(otg->dev);
+	u32 reg;
+	unsigned long flags;
+
+	dwc3_trace(trace_dwc3_core, "%s: %d\n", __func__, on);
+	if (on)
+		dwc3_event_buffers_setup(dwc);
+
+	if (on) {
+		/* As per Figure 11-20 B-Device Flow Diagram */
+
+		spin_lock_irqsave(&dwc->lock, flags);
+		/*
+		 * OCFG.HNPCap = GHWPARAMS6.HNP_CAP, OCFG.SRPCap = 1
+		 * but we set them to 0 for simple dual-role operation.
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCFG);
+		reg &= ~(DWC3_OCFG_SRPCAP | DWC3_OCFG_HNPCAP);
+		/* OCFG.OTGSftRstMsk = 0/1 */
+		reg |= DWC3_OCFG_SFTRSTMASK;
+		dwc3_writel(dwc->regs, DWC3_OCFG, reg);
+		/*
+		 * OCTL.PeriMode = 1
+		 * OCTL.TermSelDLPulse = 0/1, OCTL.HNPReq = 0
+		 * OCTL.DevSetHNPEn = 0, OCTL.HstSetHNPEn = 0
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg |= DWC3_OCTL_PERIMODE;
+		reg &= ~(DWC3_OCTL_TERMSELIDPULSE | DWC3_OCTL_HNPREQ |
+			 DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HSTSETHNPEN);
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+		/* OEVTEN.OTGBDevSesVldDetEvntEn = 1 */
+		dwc3_otg_enable_events(dwc, DWC3_OEVT_BDEVSESSVLDDET);
+		/* GUSB2PHYCFG.ULPIAutoRes = 0, GUSB2PHYCFG0.SusPHY = 1 */
+		if (!dwc->dis_u2_susphy_quirk) {
+			reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+			reg |= DWC3_GUSB2PHYCFG_SUSPHY;
+			dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+		}
+		/* GCTL.GblHibernationEn = 0 */
+		reg = dwc3_readl(dwc->regs, DWC3_GCTL);
+		reg &= ~DWC3_GCTL_GBLHIBERNATIONEN;
+		dwc3_writel(dwc->regs, DWC3_GCTL, reg);
+
+		spin_unlock_irqrestore(&dwc->lock, flags);
+
+		/* start the Peripheral driver  */
+		usb_otg_start_gadget(otg, true);
+	} else {
+		/*
+		 * Exit from B-device flow as per
+		 * Figure 11-4 OTG Driver Overall Programming Flow
+		 */
+		/* stop the Peripheral driver */
+		usb_otg_start_gadget(otg, false);
+
+		spin_lock_irqsave(&dwc->lock, flags);
+
+		/*
+		 * OEVTEN.OTGBDevHNPChngEvntEn = 0
+		 * OEVTEN.OTGBDevVBusChngEvntEn = 0
+		 * OEVTEN.OTGBDevBHostEndEvntEn = 0
+		 */
+		reg = dwc3_readl(dwc->regs, DWC3_OEVTEN);
+		reg &= ~(DWC3_OEVT_BDEVHNPCHNG | DWC3_OEVT_BDEVVBUSCHNG |
+			 DWC3_OEVT_BDEVBHOSTEND);
+		dwc3_writel(dwc->regs, DWC3_OEVTEN, reg);
+
+		/* OCTL.DevSetHNPEn = 0, OCTL.HNPReq = 0, OCTL.PeriMode=1 */
+		reg = dwc3_readl(dwc->regs, DWC3_OCTL);
+		reg &= ~(DWC3_OCTL_DEVSETHNPEN | DWC3_OCTL_HNPREQ);
+		reg |= DWC3_OCTL_PERIMODE;
+		dwc3_writel(dwc->regs, DWC3_OCTL, reg);
+
+		/* Initialize OTG registers */
+		dwc3_otgregs_init(dwc);
+		spin_unlock_irqrestore(&dwc->lock, flags);
+	}
+
+	return 0;
+}
+
+static struct otg_fsm_ops dwc3_drd_ops = {
+	.start_host = dwc3_drd_start_host,
+	.start_gadget = dwc3_drd_start_gadget,
+};
+
+static int dwc3_drd_register(struct dwc3 *dwc)
+{
+	int ret;
+
+	/* register parent as DRD device with OTG core */
+	dwc->otg = usb_otg_register(dwc->dev, &dwc->otg_config);
+	if (IS_ERR(dwc->otg)) {
+		ret = PTR_ERR(dwc->otg);
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
+static int dwc3_drd_init(struct dwc3 *dwc)
+{
+	int ret, irq;
+	struct usb_otg_caps *otgcaps = &dwc->otg_caps;
+	u32 reg;
+	unsigned long flags;
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+
+	irq = platform_get_irq_byname(dwc3_pdev, "otg");
+	if (irq == -EPROBE_DEFER)
+		return irq;
+
+	if (irq <= 0) {
+		irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+		if (irq == -EPROBE_DEFER)
+			return irq;
+
+		if (irq <= 0) {
+			irq = platform_get_irq(dwc3_pdev, 0);
+			if (irq <= 0) {
+				if (irq != -EPROBE_DEFER)
+					dev_err(dwc->dev, "missing otg IRQ\n");
+
+				if (!irq)
+					irq = -EINVAL;
+				return irq;
+			}
+		}
+	}
+
+	dwc->otg_irq = irq;
+
+	otgcaps->otg_rev = 0;
+	otgcaps->hnp_support = false;
+	otgcaps->srp_support = false;
+	otgcaps->adp_support = false;
+	dwc->otg_config.fsm_ops = &dwc3_drd_ops;
+	dwc->otg_config.otg_caps = otgcaps;
+
+	ret = dwc3_drd_register(dwc);
+	if (ret)
+		return ret;
+
+	/* disable all otg irqs */
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
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
+	spin_lock_irqsave(&dwc->lock, flags);
+
+	/*
+	 * As per Figure 11-4 OTG Driver Overall Programming Flow,
+	 * block "Initialize GCTL for OTG operation".
+	 */
+	/* GCTL.PrtCapDir=2'b11 */
+	dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+	/* GUSB2PHYCFG0.SusPHY=0 */
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
+	dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
+
+	/* Initialize OTG registers */
+	dwc3_otgregs_init(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	dwc3_otg_fsm_sync(dwc);
+
+	return 0;
+
+error:
+	usb_otg_unregister(dwc->dev);
+
+	return ret;
+}
+
+static void dwc3_drd_exit(struct dwc3 *dwc)
+{
+	free_irq(dwc->otg_irq, dwc);
+	usb_otg_unregister(dwc->dev);
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -781,11 +1224,31 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_OTG);
+		ret = dwc3_drd_init(dwc);
+		if (ret) {
+			if (ret == -EPROBE_DEFER)
+				return ret;
+
+			dev_err(dev,
+				"limiting to peripheral only as dual-role init failed: %d",
+				ret);
+			dwc->dr_mode = USB_DR_MODE_PERIPHERAL;
+			dwc3_set_mode(dwc, DWC3_GCTL_PRTCAP_DEVICE);
+			ret = dwc3_gadget_init(dwc);
+			if (ret) {
+				if (ret == -EPROBE_DEFER)
+					return ret;
+				dev_err(dev, "failed to initialize gadget\n");
+				return ret;
+			}
+			break;
+		}
+
 		ret = dwc3_host_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "failed to initialize host\n");
+			dwc3_drd_exit(dwc);
 			return ret;
 		}
 
@@ -793,6 +1256,8 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "failed to initialize gadget\n");
+			dwc3_host_exit(dwc);
+			dwc3_drd_exit(dwc);
 			return ret;
 		}
 		break;
@@ -816,6 +1281,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 	case USB_DR_MODE_OTG:
 		dwc3_host_exit(dwc);
 		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
@@ -1091,19 +1557,34 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
 {
 	unsigned long	flags;
 
+	spin_lock_irqsave(&dwc->lock, flags);
+
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_suspend(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
+		break;
+	case USB_DR_MODE_OTG:
+		dwc->otg_protocol = dwc->otg->fsm.protocol;
+
+		switch (dwc->otg->fsm.protocol) {
+		case PROTO_GADGET:
+			dwc3_gadget_suspend(dwc);
+			break;
+		case PROTO_HOST:
+		case PROTO_UNDEF:
+		default:
+			/* nothing */
+			break;
+		}
 		break;
 	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_UNKNOWN:
 	default:
 		/* do nothing */
 		break;
 	}
 
+	spin_unlock_irqrestore(&dwc->lock, flags);
 	dwc3_core_exit(dwc);
 
 	return 0;
@@ -1118,19 +1599,41 @@ static int dwc3_resume_common(struct dwc3 *dwc)
 	if (ret)
 		return ret;
 
+	spin_lock_irqsave(&dwc->lock, flags);
+
 	switch (dwc->dr_mode) {
 	case USB_DR_MODE_PERIPHERAL:
-	case USB_DR_MODE_OTG:
-		spin_lock_irqsave(&dwc->lock, flags);
 		dwc3_gadget_resume(dwc);
-		spin_unlock_irqrestore(&dwc->lock, flags);
-		/* FALLTHROUGH */
+		break;
+	case USB_DR_MODE_OTG:
+		switch (dwc->otg_protocol) {
+		case PROTO_GADGET:
+			dwc3_gadget_resume(dwc);
+			break;
+		case PROTO_HOST:
+			break;
+		case PROTO_UNDEF:
+		default:
+			/* nothing */
+			break;
+		}
+		break;
 	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_UNKNOWN:
 	default:
 		/* do nothing */
 		break;
 	}
 
+	/* Restore OTG state only if we're really using it */
+	if (dwc->current_mode == DWC3_GCTL_PRTCAP_OTG) {
+		dwc3_writel(dwc->regs, DWC3_OCFG, dwc->ocfg);
+		dwc3_writel(dwc->regs, DWC3_OCTL, dwc->octl);
+		dwc3_otg_unmask_irq(dwc);
+	}
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
 	return 0;
 }
 
@@ -1185,6 +1688,7 @@ static int dwc3_runtime_resume(struct device *dev)
 		dwc3_gadget_process_pending_events(dwc);
 		break;
 	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_UNKNOWN:
 	default:
 		/* do nothing */
 		break;
@@ -1219,6 +1723,30 @@ static int dwc3_runtime_idle(struct device *dev)
 #endif /* CONFIG_PM */
 
 #ifdef CONFIG_PM_SLEEP
+static int dwc3_prepare(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->otg_prevent_sync = true;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
+static void dwc3_complete(struct device *dev)
+{
+	struct dwc3	*dwc = dev_get_drvdata(dev);
+	unsigned long	flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->otg_prevent_sync = false;
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	if (dwc->dr_mode == USB_DR_MODE_OTG)
+		dwc3_otg_fsm_sync(dwc);
+}
+
 static int dwc3_suspend(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
@@ -1256,6 +1784,8 @@ static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
+	.prepare = dwc3_prepare,
+	.complete = dwc3_complete,
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 32bb7531..e6b771a 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -31,6 +31,7 @@
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
 #include <linux/ulpi/interface.h>
+#include <linux/usb/otg-fsm.h>
 
 #include <linux/phy/phy.h>
 
@@ -817,13 +818,21 @@ struct dwc3_scratchpad_array {
  * @gadget_driver: pointer to the gadget driver
  * @regs: base address for our registers
  * @regs_size: address space size
+ * @dr_mode: requested mode of operation
+ * @otg: usb otg data structure
+ * @otg_caps: otg controller capabilities
+ * @otg_config: otg controller configuration
+ * @otg_prevent_sync: flag to block events to otg fsm
+ * @otg_protocol: saved copy of otg state during suspend
+ * @current_mode: current mode of operation written to PRTCAPDIR
+ * @oevt: cached OEVT register during OTG irq
  * @fladj: frame length adjustment
  * @irq_gadget: peripheral controller's IRQ number
+ * @otg_irq: IRQ number for OTG IRQs
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
- * @dr_mode: requested mode of operation
  * @usb2_phy: pointer to USB2 PHY
  * @usb3_phy: pointer to USB3 PHY
  * @usb2_generic_phy: pointer to USB2 PHY
@@ -831,6 +840,9 @@ struct dwc3_scratchpad_array {
  * @ulpi: pointer to ulpi interface
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
+ * @ocfg: saved contents of OCFG register
+ * @octl: saved contents of OCTL register
+ * @oevten: saved contents of OEVTEN register
  * @isoch_delay: wValue from Set Isochronous Delay request;
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
@@ -929,9 +941,25 @@ struct dwc3 {
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	struct usb_otg		*otg;
+	struct usb_otg_caps	otg_caps;
+	struct usb_otg_config	otg_config;
+	bool			otg_prevent_sync;
+	int			otg_protocol;
+	u32			current_mode;
+	u32			oevt;
 
 	u32			fladj;
 	u32			irq_gadget;
+	int			otg_irq;
+
+	/* used for suspend/resume */
+	u32			dcfg;
+	u32			gctl;
+	u32			ocfg;
+	u32			octl;
+	u32			oevten;
+
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 1ade5e8..e409b1e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2974,7 +2974,11 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	if (ret)
 		goto err5;
 
-	ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
+	if (dwc->dr_mode == USB_DR_MODE_OTG)
+		ret = usb_otg_add_gadget_udc(dwc->dev, &dwc->gadget, dwc->dev);
+	else
+		ret = usb_add_gadget_udc(dwc->dev, &dwc->gadget);
+
 	if (ret) {
 		dev_err(dwc->dev, "failed to register udc\n");
 		goto err5;
diff --git a/drivers/usb/dwc3/host.c b/drivers/usb/dwc3/host.c
index 2e960ed..32096ec 100644
--- a/drivers/usb/dwc3/host.c
+++ b/drivers/usb/dwc3/host.c
@@ -91,6 +91,8 @@ int dwc3_host_init(struct dwc3 *dwc)
 	memset(&pdata, 0, sizeof(pdata));
 
 	pdata.usb3_lpm_capable = dwc->usb3_lpm_capable;
+	if (dwc->dr_mode == USB_DR_MODE_OTG)
+		pdata.otg_dev = dwc->dev;
 
 	ret = platform_device_add_data(xhci, &pdata, sizeof(pdata));
 	if (ret) {
-- 
2.7.4
