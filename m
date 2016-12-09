From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Fri, 9 Dec 2016 08:28:54 -0800
Message-ID: <20161209162853.GK4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <8a94638a-a8fe-88e0-aece-1ed9835df3c6@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <8a94638a-a8fe-88e0-aece-1ed9835df3c6-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
Cc: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org> [161209 08:09]:
> Hi Tony,
> 
> On 08/12/16 05:21, Tony Lindgren wrote:
> > Somehow starting with v4.9-rc7 there have been imprecise
> > external aborts on omap5-uevm dwc3 controller. I have not been
> > able to bisect what exactly triggered this as it does not always
> > happen. It seems that something changed with probing that
> > now exposes the issue:
> > 
> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> > ...
> > PC is at dwc3_omap_interrupt_thread+0x20/0x80
> > LR is at irq_thread_fn+0x1c/0x54
> > ...
> > [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>]
> > (irq_thread_fn+0x1c/0x54)
> > [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> > [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> > [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> > ...
> > 
> > Unable to handle kernel paging request at virtual address ffffffec
> > ...
> > Internal error: Oops: 37 [#2] SMP ARM
> > PC is at kthread_data+0x4/0xc
> > LR is at irq_thread_dtor+0x28/0xd0
> > ...
> > [<c035e0b4>] (kthread_data) from [<c038a5dc>] (irq_thread_dtor+0x28/0xd0)
> > [<c038a5dc>] (irq_thread_dtor) from [<c035bef0>] (task_work_run+0xb8/0xdc)
> > [<c035bef0>] (task_work_run) from [<c03448d4>] (do_exit+0x314/0xa20)
> > [<c03448d4>] (do_exit) from [<c030bea8>] (die+0x410/0x474)
> > [<c030bea8>] (die) from [<c0301350>] (do_DataAbort+0xb4/0xb8)
> > [<c0301350>] (do_DataAbort) from [<c030c578>] (__dabt_svc+0x58/0x80)
> > Exception stack(0xee777ec8 to 0xee777f10)
> > 7ec0:                   0000014d ee6e6f10 00000034 fc020034 ee6e6f10 ee1eec00
> > 7ee0: 00000000 00000000 ee6ec640 c038a4bc 00000000 00000000 00000000 ee777f18
> > 7f00: c038a4d8 c0989fa8 60000013 ffffffff
> > [<c030c578>] (__dabt_svc) from [<c0989fa8>] (dwc3_omap_interrupt_thread+0x20/0x80)
> > [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>] (irq_thread_fn+0x1c/0x54)
> > [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> > [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> > [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> > 
> > Fix the issue by making sure the dwc3 interrupts are disabled
> > before we call devm_request_threaded_irq().
> > 
> > Note that there does not seem to be issues with the dwc3 wrapper
> > accessing these registers even before the dwc3 core is probed.
> > If some of these registers are specific to the dwc3 core, we can
> > have IRQ disabled with irq_set_status_flags(omap->irq, IRQ_NOAUTOEN)
> > on start-up instead of accessing the dwc3 registers.
> > 
> > Reported-by: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> > Cc: Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>
> > Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> > ---
> >  drivers/usb/dwc3/dwc3-omap.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/dwc3-omap.c b/drivers/usb/dwc3/dwc3-omap.c
> > --- a/drivers/usb/dwc3/dwc3-omap.c
> > +++ b/drivers/usb/dwc3/dwc3-omap.c
> > @@ -511,6 +511,8 @@ static int dwc3_omap_probe(struct platform_device *pdev)
> >  	/* check the DMA Status */
> >  	reg = dwc3_omap_readl(omap->base, USBOTGSS_SYSCONFIG);
> >  
> > +	dwc3_omap_disable_irqs(omap);
> > +
> >  	ret = devm_request_threaded_irq(dev, omap->irq, dwc3_omap_interrupt,
> >  					dwc3_omap_interrupt_thread, IRQF_SHARED,
> >  					"dwc3-omap", omap);
> > 
> 
> I'm not able to see this issue on my omap5-uevm or dra7-evm on v4.9-rc8.
> What u-boot are you using? Are you using usb gadget in u-boot?

Seems to be a bit hard to reproduce, see for example "v4.9-rc8-74-gea5a9eff96fe"
at kernelci.org for "mainline" failed jobs:

https://kernelci.org/job/mainline/

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
