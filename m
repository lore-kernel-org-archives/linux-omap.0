From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Mon, 12 Sep 2016 12:32:42 -0500
Message-ID: <20160912173242.GH18340@uda0271908>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <20160912165455.GE18340@uda0271908>
 <20160912171938.5fmx2qi6xtzsohpy@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160912171938.5fmx2qi6xtzsohpy-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Mon, Sep 12, 2016 at 10:19:40AM -0700, Tony Lindgren wrote:
> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160912 09:55]:
> > Hi Tony,
> > 
> > On Mon, Sep 12, 2016 at 08:39:49AM -0700, Tony Lindgren wrote:
> > > Commit a83e17d0f73b ("usb: musb: Improve PM runtime and phy handling
> > > for 2430 glue layer") moved PHY enable/disable calls to happen from
> > > omap2430_musb_enable/disable(). That broke enumeration for several
> > > devices as PM runtime in the PHY will never enable it.
> > > 
> > > The root cause of the problem is unpaired calls from musb_core.c to
> > > musb_platform_enable/disable in musb_core.c as reported by
> > > Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>.
> > > 
> > > As musb_platform_enable/disable are being called from various functions,
> > > let's not attempt to make them paiered immediately. This would require
> > > fixing all the callers like musb_remove.
> > > 
> > > Instead, let's first fix the regression in a minimal way by removing
> > > the initial call to musb_platform_disable.
> > > 
> > > AFAIK the initial musb_platform_disable call has always been just an
> > > attempted workaround for the 2430 glue layer announcing itself too
> > > early before the gadgets are configured. And that issue finally
> > 
> > Many glue layers rely on musb_platform_diable to disable interrupts in
> > musb_init_controller() before registering ISR, is it safe to assume the
> > interrupts will be masked when musb is out-of-reset so that we don't
> > have to call musb_platform_disable() in musb_init_controller()?
> 
> It should be, we do request_irq only later on after this in musb_core.c.
> And the glue layers don't do request_irq except for the separate DMA
> interrupts in two cases.

Yeah, the glue layer does not do request_irq, core does it after called
musb_platform_disable(), in which some glues mask interrupts.

If musb_init_controller() no longer calls musb_platform_disable(), it
kinda worries me. I have asked around, no one says that it is a safe
assumption that interrupt will be masked when out-of-reset, though it is
common sense.

This change should not break any glue layer which relies on
musb_platform_disable() to disable interrupts.

So Kishon, if you take this patch in your tree, here is my 

Signed-off-by: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>

Regards,
-Bin.

> 
> And as the platform glue layer are the ones doing the probing, they
> should initialize things into sane state :)
> 
> We could add a call irq_set_status_flags(irq, IRQ_NOAUTOEN) before
> request_irq. But I'm guessing there's no need to.. Do you have some
> example in mind that should be tested?
> 
> Regards,
> 
> Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
