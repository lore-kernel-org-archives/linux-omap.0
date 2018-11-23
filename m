From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Fri, 23 Nov 2018 00:25:49 +0000
Message-ID: <20181123002549.GO6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
 <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 23, 2018 at 12:24:26AM +0200, Aaro Koskinen wrote:
> Hi,
> 
> On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> > On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
> > > On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> > > > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > > > API were too annoying and flooding the console. And now that I tried
> > > > using DMA again with g_ether, it doesn't work anymore. The device get's
> > > > recognized on host side, but no traffic goes through. Switching back to
> > > > PIO makes it to work again.
> > > 
> > > A solution to that would be to do what the warning message says, and
> > > update the driver to the DMAengine API.
> 
> Fully agreed, but I was busy debugging other more serious issues, and
> just wanted to get a reliable ssh or USB serial access to the device
> without any extra noise, so switching to PIO using a module parameter
> is probably what most users do in such situations.
> 
> > Here's a partial conversion (not even build tested) - it only supports
> > OUT transfers with dmaengine at the moment.
> 
> Thanks, I'll take a closer look and try to do some testing hopefully
> during the weekend.

The patch was more for Peter to take a peek at - there's definitely
some bits missing in the dmaengine driver (like the write to the
LCH_CTRL register) that would need to be fixed somehow.

However, it's worth noting that there is exactly one user of
omap_set_dma_channel_mode(), which is omap-udc, which means any DMA
channel made use of by omap-udc will have the LCH_CTRL register
modified to LCH_P, and it will remain that way even if someone else
subsequently makes use of the same channel.  That's rather suspicious
to me... maybe we can just initialise all LCH_CTRL registers to LCH_P
in the dmaengine driver in that case!  If not, then there's a bug
right there.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
