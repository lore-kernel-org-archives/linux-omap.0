From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Fri, 23 Nov 2018 00:24:26 +0200
Message-ID: <20181122222426.GC11423@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <20181122102948.GN6920@n2100.armlinux.org.uk>
 <20181122151236.GA9611@n2100.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181122151236.GA9611@n2100.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> On Thu, Nov 22, 2018 at 10:29:48AM +0000, Russell King - ARM Linux wrote:
> > On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> > > I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> > > API were too annoying and flooding the console. And now that I tried
> > > using DMA again with g_ether, it doesn't work anymore. The device get's
> > > recognized on host side, but no traffic goes through. Switching back to
> > > PIO makes it to work again.
> > 
> > A solution to that would be to do what the warning message says, and
> > update the driver to the DMAengine API.

Fully agreed, but I was busy debugging other more serious issues, and
just wanted to get a reliable ssh or USB serial access to the device
without any extra noise, so switching to PIO using a module parameter
is probably what most users do in such situations.

> Here's a partial conversion (not even build tested) - it only supports
> OUT transfers with dmaengine at the moment.

Thanks, I'll take a closer look and try to do some testing hopefully
during the weekend.

A.
