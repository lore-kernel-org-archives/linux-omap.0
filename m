From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCHv2] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Tue, 17 Jan 2017 10:21:52 -0600
Message-ID: <20170117162152.GE31716@uda0271908>
References: <d6fddff7-3d00-1de1-ebbf-ee2a949a6284@ti.com>
 <20170113190126.GE2630@atomide.com>
 <c80b51a2-1acd-914c-17b8-32754ea9ce3e@ti.com>
 <c58cebdf-5752-098a-8b3e-de99f6af14af@ti.com>
 <c1bbb731-940e-6d04-f127-222050d831b8@ti.com>
 <20170113215936.GF2630@atomide.com>
 <20170116233329.GF7403@atomide.com>
 <20170116235428.GG7403@atomide.com>
 <20170117125919.GA31716@uda0271908>
 <20170117161138.GJ7403@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117161138.GJ7403-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tue, Jan 17, 2017 at 08:11:39AM -0800, Tony Lindgren wrote:
> * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170117 05:00]:
> > On Mon, Jan 16, 2017 at 03:54:29PM -0800, Tony Lindgren wrote:
> > > Anyways, for the -rc series oops, we can just leave out the WARN_ON
> > > parts for now until drivers/usb/musb/musb_cppi41.c is fixed too.
> > 
> > Giving that cppi is a submodule inside the usb subsysytem and it does't
> > have separate power rail or clock, what is the benefit to adding runtime
> > PM in the cppi driver?
> 
> Good question. We need at least minimal support to enable things for
> probe and then idle cppi41 properly if only cppi41.ko is loaded with no
> USB modules.
> 
> But yeah now that musb does runtime PM based on the cable detection, we
> pretty much guarantee that cppi41 is always enabled when USB is in use.
> 
> And if there are no other devices using cppi41 dma on davinci, we can
> simplify the PM runtime a bit for cppi41.

This might be a good idea. I didn't have much time to play with this
cppi41 runtime PM, but it seems I am having more issues than you and
others seeing.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
