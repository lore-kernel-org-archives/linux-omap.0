From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] usb: musb: Fix unbalanced platform_disable
Date: Tue, 20 Sep 2016 07:35:01 -0700
Message-ID: <20160920143501.5cjazsjz6htok5hf@atomide.com>
References: <20160912153947.k4gnggur6usyujii@atomide.com>
 <14745757.ahNt4Zeunj@avalon>
 <20160918151901.k7go65s4jauldxcl@atomide.com>
 <20160919075941.4022b3f3@aktux>
 <20160919160250.itstpdk2rqw3zhzi@atomide.com>
 <20160920070433.7dada289@aktux>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20160920070433.7dada289@aktux>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160919 22:05]:
> On Mon, 19 Sep 2016 09:02:50 -0700
> Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> 
> > * Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org> [160918 23:00]:
> > > On Sun, 18 Sep 2016 08:19:02 -0700
> > > Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org> wrote:
> > > 
> > > > * Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> [160918
> > > > 05:13]:
> > > > > 
> > > > > FYI, while this patch allows me to boot my Panda board with NFS
> > > > > over usbnet, it only works with cold boots. A warm reboot
> > > > > results in the following warning, and no ethernet traffic going
> > > > > through. The USB device is detected by the host though.
> > > > 
> > > > Yeah I noticed too that we still have issues. For example doing
> > > > rmmod of omap2430 with gadget configured and connected will
> > > > produce a hardirq-safe hardirq-unsafe lock order error. That also
> > > > happens with reboot with gadget configured and connected.
> > > > 
> > > hmm, well, there is a musb_platform_disable() in musb_remove()
> > > which is simply superfluous...
> > > Some days ago we had a locking problem with musb_start() and moved
> > > it out of the locked area. Maybe we could do also something similar
> > > here.
> > 
> > Well I don't think we can do that safely at this point because we
> > have unpaired calls to musb_start() and musb_stop(). So trying to
> > make musb_platform_enable/disable() paired right now will just lead
> > into mystery breakage in various use cases.
> > 
> I am primarily talking about 
> doing things like the patch
>       usb: musb: Fix locking errors for host only mode
> 	2c5575401e34de3d2f
> 
> did for musb_start(), for musb_stop() also. 

Yeah I know, but that is really just trying to plug holes. The real
long term fix seems to to be something like:

1. Add musb_try_start_session/stop_session() that can be called
   multiple times unpaired and only tinker with the devctl register

2. Make musb_start/stop() paired for the hardware specific init

3. This allows making musb_platform_enable/disable() paired too

But for now, we still have issues in v4.8-rc cycle, so let's get
that fixed first.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
