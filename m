From: "Gupta, Ajay Kumar" <ajay.gupta@ti.com>
Subject: RE: [PATCH 2/3 v3] musb: Add context save and restore support
Date: Thu, 17 Dec 2009 19:21:41 +0530
Message-ID: <19F8576C6E063C45BE387C64729E73940449F439C7@dbde02.ent.ti.com>
References: <1260797982-28880-1-git-send-email-ajay.gupta@ti.com>
 <1260797982-28880-2-git-send-email-ajay.gupta@ti.com>
 <4B2A3453.7040008@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:48319 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750859AbZLQNvv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Dec 2009 08:51:51 -0500
In-Reply-To: <4B2A3453.7040008@nokia.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnaud Mandy <ext-arnaud.2.mandy@nokia.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Balbi Felipe (Nokia-D/Helsinki)" <felipe.balbi@nokia.com>, "david-b@pacbell.net" <david-b@pacbell.net>, "Gadiyar, Anand" <gadiyar@ti.com>

<snip>
> >
> >  #ifdef CONFIG_PM
> >
> > +static struct musb_context_registers musb_context;
> > +
> > +void musb_save_context(struct musb *musb)
> > +{
> >
>
> Could you add one more parameter to this function call, which would
> select either if we want to save the musb_platform context or not?
> I m working at the moment on turning off the musb when cable unplugged
> and turning it on with restoring context after cable re-connect.
> In this case I don't need to restore the the musb_platform_context since
> I just set them before calling this one.
>
> Same apply for restore.
>
> what do you think?
> I could also modify slightly this implementation after it is ready and
> submit it.

I think you want to add the parameter in musb_platform_save_context()  and
not in musb_save_context.

If so then where do you restore them? {As you said before calling this}

I think if the requirement is generic and suits for all other platforms
Using musb then we can add it.

-Ajay
>
> > +       int i;
> > +       void __iomem *musb_base = musb->mregs;
> > +
> > +       if (is_host_enabled(musb)) {
> > +               musb_context.frame = musb_readw(musb_base, MUSB_FRAME);
> > +               musb_context.testmode = musb_readb(musb_base,
> MUSB_TESTMODE);
> > +       }
> > +       musb_context.power = musb_readb(musb_base, MUSB_POWER);
> > +       musb_context.intrtxe = musb_readw(musb_base, MUSB_INTRTXE);
> > +       musb_context.intrrxe = musb_readw(musb_base, MUSB_INTRRXE);
> > +       musb_context.intrusbe = musb_readb(musb_base, MUSB_INTRUSBE);
> > +       musb_context.index = musb_readb(musb_base, MUSB_INDEX);
> > +       musb_context.devctl = musb_readb(musb_base, MUSB_DEVCTL);
> > +
> > +       for (i = 0; i < MUSB_C_NUM_EPS; ++i) {
> > +               musb_writeb(musb_base, MUSB_INDEX, i);
> > +               musb_context.index_regs[i].txmaxp =
> > +                       musb_readw(musb_base, 0x10 + MUSB_TXMAXP);
> > +               musb_context.index_regs[i].txcsr =
> > +                       musb_readw(musb_base, 0x10 + MUSB_TXCSR);
> > +               musb_context.index_regs[i].rxmaxp =
> > +                       musb_readw(musb_base, 0x10 + MUSB_RXMAXP);
> > +               musb_context.index_regs[i].rxcsr =
> > +                       musb_readw(musb_base, 0x10 + MUSB_RXCSR);
> > +
> > +               if (musb->dyn_fifo) {
> > +                       musb_context.index_regs[i].txfifoadd =
> > +                                       musb_read_txfifoadd(musb_base);
> > +                       musb_context.index_regs[i].rxfifoadd =
> > +                                       musb_read_rxfifoadd(musb_base);
> > +                       musb_context.index_regs[i].txfifosz =
> > +                                       musb_read_txfifosz(musb_base);
> > +                       musb_context.index_regs[i].rxfifosz =
> > +                                       musb_read_rxfifosz(musb_base);
> > +               }
> > +               if (is_host_enabled(musb)) {
> > +                       musb_context.index_regs[i].txtype =
> > +                               musb_readb(musb_base, 0x10 +
> MUSB_TXTYPE);
> > +                       musb_context.index_regs[i].txinterval =
> > +                               musb_readb(musb_base, 0x10 +
> MUSB_TXINTERVAL);
> > +                       musb_context.index_regs[i].rxtype =
> > +                               musb_readb(musb_base, 0x10 +
> MUSB_RXTYPE);
> > +                       musb_context.index_regs[i].rxinterval =
> > +                               musb_readb(musb_base, 0x10 +
> MUSB_RXINTERVAL);
> > +
> > +                       musb_context.index_regs[i].txfunaddr =
> > +                               musb_read_txfunaddr(musb_base, i);
> > +                       musb_context.index_regs[i].txhubaddr =
> > +                               musb_read_txhubaddr(musb_base, i);
> > +                       musb_context.index_regs[i].txhubport =
> > +                               musb_read_txhubport(musb_base, i);
> > +
> > +                       musb_context.index_regs[i].rxfunaddr =
> > +                               musb_read_rxfunaddr(musb_base, i);
> > +                       musb_context.index_regs[i].rxhubaddr =
> > +                               musb_read_rxhubaddr(musb_base, i);
> > +                       musb_context.index_regs[i].rxhubport =
> > +                               musb_read_rxhubport(musb_base, i);
> > +               }
> > +       }
> > +
> > +       musb_writeb(musb_base, MUSB_INDEX, musb_context.index);
> > +
> > +       musb_platform_save_context(&musb_context);
> > +}
> > +
> > +void musb_restore_context(struct musb *musb)
> > +{
> > +       int i;
> > +       void __iomem *musb_base = musb->mregs;
> > +       void __iomem *ep_target_regs;
> > +
> > +       musb_platform_restore_context(&musb_context);
> > +
> > +       if (is_host_enabled(musb)) {
> > +               musb_writew(musb_base, MUSB_FRAME, musb_context.frame);
> > +               musb_writeb(musb_base, MUSB_TESTMODE,
> musb_context.testmode);
> > +       }
> > +       musb_writeb(musb_base, MUSB_POWER, musb_context.power);
> > +       musb_writew(musb_base, MUSB_INTRTXE, musb_context.intrtxe);
> > +       musb_writew(musb_base, MUSB_INTRRXE, musb_context.intrrxe);
> > +       musb_writeb(musb_base, MUSB_INTRUSBE, musb_context.intrusbe);
> > +       musb_writeb(musb_base, MUSB_DEVCTL, musb_context.devctl);
> > +
> > +       for (i = 0; i < MUSB_C_NUM_EPS; ++i) {
> > +               musb_writeb(musb_base, MUSB_INDEX, i);
> > +               musb_writew(musb_base, 0x10 + MUSB_TXMAXP,
> > +                       musb_context.index_regs[i].txmaxp);
> > +               musb_writew(musb_base, 0x10 + MUSB_TXCSR,
> > +                       musb_context.index_regs[i].txcsr);
> > +               musb_writew(musb_base, 0x10 + MUSB_RXMAXP,
> > +                       musb_context.index_regs[i].rxmaxp);
> > +               musb_writew(musb_base, 0x10 + MUSB_RXCSR,
> > +                       musb_context.index_regs[i].rxcsr);
> > +
> > +               if (musb->dyn_fifo) {
> > +                       musb_write_txfifosz(musb_base,
> > +                               musb_context.index_regs[i].txfifosz);
> > +                       musb_write_rxfifosz(musb_base,
> > +                               musb_context.index_regs[i].rxfifosz);
> > +                       musb_write_txfifoadd(musb_base,
> > +                               musb_context.index_regs[i].txfifoadd);
> > +                       musb_write_rxfifoadd(musb_base,
> > +                               musb_context.index_regs[i].rxfifoadd);
> > +               }
> > +
> > +               if (is_host_enabled(musb)) {
> > +                       musb_writeb(musb_base, 0x10 + MUSB_TXTYPE,
> > +                               musb_context.index_regs[i].txtype);
> > +                       musb_writeb(musb_base, 0x10 + MUSB_TXINTERVAL,
> > +                               musb_context.index_regs[i].txinterval);
> > +                       musb_writeb(musb_base, 0x10 + MUSB_RXTYPE,
> > +                               musb_context.index_regs[i].rxtype);
> > +                       musb_writeb(musb_base, 0x10 + MUSB_RXINTERVAL,
> > +
> > +                       musb_context.index_regs[i].rxinterval);
> > +                       musb_write_txfunaddr(musb_base, i,
> > +                               musb_context.index_regs[i].txfunaddr);
> > +                       musb_write_txhubaddr(musb_base, i,
> > +                               musb_context.index_regs[i].txhubaddr);
> > +                       musb_write_txhubport(musb_base, i,
> > +                               musb_context.index_regs[i].txhubport);
> > +
> > +                       ep_target_regs =
> > +                               musb_read_target_reg_base(i, musb_base);
> > +
> > +                       musb_write_rxfunaddr(ep_target_regs,
> > +                               musb_context.index_regs[i].rxfunaddr);
> > +                       musb_write_rxhubaddr(ep_target_regs,
> > +                               musb_context.index_regs[i].rxhubaddr);
> > +                       musb_write_rxhubport(ep_target_regs,
> > +                               musb_context.index_regs[i].rxhubport);
> > +               }
> > +       }
> > +
> > +       musb_writeb(musb_base, MUSB_INDEX, musb_context.index);
> > +}
> > +
> >  static int musb_suspend(struct device *dev)
> >  {
> >         struct platform_device *pdev = to_platform_device(dev);
> >         unsigned long   flags;
> >         struct musb     *musb = dev_to_musb(&pdev->dev);
> > +       u8 reg;
> >
> >         if (!musb->clock)
> >                 return 0;
> > @@ -2179,15 +2322,23 @@ static int musb_suspend(struct device *dev)
> >         spin_lock_irqsave(&musb->lock, flags);
> >
> >         if (is_peripheral_active(musb)) {
> > -               /* FIXME force disconnect unless we know USB will wake
> > -                * the system up quickly enough to respond ...
> > +               /* System is entering into suspend where gadget would
> not be
> > +                * able to respond to host and thus it will be in an
> unknown
> > +                * state for host. Re-enumeration of gadget is required
> after
> > +                * a resume. So we force a disconnect.
> >                  */
> > +               reg = musb_readb(musb->mregs, MUSB_POWER);
> > +               reg &= ~MUSB_POWER_SOFTCONN;
> > +               musb_writeb(musb->mregs, MUSB_POWER, reg);
> > +
> >         } else if (is_host_active(musb)) {
> >                 /* we know all the children are suspended; sometimes
> >                  * they will even be wakeup-enabled.
> >                  */
> >         }
> >
> > +       musb_save_context(musb);
> > +
> >         if (musb->set_clock)
> >                 musb->set_clock(musb->clock, 0);
> >         else
> > @@ -2209,6 +2360,8 @@ static int musb_resume_noirq(struct device *dev)
> >         else
> >                 clk_enable(musb->clock);
> >
> > +       musb_restore_context(musb);
> > +
> >         /* for static cmos like DaVinci, register values were preserved
> >          * unless for some reason the whole soc powered down or the USB
> >          * module got reset through the PSC (vs just being disabled).
> > diff --git a/drivers/usb/musb/musb_core.h b/drivers/usb/musb/musb_core.h
> > index 969287c..38de1be 100644
> > --- a/drivers/usb/musb/musb_core.h
> > +++ b/drivers/usb/musb/musb_core.h
> > @@ -462,6 +462,45 @@ struct musb {
> >  #endif
> >  };
> >
> > +#ifdef CONFIG_PM
> > +struct musb_csr_regs {
> > +       /* FIFO registers */
> > +       u16 txmaxp, txcsr, rxmaxp, rxcsr;
> > +       u16 rxfifoadd, txfifoadd;
> > +       u8 txtype, txinterval, rxtype, rxinterval;
> > +       u8 rxfifosz, txfifosz;
> > +       u8 txfunaddr, txhubaddr, txhubport;
> > +       u8 rxfunaddr, rxhubaddr, rxhubport;
> > +};
> > +
> > +struct musb_context_registers {
> > +
> > +#if defined(CONFIG_ARCH_OMAP34XX)
> > +       u32 otg_sysconfig, otg_forcestandby;
> > +#endif
> > +       u8 power;
> > +       u16 intrtxe, intrrxe;
> > +       u8 intrusbe;
> > +       u16 frame;
> > +       u8 index, testmode;
> > +
> > +       u8 devctl, misc;
> > +
> > +       struct musb_csr_regs index_regs[MUSB_C_NUM_EPS];
> > +};
> > +
> > +#if defined(CONFIG_ARCH_OMAP34XX) || defined(CONFIG_ARCH_OMAP2430)
> > +extern void musb_platform_save_context(struct musb_context_registers
> > +               *musb_context);
> > +extern void musb_platform_restore_context(struct musb_context_registers
> > +               *musb_context);
> > +#else
> > +#define musb_platform_save_context(x)          do {} while (0)
> > +#define musb_platform_restore_context(x)       do {} while (0)
> > +#endif
> > +
> > +#endif
> > +
> >  static inline void musb_set_vbus(struct musb *musb, int is_on)
> >  {
> >         musb->board_set_vbus(musb, is_on);
> > diff --git a/drivers/usb/musb/musb_regs.h b/drivers/usb/musb/musb_regs.h
> > index 473a94e..8ca8f23 100644
> > --- a/drivers/usb/musb/musb_regs.h
> > +++ b/drivers/usb/musb/musb_regs.h
> > @@ -321,6 +321,26 @@ static inline void  musb_write_rxfifoadd(void
> __iomem *mbase, u16 c_off)
> >         musb_writew(mbase, MUSB_RXFIFOADD, c_off);
> >  }
> >
> > +static inline u8 musb_read_txfifosz(void __iomem *mbase)
> > +{
> > +       return musb_readb(mbase, MUSB_TXFIFOSZ);
> > +}
> > +
> > +static inline u16 musb_read_txfifoadd(void __iomem *mbase)
> > +{
> > +       return musb_readw(mbase, MUSB_TXFIFOADD);
> > +}
> > +
> > +static inline u8 musb_read_rxfifosz(void __iomem *mbase)
> > +{
> > +       return musb_readb(mbase, MUSB_RXFIFOSZ);
> > +}
> > +
> > +static inline u16  musb_read_rxfifoadd(void __iomem *mbase)
> > +{
> > +       return musb_readw(mbase, MUSB_RXFIFOADD);
> > +}
> > +
> >  static inline u8 musb_read_configdata(void __iomem *mbase)
> >  {
> >         musb_writeb(mbase, MUSB_INDEX, 0);
> > @@ -376,6 +396,36 @@ static inline void  musb_write_txhubport(void
> __iomem *mbase, u8 epnum,
> >                         qh_h_port_reg);
> >  }
> >
> > +static inline u8 musb_read_rxfunaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_RXFUNCADDR));
> > +}
> > +
> > +static inline u8 musb_read_rxhubaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_RXHUBADDR));
> > +}
> > +
> > +static inline u8 musb_read_rxhubport(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_RXHUBPORT));
> > +}
> > +
> > +static inline u8  musb_read_txfunaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_TXFUNCADDR));
> > +}
> > +
> > +static inline u8  musb_read_txhubaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_TXHUBADDR));
> > +}
> > +
> > +static inline u8  musb_read_txhubport(void __iomem *mbase, u8 epnum)
> > +{
> > +       return musb_readb(mbase, MUSB_BUSCTL_OFFSET(epnum,
> MUSB_TXHUBPORT));
> > +}
> > +
> >  #else /* CONFIG_BLACKFIN */
> >
> >  #define USB_BASE               USB_FADDR
> > @@ -455,6 +505,22 @@ static inline void  musb_write_rxfifoadd(void
> __iomem *mbase, u16 c_off)
> >  {
> >  }
> >
> > +static inline u8 musb_read_txfifosz(void __iomem *mbase)
> > +{
> > +}
> > +
> > +static inline u16 musb_read_txfifoadd(void __iomem *mbase)
> > +{
> > +}
> > +
> > +static inline u8 musb_read_rxfifosz(void __iomem *mbase)
> > +{
> > +}
> > +
> > +static inline u16  musb_read_rxfifoadd(void __iomem *mbase)
> > +{
> > +}
> > +
> >  static inline u8 musb_read_configdata(void __iomem *mbase)
> >  {
> >         return 0;
> > @@ -500,6 +566,30 @@ static inline void  musb_write_txhubport(void
> __iomem *mbase, u8 epnum,
> >  {
> >  }
> >
> > +static inline u8 musb_read_rxfunaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> > +static inline u8 musb_read_rxhubaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> > +static inline u8 musb_read_rxhubport(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> > +static inline u8  musb_read_txfunaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> > +static inline u8  musb_read_txhubaddr(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> > +static inline void  musb_read_txhubport(void __iomem *mbase, u8 epnum)
> > +{
> > +}
> > +
> >  #endif /* CONFIG_BLACKFIN */
> >
> >  #endif /* __MUSB_REGS_H__ */
> > diff --git a/drivers/usb/musb/omap2430.c b/drivers/usb/musb/omap2430.c
> > index 83beeac..15a3f27 100644
> > --- a/drivers/usb/musb/omap2430.c
> > +++ b/drivers/usb/musb/omap2430.c
> > @@ -255,6 +255,22 @@ int __init musb_platform_init(struct musb *musb)
> >         return 0;
> >  }
> >
> > +#ifdef CONFIG_PM
> > +void musb_platform_save_context(struct musb_context_registers
> > +               *musb_context)
> > +{
> > +       musb_context->otg_sysconfig = omap_readl(OTG_SYSCONFIG);
> > +       musb_context->otg_forcestandby = omap_readl(OTG_FORCESTDBY);
> > +}
> > +
> > +void musb_platform_restore_context(struct musb_context_registers
> > +               *musb_context)
> > +{
> > +       omap_writel(musb_context->otg_sysconfig, OTG_SYSCONFIG);
> > +       omap_writel(musb_context->otg_forcestandby, OTG_FORCESTDBY);
> > +}
> > +#endif
> > +
> >  int musb_platform_suspend(struct musb *musb)
> >  {
> >         u32 l;
> > --
> > 1.6.2.4
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >

