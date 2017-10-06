From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 0/2] USB: musb: PM fixes
Date: Fri, 6 Oct 2017 11:27:56 -0500
Message-ID: <20171006162756.GD12182@LTA0271908.dhcp.ti.com>
References: <20170907133748.7400-1-johan@kernel.org>
 <20171005091436.GA2618@localhost>
 <20171005151154.GD3962@atomide.com>
 <20171005151424.GE2618@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171005151424.GE2618@localhost>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Thu, Oct 05, 2017 at 05:14:24PM +0200, Johan Hovold wrote:
> On Thu, Oct 05, 2017 at 08:11:55AM -0700, Tony Lindgren wrote:
> > * Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> [171005 02:15]:
> > > On Thu, Sep 07, 2017 at 03:37:46PM +0200, Johan Hovold wrote:
> > > > These patches fix a couple of bugs introduced by the recent runtime-PM
> > > > work (details in the individual commit messages).
> > > > 
> > > > Note that the external abort was due to the irq work never being flushed
> > > > on suspend, and that we may need similar fixes for the delayed reset and
> > > > resume work which are likewise never cancelled on suspend.
> > > > 
> > > > As I just mentioned in the v1 thread, there are a number of further issues with
> > > > musb suspend (e.g. on BBB):
> > > > 
> > > >  1. System suspend appears to break any active gadget (which then can be
> > > >     restarted manually).
> > > > 
> > > >  2. The early_tx polling in musb_cppi41 lacks a timeout, something which can
> > > >     lead to the hrtimer rescheduling itself indefinitely if the fifo never
> > > >     empties (e.g. if a transfer is is initiated post suspend due to issue 1).
> > > > 
> > > >     See commit a655f481d83d ("usb: musb: musb_cppi41: handle pre-mature TX
> > > >     complete interrupt").
> > > > 
> > > >  3. In host mode, if a device is disconnected while the system is suspended,
> > > >     this will keep the controller runtime active after resume as the session
> > > >     bit is always set.
> > > 
> > > Bin and Tony, any comments to this series?
> > 
> > Oops sorry I forgot to test these after two recent conferences. I just gave
> > these a try and they both behave for me. Nice fixes, for both:
> > 
> > Tested-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
> 
> Great, thanks for testing!

Tony, thanks for testing them.

Johan, I recently have been over loaded with a non-usb work, and it
probably will last for another month or two. But I will try my best to
get these patches and others accumulated recently into upstream in next
week.

Sorry for the delay.

Regards,
-Bin.

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
