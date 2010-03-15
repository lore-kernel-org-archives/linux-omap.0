From: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH 1/2] musb: add musb support for AM35x
Date: Mon, 15 Mar 2010 10:40:33 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044DD3311F@dbde02.ent.ti.com>
References: <1267017527-17591-1-git-send-email-ajay.gupta@ti.com>
 <4B9A560B.7010908@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4B9A560B.7010908-hkdhdckH98+B+jHODAdFcQ@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sshtylyov-Igf4POYTYCDQT0dZR+AlfA@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Hi,
> > AM35x has musb interface and uses CPPI4.1 DMA engine.
> > Current patch supports only PIO mode and there are on-going
> > discussions on location of CPPI4.1 DMA.
> >
> > Signed-off-by: Ajay Kumar Gupta <ajay.gupta-l0cyMroinI0@public.gmane.org>
> >  	tristate 'Inventra Highspeed Dual Role Controller (TI, ADI, ...)'
> > @@ -140,7 +140,7 @@ config USB_MUSB_HDRC_HCD
> >  config MUSB_PIO_ONLY
> >  	bool 'Disable DMA (always use PIO)'
> >  	depends on USB_MUSB_HDRC
> > -	default y if USB_TUSB6010
> > +	default USB_TUSB6010 || MACH_OMAP3517EVM
> >  	help
> >  	  All data is copied between memory and FIFO by the CPU.
> >  	  DMA controllers are ignored.
> > diff --git a/drivers/usb/musb/Makefile b/drivers/usb/musb/Makefile
> > index 85710cc..9263033 100644
> > --- a/drivers/usb/musb/Makefile
> > +++ b/drivers/usb/musb/Makefile
> > @@ -19,7 +19,11 @@ ifeq ($(CONFIG_ARCH_OMAP2430),y)
> >  endif
> >
> >  ifeq ($(CONFIG_ARCH_OMAP3430),y)
> > +   ifeq ($(CONFIG_MACH_OMAP3517EVM),y)
> > +	musb_hdrc-objs  += am3517.o
> >
> 
>    Isn't there some ARCH-level option for AM3517 SoC? Depending on the
> board type doesn't really scale well...

AM3517 is actually based on OMAP3 but musb is different. Unfortunately there
is no seperate *_ARCH_* defines for AM3517 alone.

> > + * AM3517 specific definitions
> > + */
> > +
> > +/* CPPI 4.1 queue manager registers */
> > +#define QMGR_PEND0_REG		0x4090
> > +#define QMGR_PEND1_REG		0x4094
> > +#define QMGR_PEND2_REG		0x4098
> >
> 
>    Those are not used (yet)...

Yes, but I added them as they are part of register layout.

> 
> > +static inline void phy_on(void)
> > +{
> > +	u32 devconf2;
> > +
> > +	/*
> > +	 * Start the on-chip PHY and its PLL.
> > +	 */
> > +	devconf2 = omap_ctrl_readl(AM35XX_CONTROL_DEVCONF2);
> > +
> > +	devconf2 &= ~(CONF2_RESET | CONF2_PHYPWRDN | CONF2_OTGPWRDN |
> > +			CONF2_OTGMODE | CONF2_REFFREQ | CONF2_PHY_GPIOMODE);
> >
> 
>    Shouldn't you manipulate CONF2_OTGMODE in the board code instead? I
> suspect value of 0 doesn't fit the host-only configuration (without
> cable connected, MUSB will think it's a B-device, and the driver will
> fail to initialize IIRC).

I didn't see any issue in Host/Device only and OTG mode configurations
On AM3517? Did you see any issue on DA8xx?

> 
> > +	devconf2 |= CONF2_SESENDEN | CONF2_VBDTCTEN | CONF2_PHY_PLLON |
> > +		    CONF2_REFFREQ_13MHZ | CONF2_DATPOL;
> >
> 
>    Reference clock of 13 MHz, not 12? Hmm... Again, shouldn't the board
> code select the reference frequency (clock might be external, IIUC)?

Yeah, it's 13Mhz.Clock setting from board would be good to have though
Currently there is only one board AM3517EVM.
  
> > +/**
> > + * musb_platform_enable - enable interrupts
> > + */
> > +void musb_platform_enable(struct musb *musb)
> > +{
> > +	void __iomem *reg_base = musb->ctrl_base;
> > +	u32 epmask, coremask;
> > +
> > +	/* Workaround: setup IRQs through both register sets. */
> > +	epmask = ((musb->epmask & AM3517_TX_EP_MASK) << USB_INTR_TX_SHIFT) |
> > +	       ((musb->epmask & AM3517_RX_EP_MASK) << USB_INTR_RX_SHIFT);
> > +	coremask = (0x01ff << USB_INTR_USB_SHIFT);
> > +
> > +	musb_writel(reg_base, EP_INTR_MASK_SET_REG, epmask);
> > +	musb_writel(reg_base, CORE_INTR_MASK_SET_REG, coremask);
> >
> 
>    Hm, and I thought all CPPI 4.1 based controllers have the same
> register layout... alas, I was wrong.

There are changes as AM3517 supports 15Rx/Tx endpoints.

> 
> > +static int vbus_state = -1;
> >
> [...]
> > +static void am3517_source_power(struct musb *musb, int is_on, int
> immediate)
> > +{
> > +	if (is_on)
> > +		is_on = 1;
> > +
> > +	if (vbus_state == is_on)
> > +		return;
> > +	vbus_state = is_on;
> > +}
> > +
> >
> 
>    Without the real GPIOs to manipulate, I don't understand the purpose
> of this function...

Correct, this function can be removed.

> 
> > +static struct timer_list otg_workaround;
> > +
> > +static void otg_timer(unsigned long _musb)
> > +{
> > +	struct musb		*musb = (void *)_musb;
> > +	void __iomem		*mregs = musb->mregs;
> > +	u8			devctl;
> > +	unsigned long		flags;
> > +
> > +	/* We poll because AM3517's won't expose several OTG-critical
> > +	* status change events (from the transceiver) otherwise.
> >
> 
>    Need one more space before *...

Right.

> 
> > +	case OTG_STATE_A_WAIT_VFALL:
> > +		/*
> > +		 * Wait till VBUS falls below SessionEnd (~0.2 V); the 1.3
> > +		 * RTL seems to mis-handle session "start" otherwise (or in
> > +		 * our case "recover"), in routine "VBUS was valid by the time
> > +		 * VBUSERR got reported during enumeration" cases.
> > +		 */
> >
> 
>    I wonder if all this still true for RTL 1.8 on which DA8xx (and
> probably AM3517) MUSB is based...

Need to check on this..though I didn't see any issue in my testing.

> 
> > +void musb_platform_try_idle(struct musb *musb, unsigned long timeout)
> > +{
> >
> 
>    I wonder how DaVinci gets about without musb_platfrom_try_idle()...

Hmm..
> 
> > +static irqreturn_t am3517_interrupt(int irq, void *hci)
> > +{
> 
> > +		/* NOTE: this must complete power-on within 100 ms. */
> > +		am3517_source_power(musb, drvvbus, 0);
> >
> 
>    This call is effectively a NOP.

Yes and so should be removed.

> 
> > +	if (musb->int_tx || musb->int_rx || musb->int_usb) {
> > +		irqreturn_t mret;
> > +
> > +		mret = musb_interrupt(musb);
> > +		if (mret == IRQ_HANDLED)
> > +			ret = IRQ_HANDLED;
> >
> 
>    Not sure why you didn't like ret |= musb_interrupt(musb)...

Need to verify/clean it. I remember, was getting some issue initially
On this path.

> 
> > +	if (ret != IRQ_HANDLED) {
> > +		if (epintr || usbintr)
> > +			/*
> > +			 * We sometimes get unhandled IRQs in the peripheral
> > +			 * mode from EP0 and SOF...
> > +			 */
> > +			DBG(2, "Unhandled USB IRQ %08x-%08x\n",
> > +					 epintr, usbintr);
> >
> 
>    This check shouldn't be needed any more -- EP0 spurious interrupts
> have been all chased down...

Ok fine.
> 
> > +		else if (printk_ratelimit())
> > +			/*
> > +			 * We've seen series of spurious interrupts in the
> > +			 * peripheral mode after USB reset and then after some
> > +			 * time a real interrupt storm starting...
> > +			 */
> > +			DBG(2, "Spurious IRQ\n");
> >
> 
>    Those turned out to be interrupts caused by CPPI 4.1 descriptor
> starvation (for which the controller didn't even have an interrupt bit).
> I still haven't dealt with them...

and.. AM3517 has got a bit to disable them, anyways this patch currently
supports PIO only so this check can be removed also.

> 
> > +	}
> > +	return ret;
> > +}
> > +
> > +int musb_platform_set_mode(struct musb *musb, u8 musb_mode)
> > +{
> > +	WARNING("FIXME: %s not implemented\n", __func__);
> > +	return -EIO;
> >
> 
>    Could be implemented using CONF2_OTGMODE...

Ok fine.

> 
> > +int __init musb_platform_init(struct musb *musb)
> > +{
> > +	void __iomem *reg_base = musb->ctrl_base;
> > +	struct clk              *otg_fck;
> > +	u32 rev, lvl_intr, sw_reset;
> > +
> > +	usb_nop_xceiv_register();
> > +
> > +	musb->xceiv = otg_get_transceiver();
> > +	if (!musb->xceiv)
> > +		return -ENODEV;
> > +
> > +	/* Mentor is at offset of 0x400 in AM3517 */
> > +	musb->mregs += USB_MENTOR_CORE_OFFSET;
> > +
> > +	/* musb->clock is already set from board/arch files */
> > +	if (IS_ERR(musb->clock))
> > +		return PTR_ERR(musb->clock);
> >
> 
>   This is checked by musb_core.c now, no need to duplicate...

Ok fine.

> 
> > +	if (musb->set_clock)
> > +		musb->set_clock(musb->clock, 1);
> >
> 
>    musb->set_clock() is about to be dropped...

So there is 'else' part.
> 
> > +	else
> > +		clk_enable(musb->clock);
> > +
> > +	DBG(2, "usbotg_ck=%lud\n", clk_get_rate(musb->clock));
> >
> 
>    I'd put an empty line after that DBG() rather than before.
Ok fine.

> 
> > +	otg_fck = clk_get(musb->controller, "fck");
> > +	clk_enable(otg_fck);
> >
> 
>    Oh, it needs two clocks... Another argument against Felipe dropping
> plat->clock. :-)

..

> 
> > +
> > +	DBG(2, "usbotg_phy_ck=%lud\n", clk_get_rate(otg_fck));
> >
> 
>    Same about empty line here...
> 
> > +	am3517_source_power(musb, 0, 1);
> >
> 
>    Effective NOP...

So need to remove.

> 
> > +	/* Start the on-chip PHY and its PLL. */
> > +	phy_on();
> > +
> > +	msleep(15);
> >
> 
>    5 ms is not enough?

Need to test and correct.

> 
> > +	musb->a_wait_bcon = A_WAIT_BCON_TIMEOUT;
> >
> 
>    Hm... that line kept causing a stream of kernel messages for me,
> until I removed it. Doesn't it for you?

No I didn't get any error messages.. what messages were you getting ?

> 
> > diff --git a/drivers/usb/musb/musb_core.c b/drivers/usb/musb/musb_core.c
> > index 98fd5b6..f8efe00 100644
> > --- a/drivers/usb/musb/musb_core.c
> > +++ b/drivers/usb/musb/musb_core.c
> > @@ -982,7 +982,8 @@ static void musb_shutdown(struct platform_device
> *pdev)
> >   * more than selecting one of a bunch of predefined configurations.
> >   */
> >  #if defined(CONFIG_USB_TUSB6010) || \
> > -	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3)
> > +	defined(CONFIG_ARCH_OMAP2430) || defined(CONFIG_ARCH_OMAP3) || \
> > +	defined(CONFIG_MACH_OMAP3517EVM)
> >
> 
>    Isn't that dependency already covered by CONFIG_ARCH_OMAP3? Or else I
> don't see you adding your #ifdef around musb_platfrom_try_idle()
> declaration...

Right..this can be removed.

> +int musb_platform_exit(struct musb *musb) {
>   
[...]
> +	phy_off();
> +
> +	usb_nop_xceiv_unregister();
> +
> +	return 0;
>   

>>   You forgot the calls to clk_disable() for both your clocks...

Ok fine..need to correct.

Thanks,
Ajay
> 
> WBR, Sergei

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
