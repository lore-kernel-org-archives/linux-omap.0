From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting channel
Date: Mon, 30 Nov 2015 15:18:02 +0100
Message-ID: <13562653.8QgTG33tZS@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
In-Reply-To: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Monday 30 November 2015 15:45:30 Peter Ujfalusi wrote:
> Changes since RFC v01:
>- dma_request_chan(); lost the mask parameter
>- The new API does not rely on RESOURCE_DMA, instead the dma_filter_map table
>  will be used to provide the needed information to the filter function in
>  legacy mode
>- Extended the example patches to convert most of daVinci to use the new API to
>  request the DMA channels.

Very nice overall. Just a few minor comments.

> static struct dma_filter_map da830_edma_map[] = {
>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)),
>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)),
>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)),
>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, 3)),
>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, 4)),
>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, 5)),
>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14)),
>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15)),
>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16)),
>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17)),
>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18)),
>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19)),
> };

I wonder if we should mandate that the lookup table is 'const'.

We could also drop the DMA_FILTER_ENTRY() macro above, and open-code the
table like

static struct dma_filter_map da830_edma_map[] = {
         { "davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)},
         { "davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)},
         { "davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)},
	 ...
};

which is a little more compact and more obvious, but loses the
named initializers.

	Arnd
