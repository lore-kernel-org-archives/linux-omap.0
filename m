From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2 0/7] dmaengine: cppi41: Make CPPI 4.1 driver more
 generic
Date: Tue, 17 Jan 2017 08:20:52 -0800
Message-ID: <20170117162052.GK7403@atomide.com>
References: <20170117134540.9988-1-abailon@baylibre.com>
 <20170117155545.GI7403@atomide.com>
 <28b57293-4395-4281-0c64-19f299e6eaf6@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <28b57293-4395-4281-0c64-19f299e6eaf6-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org>
Cc: Alexandre Bailon <abailon-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, b-liu-l0cyMroinI0@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ptitiano-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-omap@vger.kernel.org

* Sergei Shtylyov <sergei.shtylyov-M4DtvfQ/ZS1MRgGoP+s0PdBPR1lH4CV8@public.gmane.org> [170117 08:06]:
> On 01/17/2017 06:55 PM, Tony Lindgren wrote:
> 
> > > Most of the patch of this series were part of
> > > "[PATCH 00/11] dmaengine: cppi41: Add dma support to da8xx"
> > > 
> > > This series intend to make the CPPI 4.1 more generic in order to
> > > add a new platform (the DA8xx).
> > > To achieve that, all the IRQ code present in CPPI 4.1 driver has been moved
> > > to MUSB DSPS driver.
> > > Other changes mainly update the glue layer and platform code to make the
> > > whole driver more generic.
> > 
> > So does da8xx use CPPI 4.1 DMA for other devices also in addition to
> > musb?
> 
>    No. DA8xx CPPI 4.1 is implemented as a part of the MUSB peripheral.
> But there were a SoC (support for which never got merged upstream) where
> CPPI 4.1 DMA is not limited to USB.

OK thanks for confirming it may pop up in some other devices too.

Anyways that means we can make the cppi41.c runtime PM support simpler
as it's always guaranteed to be enabled when in use with musb.

Regards,

Tony

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
