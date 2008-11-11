From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-2.6.28-rc3+ 29/59] omap: namespace cleanup to drivers/i2c/chips/isp1301_omap.c
Date: Wed, 12 Nov 2008 00:56:48 +0200
Message-ID: <1226444238-14614-30-git-send-email-me@felipebalbi.com>
References: <1226444238-14614-1-git-send-email-me@felipebalbi.com>
 <1226444238-14614-2-git-send-email-me@felipebalbi.com>
 <1226444238-14614-3-git-send-email-me@felipebalbi.com>
 <1226444238-14614-4-git-send-email-me@felipebalbi.com>
 <1226444238-14614-5-git-send-email-me@felipebalbi.com>
 <1226444238-14614-6-git-send-email-me@felipebalbi.com>
 <1226444238-14614-7-git-send-email-me@felipebalbi.com>
 <1226444238-14614-8-git-send-email-me@felipebalbi.com>
 <1226444238-14614-9-git-send-email-me@felipebalbi.com>
 <1226444238-14614-10-git-send-email-me@felipebalbi.com>
 <1226444238-14614-11-git-send-email-me@felipebalbi.com>
 <1226444238-14614-12-git-send-email-me@felipebalbi.com>
 <1226444238-14614-13-git-send-email-me@felipebalbi.com>
 <1226444238-14614-14-git-send-email-me@felipebalbi.com>
 <1226444238-14614-15-git-send-email-me@felipebalbi.com>
 <1226444238-14614-16-git-send-email-me@felipebalbi.com>
 <1226444238-14614-17-git-send-email-me@felipebalbi.com>
 <1226444238-14614-18-git-send-email-me@felipebalbi.com>
 <1226444238-14614-19-git-send-email-me@felipebalbi.com>
 <1226444238-14614-20-git-send-email-me@felipebalbi.com>
 <1226444238-14614-21-git-send-email-me@felipebalbi.com>
 <1226444238-14614-22-git-send-email-me@felipebalbi.com>
 <1226444238-14614-23-git-send-email-me@felipebalbi.com>
 <1226444238-14614-24-git-send-email-me@felipebalbi.com>
 <1226444238-14614-25-git-send-email-me@felipebalbi.com>
 <1226444238-14614-26-git-send-email-me@felipebalbi.com>
 <1226444238-14614-27-git-send-email-me@felipebalbi.com>
 <1226444238-14614-28-git-send-email-me@felipebalbi.com>
 <1226444238-14614-29-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:56538 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751662AbYKKXEr (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 Nov 2008 18:04:47 -0500
In-Reply-To: <1226444238-14614-29-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Felipe Balbi <felipe.balbi@nokia.com>

From: Felipe Balbi <felipe.balbi@nokia.com>

Signed-off-by: Felipe Balbi <felipe.balbi@nokia.com>
---
 drivers/i2c/chips/isp1301_omap.c |  118 +++++++++++++++++++-------------------
 1 files changed, 59 insertions(+), 59 deletions(-)

diff --git a/drivers/i2c/chips/isp1301_omap.c b/drivers/i2c/chips/isp1301_omap.c
index f717270..411d709 100644
--- a/drivers/i2c/chips/isp1301_omap.c
+++ b/drivers/i2c/chips/isp1301_omap.c
@@ -367,8 +367,8 @@ static void a_idle(struct isp1301 *isp, const char *tag)
 		gadget_suspend(isp);
 	}
 	isp->otg.state = OTG_STATE_A_IDLE;
-	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
-	omap_writel(l, OTG_CTRL);
+	l = __raw_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
+	__raw_writel(l, OTG_CTRL);
 	isp->last_otg_ctrl = l;
 	pr_debug("  --> %s/%s\n", state_name(isp), tag);
 }
@@ -391,8 +391,8 @@ static void b_idle(struct isp1301 *isp, const char *tag)
 		gadget_suspend(isp);
 	}
 	isp->otg.state = OTG_STATE_B_IDLE;
-	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
-	omap_writel(l, OTG_CTRL);
+	l = __raw_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
+	__raw_writel(l, OTG_CTRL);
 	isp->last_otg_ctrl = l;
 	pr_debug("  --> %s/%s\n", state_name(isp), tag);
 }
@@ -406,7 +406,7 @@ dump_regs(struct isp1301 *isp, const char *label)
 	u8	src = isp1301_get_u8(isp, ISP1301_INTERRUPT_SOURCE);
 
 	pr_debug("otg: %06x, %s %s, otg/%02x stat/%02x.%02x\n",
-		omap_readl(OTG_CTRL), label, state_name(isp),
+		__raw_readl(OTG_CTRL), label, state_name(isp),
 		ctrl, status, src);
 	/* mode control and irq enables don't change much */
 #endif
@@ -429,7 +429,7 @@ dump_regs(struct isp1301 *isp, const char *label)
 static void check_state(struct isp1301 *isp, const char *tag)
 {
 	enum usb_otg_state	state = OTG_STATE_UNDEFINED;
-	u8			fsm = omap_readw(OTG_TEST) & 0x0ff;
+	u8			fsm = __raw_readw(OTG_TEST) & 0x0ff;
 	unsigned		extra = 0;
 
 	switch (fsm) {
@@ -495,7 +495,7 @@ static void check_state(struct isp1301 *isp, const char *tag)
 		return;
 	pr_debug("otg: %s FSM %s/%02x, %s, %06x\n", tag,
 		state_string(state), fsm, state_name(isp),
-		omap_readl(OTG_CTRL));
+		__raw_readl(OTG_CTRL));
 }
 
 #else
@@ -509,7 +509,7 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
 {
 	u32	otg_ctrl;
 
-	otg_ctrl = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+	otg_ctrl = __raw_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	otg_ctrl &= ~OTG_XCEIV_INPUTS;
 	otg_ctrl &= ~(OTG_ID|OTG_ASESSVLD|OTG_VBUSVLD);
 
@@ -536,7 +536,7 @@ static void update_otg1(struct isp1301 *isp, u8 int_src)
 			return;
 		}
 	}
-	omap_writel(otg_ctrl, OTG_CTRL);
+	__raw_writel(otg_ctrl, OTG_CTRL);
 }
 
 /* outputs from ISP1301_OTG_STATUS */
@@ -544,14 +544,14 @@ static void update_otg2(struct isp1301 *isp, u8 otg_status)
 {
 	u32	otg_ctrl;
 
-	otg_ctrl = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+	otg_ctrl = __raw_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	otg_ctrl &= ~OTG_XCEIV_INPUTS;
 	otg_ctrl &= ~(OTG_BSESSVLD | OTG_BSESSEND);
 	if (otg_status & OTG_B_SESS_VLD)
 		otg_ctrl |= OTG_BSESSVLD;
 	else if (otg_status & OTG_B_SESS_END)
 		otg_ctrl |= OTG_BSESSEND;
-	omap_writel(otg_ctrl, OTG_CTRL);
+	__raw_writel(otg_ctrl, OTG_CTRL);
 }
 
 /* inputs going to ISP1301 */
@@ -560,7 +560,7 @@ static void otg_update_isp(struct isp1301 *isp)
 	u32	otg_ctrl, otg_change;
 	u8	set = OTG1_DM_PULLDOWN, clr = OTG1_DM_PULLUP;
 
-	otg_ctrl = omap_readl(OTG_CTRL);
+	otg_ctrl = __raw_readl(OTG_CTRL);
 	otg_change = otg_ctrl ^ isp->last_otg_ctrl;
 	isp->last_otg_ctrl = otg_ctrl;
 	otg_ctrl = otg_ctrl & OTG_XCEIV_INPUTS;
@@ -658,9 +658,9 @@ pulldown:
 		default:
 			break;
 		}
-		l = omap_readl(OTG_CTRL);
+		l = __raw_readl(OTG_CTRL);
 		l |= OTG_PULLUP;
-		omap_writel(l, OTG_CTRL);
+		__raw_writel(l, OTG_CTRL);
 	}
 
 	check_state(isp, __func__);
@@ -669,20 +669,20 @@ pulldown:
 
 static irqreturn_t omap_otg_irq(int irq, void *_isp)
 {
-	u16		otg_irq = omap_readw(OTG_IRQ_SRC);
+	u16		otg_irq = __raw_readw(OTG_IRQ_SRC);
 	u32		otg_ctrl;
 	int		ret = IRQ_NONE;
 	struct isp1301	*isp = _isp;
 
 	/* update ISP1301 transciever from OTG controller */
 	if (otg_irq & OPRT_CHG) {
-		omap_writew(OPRT_CHG, OTG_IRQ_SRC);
+		__raw_writew(OPRT_CHG, OTG_IRQ_SRC);
 		isp1301_defer_work(isp, WORK_UPDATE_ISP);
 		ret = IRQ_HANDLED;
 
 	/* SRP to become b_peripheral failed */
 	} else if (otg_irq & B_SRP_TMROUT) {
-		pr_debug("otg: B_SRP_TIMEOUT, %06x\n", omap_readl(OTG_CTRL));
+		pr_debug("otg: B_SRP_TIMEOUT, %06x\n", __raw_readl(OTG_CTRL));
 		notresponding(isp);
 
 		/* gadget drivers that care should monitor all kinds of
@@ -692,31 +692,31 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 		if (isp->otg.state == OTG_STATE_B_SRP_INIT)
 			b_idle(isp, "srp_timeout");
 
-		omap_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
+		__raw_writew(B_SRP_TMROUT, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 	/* HNP to become b_host failed */
 	} else if (otg_irq & B_HNP_FAIL) {
 		pr_debug("otg: %s B_HNP_FAIL, %06x\n",
-				state_name(isp), omap_readl(OTG_CTRL));
+				state_name(isp), __raw_readl(OTG_CTRL));
 		notresponding(isp);
 
-		otg_ctrl = omap_readl(OTG_CTRL);
+		otg_ctrl = __raw_readl(OTG_CTRL);
 		otg_ctrl |= OTG_BUSDROP;
 		otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
-		omap_writel(otg_ctrl, OTG_CTRL);
+		__raw_writel(otg_ctrl, OTG_CTRL);
 
 		/* subset of b_peripheral()... */
 		isp->otg.state = OTG_STATE_B_PERIPHERAL;
 		pr_debug("  --> b_peripheral\n");
 
-		omap_writew(B_HNP_FAIL, OTG_IRQ_SRC);
+		__raw_writew(B_HNP_FAIL, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 	/* detect SRP from B-device ... */
 	} else if (otg_irq & A_SRP_DETECT) {
 		pr_debug("otg: %s SRP_DETECT, %06x\n",
-				state_name(isp), omap_readl(OTG_CTRL));
+				state_name(isp), __raw_readl(OTG_CTRL));
 
 		isp1301_defer_work(isp, WORK_UPDATE_OTG);
 		switch (isp->otg.state) {
@@ -724,49 +724,49 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 			if (!isp->otg.host)
 				break;
 			isp1301_defer_work(isp, WORK_HOST_RESUME);
-			otg_ctrl = omap_readl(OTG_CTRL);
+			otg_ctrl = __raw_readl(OTG_CTRL);
 			otg_ctrl |= OTG_A_BUSREQ;
 			otg_ctrl &= ~(OTG_BUSDROP|OTG_B_BUSREQ)
 					& ~OTG_XCEIV_INPUTS
 					& OTG_CTRL_MASK;
-			omap_writel(otg_ctrl, OTG_CTRL);
+			__raw_writel(otg_ctrl, OTG_CTRL);
 			break;
 		default:
 			break;
 		}
 
-		omap_writew(A_SRP_DETECT, OTG_IRQ_SRC);
+		__raw_writew(A_SRP_DETECT, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 	/* timer expired:  T(a_wait_bcon) and maybe T(a_wait_vrise)
 	 * we don't track them separately
 	 */
 	} else if (otg_irq & A_REQ_TMROUT) {
-		otg_ctrl = omap_readl(OTG_CTRL);
+		otg_ctrl = __raw_readl(OTG_CTRL);
 		pr_info("otg: BCON_TMOUT from %s, %06x\n",
 				state_name(isp), otg_ctrl);
 		notresponding(isp);
 
 		otg_ctrl |= OTG_BUSDROP;
 		otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
-		omap_writel(otg_ctrl, OTG_CTRL);
+		__raw_writel(otg_ctrl, OTG_CTRL);
 		isp->otg.state = OTG_STATE_A_WAIT_VFALL;
 
-		omap_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
+		__raw_writew(A_REQ_TMROUT, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 	/* A-supplied voltage fell too low; overcurrent */
 	} else if (otg_irq & A_VBUS_ERR) {
-		otg_ctrl = omap_readl(OTG_CTRL);
+		otg_ctrl = __raw_readl(OTG_CTRL);
 		printk(KERN_ERR "otg: %s, VBUS_ERR %04x ctrl %06x\n",
 			state_name(isp), otg_irq, otg_ctrl);
 
 		otg_ctrl |= OTG_BUSDROP;
 		otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
-		omap_writel(otg_ctrl, OTG_CTRL);
+		__raw_writel(otg_ctrl, OTG_CTRL);
 		isp->otg.state = OTG_STATE_A_VBUS_ERR;
 
-		omap_writew(A_VBUS_ERR, OTG_IRQ_SRC);
+		__raw_writew(A_VBUS_ERR, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 	/* switch driver; the transciever code activates it,
@@ -775,7 +775,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 	} else if (otg_irq & DRIVER_SWITCH) {
 		int	kick = 0;
 
-		otg_ctrl = omap_readl(OTG_CTRL);
+		otg_ctrl = __raw_readl(OTG_CTRL);
 		printk(KERN_NOTICE "otg: %s, SWITCH to %s, ctrl %06x\n",
 				state_name(isp),
 				(otg_ctrl & OTG_DRIVER_SEL)
@@ -798,7 +798,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 		} else {
 			if (!(otg_ctrl & OTG_ID)) {
 				otg_ctrl &= OTG_CTRL_MASK & ~OTG_XCEIV_INPUTS;
-				omap_writel(otg_ctrl | OTG_A_BUSREQ, OTG_CTRL);
+				__raw_writel(otg_ctrl | OTG_A_BUSREQ, OTG_CTRL);
 			}
 
 			if (isp->otg.host) {
@@ -823,7 +823,7 @@ static irqreturn_t omap_otg_irq(int irq, void *_isp)
 			}
 		}
 
-		omap_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
+		__raw_writew(DRIVER_SWITCH, OTG_IRQ_SRC);
 		ret = IRQ_HANDLED;
 
 		if (kick)
@@ -846,7 +846,7 @@ static int otg_init(struct isp1301 *isp)
 
 	dump_regs(isp, __func__);
 	/* some of these values are board-specific... */
-	l = omap_readl(OTG_SYSCON_2);
+	l = __raw_readl(OTG_SYSCON_2);
 	l |= OTG_EN
 		/* for B-device: */
 		| SRP_GPDATA		/* 9msec Bdev D+ pulse */
@@ -857,22 +857,22 @@ static int otg_init(struct isp1301 *isp)
 		| SRP_DPW		/* detect 167+ns SRP pulses */
 		| SRP_DATA | SRP_VBUS	/* accept both kinds of SRP pulse */
 		;
-	omap_writel(l, OTG_SYSCON_2);
+	__raw_writel(l, OTG_SYSCON_2);
 
 	update_otg1(isp, isp1301_get_u8(isp, ISP1301_INTERRUPT_SOURCE));
 	update_otg2(isp, isp1301_get_u8(isp, ISP1301_OTG_STATUS));
 
 	check_state(isp, __func__);
 	pr_debug("otg: %s, %s %06x\n",
-			state_name(isp), __func__, omap_readl(OTG_CTRL));
+			state_name(isp), __func__, __raw_readl(OTG_CTRL));
 
-	omap_writew(DRIVER_SWITCH | OPRT_CHG
+	__raw_writew(DRIVER_SWITCH | OPRT_CHG
 			| B_SRP_TMROUT | B_HNP_FAIL
 			| A_VBUS_ERR | A_SRP_DETECT | A_REQ_TMROUT, OTG_IRQ_EN);
 
-	l = omap_readl(OTG_SYSCON_2);
+	l = __raw_readl(OTG_SYSCON_2);
 	l |= OTG_EN;
-	omap_writel(l, OTG_SYSCON_2);
+	__raw_writel(l, OTG_SYSCON_2);
 
 	return 0;
 }
@@ -941,8 +941,8 @@ static void b_peripheral(struct isp1301 *isp)
 {
 	u32 l;
 
-	l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
-	omap_writel(l, OTG_CTRL);
+	l = __raw_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
+	__raw_writel(l, OTG_CTRL);
 
 	usb_gadget_vbus_connect(isp->otg.gadget);
 
@@ -1037,9 +1037,9 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
 				isp1301_clear_bits(isp, ISP1301_MODE_CONTROL_1,
 						MC1_BDIS_ACON_EN);
 				isp->otg.state = OTG_STATE_B_IDLE;
-				l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+				l = __raw_readl(OTG_CTRL) & OTG_CTRL_MASK;
 				l &= ~OTG_CTRL_BITS;
-				omap_writel(l, OTG_CTRL);
+				__raw_writel(l, OTG_CTRL);
 				break;
 			case OTG_STATE_B_IDLE:
 				break;
@@ -1065,8 +1065,8 @@ static void isp_update_otg(struct isp1301 *isp, u8 stat)
 			/* FALLTHROUGH */
 		case OTG_STATE_B_SRP_INIT:
 			b_idle(isp, __func__);
-			l = omap_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
-			omap_writel(l, OTG_CTRL);
+			l = __raw_readl(OTG_CTRL) & OTG_XCEIV_OUTPUTS;
+			__raw_writel(l, OTG_CTRL);
 			/* FALLTHROUGH */
 		case OTG_STATE_B_IDLE:
 			if (isp->otg.gadget && (isp_bstat & OTG_B_SESS_VLD)) {
@@ -1150,11 +1150,11 @@ isp1301_work(struct work_struct *work)
 			case OTG_STATE_A_WAIT_VRISE:
 				isp->otg.state = OTG_STATE_A_HOST;
 				pr_debug("  --> a_host\n");
-				otg_ctrl = omap_readl(OTG_CTRL);
+				otg_ctrl = __raw_readl(OTG_CTRL);
 				otg_ctrl |= OTG_A_BUSREQ;
 				otg_ctrl &= ~(OTG_BUSDROP|OTG_B_BUSREQ)
 						& OTG_CTRL_MASK;
-				omap_writel(otg_ctrl, OTG_CTRL);
+				__raw_writel(otg_ctrl, OTG_CTRL);
 				break;
 			case OTG_STATE_B_WAIT_ACON:
 				isp->otg.state = OTG_STATE_B_HOST;
@@ -1294,7 +1294,7 @@ isp1301_set_host(struct otg_transceiver *otg, struct usb_bus *host)
 		return -ENODEV;
 
 	if (!host) {
-		omap_writew(0, OTG_IRQ_EN);
+		__raw_writew(0, OTG_IRQ_EN);
 		power_down(isp);
 		isp->otg.host = 0;
 		return 0;
@@ -1351,7 +1351,7 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
 		return -ENODEV;
 
 	if (!gadget) {
-		omap_writew(0, OTG_IRQ_EN);
+		__raw_writew(0, OTG_IRQ_EN);
 		if (!isp->otg.default_a)
 			enable_vbus_draw(isp, 0);
 		usb_gadget_vbus_disconnect(isp->otg.gadget);
@@ -1372,10 +1372,10 @@ isp1301_set_peripheral(struct otg_transceiver *otg, struct usb_gadget *gadget)
 	isp->otg.gadget = gadget;
 	// FIXME update its refcount
 
-	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
+	l = __raw_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
 	l |= OTG_ID;
-	omap_writel(l, OTG_CTRL);
+	__raw_writel(l, OTG_CTRL);
 
 	power_up(isp);
 	isp->otg.state = OTG_STATE_B_IDLE;
@@ -1428,17 +1428,17 @@ isp1301_start_srp(struct otg_transceiver *dev)
 			|| isp->otg.state != OTG_STATE_B_IDLE)
 		return -ENODEV;
 
-	otg_ctrl = omap_readl(OTG_CTRL);
+	otg_ctrl = __raw_readl(OTG_CTRL);
 	if (!(otg_ctrl & OTG_BSESSEND))
 		return -EINVAL;
 
 	otg_ctrl |= OTG_B_BUSREQ;
 	otg_ctrl &= ~OTG_A_BUSREQ & OTG_CTRL_MASK;
-	omap_writel(otg_ctrl, OTG_CTRL);
+	__raw_writel(otg_ctrl, OTG_CTRL);
 	isp->otg.state = OTG_STATE_B_SRP_INIT;
 
 	pr_debug("otg: SRP, %s ... %06x\n", state_name(isp),
-			omap_readl(OTG_CTRL));
+			__raw_readl(OTG_CTRL));
 #ifdef	CONFIG_USB_OTG
 	check_state(isp, __func__);
 #endif
@@ -1477,9 +1477,9 @@ isp1301_start_hnp(struct otg_transceiver *dev)
 #endif
 		/* caller must suspend then clear A_BUSREQ */
 		usb_gadget_vbus_connect(isp->otg.gadget);
-		l = omap_readl(OTG_CTRL);
+		l = __raw_readl(OTG_CTRL);
 		l |= OTG_A_SETB_HNPEN;
-		omap_writel(l, OTG_CTRL);
+		__raw_writel(l, OTG_CTRL);
 
 		break;
 	case OTG_STATE_A_PERIPHERAL:
@@ -1489,7 +1489,7 @@ isp1301_start_hnp(struct otg_transceiver *dev)
 		return -EILSEQ;
 	}
 	pr_debug("otg: HNP %s, %06x ...\n",
-		state_name(isp), omap_readl(OTG_CTRL));
+		state_name(isp), __raw_readl(OTG_CTRL));
 	check_state(isp, __func__);
 	return 0;
 #else
-- 
1.6.0.2.307.gc427

