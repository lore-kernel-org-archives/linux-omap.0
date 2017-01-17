From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCHv2] dmaengine: cppi41: Fix oops in cppi41_runtime_resume
Date: Tue, 17 Jan 2017 09:39:23 -0800
Message-ID: <20170117173922.GR7403@atomide.com>
References: <c58cebdf-5752-098a-8b3e-de99f6af14af@ti.com>
 <c1bbb731-940e-6d04-f127-222050d831b8@ti.com>
 <20170113215936.GF2630@atomide.com>
 <20170116233329.GF7403@atomide.com>
 <20170116235428.GG7403@atomide.com>
 <20170117125919.GA31716@uda0271908>
 <20170117161138.GJ7403@atomide.com>
 <20170117162152.GE31716@uda0271908>
 <20170117163103.GO7403@atomide.com>
 <20170117164846.GG31716@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170117164846.GG31716@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felipe Balbi <felipe.balbi-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Patrick Titiano <ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170117 08:49]:
> On Tue, Jan 17, 2017 at 08:31:03AM -0800, Tony Lindgren wrote:
> > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170117 08:22]:
> > > On Tue, Jan 17, 2017 at 08:11:39AM -0800, Tony Lindgren wrote:
> > > > * Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170117 05:00]:
> > > > > On Mon, Jan 16, 2017 at 03:54:29PM -0800, Tony Lindgren wrote:
> > > > > > Anyways, for the -rc series oops, we can just leave out the WARN_ON
> > > > > > parts for now until drivers/usb/musb/musb_cppi41.c is fixed too.
> > > > > 
> > > > > Giving that cppi is a submodule inside the usb subsysytem and it does't
> > > > > have separate power rail or clock, what is the benefit to adding runtime
> > > > > PM in the cppi driver?
> > > > 
> > > > Good question. We need at least minimal support to enable things for
> > > > probe and then idle cppi41 properly if only cppi41.ko is loaded with no
> > > > USB modules.
> > > > 
> > > > But yeah now that musb does runtime PM based on the cable detection, we
> > > > pretty much guarantee that cppi41 is always enabled when USB is in use.
> > > > 
> > > > And if there are no other devices using cppi41 dma on davinci, we can
> > > > simplify the PM runtime a bit for cppi41.
> > > 
> > > This might be a good idea. I didn't have much time to play with this
> > > cppi41 runtime PM, but it seems I am having more issues than you and
> > > others seeing.
> > 
> > What kind of additional issues are you seeing not described in the $subject
> > patch?
> 
> I didn't take a note and don't remember if those are in the $subject
> patch. But
> 
> - enumeration begining with a reset that the device doesn't accept
>   address X, error code -71; or

Some of this could be fixed by $subject patch if caused by a race.
Some of it I'm suspecting might be a different issue where cppi41 dma
will just hang until the device is disconnected on 1 sized in dma transfer.
See the experimental patch below.

> - console fooding with cppi error code -115 after thumb drive enumeration.

This should get fixed with the $subject patch if we additionally set
the autosuspend_delay to something sufficient, like 1000.

> Again, I only tried for a few minutes and didn't take a note, since I
> don't have time to look at this ATM.

Well I'll post what I think we should fix for the -rc series for cppi41.
If you can then please test that a bit and see if it works. Assuming
things work, then all the other changes can be done later on with no
rush.

Regards,

Tony

8< ----------------------------------------
diff --git a/drivers/usb/musb/musb_host.c b/drivers/usb/musb/musb_host.c
--- a/drivers/usb/musb/musb_host.c
+++ b/drivers/usb/musb/musb_host.c
@@ -751,6 +751,15 @@ static void musb_ep_program(struct musb *musb, u8 epnum,
 		hw_ep->tx_channel = NULL;
 	}
 
+	/*
+	 * At least cppi41 in dma will just hang with size of 1 until the
+	 * device is connected. For sizes less than 8 it seems to take a
+	 * long time to complete. Let's use minimum size of 16 to avoid
+	 * tiny in DMA transfers.
+	 */
+	if (!is_out && (len < 16))
+		use_dma = 0;
+
 	/* candidate for DMA? */
 	dma_controller = musb->dma_controller;
 	if (use_dma && is_dma_capable() && epnum && dma_controller) {
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
