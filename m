From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Tue, 13 Sep 2016 07:53:30 -0700
Message-ID: <20160913145329.hixzehjrwadx3ek3@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <20160913031805.m5nzyqyclh4pyj6k@atomide.com>
 <20160913141448.GN18340@uda0271908>
 <3051875.lhB0TfZGyq@avalon>
 <20160913144020.GO18340@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160913144020.GO18340@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rolf Peukert <rolf.peukert-cSCHQGRfioA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160913 07:40]:
> On Tue, Sep 13, 2016 at 05:32:23PM +0300, Laurent Pinchart wrote:
> > Hi Bin,
> > 
> > On Tuesday 13 Sep 2016 09:14:48 Bin Liu wrote:
> > > On Mon, Sep 12, 2016 at 08:18:05PM -0700, Tony Lindgren wrote:
> > > > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [160912 11:36]:
> > > > > On Mon, Sep 12, 2016 at 08:05:30PM +0200, Andreas Kemnade wrote:
> > > > > > Hmm, then the question is: Couldn't the X_musb_disable simply be
> > > > > > called
> > > > > > from X_probe if needed to be an the safe side?
> > > > > 
> > > > > In general, we try not to do so if all possible. We want to put common
> > > > > code in the core, not repleat them in glue layers.
> > > > > 
> > > > > In this specific case, we cannot do it. For example in dsps glue, the
> > > > > musb reset is done in dsps_musb_init(), so no place in dsps_probe() to
> > > > > call dsps_musb_disable().
> > > > 
> > > > OK yeah if we need to do something, then disabling the irq in
> > > > musb_core.c until we're done should be enough.
> > > 
> > > I don't think we can disable it in musb core directly. *_musb_disable()
> > > in glue layers disables the musb wrapper's irq, not the core's irq.
> > > 
> > > But I guess we can let *_musb_init() directly calls *_musb_disable() in
> > > the glue drivers right after musb reset. This would have to touch almost
> > > all glue drivers, but trivial change. Thoughts?
> > 
> > Is there any use case for starting a glue layer with interrupts enabled ? If 
> 
> I cannot think of any, at least in the current musb drivers.

No reason that I can think of :)

> > not I agree that all glue layers should do so in *_musb_init(). Probably not 
> > by calling *_musb_disable() directly though, as that would reintroduce the 
> > unbalanced PHY power control problem.
> 
> Not a problem, such change will be done in each glue driver, so we don't
> do it for omap2430 glue.

Makes sense. Then we can just move all of musb_generic_enable/disable
code into pm_runtime_resume/suspend in musb-core.c and make sure they
are paired.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
