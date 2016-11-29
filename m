From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/2] dmaengine: dma_slave_config: add support for slave
 port window
Date: Tue, 29 Nov 2016 12:47:48 +0200
Message-ID: <1c9221e8-c2e9-4d87-4d74-670e1bc2fec1@ti.com>
References: <20161117125017.14954-1-peter.ujfalusi@ti.com>
 <20161117125017.14954-2-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117125017.14954-2-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: vinod.koul@intel.com, dan.j.williams@intel.com, tony@atomide.com, linux@armlinux.org.uk
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, arnd@arndb.de
List-Id: linux-omap@vger.kernel.org

Vinod,

On 11/17/2016 02:50 PM, Peter Ujfalusi wrote:
> Some slave devices uses address window instead of single register for read
> and/or write of data. With the src/dst_port_window_size the address window
> can be specified and the DMAengine driver should use this information to
> correctly set up the transfer to loop within the provided window.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  include/linux/dmaengine.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
> index cc535a478bae..689d44327ef3 100644
> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -336,6 +336,12 @@ enum dma_slave_buswidth {
>   * may or may not be applicable on memory sources.
>   * @dst_maxburst: same as src_maxburst but for destination target
>   * mutatis mutandis.
> + * @src_port_window_size: The length of the register area the data need to be
> + * written on the device side. It is only used for devices which is using an
> + * area instead of a single register to receive the data. Typically the DMA
> + * loops in this area in order to transfer the data.
> + * @dst_port_window_size: same as src_port_window_size but for the destination
> + * port.

I think this needs some clarification.
Should the src/dst_port_window_size be in bytes or in words? I think it would
make more sense to define it as number of words to be in sync with the
src/dst_maxburst.

I will need to resend the series either way. The omap-dma patch does not
handle this correctly.

>   * @device_fc: Flow Controller Settings. Only valid for slave channels. Fill
>   * with 'true' if peripheral should be flow controller. Direction will be
>   * selected at Runtime.
> @@ -363,6 +369,8 @@ struct dma_slave_config {
>  	enum dma_slave_buswidth dst_addr_width;
>  	u32 src_maxburst;
>  	u32 dst_maxburst;
> +	u32 src_port_window_size;
> +	u32 dst_port_window_size;
>  	bool device_fc;
>  	unsigned int slave_id;
>  };
> 


-- 
Péter
