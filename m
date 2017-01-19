From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 2/2] usb: musb: Size 1 dma in transfers won't complete
 with cpp41
Date: Thu, 19 Jan 2017 07:04:57 -0800
Message-ID: <20170119150457.GS7403@atomide.com>
References: <20170119022959.30793-1-tony@atomide.com>
 <20170119022959.30793-3-tony@atomide.com>
 <20170119034130.GA22265@uda0271908>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170119034130.GA22265@uda0271908>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>, Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Andreas Kemnade <andreas-cLv4Z9ELZ06ZuzBka8ofvg@public.gmane.org>, Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Felipe Balbi <balbi-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Kishon Vijay Abraham I <kishon-l0cyMroinI0@public.gmane.org>, Ivaylo Dimitrov <ivo.g.dimitrov.75-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Johan Hovold <johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Ladislav Michl <ladis-6z/3iImG2C8G8FEW9MqTrA@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> [170118 19:42]:
> On Wed, Jan 18, 2017 at 06:29:59PM -0800, Tony Lindgren wrote:
> > At least with the cppi41 dma, size 1 in dma transfers will just wait
> 
> In which case do you see the size 1 transfer? using testusb?
> 
> > until the device is disconnected. This causes timeouts in cppi41 dma
> > runtime PM.
> > 
> > Also the initial size 8 transfers take about 200ms to complete when
> > plugging a USB mass storage device to a hub. But we probably want to
> > keep those to avoid using PIO.
> > 
> > Fix the issue by adding a quirk for cppi41 and skip size 1 in dma if
> > set.
> 
> It is fine to bypass dma for size 1 transfers, due to the dma setup
> overhead. But I'd like to know the test case to understand why it hangs.

The test case is the same old connect a USB mass storage device to a hub.
There we see the initial size 1 transfer in the beginning. That transfer
seems to never complete with cppi41 and the transfer will stay active
until the device is disconnected. Currently we don't seem to have any
timeout mechanism in cppi41 for that.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
