From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH 5/8] usb: dwc3: add dual-role support
Date: Mon, 23 Jan 2017 13:19:38 +0200
Message-ID: <1485170381-32110-6-git-send-email-rogerq@ti.com>
References: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485170381-32110-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@kernel.org, tony@atomide.com
Cc: peter.chen@freescale.com, vivek.gautam@codeaurora.org, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

If dr_mode is "otg" then support dual role mode of operation.

Get ID and VBUS information from the OTG controller
and put the controller in the appropriate state.

This is our dual-role state table.

ID	VBUS	dual-role state
--	----	---------------
0	x	A_HOST - Host controller active
1	0	B_IDLE - Both Host and Gadget controllers inactive
1	1	B_PERIPHERAL - Gadget controller active

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/usb/dwc3/core.c   | 583 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/usb/dwc3/core.h   |  38 ++-
 drivers/usb/dwc3/gadget.c |  18 +-
 3 files changed, 615 insertions(+), 24 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 369bab1..ca8b814 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -27,6 +27,7 @@
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/ioport.h>
 #include <linux/io.h>
 #include <linux/list.h>
@@ -107,6 +108,7 @@ void dwc3_set_mode(struct dwc3 *dwc, u32 mode)
 	reg = dwc3_readl(dwc->regs, DWC3_GCTL);
 	reg &= ~(DWC3_GCTL_PRTCAPDIR(DWC3_GCTL_PRTCAP_OTG));
 	reg |= DWC3_GCTL_PRTCAPDIR(mode);
+	dwc->current_mode = mode;
 	dwc3_writel(dwc->regs, DWC3_GCTL, reg);
 }
 
@@ -839,6 +841,495 @@ static int dwc3_core_get_phy(struct dwc3 *dwc)
 	return 0;
 }
 
+static int dwc3_drd_start_host(struct dwc3 *dwc, int on);
+static int dwc3_drd_start_gadget(struct dwc3 *dwc, int on);
+
+/* dwc->lock must be held */
+static void dwc3_drd_statemachine(struct dwc3 *dwc, int id, int vbus)
+{
+	enum usb_otg_state new_state;
+	int protocol;
+
+	if (id == dwc->otg_fsm.id && vbus == dwc->otg_fsm.b_sess_vld)
+		return;
+
+	dwc->otg_fsm.id = id;
+	dwc->otg_fsm.b_sess_vld = vbus;
+
+	if (!id) {
+		new_state = OTG_STATE_A_HOST;
+	} else{
+		if (vbus)
+			new_state = OTG_STATE_B_PERIPHERAL;
+		else
+			new_state = OTG_STATE_B_IDLE;
+	}
+
+	if (dwc->otg.state == new_state)
+		return;
+
+	protocol = dwc->otg_fsm.protocol;
+	switch (new_state) {
+	case OTG_STATE_B_IDLE:
+		if (protocol == PROTO_GADGET)
+			dwc3_drd_start_gadget(dwc, 0);
+		else if (protocol == PROTO_HOST)
+			dwc3_drd_start_host(dwc, 0);
+		dwc->otg_fsm.protocol = PROTO_UNDEF;
+		break;
+	case OTG_STATE_B_PERIPHERAL:
+		if (protocol == PROTO_HOST)
+			dwc3_drd_start_host(dwc, 0);
+
+		if (protocol != PROTO_GADGET) {
+			dwc->otg_fsm.protocol = PROTO_GADGET;
+			dwc3_drd_start_gadget(dwc, 1);
+		}
+		break;
+	case OTG_STATE_A_HOST:
+		if (protocol == PROTO_GADGET)
+			dwc3_drd_start_gadget(dwc, 0);
+
+		if (protocol != PROTO_HOST) {
+			dwc->otg_fsm.protocol = PROTO_HOST;
+			dwc3_drd_start_host(dwc, 1);
+		}
+		break;
+	default:
+		dev_err(dwc->dev, "drd: invalid usb-drd state: %s\n",
+			usb_otg_state_string(new_state));
+		return;
+	}
+
+	dwc->otg.state = new_state;
+}
+
+/* dwc->lock must be held */
+static void dwc3_otg_fsm_sync(struct dwc3 *dwc)
+{
+	u32 reg, osts;
+	int id, vbus;
+
+	/*
+	 * calling dwc3_otg_fsm_sync() during resume breaks host
+	 * if adapter was removed during suspend as xhci driver
+	 * is not prepared to see hcd removal before xhci_resume.
+	 */
+	if (dwc->otg_prevent_sync)
+		return;
+
+	do {
+		reg = dwc3_readl(dwc->regs, DWC3_OSTS);
+
+		id = !!(reg & DWC3_OSTS_CONIDSTS);
+		vbus = !!(reg & DWC3_OSTS_BSESVLD);
+
+		dwc3_drd_statemachine(dwc, id, vbus);
+		osts = dwc3_readl(dwc->regs, DWC3_OSTS);
+		/*
+		 * OTG status might have changed and if we don't re-check
+		 * here we will loose events as OTG events have been
+		 * temporarily disabled.
+		 */
+		/* FIXME: there is still a small time window where we can
+		 * miss an OTG event. i.e. from here till where we enable the
+		 * OEVTEN in OTG IRQ thread handler. Try another solution
+		 * where OEVTEN can be enabled but otg irq in GIC is disabled.
+		 * so any OTG changes can re-trigger the OTG IRQ after current
+		 * ISR ends.
+		 */
+	} while (osts != reg);
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
+static irqreturn_t dwc3_otg_thread_irq(int irq, void *_dwc)
+{
+	struct dwc3 *dwc = _dwc;
+
+	spin_lock(&dwc->lock);
+	dwc3_otg_fsm_sync(dwc);
+	dwc3_otg_unmask_irq(dwc);
+	spin_unlock(&dwc->lock);
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
+/* dwc->lock must be held */
+static int dwc3_drd_start_host(struct dwc3 *dwc, int on)
+{
+	u32 reg;
+
+	/* switch OTG core */
+	if (on) {
+		/* As per Figure 11-10 A-Device Flow Diagram */
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
+		spin_unlock(&dwc->lock);
+		dwc3_host_init(dwc);
+		spin_lock(&dwc->lock);
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
+	} else {
+		/*
+		 * Exit from A-device flow as per
+		 * Figure 11-4 OTG Driver Overall Programming Flow
+		 */
+		/* stop the HCD */
+		spin_unlock(&dwc->lock);
+		dwc3_host_exit(dwc);
+		spin_lock(&dwc->lock);
+
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
+	}
+
+	return 0;
+}
+
+/* dwc->lock must be held */
+static int dwc3_drd_start_gadget(struct dwc3 *dwc, int on)
+{
+	u32 reg;
+
+	if (on)
+		dwc3_event_buffers_setup(dwc);
+
+	if (on) {
+		/* As per Figure 11-20 B-Device Flow Diagram */
+
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
+		/* start the Peripheral driver  */
+		if (dwc->gadget_driver) {
+			__dwc3_gadget_start(dwc);
+			if (dwc->gadget_pullup)
+				dwc3_gadget_run_stop(dwc, true, false);
+		}
+	} else {
+		/*
+		 * Exit from B-device flow as per
+		 * Figure 11-4 OTG Driver Overall Programming Flow
+		 */
+		/* stop the Peripheral driver */
+		if (dwc->gadget_driver) {
+			if (dwc->gadget_pullup)
+				dwc3_gadget_run_stop(dwc, false, false);
+			spin_unlock(&dwc->lock);
+			if (dwc->gadget_driver->disconnect)
+				dwc->gadget_driver->disconnect(&dwc->gadget);
+			spin_lock(&dwc->lock);
+			__dwc3_gadget_stop(dwc);
+		}
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
+	}
+
+	return 0;
+}
+
+static int dwc3_otg_get_irq(struct dwc3 *dwc)
+{
+	struct platform_device *dwc3_pdev = to_platform_device(dwc->dev);
+	int irq;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "otg");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq_byname(dwc3_pdev, "dwc_usb3");
+	if (irq > 0)
+		goto out;
+
+	if (irq == -EPROBE_DEFER)
+		goto out;
+
+	irq = platform_get_irq(dwc3_pdev, 0);
+	if (irq > 0)
+		goto out;
+
+	if (irq != -EPROBE_DEFER)
+		dev_err(dwc->dev, "missing otg IRQ\n");
+
+	if (!irq)
+		irq = -EINVAL;
+
+out:
+	return irq;
+}
+
+static int dwc3_drd_init(struct dwc3 *dwc)
+{
+	int ret, irq;
+	u32 reg;
+	unsigned long flags;
+
+	irq = dwc3_otg_get_irq(dwc);
+	if (irq < 0)
+		return irq;
+
+	dwc->otg_irq = irq;
+
+	/* disable all otg irqs */
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	/* clear all events */
+	dwc3_writel(dwc->regs, DWC3_OEVT, ~0);
+
+	irq_set_status_flags(dwc->otg_irq, IRQ_NOAUTOEN);
+	ret = request_threaded_irq(dwc->otg_irq, dwc3_otg_irq,
+				   dwc3_otg_thread_irq,
+				   IRQF_SHARED, "dwc3-otg", dwc);
+	if (ret) {
+		dev_err(dwc->dev, "failed to request irq #%d --> %d\n",
+			dwc->otg_irq, ret);
+		ret = -ENODEV;
+		return ret;
+	}
+
+	ret = dwc3_gadget_init(dwc);
+	if (ret) {
+		free_irq(dwc->otg_irq, dwc);
+		return ret;
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
+
+	/* force drd state machine update the first time */
+	dwc->otg_fsm.b_sess_vld = -1;
+	dwc->otg_fsm.id = -1;
+	dwc3_otg_fsm_sync(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	return 0;
+}
+
+static void dwc3_drd_exit(struct dwc3 *dwc)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_otg_disable_events(dwc, DWC3_OTG_ALL_EVENTS);
+	if (dwc->otg_fsm.protocol == PROTO_HOST)
+		dwc3_drd_start_host(dwc, 0);
+	dwc->otg_fsm.protocol = PROTO_UNDEF;
+	free_irq(dwc->otg_irq, dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+
+	dwc3_gadget_exit(dwc);
+}
+
+/* -------------------------------------------------------------------------- */
+
 static int dwc3_core_init_mode(struct dwc3 *dwc)
 {
 	struct device *dev = dwc->dev;
@@ -862,17 +1353,10 @@ static int dwc3_core_init_mode(struct dwc3 *dwc)
 		}
 		break;
 	case USB_DR_MODE_OTG:
-		ret = dwc3_host_init(dwc);
-		if (ret) {
-			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize host\n");
-			return ret;
-		}
-
-		ret = dwc3_gadget_init(dwc);
+		ret = dwc3_drd_init(dwc);
 		if (ret) {
 			if (ret != -EPROBE_DEFER)
-				dev_err(dev, "failed to initialize gadget\n");
+				dev_err(dev, "failed to initialize dual-role\n");
 			return ret;
 		}
 		break;
@@ -894,8 +1378,7 @@ static void dwc3_core_exit_mode(struct dwc3 *dwc)
 		dwc3_host_exit(dwc);
 		break;
 	case USB_DR_MODE_OTG:
-		dwc3_host_exit(dwc);
-		dwc3_gadget_exit(dwc);
+		dwc3_drd_exit(dwc);
 		break;
 	default:
 		/* do nothing */
@@ -1207,19 +1690,32 @@ static int dwc3_suspend_common(struct dwc3 *dwc)
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
+		switch (dwc->otg_fsm.protocol) {
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
@@ -1234,19 +1730,41 @@ static int dwc3_resume_common(struct dwc3 *dwc)
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
+		switch (dwc->otg_fsm.protocol) {
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
 
@@ -1301,6 +1819,7 @@ static int dwc3_runtime_resume(struct device *dev)
 		dwc3_gadget_process_pending_events(dwc);
 		break;
 	case USB_DR_MODE_HOST:
+	case USB_DR_MODE_UNKNOWN:
 	default:
 		/* do nothing */
 		break;
@@ -1336,6 +1855,30 @@ static int dwc3_runtime_idle(struct device *dev)
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
+	if (dwc->dr_mode == USB_DR_MODE_OTG)
+		dwc3_otg_fsm_sync(dwc);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static int dwc3_suspend(struct device *dev)
 {
 	struct dwc3	*dwc = dev_get_drvdata(dev);
@@ -1373,6 +1916,10 @@ static const struct dev_pm_ops dwc3_dev_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(dwc3_suspend, dwc3_resume)
 	SET_RUNTIME_PM_OPS(dwc3_runtime_suspend, dwc3_runtime_resume,
 			dwc3_runtime_idle)
+#ifdef CONFIG_PM_SLEEP
+	.prepare = dwc3_prepare,
+	.complete = dwc3_complete,
+#endif
 };
 
 #ifdef CONFIG_OF
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index fc82d2e..8463c4c 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -35,6 +35,9 @@
 
 #include <linux/phy/phy.h>
 
+#include <linux/usb/otg.h>
+#include <linux/usb/otg-fsm.h>
+
 #define DWC3_MSG_MAX	500
 
 /* Global constants */
@@ -854,15 +857,21 @@ struct dwc3_scratchpad_array {
  * @event_buffer_list: a list of event buffers
  * @gadget: device side representation of the peripheral controller
  * @gadget_driver: pointer to the gadget driver
+ * @gadget_pullup: gadget driver's pullup request flag
  * @regs: base address for our registers
  * @regs_size: address space size
+ * @dr_mode: requested mode of operation
+ * @otg: usb otg data structure
+ * @otg-fsm: usb otg fsm data structure
+ * @otg_prevent_sync: flag to block events to otg fsm
+ * @current_mode: current mode of operation written to PRTCAPDIR
  * @fladj: frame length adjustment
  * @irq_gadget: peripheral controller's IRQ number
+ * @otg_irq: IRQ number for OTG IRQs
  * @nr_scratch: number of scratch buffers
  * @u1u2: only used on revisions <1.83a for workaround
  * @maximum_speed: maximum speed requested (mainly for testing purposes)
  * @revision: revision register contents
- * @dr_mode: requested mode of operation
  * @hsphy_mode: UTMI phy mode, one of following:
  *		- USBPHY_INTERFACE_MODE_UTMI
  *		- USBPHY_INTERFACE_MODE_UTMIW
@@ -873,6 +882,9 @@ struct dwc3_scratchpad_array {
  * @ulpi: pointer to ulpi interface
  * @dcfg: saved contents of DCFG register
  * @gctl: saved contents of GCTL register
+ * @ocfg: saved contents of OCFG register
+ * @octl: saved contents of OCTL register
+ * @oevten: saved contents of OEVTEN register
  * @isoch_delay: wValue from Set Isochronous Delay request;
  * @u2sel: parameter from Set SEL request.
  * @u2pel: parameter from Set SEL request.
@@ -964,6 +976,7 @@ struct dwc3 {
 
 	struct usb_gadget	gadget;
 	struct usb_gadget_driver *gadget_driver;
+	bool			gadget_pullup;
 
 	struct usb_phy		*usb2_phy;
 	struct usb_phy		*usb3_phy;
@@ -973,14 +986,28 @@ struct dwc3 {
 
 	struct ulpi		*ulpi;
 
+	/* used for suspend/resume */
+	u32			dcfg;
+	u32			gctl;
+	u32			ocfg;
+	u32			octl;
+	u32			oevten;
+
 	void __iomem		*regs;
 	size_t			regs_size;
 
 	enum usb_dr_mode	dr_mode;
+	struct usb_otg		otg;
+	struct otg_fsm		otg_fsm;
+	bool			otg_prevent_sync;
+	u32			current_mode;
+
 	enum usb_phy_interface	hsphy_mode;
 
 	u32			fladj;
 	u32			irq_gadget;
+	int			otg_irq;
+
 	u32			nr_scratch;
 	u32			u1u2;
 	u32			maximum_speed;
@@ -1277,6 +1304,9 @@ int dwc3_gadget_set_link_state(struct dwc3 *dwc, enum dwc3_link_state state);
 int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 		struct dwc3_gadget_ep_cmd_params *params);
 int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param);
+int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend);
+int __dwc3_gadget_start(struct dwc3 *dwc);
+void __dwc3_gadget_stop(struct dwc3 *dwc);
 #else
 static inline int dwc3_gadget_init(struct dwc3 *dwc)
 { return 0; }
@@ -1296,6 +1326,12 @@ static inline int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
 static inline int dwc3_send_gadget_generic_command(struct dwc3 *dwc,
 		int cmd, u32 param)
 { return 0; }
+static inline int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+{ return 0; }
+static inline int __dwc3_gadget_start(struct dwc3 *dwc)
+{ return 0; }
+static inline void __dwc3_gadget_stop(struct dwc3 *dwc)
+{ }
 #endif
 
 /* power management interface */
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 204c754c..8779f7a 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1534,7 +1534,7 @@ static int dwc3_gadget_set_selfpowered(struct usb_gadget *g,
 	return 0;
 }
 
-static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
+int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 {
 	u32			reg;
 	u32			timeout = 500;
@@ -1542,6 +1542,10 @@ static int dwc3_gadget_run_stop(struct dwc3 *dwc, int is_on, int suspend)
 	if (pm_runtime_suspended(dwc->dev))
 		return 0;
 
+	if (dwc->dr_mode == USB_DR_MODE_OTG &&
+	    dwc->otg_fsm.protocol != PROTO_GADGET)
+		return 0;
+
 	reg = dwc3_readl(dwc->regs, DWC3_DCTL);
 	if (is_on) {
 		if (dwc->revision <= DWC3_REVISION_187A) {
@@ -1603,6 +1607,7 @@ static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
 	}
 
 	spin_lock_irqsave(&dwc->lock, flags);
+	dwc->gadget_pullup = is_on;
 	ret = dwc3_gadget_run_stop(dwc, is_on, false);
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -1679,7 +1684,7 @@ static void dwc3_gadget_setup_nump(struct dwc3 *dwc)
 	dwc3_writel(dwc->regs, DWC3_DCFG, reg);
 }
 
-static int __dwc3_gadget_start(struct dwc3 *dwc)
+int __dwc3_gadget_start(struct dwc3 *dwc)
 {
 	struct dwc3_ep		*dep;
 	int			ret = 0;
@@ -1812,8 +1817,11 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 
 	dwc->gadget_driver	= driver;
 
-	if (pm_runtime_active(dwc->dev))
-		__dwc3_gadget_start(dwc);
+	if (pm_runtime_active(dwc->dev)) {
+		if (!(dwc->dr_mode == USB_DR_MODE_OTG &&
+		      dwc->otg_fsm.protocol != PROTO_GADGET))
+			__dwc3_gadget_start(dwc);
+	}
 
 	spin_unlock_irqrestore(&dwc->lock, flags);
 
@@ -1827,7 +1835,7 @@ static int dwc3_gadget_start(struct usb_gadget *g,
 	return ret;
 }
 
-static void __dwc3_gadget_stop(struct dwc3 *dwc)
+void __dwc3_gadget_stop(struct dwc3 *dwc)
 {
 	dwc3_gadget_disable_irq(dwc);
 	__dwc3_gadget_ep_disable(dwc->eps[0]);
-- 
2.7.4
