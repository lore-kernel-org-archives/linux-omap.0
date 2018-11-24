From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [PATCH] dmaengine: ti: omap-dma: Configure LCH_TYPE for OMAP1
Date: Sat, 24 Nov 2018 02:17:40 +0200
Message-ID: <20181124001740.GI12912@darkstar.musicnaut.iki.fi>
References: <20181119104040.12885-1-peter.ujfalusi@ti.com>
 <20181119184649.GE16897@darkstar.musicnaut.iki.fi>
 <6af8c6e7-bf5c-5555-161b-5d3fb7ecae43@ti.com>
 <20181120210406.GB24888@darkstar.musicnaut.iki.fi>
 <4eb3b03e-0a97-6195-f162-e03e32705fe0@ti.com>
 <20181122220114.GB11423@darkstar.musicnaut.iki.fi>
 <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cb1355b5-0d2e-1f83-5ea1-7615350ca0ec@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vkoul@kernel.org, dan.j.williams@intel.com, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, tony@atomide.com, linux-omap@vger.kernel.org, rmk+kernel@armlinux.org.uk, Felipe Balbi <felipe.balbi@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Fri, Nov 23, 2018 at 01:45:46PM +0200, Peter Ujfalusi wrote:
> On 23/11/2018 0.01, Aaro Koskinen wrote:
> > With that reverted, the DMA works OK (and I can also now confirm that
> > OMAP_DMA_LCH_2D works). I haven't yet checked if we actually need that
> > quirk in OMAP UDC,
> 
> The omap_udc driver is a bit of a mess, need to check it myself, but for
> now we can just set the quirk_ep_out_aligned_size and investigate later.

OK, with quirk_ep_out_aligned_size we get 770/16xx DMA working again,
but on 15xx the omap_udc DMA still doesn't work (tested today for the
first time ever, I have no idea if it has ever worked and if so, when?).

A.
