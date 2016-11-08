From: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/4] usb: musb: Fix sleeping function called from invalid
 context for hdrc glue
Date: Tue, 8 Nov 2016 20:03:31 +0100
Message-ID: <20161108190331.GA14744@localhost>
References: <20161107215020.31399-1-tony@atomide.com>
 <20161107215020.31399-3-tony@atomide.com>
 <20161108170917.GA3328@localhost>
 <20161108173413.GM2428@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161108173413.GM2428-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, George Cherian <george.cherian-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 08, 2016 at 10:34:13AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [161108 10:09]:
> > On Mon, Nov 07, 2016 at 02:50:18PM -0700, Tony Lindgren wrote:
> > > @@ -2604,6 +2669,9 @@ static int musb_resume(struct device *dev)
> > >  	mask = MUSB_DEVCTL_BDEVICE | MUSB_DEVCTL_FSDEV | MUSB_DEVCTL_LSDEV;
> > >  	if ((devctl & mask) != (musb->context.devctl & mask))
> > >  		musb->port1_status = 0;
> > > +
> > > +	schedule_delayed_work(&musb->pending_resume_work, 0);
> > > +
> > 
> > The interactions with system suspend looks a bit suspicious. It seems
> > you need to drain any pending resume work on suspend for example.
> > 
> > And then the above should not be needed, right?
> 
> Hmm that's an interesting idea. I think that would allow us to get
> rid of the delayed work if we check the list both on resume and
> suspend :)

Note that I was referring to draining the runtime-resume work on system
suspend above. I think we still want the delayed work considering that
we could stay active for long periods of time.

> > In fact, the dsps timer must also be cancelled on suspend, or you could
> > end up calling dsps_check_status() while suspended (it is currently not
> > cancelled until the parent device is suspended, which could be too
> > late).
> 
> And then this should no longer be an issue either.

It would still be an issue as a system-suspending device could already
have been runtime-resumed so that dsps_check_status() would be called
directly from the timer function.

Thanks,
Johan
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
