From: Romit Dasgupta <romit-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 1/2 v2] musb: Add context save and restore support
Date: Thu, 26 Nov 2009 14:33:05 +0530
Message-ID: <4B0E4449.8030701@ti.com>
References: <1259217599-17793-1-git-send-email-ajay.gupta@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1259217599-17793-1-git-send-email-ajay.gupta-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gupta, Ajay Kumar" <ajay.gupta-l0cyMroinI0@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org" <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, "Gadiyar, Anand" <gadiyar-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

> --- a/drivers/usb/musb/musb_core.c
> +++ b/drivers/usb/musb/musb_core.c
> @@ -2167,21 +2167,163 @@ static int __devexit musb_remove(struct platform_device *pdev)
> 
>  #ifdef CONFIG_PM
> 
> +static struct musb_context_registers musb_context;
> +
> +void musb_save_context(void __iomem *musb_base)
> +{
> +       int i;
> +
> +       musb_context.faddr = musb_readb(musb_base, MUSB_FADDR);
> +       musb_context.power = musb_readb(musb_base, MUSB_POWER);
> +       musb_context.intrtxe = musb_readw(musb_base, MUSB_INTRTXE);
> +       musb_context.intrrxe = musb_readw(musb_base, MUSB_INTRRXE);
> +       musb_context.intrusbe = musb_readb(musb_base, MUSB_INTRUSBE);
> +       musb_context.frame = musb_readw(musb_base, MUSB_FRAME);
Not necessary for gadget
> +       musb_context.index = musb_readb(musb_base, MUSB_INDEX);

> +       musb_context.testmode = musb_readb(musb_base, MUSB_TESTMODE);
Not sure if it is necessary for gadget.

> +       musb_context.devctl = musb_readb(musb_base, MUSB_DEVCTL);
> +
> +       for (i = 0; i < MUSB_C_NUM_EPS; ++i) {
> +               musb_writeb(musb_base, MUSB_INDEX, i);
> +               musb_context.index_regs[i].txmaxp =
> +                       musb_readw(musb_base, 0x10 + MUSB_TXMAXP);
> +               musb_context.index_regs[i].txcsr =
> +                       musb_readw(musb_base, 0x10 + MUSB_TXCSR);
> +               musb_context.index_regs[i].rxmaxp =
> +                       musb_readw(musb_base, 0x10 + MUSB_RXMAXP);
> +               musb_context.index_regs[i].rxcsr =
> +                       musb_readw(musb_base, 0x10 + MUSB_RXCSR);
> +               musb_context.index_regs[i].rxcount =
> +                       musb_readw(musb_base, 0x10 + MUSB_RXCOUNT);
> +               musb_context.index_regs[i].txtype =
> +                       musb_readb(musb_base, 0x10 + MUSB_TXTYPE);
> +               musb_context.index_regs[i].txinterval =
> +                       musb_readb(musb_base, 0x10 + MUSB_TXINTERVAL);
> +               musb_context.index_regs[i].rxtype =
> +                       musb_readb(musb_base, 0x10 + MUSB_RXTYPE);
> +               musb_context.index_regs[i].rxinterval =
> +                       musb_readb(musb_base, 0x10 + MUSB_RXINTERVAL);
> +
> +               musb_context.index_regs[i].txfifoadd =
> +                               musb_read_txfifoadd(musb_base);
> +               musb_context.index_regs[i].rxfifoadd =
> +                               musb_read_rxfifoadd(musb_base);
> +               musb_context.index_regs[i].txfifosz =
> +                               musb_read_txfifosz(musb_base);
> +               musb_context.index_regs[i].rxfifosz =
> +                               musb_read_rxfifosz(musb_base);

If MUSB_CONFIGDATA_DYNFIFO is not set then saving FIFO address and sizes are
probably not necessary. Not sure if they are detrimental as well.
> +
> +               musb_context.index_regs[i].txfunaddr =
> +                       musb_read_txfunaddr(musb_base, i);
> +               musb_context.index_regs[i].txhubaddr =
> +                       musb_read_txhubaddr(musb_base, i);
> +               musb_context.index_regs[i].txhubport =
> +                       musb_read_txhubport(musb_base, i);
> +
> +               musb_context.index_regs[i].rxfunaddr =
> +                       musb_read_rxfunaddr(musb_base, i);
> +               musb_context.index_regs[i].rxhubaddr =
> +                       musb_read_rxhubaddr(musb_base, i);
> +               musb_context.index_regs[i].rxhubport =
> +                       musb_read_rxhubport(musb_base, i);
> +       }
If we are in gadget mode, do we have to save this?
> +
> +       musb_writeb(musb_base, MUSB_INDEX, musb_context.index);
> +
> +       musb_platform_save_context(&musb_context);
> +}
Similar for restore.
>  static int musb_suspend(struct device *dev)
>  {
>         struct platform_device *pdev = to_platform_device(dev);
>         unsigned long   flags;
>         struct musb     *musb = dev_to_musb(&pdev->dev);
> +       u8 reg;
> 
>         if (!musb->clock)
>                 return 0;
> 
>         spin_lock_irqsave(&musb->lock, flags);
> 
> +       musb_save_context(musb->mregs);
> +
>         if (is_peripheral_active(musb)) {
> -               /* FIXME force disconnect unless we know USB will wake
> -                * the system up quickly enough to respond ...
> +               /* System is entering into suspend where gadget would not be
> +                * able to respond to host and thus it will be in an unknown
> +                * state for host.Re-enumemation of gadget is required after
> +                * resume to make the gadget functional thus doing a force
> +                * disconnect.
>                  */
> +               reg = musb_readb(musb->mregs, MUSB_POWER);
> +               reg &= ~MUSB_POWER_SOFTCONN;
> +               musb_writeb(musb->mregs, MUSB_POWER, reg);
After this softdisconnect when we subsequently get reconnected followed by a
reset we could have changed our speed (LS,FS, HS). In your resume routine we are
writing back our previous speed. I am not sure here but is it not possible that
we have reset the controller and then restored back the old speed overwriting
the new speed?
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
