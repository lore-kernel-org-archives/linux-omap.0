From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Sat, 24 Nov 2018 20:09:42 +0000
Message-ID: <20181124200942.GS6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <6ed280af-edb6-4be7-82f4-7fc00378103e@ti.com>
 <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181123185215.GH12912@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>, tony@atomide.com
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 23, 2018 at 08:52:15PM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Fri, Nov 23, 2018 at 02:35:04PM +0200, Peter Ujfalusi wrote:
> > On 22/11/2018 17.12, Russell King - ARM Linux wrote:
> > > I'm also not sure about this:
> > > 
> > >         if (cpu_is_omap15xx())
> > >                 end++;
> > > 
> > > in dma_dest_len() - is that missing from the omap-dma driver?  It looks
> > > like a work-around for some problem on OMAP15xx, but I can't make sense
> > > about why it's in the UDC driver rather than the legacy DMA driver.
> > 
> > afaik no other legacy drivers were doing similar thing, this must be
> > something which is needed for the omap_udc driver to fix up something?
> 
> Here's the patch that added it: https://marc.info/?l=linux-omap&m=119634396324221&w=2
> 
> "Make DMA-OUT behave on the 1510 ... the 1510 CPC register was just
> off-by-one with respect to the 1611 CDAC"

... which suggests that's a problem with the CPC register itself, and
we should fix that in the DMAengine driver rather than the USB gadget
driver.

Tony, any input on this?

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
