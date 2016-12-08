From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 14:57:25 -0800
Message-ID: <20161208225724.GI4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <9cce1e34-2fec-9477-4827-6b4c67920a8a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <9cce1e34-2fec-9477-4827-6b4c67920a8a-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org> [161208 13:54]:
> Hi Tony,
> 
> On 12/08/2016 09:37 AM, Tony Lindgren wrote:
> > * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 01:45]:
> >> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >>> Somehow starting with v4.9-rc7 there have been imprecise
> >>
> >> There's nothing touching dwc3 since v4.9-rc5.
> > 
> > Right, nothing obvious has changed. I think it's just a slight timing
> > change in the code that started triggering it.
> > 
> >>> external aborts on omap5-uevm dwc3 controller. I have not been
> >>> able to bisect what exactly triggered this as it does not always
> >>> happen. It seems that something changed with probing that
> >>> now exposes the issue:
> >>>
> >>> Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> >>
> >> hmmm, clock disabled... dwc3-omap shouldn't have pm runtime at all.
> > 
> > It does for the interconnect target module clkctrl register via PM
> > runtime. That's the "usb_otg_ss" module.
> > 
> >>> ...
> >>> PC is at dwc3_omap_interrupt_thread+0x20/0x80
> >>> LR is at irq_thread_fn+0x1c/0x54
> >>> ...
> >>> [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>]
> >>> (irq_thread_fn+0x1c/0x54)
> >>> [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> >>> [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> >>> [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> >>> ...
> >>>
> >>> Unable to handle kernel paging request at virtual address ffffffec
> >>> ...
> >>> Internal error: Oops: 37 [#2] SMP ARM
> >>> PC is at kthread_data+0x4/0xc
> >>> LR is at irq_thread_dtor+0x28/0xd0
> >>> ...
> >>> [<c035e0b4>] (kthread_data) from [<c038a5dc>] (irq_thread_dtor+0x28/0xd0)
> >>> [<c038a5dc>] (irq_thread_dtor) from [<c035bef0>] (task_work_run+0xb8/0xdc)
> >>> [<c035bef0>] (task_work_run) from [<c03448d4>] (do_exit+0x314/0xa20)
> >>> [<c03448d4>] (do_exit) from [<c030bea8>] (die+0x410/0x474)
> >>> [<c030bea8>] (die) from [<c0301350>] (do_DataAbort+0xb4/0xb8)
> >>> [<c0301350>] (do_DataAbort) from [<c030c578>] (__dabt_svc+0x58/0x80)
> >>> Exception stack(0xee777ec8 to 0xee777f10)
> >>> 7ec0:                   0000014d ee6e6f10 00000034 fc020034 ee6e6f10 ee1eec00
> >>> 7ee0: 00000000 00000000 ee6ec640 c038a4bc 00000000 00000000 00000000 ee777f18
> >>> 7f00: c038a4d8 c0989fa8 60000013 ffffffff
> >>> [<c030c578>] (__dabt_svc) from [<c0989fa8>] (dwc3_omap_interrupt_thread+0x20/0x80)
> >>> [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>] (irq_thread_fn+0x1c/0x54)
> >>> [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> >>> [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> >>> [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> >>>
> >>> Fix the issue by making sure the dwc3 interrupts are disabled
> >>> before we call devm_request_threaded_irq().
> >>
> >> that should already be the case. Are you sure that register isn't zero
> >> in probe?
> > 
> > Looks like irq0_status = 0 and irqmisc_status = 0x2121. Also just
> > clearing irqmisc with dwc3_omap_write_irqmisc_clr(omap, 0xffffffff)
> > stops the issue from happening.
> > 
> > There is some deferred probing happening but irqmisc is always 0x2121.
> > 
> 
> My assumption is that you have race here between IRQ handler and PM runtime
> in error handling path during deferred probing.
> 
>  Will below change fix issue for you?

I think you figured out why it behaves that way :)

Seems to work based on few boot tests. Probably both should be applied,
my original patch to prevent spurious interrupts before things are
initialized, this to disable interrupts before pm_runtime_suspend()
on exit path:

Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>


> diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> index 29e80cc..dbc21bc 100644
> --- a/drivers/usb/dwc3/dwc3-omap.c
> +++ b/drivers/usb/dwc3/dwc3-omap.c
> @@ -517,12 +517,12 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>         if (ret) {
>                 dev_err(dev, "failed to request IRQ #%d --> %d\n",
>                                 omap->irq, ret);
> -               goto err1;
> +               goto err11;
>         }
>  
>         ret = dwc3_omap_extcon_register(omap);
>         if (ret < 0)
> -               goto err1;
> +               goto err11;
>  
>         ret = of_platform_populate(node, NULL, NULL, dev);
>         if (ret) {
> @@ -538,6 +538,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
>         extcon_unregister_notifier(omap->edev, EXTCON_USB, &omap->vbus_nb);
>         extcon_unregister_notifier(omap->edev, EXTCON_USB_HOST, &omap->id_nb);
>  
> +err11:
> +       disable_irq(omap->irq);
>  err1:
>         pm_runtime_put_sync(dev);
>         pm_runtime_disable(dev);
> 
> 
> -- 
> regards,
> -grygorii
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
