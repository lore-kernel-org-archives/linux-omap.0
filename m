From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] Fix bootup crash for LDP platform
Date: Sat, 18 Oct 2008 12:28:08 -0700
Message-ID: <200810181228.09194.david-b@pacbell.net>
References: <1224284642-13863-1-git-send-email-vikram.pandita@ti.com> <20081017235020.GM31842@frodo> <20081018135642.GP18573@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp128.sbc.mail.sp1.yahoo.com ([69.147.65.187]:48647 "HELO
	smtp128.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750806AbYJRT2M (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Sat, 18 Oct 2008 15:28:12 -0400
In-Reply-To: <20081018135642.GP18573@atomide.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Felipe Balbi <me@felipebalbi.com>, "Pandita, Vikram" <vikram.pandita@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Saturday 18 October 2008, Tony Lindgren wrote:
> Pushed. I hope you have a real fix for this coming from mainline soon :)

There's a general issue to sort out here too.

The early development of the MUSB code was on DaVinci, and
then TUSB6010, which integrate (a) an OTG transceiver, plus
(b) the OTG hardware.  So musb_hdrc currently presumes it
always works that way.

However, OMAP3 (and 2430) split out (a) into the TWL4030
or TWL5030 chip, leaving (b) integral to the MUSB silicon.

But the MUSB code only accomodates that through a hack ...
in musb/omap2430.c is the line which I suspect oopsed:

	musb->xceiv = *x;

So when the twl4030 transceiver support does its thing,
it does it to the original otg_transceiver struct instead
of the copy being used by the MUSB core.  Wrong!!!

Partial fixup patch appended; doesn't resolve $SUBJECT
issue, I think, but it's in the right direction.

- Dave

===================
Let the otg_transceiver in MUSB be external; don't force it to be internal
any more.  Newer OMAPs need it to be external.

PARTIAL AND INCOMPLETE FIX ... not build-tested except for OMAP3 boards.

Davinci and TUSB6010 should provide their own otg_transceiver struct,
and not as part of the overall "struct musb".

The transceiver is responsible for a handful of things, but in this
case most of the OTG state machine is part of the MUSB silicon not
the transceiver.


---
 drivers/i2c/chips/twl4030-usb.c |   12 +++++-
 drivers/usb/musb/davinci.c      |   20 +++++-----
 drivers/usb/musb/musb_core.c    |   70 +++++++++++++++++++-------------------
 drivers/usb/musb/musb_core.h    |    3 +
 drivers/usb/musb/musb_gadget.c  |   36 ++++++++-----------
 drivers/usb/musb/musb_host.c    |    2 -
 drivers/usb/musb/musb_virthub.c |   20 +++++-----
 drivers/usb/musb/omap2430.c     |   40 ++++++++-------------
 drivers/usb/musb/tusb6010.c     |   42 +++++++++++-----------
 9 files changed, 122 insertions(+), 123 deletions(-)

--- a/drivers/i2c/chips/twl4030-usb.c
+++ b/drivers/i2c/chips/twl4030-usb.c
@@ -586,13 +586,14 @@ static int twl4030_set_peripheral(struct
 		struct usb_gadget *gadget)
 {
 	struct twl4030_usb *twl;
-	u32 l;
+//	u32 l;
 
 	if (!x)
 		return -ENODEV;
 
 	twl = xceiv_to_twl(x);
 
+/*
 	if (!gadget) {
 		omap_writew(0, OTG_IRQ_EN);
 		twl4030_phy_suspend(twl, 1);
@@ -600,16 +601,19 @@ static int twl4030_set_peripheral(struct
 
 		return -ENODEV;
 	}
+*/
 
 	twl->otg.gadget = gadget;
+/*
 	twl4030_phy_resume(twl);
 
 	l = omap_readl(OTG_CTRL) & OTG_CTRL_MASK;
 	l &= ~(OTG_XCEIV_OUTPUTS|OTG_CTRL_BITS);
 	l |= OTG_ID;
 	omap_writel(l, OTG_CTRL);
+*/
 
-	twl->otg.state = OTG_STATE_B_IDLE;
+	twl->otg.state = gadget ? OTG_STATE_B_IDLE : OTG_STATE_UNDEFINED;
 
 	return 0;
 }
@@ -623,6 +627,7 @@ static int twl4030_set_host(struct otg_t
 
 	twl = xceiv_to_twl(x);
 
+/*
 	if (!host) {
 		omap_writew(0, OTG_IRQ_EN);
 		twl4030_phy_suspend(twl, 1);
@@ -630,8 +635,10 @@ static int twl4030_set_host(struct otg_t
 
 		return -ENODEV;
 	}
+*/
 
 	twl->otg.host = host;
+/*
 	twl4030_phy_resume(twl);
 
 	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL,
@@ -640,6 +647,7 @@ static int twl4030_set_host(struct otg_t
 
 	twl4030_usb_set_bits(twl, FUNC_CTRL, FUNC_CTRL_SUSPENDM);
 	twl4030_usb_set_bits(twl, TWL4030_OTG_CTRL, TWL4030_OTG_CTRL_DRVVBUS);
+*/
 
 	return 0;
 }
--- a/drivers/usb/musb/davinci.c
+++ b/drivers/usb/musb/davinci.c
@@ -211,7 +211,7 @@ static void otg_timer(unsigned long _mus
 	DBG(7, "poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
 
 	spin_lock_irqsave(&musb->lock, flags);
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_A_WAIT_VFALL:
 		/* Wait till VBUS falls below SessionEnd (~0.2V); the 1.3 RTL
 		 * seems to mis-handle session "start" otherwise (or in our
@@ -222,7 +222,7 @@ static void otg_timer(unsigned long _mus
 			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 			break;
 		}
-		musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
+		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
 		musb_writel(musb->ctrl_base, DAVINCI_USB_INT_SET_REG,
 			MUSB_INTR_VBUSERROR << DAVINCI_USB_USBINT_SHIFT);
 		break;
@@ -247,7 +247,7 @@ static void otg_timer(unsigned long _mus
 		if (devctl & MUSB_DEVCTL_BDEVICE)
 			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 		else
-			musb->xceiv.state = OTG_STATE_A_IDLE;
+			musb->xceiv->state = OTG_STATE_A_IDLE;
 		break;
 	default:
 		break;
@@ -327,21 +327,21 @@ static irqreturn_t davinci_interrupt(int
 			 * to stop registering in devctl.
 			 */
 			musb->int_usb &= ~MUSB_INTR_VBUSERROR;
-			musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
 			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 			WARNING("VBUS error workaround (delay coming)\n");
 		} else if (is_host_enabled(musb) && drvvbus) {
 			musb->is_active = 1;
 			MUSB_HST_MODE(musb);
-			musb->xceiv.default_a = 1;
-			musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
+			musb->xceiv->default_a = 1;
+			musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
 			portstate(musb->port1_status |= USB_PORT_STAT_POWER);
 			del_timer(&otg_workaround);
 		} else {
 			musb->is_active = 0;
 			MUSB_DEV_MODE(musb);
-			musb->xceiv.default_a = 0;
-			musb->xceiv.state = OTG_STATE_B_IDLE;
+			musb->xceiv->default_a = 0;
+			musb->xceiv->state = OTG_STATE_B_IDLE;
 			portstate(musb->port1_status &= ~USB_PORT_STAT_POWER);
 		}
 
@@ -363,7 +363,7 @@ static irqreturn_t davinci_interrupt(int
 
 	/* poll for ID change */
 	if (is_otg_enabled(musb)
-			&& musb->xceiv.state == OTG_STATE_B_IDLE)
+			&& musb->xceiv->state == OTG_STATE_B_IDLE)
 		mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
 
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -432,7 +432,7 @@ int musb_platform_exit(struct musb *musb
 	davinci_source_power(musb, 0 /*off*/, 1);
 
 	/* delay, to avoid problems with module reload */
-	if (is_host_enabled(musb) && musb->xceiv.default_a) {
+	if (is_host_enabled(musb) && musb->xceiv->default_a) {
 		int	maxdelay = 30;
 		u8	devctl, warn = 0;
 
--- a/drivers/usb/musb/musb_core.c
+++ b/drivers/usb/musb/musb_core.c
@@ -266,7 +266,7 @@ void musb_load_testpacket(struct musb *m
 
 const char *otg_state_string(struct musb *musb)
 {
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_A_IDLE:		return "a_idle";
 	case OTG_STATE_A_WAIT_VRISE:	return "a_wait_vrise";
 	case OTG_STATE_A_WAIT_BCON:	return "a_wait_bcon";
@@ -301,11 +301,11 @@ void musb_otg_timer_func(unsigned long d
 	unsigned long	flags;
 
 	spin_lock_irqsave(&musb->lock, flags);
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_B_WAIT_ACON:
 		DBG(1, "HNP: b_wait_acon timeout; back to b_peripheral\n");
 		musb_g_disconnect(musb);
-		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_WAIT_BCON:
@@ -330,20 +330,20 @@ void musb_hnp_stop(struct musb *musb)
 	void __iomem	*mbase = musb->mregs;
 	u8	reg;
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_A_PERIPHERAL:
 	case OTG_STATE_A_WAIT_VFALL:
 	case OTG_STATE_A_WAIT_BCON:
 		DBG(1, "HNP: Switching back to A-host\n");
 		musb_g_disconnect(musb);
-		musb->xceiv.state = OTG_STATE_A_IDLE;
+		musb->xceiv->state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_B_HOST:
 		DBG(1, "HNP: Disabling HR\n");
 		hcd->self.is_b_host = 0;
-		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		MUSB_DEV_MODE(musb);
 		reg = musb_readb(mbase, MUSB_POWER);
 		reg |= MUSB_POWER_SUSPENDM;
@@ -401,7 +401,7 @@ static irqreturn_t musb_stage0_irq(struc
 
 		if (devctl & MUSB_DEVCTL_HM) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
-			switch (musb->xceiv.state) {
+			switch (musb->xceiv->state) {
 			case OTG_STATE_A_SUSPEND:
 				/* remote wakeup?  later, GetPortStatus
 				 * will stop RESUME signaling
@@ -424,12 +424,12 @@ static irqreturn_t musb_stage0_irq(struc
 				musb->rh_timer = jiffies
 						+ msecs_to_jiffies(20);
 
-				musb->xceiv.state = OTG_STATE_A_HOST;
+				musb->xceiv->state = OTG_STATE_A_HOST;
 				musb->is_active = 1;
 				usb_hcd_resume_root_hub(musb_to_hcd(musb));
 				break;
 			case OTG_STATE_B_WAIT_ACON:
-				musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				musb->is_active = 1;
 				MUSB_DEV_MODE(musb);
 				break;
@@ -440,11 +440,11 @@ static irqreturn_t musb_stage0_irq(struc
 			}
 #endif
 		} else {
-			switch (musb->xceiv.state) {
+			switch (musb->xceiv->state) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 			case OTG_STATE_A_SUSPEND:
 				/* possibly DISCONNECT is upcoming */
-				musb->xceiv.state = OTG_STATE_A_HOST;
+				musb->xceiv->state = OTG_STATE_A_HOST;
 				usb_hcd_resume_root_hub(musb_to_hcd(musb));
 				break;
 #endif
@@ -489,7 +489,7 @@ static irqreturn_t musb_stage0_irq(struc
 		 */
 		musb_writeb(mbase, MUSB_DEVCTL, MUSB_DEVCTL_SESSION);
 		musb->ep0_stage = MUSB_EP0_START;
-		musb->xceiv.state = OTG_STATE_A_IDLE;
+		musb->xceiv->state = OTG_STATE_A_IDLE;
 		MUSB_HST_MODE(musb);
 		musb_set_vbus(musb, 1);
 
@@ -515,7 +515,7 @@ static irqreturn_t musb_stage0_irq(struc
 		 * REVISIT:  do delays from lots of DEBUG_KERNEL checks
 		 * make trouble here, keeping VBUS < 4.4V ?
 		 */
-		switch (musb->xceiv.state) {
+		switch (musb->xceiv->state) {
 		case OTG_STATE_A_HOST:
 			/* recovery is dicey once we've gotten past the
 			 * initial stages of enumeration, but if VBUS
@@ -601,11 +601,11 @@ static irqreturn_t musb_stage0_irq(struc
 		MUSB_HST_MODE(musb);
 
 		/* indicate new connection to OTG machine */
-		switch (musb->xceiv.state) {
+		switch (musb->xceiv->state) {
 		case OTG_STATE_B_PERIPHERAL:
 			if (int_usb & MUSB_INTR_SUSPEND) {
 				DBG(1, "HNP: SUSPEND+CONNECT, now b_host\n");
-				musb->xceiv.state = OTG_STATE_B_HOST;
+				musb->xceiv->state = OTG_STATE_B_HOST;
 				hcd->self.is_b_host = 1;
 				int_usb &= ~MUSB_INTR_SUSPEND;
 			} else
@@ -613,13 +613,13 @@ static irqreturn_t musb_stage0_irq(struc
 			break;
 		case OTG_STATE_B_WAIT_ACON:
 			DBG(1, "HNP: Waiting to switch to b_host state\n");
-			musb->xceiv.state = OTG_STATE_B_HOST;
+			musb->xceiv->state = OTG_STATE_B_HOST;
 			hcd->self.is_b_host = 1;
 			break;
 		default:
 			if ((devctl & MUSB_DEVCTL_VBUS)
 					== (3 << MUSB_DEVCTL_VBUS_SHIFT)) {
-				musb->xceiv.state = OTG_STATE_A_HOST;
+				musb->xceiv->state = OTG_STATE_A_HOST;
 				hcd->self.is_b_host = 0;
 			}
 			break;
@@ -649,7 +649,7 @@ static irqreturn_t musb_stage0_irq(struc
 			}
 		} else if (is_peripheral_capable()) {
 			DBG(1, "BUS RESET as %s\n", otg_state_string(musb));
-			switch (musb->xceiv.state) {
+			switch (musb->xceiv->state) {
 #ifdef CONFIG_USB_OTG
 			case OTG_STATE_A_SUSPEND:
 				/* We need to ignore disconnect on suspend
@@ -672,12 +672,12 @@ static irqreturn_t musb_stage0_irq(struc
 			case OTG_STATE_B_WAIT_ACON:
 				DBG(1, "HNP: RESET (%s), to b_peripheral\n",
 					otg_state_string(musb));
-				musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				musb_g_reset(musb);
 				break;
 #endif
 			case OTG_STATE_B_IDLE:
-				musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+				musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 				/* FALLTHROUGH */
 			case OTG_STATE_B_PERIPHERAL:
 				musb_g_reset(musb);
@@ -762,7 +762,7 @@ static irqreturn_t musb_stage2_irq(struc
 				MUSB_MODE(musb), devctl);
 		handled = IRQ_HANDLED;
 
-		switch (musb->xceiv.state) {
+		switch (musb->xceiv->state) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 		case OTG_STATE_A_HOST:
 		case OTG_STATE_A_SUSPEND:
@@ -803,7 +803,7 @@ static irqreturn_t musb_stage2_irq(struc
 				otg_state_string(musb), devctl, power);
 		handled = IRQ_HANDLED;
 
-		switch (musb->xceiv.state) {
+		switch (musb->xceiv->state) {
 #ifdef	CONFIG_USB_MUSB_OTG
 		case OTG_STATE_A_PERIPHERAL:
 			/*
@@ -815,10 +815,10 @@ static irqreturn_t musb_stage2_irq(struc
 		case OTG_STATE_B_PERIPHERAL:
 			musb_g_suspend(musb);
 			musb->is_active = is_otg_enabled(musb)
-					&& musb->xceiv.gadget->b_hnp_enable;
+					&& musb->xceiv->gadget->b_hnp_enable;
 			if (musb->is_active) {
 #ifdef	CONFIG_USB_MUSB_OTG
-				musb->xceiv.state = OTG_STATE_B_WAIT_ACON;
+				musb->xceiv->state = OTG_STATE_B_WAIT_ACON;
 				DBG(1, "HNP: Setting timer for b_ase0_brst\n");
 				musb_otg_timer.data = (unsigned long)musb;
 				mod_timer(&musb_otg_timer, jiffies
@@ -832,9 +832,9 @@ static irqreturn_t musb_stage2_irq(struc
 					+ msecs_to_jiffies(musb->a_wait_bcon));
 			break;
 		case OTG_STATE_A_HOST:
-			musb->xceiv.state = OTG_STATE_A_SUSPEND;
+			musb->xceiv->state = OTG_STATE_A_SUSPEND;
 			musb->is_active = is_otg_enabled(musb)
-					&& musb->xceiv.host->b_hnp_enable;
+					&& musb->xceiv->host->b_hnp_enable;
 			break;
 		case OTG_STATE_B_HOST:
 			/* Transition to B_PERIPHERAL, see 6.8.2.6 p 44 */
@@ -1700,7 +1700,7 @@ musb_vbus_store(struct device *dev, stru
 
 	spin_lock_irqsave(&musb->lock, flags);
 	musb->a_wait_bcon = val;
-	if (musb->xceiv.state == OTG_STATE_A_WAIT_BCON)
+	if (musb->xceiv->state == OTG_STATE_A_WAIT_BCON)
 		musb->is_active = 0;
 	musb_platform_try_idle(musb, jiffies + msecs_to_jiffies(val));
 	spin_unlock_irqrestore(&musb->lock, flags);
@@ -1761,8 +1761,8 @@ static void musb_irq_work(struct work_st
 	struct musb *musb = container_of(data, struct musb, irq_work);
 	static int old_state;
 
-	if (musb->xceiv.state != old_state) {
-		old_state = musb->xceiv.state;
+	if (musb->xceiv->state != old_state) {
+		old_state = musb->xceiv->state;
 		sysfs_notify(&musb->controller->kobj, NULL, "mode");
 	}
 }
@@ -1857,7 +1857,7 @@ static void musb_free(struct musb *musb)
 	}
 
 #ifdef CONFIG_USB_MUSB_OTG
-	put_device(musb->xceiv.dev);
+	put_device(musb->xceiv->dev);
 #endif
 
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
@@ -2012,7 +2012,7 @@ bad_config:
 
 		if (musb->board_mode == MUSB_OTG)
 			hcd->self.otg_port = 1;
-		musb->xceiv.host = &hcd->self;
+		musb->xceiv->host = &hcd->self;
 		hcd->power_budget = 2 * (plat->power ? : 250);
 	}
 #endif				/* CONFIG_USB_MUSB_HDRC_HCD */
@@ -2023,8 +2023,8 @@ bad_config:
 	 */
 	if (!is_otg_enabled(musb) && is_host_enabled(musb)) {
 		MUSB_HST_MODE(musb);
-		musb->xceiv.default_a = 1;
-		musb->xceiv.state = OTG_STATE_A_IDLE;
+		musb->xceiv->default_a = 1;
+		musb->xceiv->state = OTG_STATE_A_IDLE;
 
 		status = usb_add_hcd(musb_to_hcd(musb), -1, 0);
 		if (status)
@@ -2039,8 +2039,8 @@ bad_config:
 
 	} else /* peripheral is enabled */ {
 		MUSB_DEV_MODE(musb);
-		musb->xceiv.default_a = 0;
-		musb->xceiv.state = OTG_STATE_B_IDLE;
+		musb->xceiv->default_a = 0;
+		musb->xceiv->state = OTG_STATE_B_IDLE;
 
 		status = musb_gadget_setup(musb);
 		if (status)
--- a/drivers/usb/musb/musb_core.h
+++ b/drivers/usb/musb/musb_core.h
@@ -349,6 +349,7 @@ struct musb {
 	dma_addr_t		async;
 	dma_addr_t		sync;
 	void __iomem		*sync_va;
+	struct otg_transceiver	otg;
 #endif
 
 	/* passed down from chip/board specific irq handlers */
@@ -356,7 +357,7 @@ struct musb {
 	u16			int_rx;
 	u16			int_tx;
 
-	struct otg_transceiver	xceiv;
+	struct otg_transceiver	*xceiv;
 
 	int nIrq;
 
--- a/drivers/usb/musb/musb_gadget.c
+++ b/drivers/usb/musb/musb_gadget.c
@@ -1394,7 +1394,7 @@ static int musb_gadget_wakeup(struct usb
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_B_PERIPHERAL:
 		/* NOTE:  OTG state machine doesn't include B_SUSPENDED;
 		 * that's part of the standard usb 1.1 state machine, and
@@ -1496,9 +1496,9 @@ static int musb_gadget_vbus_draw(struct 
 {
 	struct musb	*musb = gadget_to_musb(gadget);
 
-	if (!musb->xceiv.set_power)
+	if (!musb->xceiv->set_power)
 		return -EOPNOTSUPP;
-	return otg_set_power(&musb->xceiv, mA);
+	return otg_set_power(musb->xceiv, mA);
 }
 
 static int musb_gadget_pullup(struct usb_gadget *gadget, int is_on)
@@ -1721,11 +1721,7 @@ int usb_gadget_register_driver(struct us
 
 		spin_lock_irqsave(&musb->lock, flags);
 
-		/* REVISIT always use otg_set_peripheral(), handling
-		 * issues including the root hub one below ...
-		 */
-		musb->xceiv.gadget = &musb->g;
-		musb->xceiv.state = OTG_STATE_B_IDLE;
+		otg_set_peripheral(musb->xceiv, &musb->g);
 		musb->is_active = 1;
 
 		/* FIXME this ignores the softconnect flag.  Drivers are
@@ -1750,8 +1746,7 @@ int usb_gadget_register_driver(struct us
 			if (retval < 0) {
 				DBG(1, "add_hcd failed, %d\n", retval);
 				spin_lock_irqsave(&musb->lock, flags);
-				musb->xceiv.gadget = NULL;
-				musb->xceiv.state = OTG_STATE_UNDEFINED;
+				otg_set_peripheral(musb->xceiv, NULL);
 				musb->gadget_driver = NULL;
 				musb->g.dev.driver = NULL;
 				spin_unlock_irqrestore(&musb->lock, flags);
@@ -1834,8 +1829,9 @@ int usb_gadget_unregister_driver(struct 
 
 		(void) musb_gadget_vbus_draw(&musb->g, 0);
 
-		musb->xceiv.state = OTG_STATE_UNDEFINED;
+		musb->xceiv->state = OTG_STATE_UNDEFINED;
 		stop_activity(musb, driver);
+		otg_set_peripheral(musb->xceiv, NULL);
 
 		DBG(3, "unregistering driver %s\n", driver->function);
 		spin_unlock_irqrestore(&musb->lock, flags);
@@ -1871,7 +1867,7 @@ EXPORT_SYMBOL(usb_gadget_unregister_driv
 void musb_g_resume(struct musb *musb)
 {
 	musb->is_suspended = 0;
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_B_IDLE:
 		break;
 	case OTG_STATE_B_WAIT_ACON:
@@ -1897,10 +1893,10 @@ void musb_g_suspend(struct musb *musb)
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 	DBG(3, "devctl %02x\n", devctl);
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_B_IDLE:
 		if ((devctl & MUSB_DEVCTL_VBUS) == MUSB_DEVCTL_VBUS)
-			musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+			musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		break;
 	case OTG_STATE_B_PERIPHERAL:
 		musb->is_suspended = 1;
@@ -1946,22 +1942,22 @@ void musb_g_disconnect(struct musb *musb
 		spin_lock(&musb->lock);
 	}
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	default:
 #ifdef	CONFIG_USB_MUSB_OTG
 		DBG(2, "Unhandled disconnect %s, setting a_idle\n",
 			otg_state_string(musb));
-		musb->xceiv.state = OTG_STATE_A_IDLE;
+		musb->xceiv->state = OTG_STATE_A_IDLE;
 		break;
 	case OTG_STATE_A_PERIPHERAL:
-		musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
+		musb->xceiv->state = OTG_STATE_A_WAIT_VFALL;
 		break;
 	case OTG_STATE_B_WAIT_ACON:
 	case OTG_STATE_B_HOST:
 #endif
 	case OTG_STATE_B_PERIPHERAL:
 	case OTG_STATE_B_IDLE:
-		musb->xceiv.state = OTG_STATE_B_IDLE;
+		musb->xceiv->state = OTG_STATE_B_IDLE;
 		break;
 	case OTG_STATE_B_SRP_INIT:
 		break;
@@ -2017,10 +2013,10 @@ __acquires(musb->lock)
 	 * or else after HNP, as A-Device
 	 */
 	if (devctl & MUSB_DEVCTL_BDEVICE) {
-		musb->xceiv.state = OTG_STATE_B_PERIPHERAL;
+		musb->xceiv->state = OTG_STATE_B_PERIPHERAL;
 		musb->g.is_a_peripheral = 0;
 	} else if (is_otg_enabled(musb)) {
-		musb->xceiv.state = OTG_STATE_A_PERIPHERAL;
+		musb->xceiv->state = OTG_STATE_A_PERIPHERAL;
 		musb->g.is_a_peripheral = 1;
 	} else
 		WARN_ON(1);
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -2130,7 +2130,7 @@ static int musb_bus_suspend(struct usb_h
 {
 	struct musb	*musb = hcd_to_musb(hcd);
 
-	if (musb->xceiv.state == OTG_STATE_A_SUSPEND)
+	if (musb->xceiv->state == OTG_STATE_A_SUSPEND)
 		return 0;
 
 	if (is_host_active(musb) && musb->is_active) {
--- a/drivers/usb/musb/musb_virthub.c
+++ b/drivers/usb/musb/musb_virthub.c
@@ -78,18 +78,18 @@ static void musb_port_suspend(struct mus
 		DBG(3, "Root port suspended, power %02x\n", power);
 
 		musb->port1_status |= USB_PORT_STAT_SUSPEND;
-		switch (musb->xceiv.state) {
+		switch (musb->xceiv->state) {
 		case OTG_STATE_A_HOST:
-			musb->xceiv.state = OTG_STATE_A_SUSPEND;
+			musb->xceiv->state = OTG_STATE_A_SUSPEND;
 			musb->is_active = is_otg_enabled(musb)
-					&& musb->xceiv.host->b_hnp_enable;
+					&& musb->xceiv->host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
 #ifdef	CONFIG_USB_MUSB_OTG
 		case OTG_STATE_B_HOST:
-			musb->xceiv.state = OTG_STATE_B_WAIT_ACON;
+			musb->xceiv->state = OTG_STATE_B_WAIT_ACON;
 			musb->is_active = is_otg_enabled(musb)
-					&& musb->xceiv.host->b_hnp_enable;
+					&& musb->xceiv->host->b_hnp_enable;
 			musb_platform_try_idle(musb, 0);
 			break;
 #endif
@@ -116,7 +116,7 @@ static void musb_port_reset(struct musb 
 	void __iomem	*mbase = musb->mregs;
 
 #ifdef CONFIG_USB_MUSB_OTG
-	if (musb->xceiv.state == OTG_STATE_B_IDLE) {
+	if (musb->xceiv->state == OTG_STATE_B_IDLE) {
 		DBG(2, "HNP: Returning from HNP; no hub reset from b_idle\n");
 		musb->port1_status &= ~USB_PORT_STAT_RESET;
 		return;
@@ -186,14 +186,14 @@ void musb_root_disconnect(struct musb *m
 	usb_hcd_poll_rh_status(musb_to_hcd(musb));
 	musb->is_active = 0;
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_A_HOST:
 	case OTG_STATE_A_SUSPEND:
-		musb->xceiv.state = OTG_STATE_A_WAIT_BCON;
+		musb->xceiv->state = OTG_STATE_A_WAIT_BCON;
 		musb->is_active = 0;
 		break;
 	case OTG_STATE_A_WAIT_VFALL:
-		musb->xceiv.state = OTG_STATE_B_IDLE;
+		musb->xceiv->state = OTG_STATE_B_IDLE;
 		break;
 	default:
 		DBG(1, "host disconnect (%s)\n", otg_state_string(musb));
@@ -332,7 +332,7 @@ int musb_hub_control(
 			musb->port1_status |= USB_PORT_STAT_C_SUSPEND << 16;
 			usb_hcd_poll_rh_status(musb_to_hcd(musb));
 			/* NOTE: it might really be A_WAIT_BCON ... */
-			musb->xceiv.state = OTG_STATE_A_HOST;
+			musb->xceiv->state = OTG_STATE_A_HOST;
 		}
 
 		put_unaligned(cpu_to_le32(musb->port1_status
--- a/drivers/usb/musb/omap2430.c
+++ b/drivers/usb/musb/omap2430.c
@@ -60,17 +60,17 @@ static void musb_do_idle(unsigned long _
 
 	devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 
-	switch (musb->xceiv.state) {
+	switch (musb->xceiv->state) {
 	case OTG_STATE_A_WAIT_BCON:
 		devctl &= ~MUSB_DEVCTL_SESSION;
 		musb_writeb(musb->mregs, MUSB_DEVCTL, devctl);
 
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if (devctl & MUSB_DEVCTL_BDEVICE) {
-			musb->xceiv.state = OTG_STATE_B_IDLE;
+			musb->xceiv->state = OTG_STATE_B_IDLE;
 			MUSB_DEV_MODE(musb);
 		} else {
-			musb->xceiv.state = OTG_STATE_A_IDLE;
+			musb->xceiv->state = OTG_STATE_A_IDLE;
 			MUSB_HST_MODE(musb);
 		}
 		break;
@@ -88,7 +88,7 @@ static void musb_do_idle(unsigned long _
 			musb->port1_status |= USB_PORT_STAT_C_SUSPEND << 16;
 			usb_hcd_poll_rh_status(musb_to_hcd(musb));
 			/* NOTE: it might really be A_WAIT_BCON ... */
-			musb->xceiv.state = OTG_STATE_A_HOST;
+			musb->xceiv->state = OTG_STATE_A_HOST;
 		}
 		break;
 #endif
@@ -96,9 +96,9 @@ static void musb_do_idle(unsigned long _
 	case OTG_STATE_A_HOST:
 		devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
 		if (devctl &  MUSB_DEVCTL_BDEVICE)
-			musb->xceiv.state = OTG_STATE_B_IDLE;
+			musb->xceiv->state = OTG_STATE_B_IDLE;
 		else
-			musb->xceiv.state = OTG_STATE_A_WAIT_BCON;
+			musb->xceiv->state = OTG_STATE_A_WAIT_BCON;
 #endif
 	default:
 		break;
@@ -117,7 +117,7 @@ void musb_platform_try_idle(struct musb 
 
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
-			&& (musb->xceiv.state == OTG_STATE_A_WAIT_BCON))) {
+			&& (musb->xceiv->state == OTG_STATE_A_WAIT_BCON))) {
 		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
@@ -162,8 +162,8 @@ static void omap_set_vbus(struct musb *m
 
 	if (is_on) {
 		musb->is_active = 1;
-		musb->xceiv.default_a = 1;
-		musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
+		musb->xceiv->default_a = 1;
+		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
 		devctl |= MUSB_DEVCTL_SESSION;
 
 		MUSB_HST_MODE(musb);
@@ -174,8 +174,8 @@ static void omap_set_vbus(struct musb *m
 		 * jumping right to B_IDLE...
 		 */
 
-		musb->xceiv.default_a = 0;
-		musb->xceiv.state = OTG_STATE_B_IDLE;
+		musb->xceiv->default_a = 0;
+		musb->xceiv->state = OTG_STATE_B_IDLE;
 		devctl &= ~MUSB_DEVCTL_SESSION;
 
 		MUSB_DEV_MODE(musb);
@@ -187,10 +187,6 @@ static void omap_set_vbus(struct musb *m
 		otg_state_string(musb),
 		musb_readb(musb->mregs, MUSB_DEVCTL));
 }
-static int omap_set_power(struct otg_transceiver *x, unsigned mA)
-{
-	return 0;
-}
 
 static int musb_platform_resume(struct musb *musb);
 
@@ -203,10 +199,10 @@ void musb_platform_set_mode(struct musb 
 
 	switch (musb_mode) {
 	case MUSB_HOST:
-		otg_set_host(&musb->xceiv, musb->xceiv.host);
+		otg_set_host(musb->xceiv, musb->xceiv->host);
 		break;
 	case MUSB_PERIPHERAL:
-		otg_set_peripheral(&musb->xceiv, musb->xceiv.gadget);
+		otg_set_peripheral(musb->xceiv, musb->xceiv->gadget);
 		break;
 	case MUSB_OTG:
 		break;
@@ -222,7 +218,7 @@ int __init musb_platform_init(struct mus
 	omap_cfg_reg(AE5_2430_USB0HS_STP);
 #endif
 
-	musb->xceiv = *x;
+	musb->xceiv = x;
 	musb_platform_resume(musb);
 
 	l = omap_readl(OTG_SYSCONFIG);
@@ -249,8 +245,6 @@ int __init musb_platform_init(struct mus
 
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = omap_set_vbus;
-	if (is_peripheral_enabled(musb))
-		musb->xceiv.set_power = omap_set_power;
 	musb->a_wait_bcon = MUSB_TIMEOUT_A_WAIT_BCON;
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
@@ -274,8 +268,7 @@ int musb_platform_suspend(struct musb *m
 	l |= ENABLEWAKEUP;	/* enable wakeup */
 	omap_writel(l, OTG_SYSCONFIG);
 
-	if (musb->xceiv.set_suspend)
-		musb->xceiv.set_suspend(&musb->xceiv, 1);
+	otg_set_suspend(musb->xceiv, 1);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 0);
@@ -292,8 +285,7 @@ static int musb_platform_resume(struct m
 	if (!musb->clock)
 		return 0;
 
-	if (musb->xceiv.set_suspend)
-		musb->xceiv.set_suspend(&musb->xceiv, 0);
+	otg_set_suspend(musb->xceiv, 0);
 
 	if (musb->set_clock)
 		musb->set_clock(musb->clock, 1);
--- a/drivers/usb/musb/tusb6010.c
+++ b/drivers/usb/musb/tusb6010.c
@@ -270,7 +270,7 @@ void musb_read_fifo(struct musb_hw_ep *h
  */
 static int tusb_draw_power(struct otg_transceiver *x, unsigned mA)
 {
-	struct musb	*musb = container_of(x, struct musb, xceiv);
+	struct musb	*musb = container_of(x, struct musb, otg);
 	void __iomem	*tbase = musb->ctrl_base;
 	u32		reg;
 
@@ -420,7 +420,7 @@ static void musb_do_idle(unsigned long _
 
 	spin_lock_irqsave(&musb->lock, flags);
 
-	switch (musb->xceiv.state) {
+	switch (musb->otg.state) {
 	case OTG_STATE_A_WAIT_BCON:
 		if ((musb->a_wait_bcon != 0)
 			&& (musb->idle_timeout == 0
@@ -484,7 +484,7 @@ void musb_platform_try_idle(struct musb 
 
 	/* Never idle if active, or when VBUS timeout is not set as host */
 	if (musb->is_active || ((musb->a_wait_bcon == 0)
-			&& (musb->xceiv.state == OTG_STATE_A_WAIT_BCON))) {
+			&& (musb->otg.state == OTG_STATE_A_WAIT_BCON))) {
 		DBG(4, "%s active, deleting timer\n", otg_state_string(musb));
 		del_timer(&musb_idle_timer);
 		last_timer = jiffies;
@@ -533,8 +533,8 @@ static void tusb_source_power(struct mus
 		if (musb->set_clock)
 			musb->set_clock(musb->clock, 1);
 		timer = OTG_TIMER_MS(OTG_TIME_A_WAIT_VRISE);
-		musb->xceiv.default_a = 1;
-		musb->xceiv.state = OTG_STATE_A_WAIT_VRISE;
+		musb->otg.default_a = 1;
+		musb->otg.state = OTG_STATE_A_WAIT_VRISE;
 		devctl |= MUSB_DEVCTL_SESSION;
 
 		conf |= TUSB_DEV_CONF_USB_HOST_MODE;
@@ -547,24 +547,24 @@ static void tusb_source_power(struct mus
 		/* If ID pin is grounded, we want to be a_idle */
 		otg_stat = musb_readl(tbase, TUSB_DEV_OTG_STAT);
 		if (!(otg_stat & TUSB_DEV_OTG_STAT_ID_STATUS)) {
-			switch (musb->xceiv.state) {
+			switch (musb->otg.state) {
 			case OTG_STATE_A_WAIT_VRISE:
 			case OTG_STATE_A_WAIT_BCON:
-				musb->xceiv.state = OTG_STATE_A_WAIT_VFALL;
+				musb->otg.state = OTG_STATE_A_WAIT_VFALL;
 				break;
 			case OTG_STATE_A_WAIT_VFALL:
-				musb->xceiv.state = OTG_STATE_A_IDLE;
+				musb->otg.state = OTG_STATE_A_IDLE;
 				break;
 			default:
-				musb->xceiv.state = OTG_STATE_A_IDLE;
+				musb->otg.state = OTG_STATE_A_IDLE;
 			}
 			musb->is_active = 0;
-			musb->xceiv.default_a = 1;
+			musb->otg.default_a = 1;
 			MUSB_HST_MODE(musb);
 		} else {
 			musb->is_active = 0;
-			musb->xceiv.default_a = 0;
-			musb->xceiv.state = OTG_STATE_B_IDLE;
+			musb->otg.default_a = 0;
+			musb->otg.state = OTG_STATE_B_IDLE;
 			MUSB_DEV_MODE(musb);
 		}
 
@@ -672,7 +672,7 @@ tusb_otg_ints(struct musb *musb, u32 int
 		else
 			default_a = is_host_enabled(musb);
 		DBG(2, "Default-%c\n", default_a ? 'A' : 'B');
-		musb->xceiv.default_a = default_a;
+		musb->otg.default_a = default_a;
 		tusb_source_power(musb, default_a);
 
 		/* Don't allow idling immediately */
@@ -684,7 +684,7 @@ tusb_otg_ints(struct musb *musb, u32 int
 	if (int_src & TUSB_INT_SRC_VBUS_SENSE_CHNG) {
 
 		/* B-dev state machine:  no vbus ~= disconnect */
-		if ((is_otg_enabled(musb) && !musb->xceiv.default_a)
+		if ((is_otg_enabled(musb) && !musb->otg.default_a)
 				|| !is_host_enabled(musb)) {
 #ifdef CONFIG_USB_MUSB_HDRC_HCD
 			/* ? musb_root_disconnect(musb); */
@@ -699,9 +699,9 @@ tusb_otg_ints(struct musb *musb, u32 int
 
 			if (otg_stat & TUSB_DEV_OTG_STAT_SESS_END) {
 				DBG(1, "Forcing disconnect (no interrupt)\n");
-				if (musb->xceiv.state != OTG_STATE_B_IDLE) {
+				if (musb->otg.state != OTG_STATE_B_IDLE) {
 					/* INTR_DISCONNECT can hide... */
-					musb->xceiv.state = OTG_STATE_B_IDLE;
+					musb->otg.state = OTG_STATE_B_IDLE;
 					musb->int_usb |= MUSB_INTR_DISCONNECT;
 				}
 				musb->is_active = 0;
@@ -715,7 +715,7 @@ tusb_otg_ints(struct musb *musb, u32 int
 			DBG(2, "vbus change, %s, otg %03x\n",
 				otg_state_string(musb), otg_stat);
 
-			switch (musb->xceiv.state) {
+			switch (musb->otg.state) {
 			case OTG_STATE_A_IDLE:
 				DBG(2, "Got SRP, turning on VBUS\n");
 				musb_set_vbus(musb, 1);
@@ -763,7 +763,7 @@ tusb_otg_ints(struct musb *musb, u32 int
 
 		DBG(4, "%s timer, %03x\n", otg_state_string(musb), otg_stat);
 
-		switch (musb->xceiv.state) {
+		switch (musb->otg.state) {
 		case OTG_STATE_A_WAIT_VRISE:
 			/* VBUS has probably been valid for a while now,
 			 * but may well have bounced out of range a bit
@@ -775,7 +775,7 @@ tusb_otg_ints(struct musb *musb, u32 int
 					DBG(2, "devctl %02x\n", devctl);
 					break;
 				}
-				musb->xceiv.state = OTG_STATE_A_WAIT_BCON;
+				musb->otg.state = OTG_STATE_A_WAIT_BCON;
 				musb->is_active = 0;
 				idle_timeout = jiffies
 					+ msecs_to_jiffies(musb->a_wait_bcon);
@@ -1128,10 +1128,12 @@ int __init musb_platform_init(struct mus
 	}
 	musb->isr = tusb_interrupt;
 
+	musb->xceiv = &musb->otg;
+
 	if (is_host_enabled(musb))
 		musb->board_set_vbus = tusb_source_power;
 	if (is_peripheral_enabled(musb))
-		musb->xceiv.set_power = tusb_draw_power;
+		musb->otg.set_power = tusb_draw_power;
 
 	setup_timer(&musb_idle_timer, musb_do_idle, (unsigned long) musb);
 


