From: Bin Liu <b-liu-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/3] usb: musb: dsps: Manage CPPI 4.1 DMA interrupt in
 dsps
Date: Mon, 23 Jan 2017 15:32:18 -0600
Message-ID: <20170123213218.GD1609@uda0271908>
References: <20170119100659.11370-1-abailon@baylibre.com>
 <20170119100659.11370-4-abailon@baylibre.com>
 <20170120201717.GE14571@uda0271908>
 <m2pojd3c39.fsf@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <m2pojd3c39.fsf-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kevin Hilman <khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, grygorii.strashko-l0cyMroinI0@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

On Mon, Jan 23, 2017 at 09:44:42AM -0800, Kevin Hilman wrote:
> Bin Liu <b-liu-l0cyMroinI0@public.gmane.org> writes:
> 
> > On Thu, Jan 19, 2017 at 11:06:59AM +0100, Alexandre Bailon wrote:
> >> Despite the CPPI 4.1 is a generic DMA, it is tied to USB.
> >> On the dsps, CPPI 4.1 interrupt's registers are in USBSS (the MUSB glue).
> >> Currently, to enable / disable and clear interrupts, the CPPI 4.1 driver
> >> maps and accesses to USBSS's register, which making CPPI 4.1 driver not
> >> really generic.
> >> Move the interrupt management to dsps driver.
> >> 
> >> Signed-off-by: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
> >> ---
> >>  drivers/dma/cppi41.c         | 28 ++++------------
> >>  drivers/usb/musb/musb_dsps.c | 77 ++++++++++++++++++++++++++++++++++++++++++--
> >>  2 files changed, 82 insertions(+), 23 deletions(-)
> >
> > This patch touches both dma and musb modules, I know it makes review
> > easier, but how we get it merged? One maintainer ACK it and the other
> > pick it up? Sorry for the dumb question, I am new as a maintainer...
> 
> For patches where the change needs to go together, then one maintainer
> can ack, and the other can merge.  Alternately, if the patch can be done

Ok, this is what I thought :)

> in a way that the parts can go independently, that is sometimes
> cleaner.  I don't know this code well enough to know which is which.

In this case it is better to keep all together, since it moves code from
one place to another.

I think it makes sense it goes to my tree, since the reset patches are
for musb.

Regards,
-Bin.
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
