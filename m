From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP1: DMA: Provide dma_slave_map to omap-dma
Date: Mon, 22 Feb 2016 10:02:01 -0800
Message-ID: <20160222180201.GK13417@atomide.com>
References: <1454423227-31830-1-git-send-email-peter.ujfalusi@ti.com>
 <1454423227-31830-2-git-send-email-peter.ujfalusi@ti.com>
 <20160219214426.GK1640@darkstar.musicnaut.iki.fi>
 <56CAB676.6080309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56CAB676.6080309@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160221 23:19]:
> On 2016-02-19 23:44, Aaro Koskinen wrote:
> > On Tue, Feb 02, 2016 at 04:27:06PM +0200, Peter Ujfalusi wrote:
> >> OMAP1 can not boot in DT mode and to be able to clean up the driver
> >> regarding to the dmaengine API use (switching to the new API) the
> >> device/slave -> filter mapping needs to be provided to the omap-dma driver.
> >>
> >> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > 
> > Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> 
> Thanks Aaro,
> 
> I believe the map covers all drivers using DMA, but in case I missed any we -
> you ;) will notice it as they will fail to get the DMA channels. This only
> going to be visible after I send the driver changes for 4.7. In such a case we
> will need to add the given device to the list.

Yeah makes sense. Applying both into omap-for-v4.6/soc thanks.

Tony
