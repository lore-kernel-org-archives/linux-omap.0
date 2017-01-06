From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP1: DMA: Correct the number of logical channels
Date: Fri, 6 Jan 2017 08:33:35 -0800
Message-ID: <20170106163335.GE2630@atomide.com>
References: <20170103112234.19097-1-peter.ujfalusi@ti.com>
 <20170105214750.g7d6kbaq7q4vgrug@raspberrypi-2.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170105214750.g7d6kbaq7q4vgrug@raspberrypi-2.musicnaut.iki.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Aaro Koskinen <aaro.koskinen@iki.fi> [170105 13:48]:
> Hi,
> 
> On Tue, Jan 03, 2017 at 01:22:34PM +0200, Peter Ujfalusi wrote:
> > OMAP1510, OMAP5910 and OMAP310 have only 9 logical channels.
> > OMAP1610, OMAP5912, OMAP1710, OMAP730, and OMAP850 have 16 logical channels
> > available.
> > 
> > The wired 17 for the lch_count must have been used to cover the 16 + 1
> > dedicated LCD channel, in reality we can only use 9 or 16 channels.
> > 
> > The d->chan_count is not used by the omap-dma stack, so we can skip the
> > setup. chan_count was configured to the number of logical channels and not
> > the actual number of physical channels anyways.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Applying into omap-for-v4.10/fixes thanks.

Tony
