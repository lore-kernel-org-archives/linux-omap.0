From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv3] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Wed, 18 Jan 2017 10:46:52 -0800
Message-ID: <20170118184652.GL7403@atomide.com>
References: <20170117175524.3484-1-tony@atomide.com>
 <20170118142501.GA10928@uda0271908>
 <20170118165308.GC7403@atomide.com>
 <20170118184223.GC10928@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170118184223.GC10928@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 10:43]:
> On Wed, Jan 18, 2017 at 08:53:09AM -0800, Tony Lindgren wrote:
> > Hi,
> > 
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 06:26]:
> > > With this v3, I still get -71 error when a device is plugged to a hub to
> > > musb. It doesn't happen though if the device is already plugged to the hub
> > > before attaching the hub to musb.
> > > 
> > > [  177.579300] usb 1-1: reset high-speed USB device number 2 using musb-hdrc
> > > [  177.719308] usb 1-1: device descriptor read/64, error -71
> > > [  178.350297] usb 1-1.1: new high-speed USB device number 4 using musb-hdrc
> > 
> > I think the -71 issue is a different regression. I've verified that v4.8.y
> > does not have this, but v4.9.y does have it.
> 
> I will take a look on this one.

Found the commit causing, see the mail I just sent. It's 467d5c980709.

> > Care to try the updated patch below? It won't help with the -71 issue
> > but the $subject issue should be fixed. And you should not see the
> > WARN() trigger with your tests presumably.
> 
> Yes, now no WARN() and no -115 any more. Thanks.

OK. I'll take a look at what additional quirk handling the devctl
session bit needs for the -71 error and then with these we should
have things working again.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
