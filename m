From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Wed, 9 Nov 2016 17:04:16 +0100
Message-ID: <20161109160416.GI14744@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
 <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
 <20161108190331.GA14744@localhost>
 <20161109012606.GR2428@atomide.com>
 <20161109153953.GG14744@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161109153953.GG14744@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Wed, Nov 09, 2016 at 04:39:53PM +0100, Johan Hovold wrote:
> On Tue, Nov 08, 2016 at 06:26:07PM -0700, Tony Lindgren wrote:

> > @@ -2065,6 +2147,7 @@ musb_init_controller(struct device *dev, int nIrq, void __iomem *ctrl)
> >  	}
> >  
> >  	spin_lock_init(&musb->lock);
> > +	spin_lock_init(&musb->list_lock);
> >  	musb->board_set_power = plat->set_power;
> >  	musb->min_power = plat->min_power;
> >  	musb->ops = plat->platform_ops;
> > @@ -2556,6 +2639,7 @@ static int musb_suspend(struct device *dev)
> >  	struct musb	*musb = dev_to_musb(dev);
> >  	unsigned long	flags;
> >  
> > +	WARN_ON(!list_empty(&musb->pending_list));
> 
> And this also depends on anyone attempting to queue work having first
> gotten an RPM reference (so that driver core runtime resumes the device
> before calling suspend()).
> 
> But no, there's actually still a window were this could be false when
> work is queued while runtime resuming (and eventually is executed from
> musb_queue_resume_work()).

As you just pointed out that can actually never happen and corresponding
code can be removed from musb_queue_resume_work(), so scrap this last
paragraph too. :)

Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
