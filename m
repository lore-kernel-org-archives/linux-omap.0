From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] usb: dwc3: omap: Fix imprecise external abort and oops
 on boot
Date: Thu, 8 Dec 2016 10:25:25 -0800
Message-ID: <20161208182521.GA4920@atomide.com>
References: <20161208032108.21962-1-tony@atomide.com>
 <87lgvqkb6f.fsf@linux.intel.com>
 <20161208153734.GF4264@atomide.com>
 <87a8c6pavm.fsf@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87a8c6pavm.fsf-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Roger Quadros <rogerq-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 09:52]:
> 
> Hi,
> 
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> > * Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161208 01:45]:
> >> 
> >> Hi,
> >> 
> >> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> writes:
> >> > Somehow starting with v4.9-rc7 there have been imprecise
> >> 
> >> There's nothing touching dwc3 since v4.9-rc5.
> >
> > Right, nothing obvious has changed. I think it's just a slight timing
> > change in the code that started triggering it.
> 
> could be
> 
> >> > external aborts on omap5-uevm dwc3 controller. I have not been
> >> > able to bisect what exactly triggered this as it does not always
> >> > happen. It seems that something changed with probing that
> >> > now exposes the issue:
> >> >
> >> > Unhandled fault: imprecise external abort (0x1406) at 0x00000000
> >> 
> >> hmmm, clock disabled... dwc3-omap shouldn't have pm runtime at all.
> >
> > It does for the interconnect target module clkctrl register via PM
> > runtime. That's the "usb_otg_ss" module.
> 
> but that's all hidden in omap_device.c, we don't touch it from driver
> perspective.

The call to pm_runtime_get_sync() in dwc3_omap_probe() will use it.

Is there also some dwc3 internal clock? If we assume the usb_otg_ss
module is properly enabled it could be some dwc3 internal clock not
enabled?

We do have a srst_udelay needed for enabling musb controller for some
SoCs, I'll check if that's the case here.

> >> > ...
> >> > PC is at dwc3_omap_interrupt_thread+0x20/0x80
> >> > LR is at irq_thread_fn+0x1c/0x54
> >> > ...
> >> > [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>]
> >> > (irq_thread_fn+0x1c/0x54)
> >> > [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> >> > [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> >> > [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> >> > ...
> >> >
> >> > Unable to handle kernel paging request at virtual address ffffffec
> >> > ...
> >> > Internal error: Oops: 37 [#2] SMP ARM
> >> > PC is at kthread_data+0x4/0xc
> >> > LR is at irq_thread_dtor+0x28/0xd0
> >> > ...
> >> > [<c035e0b4>] (kthread_data) from [<c038a5dc>] (irq_thread_dtor+0x28/0xd0)
> >> > [<c038a5dc>] (irq_thread_dtor) from [<c035bef0>] (task_work_run+0xb8/0xdc)
> >> > [<c035bef0>] (task_work_run) from [<c03448d4>] (do_exit+0x314/0xa20)
> >> > [<c03448d4>] (do_exit) from [<c030bea8>] (die+0x410/0x474)
> >> > [<c030bea8>] (die) from [<c0301350>] (do_DataAbort+0xb4/0xb8)
> >> > [<c0301350>] (do_DataAbort) from [<c030c578>] (__dabt_svc+0x58/0x80)
> >> > Exception stack(0xee777ec8 to 0xee777f10)
> >> > 7ec0:                   0000014d ee6e6f10 00000034 fc020034 ee6e6f10 ee1eec00
> >> > 7ee0: 00000000 00000000 ee6ec640 c038a4bc 00000000 00000000 00000000 ee777f18
> >> > 7f00: c038a4d8 c0989fa8 60000013 ffffffff
> >> > [<c030c578>] (__dabt_svc) from [<c0989fa8>] (dwc3_omap_interrupt_thread+0x20/0x80)
> >> > [<c0989fa8>] (dwc3_omap_interrupt_thread) from [<c038a4d8>] (irq_thread_fn+0x1c/0x54)
> >> > [<c038a4d8>] (irq_thread_fn) from [<c038a7b0>] (irq_thread+0x12c/0x1f0)
> >> > [<c038a7b0>] (irq_thread) from [<c035d6f0>] (kthread+0xdc/0xf4)
> >> > [<c035d6f0>] (kthread) from [<c0307d78>] (ret_from_fork+0x14/0x3c)
> >> >
> >> > Fix the issue by making sure the dwc3 interrupts are disabled
> >> > before we call devm_request_threaded_irq().
> >> 
> >> that should already be the case. Are you sure that register isn't zero
> >> in probe?
> >
> > Looks like irq0_status = 0 and irqmisc_status = 0x2121. Also just
> > clearing irqmisc with dwc3_omap_write_irqmisc_clr(omap, 0xffffffff)
> > stops the issue from happening.
> >
> > There is some deferred probing happening but irqmisc is always 0x2121.
> 
> some spurious irq status from ROM code, perhaps? Are you not resetting
> usb_otg_ss hwmod? We shouldn't have any pending interrupts when we get
> to probe(), if we do have them, then we need an erratum for it.

I have u-boot use it to download the kernel and that is probably using
the ROM code USB support.

> You could try making usb_otg_ss is reset by hwmod. It would also be good
> to check other OMAP-ish devices sporting dwc3 (DRA7x, AM437x, AM57x) if
> they have the same behavior.

It should be reset by default by hwmod.

> Adding Nishanth to the loop too for reference.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
