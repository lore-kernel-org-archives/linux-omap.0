From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] ARM: dts: am33x, da816x, da814x: Remove useless register
 address
Date: Tue, 17 Jan 2017 08:28:42 -0800
Message-ID: <20170117162842.GN7403@atomide.com>
References: <20170117135420.10197-1-abailon@baylibre.com>
 <20170117154752.GH7403@atomide.com>
 <08fc8b99-e6c4-7282-8023-b0d37956428c@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <08fc8b99-e6c4-7282-8023-b0d37956428c-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170117 08:17]:
> On 01/17/2017 04:47 PM, Tony Lindgren wrote:
> > * Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org> [170117 05:55]:
> >> In order to make CPPI 4.1 DMA driver more generic, accesses to USBSS
> >> have been removed. So it is not required anymore to define "glue"
> >> register's address and size in DT.
> >> Remove "glue" register from cppi41dma node.
> > 
> > Is this OK to queue later on after all the dependencies have been
> > merged?
> It should be queued on same time as "[PATCH v2 3/7] dmaengine: cppi41:
> Remove usbss_mem", so yes I guess it is OK.

Sounds like it will break things then.. Please read about "flag day"
changes and why they are not accepted.

You should make the driver work with the old and new binding, then
we can just drop the old binding later on from the dts files.

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
