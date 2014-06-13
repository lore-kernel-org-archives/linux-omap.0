From: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>
Subject: Re: [PATCH V2 05/19] irqchip: crossbar: Change allocation logic by
 reversing search for free irqs
Date: Fri, 13 Jun 2014 09:13:21 -0400
Message-ID: <20140613131321.GG8664@titan.lakedaemon.net>
References: <1402574007-13987-1-git-send-email-r.sricharan@ti.com>
 <1402574007-13987-6-git-send-email-r.sricharan@ti.com>
 <20140612125615.GT8664@titan.lakedaemon.net>
 <539A95A3.1010301@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <539A95A3.1010301-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sricharan R <r.sricharan-l0cyMroinI0@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, santosh.shilimkar-l0cyMroinI0@public.gmane.org, nm-l0cyMroinI0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 13, 2014 at 11:39:39AM +0530, Sricharan R wrote:
> Hi Jason,
> 
> On Thursday 12 June 2014 06:26 PM, Jason Cooper wrote:
> > On Thu, Jun 12, 2014 at 05:23:13PM +0530, Sricharan R wrote:
> >> From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
> >>
> >> Reverse the search algorithm to ensure that address mapping and IRQ
> >> allocation logics are proper. This can open up new bugs which are
> >> easily fixable rather than wait till allocation logic approaches
> >> the limit to find new bugs.
> > 
> > Could you expand on this logic some more?  What class of bugs are you
> > hoping to discover more easily?
> > 
> 
> class 1. address space errors -> example:
> reg = <a size_b>
> ti,max-irqs =  is a wrong parameter
> 
> class 2: irq-reserved list - which decides which entries in the
> address space is not actually wired in
> 
> class 3: wrong list of routable-irqs.
> 
> in general allocating from max to min tends to have benefits in
> ensuring the different issues that may be present in dts is easily
> caught at definition time, rather than at a later point in time.

Perfect, thanks for clarifying.  Please add this to the commit log when
you respin.

thx,

Jason.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
