From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Tue, 4 Oct 2016 11:32:16 +0300
Message-ID: <0ff2c6ef-3fa1-dc8b-fb6e-1a4dcfea8ea9@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
 <20161003130318.12591-3-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161003130318.12591-3-mugunthanvnm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mugunthan V N <mugunthanvnm@ti.com>, linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, John Syne <john3909@gmail.com>
List-Id: linux-omap@vger.kernel.org

On 10/03/16 16:03, Mugunthan V N wrote:
> +static int tiadc_request_dma(struct platform_device *pdev,
> +			     struct tiadc_device *adc_dev)
> +{
> +	struct tiadc_dma	*dma = &adc_dev->dma;
> +	dma_cap_mask_t		mask;
> +
> +	/* Default slave configuration parameters */
> +	dma->conf.direction = DMA_DEV_TO_MEM;
> +	dma->conf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
> +	dma->conf.src_addr = adc_dev->mfd_tscadc->tscadc_phys_base + REG_FIFO1;
> +
> +	dma_cap_zero(mask);
> +	dma_cap_set(DMA_CYCLIC, mask);
> +
> +	/* Get a channel for RX */
> +	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
> +	if (!dma->chan)
> +		return -ENODEV;

dma_request_chan() ERR_PTR in case of failure, never NULL. You should reuse
the returned error code to support deferred probing.

> +
> +	/* RX buffer */
> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
> +				      &dma->addr, GFP_KERNEL);
> +	if (!dma->buf)
> +		goto err;
> +
> +	return 0;
> +err:
> +	dma_release_channel(dma->chan);
> +
> +	return -ENOMEM;
> +}
> +
>  static int tiadc_parse_dt(struct platform_device *pdev,
>  			  struct tiadc_device *adc_dev)
>  {
> @@ -512,8 +639,14 @@ static int tiadc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> +	err = tiadc_request_dma(pdev, adc_dev);
> +	if (err && err != -ENODEV)
> +		goto err_dma;

You should handle the deferred probing for DMA channel.

> +
>  	return 0;
>  
> +err_dma:
> +	iio_device_unregister(indio_dev);
>  err_buffer_unregister:
>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>  err_free_channels:
> @@ -525,8 +658,14 @@ static int tiadc_remove(struct platform_device *pdev)
>  {
>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> +	struct tiadc_dma *dma = &adc_dev->dma;
>  	u32 step_en;
>  
> +	if (dma->chan) {
> +		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
> +				  dma->buf, dma->addr);
> +		dma_release_channel(dma->chan);
> +	}
>  	iio_device_unregister(indio_dev);
>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>  	tiadc_channels_remove(indio_dev);
> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
> index e45a208..b9a53e0 100644
> --- a/include/linux/mfd/ti_am335x_tscadc.h
> +++ b/include/linux/mfd/ti_am335x_tscadc.h
> @@ -23,6 +23,8 @@
>  #define REG_IRQENABLE		0x02C
>  #define REG_IRQCLR		0x030
>  #define REG_IRQWAKEUP		0x034
> +#define REG_DMAENABLE_SET	0x038
> +#define REG_DMAENABLE_CLEAR	0x03c
>  #define REG_CTRL		0x040
>  #define REG_ADCFSM		0x044
>  #define REG_CLKDIV		0x04C
> @@ -36,6 +38,7 @@
>  #define REG_FIFO0THR		0xE8
>  #define REG_FIFO1CNT		0xF0
>  #define REG_FIFO1THR		0xF4
> +#define REG_DMA1REQ		0xF8
>  #define REG_FIFO0		0x100
>  #define REG_FIFO1		0x200
>  
> @@ -126,6 +129,10 @@
>  #define FIFOREAD_DATA_MASK (0xfff << 0)
>  #define FIFOREAD_CHNLID_MASK (0xf << 16)
>  
> +/* DMA ENABLE/CLEAR Register */
> +#define DMA_FIFO0		BIT(0)
> +#define DMA_FIFO1		BIT(1)
> +
>  /* Sequencer Status */
>  #define SEQ_STATUS BIT(5)
>  #define CHARGE_STEP		0x11
> 


-- 
Péter
