From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v3 0/2] dmaengine: core/omap-dma: Support for port window
Date: Wed, 30 Nov 2016 08:54:28 +0530
Message-ID: <20161130032428.GZ6408@localhost>
References: <20161129142342.30949-1-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161129142342.30949-1-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk, dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

On Tue, Nov 29, 2016 at 04:23:40PM +0200, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v2:
> - the src/dst_port_window_size is in words, not in bytes (comment updated)
> - correct the port_window based configuration in the omap-dma driver
> 
> Changes since v1:
> - Make sure that the one frame covers the port_window (burst = port_window)
> - added comment to explain the double indexed setup to cover the port_window
> - Simplifications for the code mentioned by Russell and Vinod
> 
> Cover letter from v1:
> 
> as I'm trying to convert the remaining OMAP driver to use DMAengine instead of
> the legacy omap-dma API I have encountered with the
> drivers/usb/musb/tusb6010_omap.c driver.
> 
> The TUSB6010 is connected via NOR FLASH interface and it's register space is
> mapped in the GPMC memory area. In OMAP SoCs we have support for external DMA
> request lines and the TUSB6010 is using those as well.
> 
> With asynchronous access the DMA needs to read/write within the FIFO 'window' in
> incremental address mode to read/write data.
> The constant addressing only works in synchronous mode.
> 
> Since the DMA is driven by external DMA requests, the asynchronous mode is also
> slave DMA operation, but currently the port window can not be 'swiped' as the
> DMAengine only supports single register/address on the slave side.
> 
> This series will add support in dma_slave_config to specify the port side window
> size and the second patch implements the setup needs in omap-dma driver for such
> a transfer.

Applied both, thanks

-- 
~Vinod
