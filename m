From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/6] usb: musb: Fix broken use of static variable for
 multiple instances
Date: Fri, 11 Nov 2016 12:05:19 -0800
Message-ID: <20161111200519.GG7138@atomide.com>
References: <20161111184302.2438-1-tony@atomide.com>
 <20161111184302.2438-2-tony@atomide.com>
 <20161111191430.GB17372@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161111191430.GB17372@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [161111 11:15]:
> On Fri, Nov 11, 2016 at 10:42:57AM -0800, Tony Lindgren wrote:
> > --- a/drivers/usb/musb/musb_core.h
> > +++ b/drivers/usb/musb/musb_core.h
> > @@ -385,6 +385,8 @@ struct musb {
> >  	int			a_wait_bcon;	/* VBUS timeout in msecs */
> >  	unsigned long		idle_timeout;	/* Next timeout in jiffies */
> >  
> > +	unsigned		is_initialized:1;
> > +
> 
> The musb strcut is getting bigger and bigger. Is it possible to not add
> a new variable but use one initialized in musb_init_controller() for
> this flag purpose? Readability shouldn't be an issue, since it is only
> used once in musb_runtime_resume().

Well I was initially checking for delayed work being initialized,
but Johan did not like the idea of using it. Looking at
musb_init_controller(), we only initialize musb->nIrq after
pm_runtime_get_sync(), but that's no better either.. Do you have
any better ideas for something to use?

I agree in the long run we should split struct musb into smaller
structs though.

Meanwhile the new flags added in this series are bitfields, so it's
probably better to use that and overloading something that's not
strictly related.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
