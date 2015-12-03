From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH 0/4] dmaengine: New 'universal' API for requesting channel
Date: Thu, 3 Dec 2015 18:32:20 +0200
Message-ID: <CAHp75VeLvxwc910ZM-X1_sfZhmf+05CXMuHkMdhVZVHrEmTrDQ@mail.gmail.com>
References: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1449153192-9082-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Dec 3, 2015 at 4:33 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:
> Hi,

> As it has been discussed in the following thread:
> http://www.gossamer-threads.com/lists/linux/kernel/2181487#2181487
>
> With this series I have taken a path which would result two new API, which can
> be used to convert most of the current users already and with some work all
> users might be able to move to this set.
> With this set the filter_fn used for legacy (non DT/ACPI) channel request is no
> longer needed to be exported to client drivers since the selection of the
> correct filter_fn will be done in the core.
>
> So, the first proposal is to have:
>
> struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
>
> The dma_request_chan_by_mask() is to request any channel matching with the
> requested capabilities, can be used to request channel for memcpy, memset, xor,
> etc where no hardware synchronization is needed.
>
> The dma_request_chan() is to request a slave channel. The dma_request_chan()
> will try to find the channel via DT, ACPI or in case if the kernel booted in non
> DT/ACPI mode it will use a filter lookup table and retrieves the needed
> information from the dma_slave_map provided by the DMA drivers.
> This legacy mode needs changes in platform code, in dmaengine drivers and
> finally the dmaengine user drivers can be converted:
>
> For each dmaengine driver an array of DMA device, slave and the parameter
> for the filter function needs to be added:
>
> static const struct dma_slave_map da830_edma_map[] = {
>         { "davinci-mcasp.0", "rx", EDMA_FILTER_PARAM(0, 0) },
>         { "davinci-mcasp.0", "tx", EDMA_FILTER_PARAM(0, 1) },
>         { "davinci-mcasp.1", "rx", EDMA_FILTER_PARAM(0, 2) },
>         { "davinci-mcasp.1", "tx", EDMA_FILTER_PARAM(0, 3) },
>         { "davinci-mcasp.2", "rx", EDMA_FILTER_PARAM(0, 4) },
>         { "davinci-mcasp.2", "tx", EDMA_FILTER_PARAM(0, 5) },
>         { "spi_davinci.0", "rx", EDMA_FILTER_PARAM(0, 14) },
>         { "spi_davinci.0", "tx", EDMA_FILTER_PARAM(0, 15) },
>         { "da830-mmc.0", "rx", EDMA_FILTER_PARAM(0, 16) },
>         { "da830-mmc.0", "tx", EDMA_FILTER_PARAM(0, 17) },
>         { "spi_davinci.1", "rx", EDMA_FILTER_PARAM(0, 18) },
>         { "spi_davinci.1", "tx", EDMA_FILTER_PARAM(0, 19) },
> };
>
> This information is going to be used by the dmaengine driver, so
> modification to the platform_data is needed, and the driver map should be
> added to the pdata of the DMA driver:
>
> da8xx_edma0_pdata.slave_map = da830_edma_map;
> da8xx_edma0_pdata.slavecnt = ARRAY_SIZE(da830_edma_map);
>
> The DMA driver then needs to configure the needed device -> filter_fn
> mapping before it registers with dma_async_device_register() :
>
> if (info->slave_map) {
>         ecc->dma_slave.filter_map.map = info->slave_map;
>         ecc->dma_slave.filter_map.mapcnt = info->slavecnt;
>         ecc->dma_slave.filter_map.filter_fn = edma_filter_fn;
> }
>
> When neither DT or ACPI lookup is available the dma_request_chan() will
> try to match the requester's device name with the filter_map's list of
> device names, when a match found it will use the information from the
> dma_slave_map to get the channel with the dma_get_channel() internal
> function.

For patches 1-3 with regard to comment on 3:
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

-- 
With Best Regards,
Andy Shevchenko
