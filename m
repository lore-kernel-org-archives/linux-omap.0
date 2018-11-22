From: Russell King - ARM Linux <linux@armlinux.org.uk>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Thu, 22 Nov 2018 10:29:48 +0000
Message-ID: <20181122102948.GN6920@n2100.armlinux.org.uk>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 20, 2018 at 11:04:06PM +0200, Aaro Koskinen wrote:
> I had switched to PIO mode in 2015 since the WARNs about legacy DMA
> API were too annoying and flooding the console. And now that I tried
> using DMA again with g_ether, it doesn't work anymore. The device get's
> recognized on host side, but no traffic goes through. Switching back to
> PIO makes it to work again.

A solution to that would be to do what the warning message says, and
update the driver to the DMAengine API.

The reason it didn't get updated when the DMAengine conversion happened
is because I don't have hardware for it, so had no way to test, and no
one seemed to know that anyone was using it.  Eventually, the WARN_ON()
was added to try and root out any users and generate interest in
updating the drivers.  Obviously that didn't happen, because people
just worked around the warning rather than saying anything.

I'm afraid we're long past the time that I'd be willing to update the
omap_udc driver now as I've dropped most of my knowledge on that as
it's been four years, and Peter has been looking after OMAP DMAengine
issues since.

Sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
