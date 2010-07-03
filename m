From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH resend 2/3] musb: add musb support for AM35x
Date: Sat, 3 Jul 2010 08:54:28 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAAD82A@dbde02.ent.ti.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <1278053879-6850-2-git-send-email-ajay.gupta@ti.com>
 <4C2DD9B6.4000401@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33962 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754714Ab0GCDYm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Jul 2010 23:24:42 -0400
In-Reply-To: <4C2DD9B6.4000401@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>

> > +#define USB_SOFT_RESET_MASK	1
> 
>     Need a empty line here.

Hmm, ok.
> 
> > +#define A_WAIT_BCON_TIMEOUT	1100		/* in ms */
> 
>     I think this #define should be dropped -- see below...
> 
> > +{
> > +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> > +	u32 devconf2;
> > +
> > +	/*
> > +	 * Start the on-chip PHY and its PLL.
> > +	 */
> > +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > +
> > +	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN |
> > +			CONF2_PHY_GPIOMODE);
> 
>     BWT, what's thet GPIOMODE bit for?
If GPIO Mode is set to '1' then UART3 Tx/Rx would come on DP and
DM pins of USBPHY.

> 
> > +	devconf2 |= CONF2_PHY_PLLON | CONF2_DATPOL;
> 
>     So, AM35x always uses the reversed data polarity?

It's getting set to '1' so its always normal polarity.

> 
> > +static void otg_timer(unsigned long _musb)
> > +{
> > +	struct musb		*musb = (void *)_musb;
> > +	void __iomem		*mregs = musb->mregs;
> > +	u8			devctl;
> > +	unsigned long		flags;
> > +
> > +	/*
> > +	 * We poll because AM35x's won't expose several OTG-critical
> > +	 * status change events (from the transceiver) otherwise.
> > +	 */
> > +	devctl = musb_readb(mregs, MUSB_DEVCTL);
> > +	DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
> > +	switch (musb->xceiv->state) {
> [...]
> > +	case OTG_STATE_A_WAIT_VFALL:
> 
>     So, are you sure there's no need to call mod_timer() here for RTL 1.8?
What issue did you see on earlier RTLs ? As such I didn't see issue
In my normal testing.

> 
> > +		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
> > +		musb_writel(musb->ctrl_base, CORE_INTR_SRC_SET_REG,
> > +			    MUSB_INTR_VBUSERROR << USB_INTR_USB_SHIFT);
> > +		break;
> > +	case OTG_STATE_B_IDLE:
> > +		if (!is_peripheral_enabled(musb))
> > +			break;
> 
>     Hm, davinci.c sets DevCtl.Session here and I'm also doing it in
> da8xx.c --
> can you comment why you don't do that too?
I remember this was causing some issue in OTG testing.

> 
> > +		devctl = musb_readb(mregs, MUSB_DEVCTL);
> > +		if (devctl & MUSB_DEVCTL_BDEVICE)
> > +			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
> > +		else
> > +			musb->xceiv->state = OTG_STATE_A_IDLE;
> > +		break;
> 
> [...]
> 
> > +static irqreturn_t am35x_interrupt(int irq, void *hci)
> > +{
> > +	struct musb  *musb = hci;
> > +	void __iomem *reg_base = musb->ctrl_base;
> > +	unsigned long flags;
> > +	irqreturn_t ret = IRQ_NONE;
> > +	u32 epintr, usbintr, lvl_intr;
> > +
> > +	spin_lock_irqsave(&musb->lock, flags);
> > +
> > +	/* Get endpoint interrupts */
> > +	epintr = musb_readl(reg_base, EP_INTR_SRC_MASKED_REG);
> > +
> > +	if (epintr) {
> > +		musb_writel(reg_base, EP_INTR_SRC_CLEAR_REG, epintr);
> > +
> > +		musb->int_rx =
> > +			(epintr & AM35X_RX_INTR_MASK) >> USB_INTR_RX_SHIFT;
> > +		musb->int_tx =
> > +			(epintr & AM35X_TX_INTR_MASK) >> USB_INTR_TX_SHIFT;
> > +	}
> 
>     Perhaps this should be placed after the following check...
Hmm, ok.

> 
> > +	/* Get usb core interrupts */
> > +	usbintr = musb_readl(reg_base, CORE_INTR_SRC_MASKED_REG);
> > +	if (!usbintr && !epintr)
> > +		goto eoi;
> > +
> > +	if (usbintr) {
> > +		musb_writel(reg_base, CORE_INTR_SRC_CLEAR_REG, usbintr);
> > +
> > +		musb->int_usb =
> > +			(usbintr & USB_INTR_USB_MASK) >> USB_INTR_USB_SHIFT;
> > +	}
> [...]
> > +	if (usbintr & (USB_INTR_DRVVBUS << USB_INTR_USB_SHIFT)) {
> > +		int drvvbus = musb_readl(reg_base, USB_STAT_REG);
> > +		void __iomem *mregs = musb->mregs;
> > +		u8 devctl = musb_readb(mregs, MUSB_DEVCTL);
> > +		int err;
> [...]
> > +		} else if (is_host_enabled(musb) && drvvbus) {
> > +			musb->is_active = 1;
> 
>     I dropped this line from da8xx.c as per this change to davinci.c:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=89368d3d11a5b2eff83ad8e752be67f77a372bad
Would test on this.

> 
> [...]
> 
> > +int __init musb_platform_init(struct musb *musb, void *board_data)
> > +{
> > +	void __iomem *reg_base = musb->ctrl_base;
> > +	struct clk              *otg_fck;
> > +	u32 rev, lvl_intr, sw_reset;
> > +
> > +	musb->mregs += USB_MENTOR_CORE_OFFSET;
> > +
> > +	if (musb->set_clock)
> > +		musb->set_clock(musb->clock, 1);
> > +	else
> > +		clk_enable(musb->clock);
> > +	DBG(2, "usbotg_ck=%lud\n", clk_get_rate(musb->clock));
> > +
> > +	otg_fck = clk_get(musb->controller, "fck");
> 
>     Can't this fail?

Yup, need to correct.
> 
> > +	clk_enable(otg_fck);
> > +	DBG(2, "usbotg_phy_ck=%lud\n", clk_get_rate(otg_fck));
> > +
> > +	/* Returns zero if e.g. not clocked */
> > +	rev = musb_readl(reg_base, USB_REVISION_REG);
> > +	if (!rev)
> > +		return -ENODEV;
> 
>     You forgot to disable the clocks you just enabled above.
> 
> > +	usb_nop_xceiv_register();
> > +	musb->xceiv = otg_get_transceiver();
> > +	if (!musb->xceiv)
> > +		return -ENODEV;
> 
>     Ditto.
> 
> > +	musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;
> 
>     This field is set by musb_core.c, so I dropped this line from
> da8xx.c...

Need to test again but I was facing a issue where OTG build image
Was either working in host only mode or device only. Role were
Not changing based on ID pin status.

> 
> > +int musb_platform_exit(struct musb *musb)
> > +{
> > +	struct clk *otg_fck = clk_get(musb->controller, "fck");
> > +
> > +	if (is_host_enabled(musb))
> > +		del_timer_sync(&otg_workaround);
> > +
> > +	/* Delay to avoid problems with module reload... */
> 
>     Are you sure this is needed? For DA8xx, I'm not sure: at least in host
> mode it just causes pointless delay for me (VBUS comparator is overridden
> in
> host mode); I was unable to test the OTG mode properly -- for some reason
> USB
> device didn't get recongnized and VBUS has probably stayed low.

I need to check on this, I guess it's not required though I have tested
OTG also on AM3517EVM.

> 
> > +	if (is_host_enabled(musb) && musb->xceiv->default_a) {
> > +		u8 devctl, warn = 0;
> > +		int delay;
> > +
> > +		/*
> > +		 * If there's no peripheral connected, VBUS can take a
> > +		 * long time to fall...
> > +		 */
> 
>     Well, if you have a large capacitor on VBUS... DA8xx seems to have one
> (as
> I was unable to get the disconnect interrupts in the gadget mode), so
> probably
> the delay is still needed... don't know about your board.

Will test and update.

> 
> > +		for (delay = 30; delay > 0; delay--) {
> > +			devctl = musb_readb(musb->mregs, MUSB_DEVCTL);
> > +			if (!(devctl & MUSB_DEVCTL_VBUS))
> > +				goto done;
> > +			if ((devctl & MUSB_DEVCTL_VBUS) != warn) {
> > +				warn = devctl & MUSB_DEVCTL_VBUS;
> > +				DBG(1, "VBUS %d\n",
> > +					warn >> MUSB_DEVCTL_VBUS_SHIFT);
> > +			}
> > +			msleep(1000);
> > +		}
> > +
> > +		/* In OTG mode, another host might be connected... */
> > +		DBG(1, "VBUS off timeout (devctl %02x)\n", devctl);
> > +	}
> > +	if (otg_fck) {
> 
>     musb_platfrom_init() suggests that otg_fck can't be NULL. Also,
> clk_get
> returns error code, not NULL, so should use IS_ERR() here.
Correct, would clean it.

Thanks,
Ajay
> 
> > +		clk_put(otg_fck);
> > +		clk_disable(otg_fck);
> > +	}
> > +
> > +	return 0;
> > +}
> 
> WBR, Sergei
