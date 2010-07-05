From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH resend 2/3] musb: add musb support for AM35x
Date: Mon, 5 Jul 2010 17:16:38 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044EAAD8F5@dbde02.ent.ti.com>
References: <1278053879-6850-1-git-send-email-ajay.gupta@ti.com>
 <1278053879-6850-2-git-send-email-ajay.gupta@ti.com>
 <4C2DD9B6.4000401@ru.mvista.com>
 <19F8576C6E063C45BE387C64729E7394044EAAD82A@dbde02.ent.ti.com>
 <4C2F3564.8030103@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42565 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752837Ab0GELqt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Jul 2010 07:46:49 -0400
In-Reply-To: <4C2F3564.8030103@ru.mvista.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>


Hi,
> >>> +{
> >>> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
> >>> +	u32 devconf2;
> >>> +
> >>> +	/*
> >>> +	 * Start the on-chip PHY and its PLL.
> >>> +	 */
> >>> +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> >>> +
> >>> +	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN |
> >>> +			CONF2_PHY_GPIOMODE);
> 
> >>     BWT, what's thet GPIOMODE bit for?
> 
> > If GPIO Mode is set to '1' then UART3 Tx/Rx would come on DP and
> > DM pins of USBPHY.
> 
>     Hm, why GPIOMODE then I wonder... :-)
> 
> >>> +	devconf2 |= CONF2_PHY_PLLON | CONF2_DATPOL;
> 
> >>     So, AM35x always uses the reversed data polarity?
> 
> > It's getting set to '1' so its always normal polarity.
> 
>     Ah, I got it reversed: 1 means normal polarity indeed...

I think, this would again be dependent on boards and therefore
should be moved to board file.

> 
> >>> +static void otg_timer(unsigned long _musb)
> >>> +{
> >>> +	struct musb		*musb = (void *)_musb;
> >>> +	void __iomem		*mregs = musb->mregs;
> >>> +	u8			devctl;
> >>> +	unsigned long		flags;
> >>> +
> >>> +	/*
> >>> +	 * We poll because AM35x's won't expose several OTG-critical
> >>> +	 * status change events (from the transceiver) otherwise.
> >>> +	 */
> >>> +	devctl = musb_readb(mregs, MUSB_DEVCTL);
> >>> +	DBG(7, "Poll devctl %02x (%s)\n", devctl, otg_state_string(musb));
> >>> +
> >>> +	spin_lock_irqsave(&musb->lock, flags);
> >>> +	switch (musb->xceiv->state) {
> 
> >> [...]
> 
> >>> +	case OTG_STATE_A_WAIT_VFALL:
> 
> >>     So, are you sure there's no need to call mod_timer() here for RTL
> 1.8?
> 
> > What issue did you see on earlier RTLs ?
> 
>     I didn't test DaVinci much; I didn't even test DA8xx much in OTG mode.
> :-/
> And in the DA8xx host mode VBUS error would never occur anyway (as the
> VBUS
> comparator is overridden on the EVM board).
> 
> > As such I didn't see issue
> > In my normal testing.
> 
>     OK.
> 
> >>> +		musb->xceiv->state = OTG_STATE_A_WAIT_VRISE;
> >>> +		musb_writel(musb->ctrl_base, CORE_INTR_SRC_SET_REG,
> >>> +			    MUSB_INTR_VBUSERROR << USB_INTR_USB_SHIFT);
> >>> +		break;
> >>> +	case OTG_STATE_B_IDLE:
> >>> +		if (!is_peripheral_enabled(musb))
> >>> +			break;
> 
> >>     Hm, davinci.c sets DevCtl.Session here and I'm also doing it in
> >> da8xx.c --
> >> can you comment why you don't do that too?
> 
> > I remember this was causing some issue in OTG testing.
> 
>     Do you remember which issue?
>     Although I suspect that this code might be related to the comment
> below:
> "DEVCTL.BDEVICE is invalid without DEVCTL.SESSION set".

I will test again and then provide the details. I too feel it has something
to do with the comment you pointed out.

> 
> >>> +		devctl = musb_readb(mregs, MUSB_DEVCTL);
> >>> +		if (devctl & MUSB_DEVCTL_BDEVICE)
> >>> +			mod_timer(&otg_workaround, jiffies + POLL_SECONDS * HZ);
> >>> +		else
> >>> +			musb->xceiv->state = OTG_STATE_A_IDLE;
> >>> +		break;
> 
> >> [...]
> 
> >>> +	musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;
> 
> >>     This field is set by musb_core.c, so I dropped this line from
> >> da8xx.c...
> 
>     This has also been dropped from omap2430.c by this commit:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-
> 2.6.git;a=commit;h=f7f9d63eac12b345d6243d1d608b7944a05be921
> 
> > Need to test again but I was facing a issue where OTG build image
> > Was either working in host only mode or device only. Role were
> > Not changing based on ID pin status.
> 
>     Hm, is this related?

Not really but let me test again and get the details.

> 
> >>> +int musb_platform_exit(struct musb *musb)
> >>> +{
> >>> +	struct clk *otg_fck = clk_get(musb->controller, "fck");
> >>> +
> >>> +	if (is_host_enabled(musb))
> >>> +		del_timer_sync(&otg_workaround);
> >>> +
> >>> +	/* Delay to avoid problems with module reload... */
> 
[..]
> 
> >>     musb_platfrom_init() suggests that otg_fck can't be NULL. Also,
> >> clk_get
> >> returns error code, not NULL, so should use IS_ERR() here.
> 
> > Correct, would clean it.
> 
>     Also, you call clk_get() on this clock twice, in musb_platfrom_init()
> and
> here, but clk_put() only once.

Ok fine.

Thanks,
Ajay
> 
> > Thanks,
> > Ajay
> 
> WBR, Sergei

