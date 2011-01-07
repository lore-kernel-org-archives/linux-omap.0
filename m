From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure - solved + SPI bug fix
Date: Fri, 7 Jan 2011 09:10:20 -0800
Message-ID: <20110107171020.GF880@atomide.com>
References: <20110106235203.GA14425@n2100.arm.linux.org.uk>
 <d540408e2df154cf13932e79d3a11ceb@mail.gmail.com>
 <20110107092800.GJ1198@n2100.arm.linux.org.uk>
 <86f60bc5418ca1d3e87db960e5e2c48f@mail.gmail.com>
 <729152acd9ee0c3e3e3cd505e84f8865@mail.gmail.com>
 <20110107125132.GM1198@n2100.arm.linux.org.uk>
 <48cbfb338be4d33a8a19e070430d015b@mail.gmail.com>
 <20110107142432.GO1198@n2100.arm.linux.org.uk>
 <c71399f20609c539b8c335344963253f@mail.gmail.com>
 <20110107154920.GQ1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:12244 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754551Ab1AGRKk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 7 Jan 2011 12:10:40 -0500
Content-Disposition: inline
In-Reply-To: <20110107154920.GQ1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-omap@vger.kernel.org

Grant,

Care to queue or ack the following fix?

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 07:48]:
> On Fri, Jan 07, 2011 at 07:56:34PM +0530, Santosh Shilimkar wrote:
> > > -----Original Message-----
> > > From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> > > Sent: Friday, January 07, 2011 7:55 PM
> > > To: Santosh Shilimkar
> > > Cc: linux-omap@vger.kernel.org; Tony Lindgren
> > > Subject: Re: 4430SDP boot failure
> > >
> > > On Fri, Jan 07, 2011 at 06:39:06PM +0530, Santosh Shilimkar wrote:
> > > > Have sent you latest bootloaders and full bootlog on my ES1.0
> > > > OMAP4430SDP. 2.6.37 just boots fine for me.
> > > >
> > > > Low level debug as you reported seems to be broken though.
> > >
> > > Many thanks, the new mlo and uboot gets dhcp/tftp working nicely on
> > > the board - which should ease the debugging problem as it no longer
> > > requires anything but the reset button pressed to test a new kernel.
> > 
> > Glad to hear that.
> 
> And, with one ARM errata disabled, the kernel finally boots.  So the
> "X-Loader hangs" message means that we did something that non-secure
> mode prevented us from doing.
> 
> It would be a good idea if X-loader could tell dump out the exception,
> register dump, and for data/prefetch aborts, the relevent FSR and FAR
> registers - that would make debugging this kind of failure a lot
> easier.
> 
> =================
> Subject: Fix DMA API usage in OMAP MCSPI driver
> 
> Running the latest kernel on the 4430SDP board with DMA API debugging
> enabled results in this:
> 
> WARNING: at lib/dma-debug.c:803 check_unmap+0x19c/0x6f0()
> NULL NULL: DMA-API: device driver tries to free DMA memory it has not allocated
> [device address=0x000000008129901a] [size=260 bytes]
> Modules linked in:
> Backtrace:
> [<c003cbe0>] (dump_backtrace+0x0/0x10c) from [<c0278da8>] (dump_stack+0x18/0x1c)
>  r7:c1839dc0 r6:c0198578 r5:c0304b17 r4:00000323
> [<c0278d90>] (dump_stack+0x0/0x1c) from [<c005b158>] (warn_slowpath_common+0x58/0x70)
> [<c005b100>] (warn_slowpath_common+0x0/0x70) from [<c005b214>] (warn_slowpath_fmt+0x38/0x40)
>  r8:c1839e40 r7:00000000 r6:00000104 r5:00000000 r4:8129901a
> [<c005b1dc>] (warn_slowpath_fmt+0x0/0x40) from [<c0198578>] (check_unmap+0x19c/0x6f0)
>  r3:c03110de r2:c0304e6b
> [<c01983dc>] (check_unmap+0x0/0x6f0) from [<c0198cd8>] (debug_dma_unmap_page+0x74/0x80)
> [<c0198c64>] (debug_dma_unmap_page+0x0/0x80) from [<c01d5ad8>] (omap2_mcspi_work+0x514/0xbf0)
> [<c01d55c4>] (omap2_mcspi_work+0x0/0xbf0) from [<c006dfb0>] (process_one_work+0x294/0x400)
> [<c006dd1c>] (process_one_work+0x0/0x400) from [<c006e50c>] (worker_thread+0x220/0x3f8)
> [<c006e2ec>] (worker_thread+0x0/0x3f8) from [<c00738d0>] (kthread+0x88/0x90)
> [<c0073848>] (kthread+0x0/0x90) from [<c005e924>] (do_exit+0x0/0x5fc)
>  r7:00000013 r6:c005e924 r5:c0073848 r4:c1829ee0
> ---[ end trace 1b75b31a2719ed20 ]---
> 
> I've no idea why this driver uses NULL for dma_unmap_single instead of
> the &spi->dev that is laying around just waiting to be used in that
> function - but it's an easy fix.
> 
> Also replace this comment with a FIXME comment:
>                 /* Do DMA mapping "early" for better error reporting and
>                  * dcache use.  Note that if dma_unmap_single() ever starts
>                  * to do real work on ARM, we'd need to clean up mappings
>                  * for previous transfers on *ALL* exits of this loop...
>                  */
> as the comment is not true - we do work in dma_unmap() functions,
> particularly on ARMv6 and above.  I've corrected the existing unmap
> functions but if any others are required they must be added ASAP.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>


> ---
> I'm surprised this driver got merged as it has such a comment, and is
> abusing the DMA API... well, at least with the DMA API debugging we
> can now catch this stuff.
> 
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index 951a160..abb1ffb 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -397,7 +397,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  
>  	if (tx != NULL) {
>  		wait_for_completion(&mcspi_dma->dma_tx_completion);
> -		dma_unmap_single(NULL, xfer->tx_dma, count, DMA_TO_DEVICE);
> +		dma_unmap_single(&spi->dev, xfer->tx_dma, count, DMA_TO_DEVICE);
>  
>  		/* for TX_ONLY mode, be sure all words have shifted out */
>  		if (rx == NULL) {
> @@ -412,7 +412,7 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct spi_transfer *xfer)
>  
>  	if (rx != NULL) {
>  		wait_for_completion(&mcspi_dma->dma_rx_completion);
> -		dma_unmap_single(NULL, xfer->rx_dma, count, DMA_FROM_DEVICE);
> +		dma_unmap_single(&spi->dev, xfer->rx_dma, count, DMA_FROM_DEVICE);
>  		omap2_mcspi_set_enable(spi, 0);
>  
>  		if (l & OMAP2_MCSPI_CHCONF_TURBO) {
> @@ -1025,11 +1025,6 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
>  		if (m->is_dma_mapped || len < DMA_MIN_BYTES)
>  			continue;
>  
> -		/* Do DMA mapping "early" for better error reporting and
> -		 * dcache use.  Note that if dma_unmap_single() ever starts
> -		 * to do real work on ARM, we'd need to clean up mappings
> -		 * for previous transfers on *ALL* exits of this loop...
> -		 */
>  		if (tx_buf != NULL) {
>  			t->tx_dma = dma_map_single(&spi->dev, (void *) tx_buf,
>  					len, DMA_TO_DEVICE);
> @@ -1046,7 +1041,7 @@ static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_message *m)
>  				dev_dbg(&spi->dev, "dma %cX %d bytes error\n",
>  						'R', len);
>  				if (tx_buf != NULL)
> -					dma_unmap_single(NULL, t->tx_dma,
> +					dma_unmap_single(&spi->dev, t->tx_dma,
>  							len, DMA_TO_DEVICE);
>  				return -EINVAL;
>  			}
> 
