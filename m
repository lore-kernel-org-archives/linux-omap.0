From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Mon, 17 Dec 2018 21:16:58 +0200
Message-ID: <20181217191657.GB7288@darkstar.musicnaut.iki.fi>
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
To: Russell King - ARM Linux <linux@armlinux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 22, 2018 at 03:12:36PM +0000, Russell King - ARM Linux wrote:
> Also we can't deal with the omap_set_dma_dest_burst_mode() setting -
> DMAengine always uses a 64 byte burst, but udc wants a smaller burst
> setting.  Does this matter?

Looking at OMAP1 docs, it seems it supports only 16 bytes. Then checking
DMAengine code, I don't think these CSDP bit values are not valid
for OMAP1:

        CSDP_SRC_BURST_1        = 0 << 7,
        CSDP_SRC_BURST_16       = 1 << 7,
        CSDP_SRC_BURST_32       = 2 << 7,
        CSDP_SRC_BURST_64       = 3 << 7,

>From TI SPRU674 document, pages 50-51:

	0	single access (no burst)
	1	single access (no burst)
	2	burst 4
	3	reserved (do not use this setting)

So if CSDP_SRC_BURST_64 (3) gets programmed OMAP1, I wonder what is the
end result, no burst or burst 4...

A.
