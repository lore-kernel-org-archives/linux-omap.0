From: Mugunthan V N <mugunthanvnm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v2 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Wed, 5 Oct 2016 11:51:56 +0530
Message-ID: <e9c3108e-ffd1-472a-a2d3-2948665de217@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
 <20161003130318.12591-3-mugunthanvnm@ti.com>
 <0ff2c6ef-3fa1-dc8b-fb6e-1a4dcfea8ea9@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0ff2c6ef-3fa1-dc8b-fb6e-1a4dcfea8ea9-l0cyMroinI0@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Peter Meerwald-Stadler <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vignesh R <vigneshr-l0cyMroinI0@public.gmane.org>, "Andrew F . Davis" <afd-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, John Syne <john3909-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Tuesday 04 October 2016 02:02 PM, Peter Ujfalusi wrote:
> On 10/03/16 16:03, Mugunthan V N wrote:
>> +static int tiadc_request_dma(struct platform_device *pdev,
>> +			     struct tiadc_device *adc_dev)
>> +{
>> +	struct tiadc_dma	*dma = &adc_dev->dma;
>> +	dma_cap_mask_t		mask;
>> +
>> +	/* Default slave configuration parameters */
>> +	dma->conf.direction = DMA_DEV_TO_MEM;
>> +	dma->conf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>> +	dma->conf.src_addr = adc_dev->mfd_tscadc->tscadc_phys_base + REG_FIFO1;
>> +
>> +	dma_cap_zero(mask);
>> +	dma_cap_set(DMA_CYCLIC, mask);
>> +
>> +	/* Get a channel for RX */
>> +	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
>> +	if (!dma->chan)
>> +		return -ENODEV;
> 
> dma_request_chan() ERR_PTR in case of failure, never NULL. You should reuse
> the returned error code to support deferred probing.

Will fix this in v3.

> 
>> +
>> +	/* RX buffer */
>> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>> +				      &dma->addr, GFP_KERNEL);
>> +	if (!dma->buf)
>> +		goto err;
>> +
>> +	return 0;
>> +err:
>> +	dma_release_channel(dma->chan);
>> +
>> +	return -ENOMEM;
>> +}
>> +
>>  static int tiadc_parse_dt(struct platform_device *pdev,
>>  			  struct tiadc_device *adc_dev)
>>  {
>> @@ -512,8 +639,14 @@ static int tiadc_probe(struct platform_device *pdev)
>>  
>>  	platform_set_drvdata(pdev, indio_dev);
>>  
>> +	err = tiadc_request_dma(pdev, adc_dev);
>> +	if (err && err != -ENODEV)
>> +		goto err_dma;
> 
> You should handle the deferred probing for DMA channel.

+	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
+	if (IS_ERR(dma->chan)) {
+		int ret = PTR_ERR(dma->chan);
+
+		dma->chan = NULL;
+		return ret;
+	}

With this probe defer will be taken care and ADC will continue without
DMA when request channel returns -ENODEV.

Regards
Mugunthan V N

> 
>> +
>>  	return 0;
>>  
>> +err_dma:
>> +	iio_device_unregister(indio_dev);
>>  err_buffer_unregister:
>>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>>  err_free_channels:
>> @@ -525,8 +658,14 @@ static int tiadc_remove(struct platform_device *pdev)
>>  {
>>  	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>>  	struct tiadc_device *adc_dev = iio_priv(indio_dev);
>> +	struct tiadc_dma *dma = &adc_dev->dma;
>>  	u32 step_en;
>>  
>> +	if (dma->chan) {
>> +		dma_free_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>> +				  dma->buf, dma->addr);
>> +		dma_release_channel(dma->chan);
>> +	}
>>  	iio_device_unregister(indio_dev);
>>  	tiadc_iio_buffered_hardware_remove(indio_dev);
>>  	tiadc_channels_remove(indio_dev);
>> diff --git a/include/linux/mfd/ti_am335x_tscadc.h b/include/linux/mfd/ti_am335x_tscadc.h
>> index e45a208..b9a53e0 100644
>> --- a/include/linux/mfd/ti_am335x_tscadc.h
>> +++ b/include/linux/mfd/ti_am335x_tscadc.h
>> @@ -23,6 +23,8 @@
>>  #define REG_IRQENABLE		0x02C
>>  #define REG_IRQCLR		0x030
>>  #define REG_IRQWAKEUP		0x034
>> +#define REG_DMAENABLE_SET	0x038
>> +#define REG_DMAENABLE_CLEAR	0x03c
>>  #define REG_CTRL		0x040
>>  #define REG_ADCFSM		0x044
>>  #define REG_CLKDIV		0x04C
>> @@ -36,6 +38,7 @@
>>  #define REG_FIFO0THR		0xE8
>>  #define REG_FIFO1CNT		0xF0
>>  #define REG_FIFO1THR		0xF4
>> +#define REG_DMA1REQ		0xF8
>>  #define REG_FIFO0		0x100
>>  #define REG_FIFO1		0x200
>>  
>> @@ -126,6 +129,10 @@
>>  #define FIFOREAD_DATA_MASK (0xfff << 0)
>>  #define FIFOREAD_CHNLID_MASK (0xf << 16)
>>  
>> +/* DMA ENABLE/CLEAR Register */
>> +#define DMA_FIFO0		BIT(0)
>> +#define DMA_FIFO1		BIT(1)
>> +
>>  /* Sequencer Status */
>>  #define SEQ_STATUS BIT(5)
>>  #define CHARGE_STEP		0x11
>>
> 
> 
