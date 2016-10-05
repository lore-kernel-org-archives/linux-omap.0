From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: Re: [PATCH v2 2/4] drivers: iio: ti_am335x_adc: add dma support
Date: Wed, 5 Oct 2016 14:22:38 +0530
Message-ID: <d059db2e-c5fc-f1a9-47ad-0ffbb0c4f86b@ti.com>
References: <20161003130318.12591-1-mugunthanvnm@ti.com>
 <20161003130318.12591-3-mugunthanvnm@ti.com>
 <0ff2c6ef-3fa1-dc8b-fb6e-1a4dcfea8ea9@ti.com>
 <e9c3108e-ffd1-472a-a2d3-2948665de217@ti.com>
 <de6bbf1c-e9e2-83b1-73c2-49aa64cc939c@ti.com>
 <1ffce826-b94a-5b9f-ffb4-ba2d0324b246@ti.com>
 <f00632fa-a542-c633-ae5e-3a42cf364a9f@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f00632fa-a542-c633-ae5e-3a42cf364a9f@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-iio@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Lee Jones <lee.jones@linaro.org>, Vignesh R <vigneshr@ti.com>, "Andrew F . Davis" <afd@ti.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, John Syne <john3909@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wednesday 05 October 2016 02:16 PM, Peter Ujfalusi wrote:
> On 10/05/16 11:17, Mugunthan V N wrote:
>> On Wednesday 05 October 2016 12:01 PM, Peter Ujfalusi wrote:
>>> On 10/05/16 09:21, Mugunthan V N wrote:
>>>> On Tuesday 04 October 2016 02:02 PM, Peter Ujfalusi wrote:
>>>>> On 10/03/16 16:03, Mugunthan V N wrote:
>>>>>> +static int tiadc_request_dma(struct platform_device *pdev,
>>>>>> +			     struct tiadc_device *adc_dev)
>>>>>> +{
>>>>>> +	struct tiadc_dma	*dma = &adc_dev->dma;
>>>>>> +	dma_cap_mask_t		mask;
>>>>>> +
>>>>>> +	/* Default slave configuration parameters */
>>>>>> +	dma->conf.direction = DMA_DEV_TO_MEM;
>>>>>> +	dma->conf.src_addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>>>>>> +	dma->conf.src_addr = adc_dev->mfd_tscadc->tscadc_phys_base + REG_FIFO1;
>>>>>> +
>>>>>> +	dma_cap_zero(mask);
>>>>>> +	dma_cap_set(DMA_CYCLIC, mask);
>>>>>> +
>>>>>> +	/* Get a channel for RX */
>>>>>> +	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
>>>>>> +	if (!dma->chan)
>>>>>> +		return -ENODEV;
>>>>>
>>>>> dma_request_chan() ERR_PTR in case of failure, never NULL. You should reuse
>>>>> the returned error code to support deferred probing.
>>>>
>>>> Will fix this in v3.
>>>>
>>>>>
>>>>>> +
>>>>>> +	/* RX buffer */
>>>>>> +	dma->buf = dma_alloc_coherent(dma->chan->device->dev, DMA_BUFFER_SIZE,
>>>>>> +				      &dma->addr, GFP_KERNEL);
>>>>>> +	if (!dma->buf)
>>>>>> +		goto err;
>>>>>> +
>>>>>> +	return 0;
>>>>>> +err:
>>>>>> +	dma_release_channel(dma->chan);
>>>>>> +
>>>>>> +	return -ENOMEM;
>>>>>> +}
>>>>>> +
>>>>>>  static int tiadc_parse_dt(struct platform_device *pdev,
>>>>>>  			  struct tiadc_device *adc_dev)
>>>>>>  {
>>>>>> @@ -512,8 +639,14 @@ static int tiadc_probe(struct platform_device *pdev)
>>>>>>  
>>>>>>  	platform_set_drvdata(pdev, indio_dev);
>>>>>>  
>>>>>> +	err = tiadc_request_dma(pdev, adc_dev);
>>>>>> +	if (err && err != -ENODEV)
>>>>>> +		goto err_dma;
>>>>>
>>>>> You should handle the deferred probing for DMA channel.
>>>>
>>>> +	dma->chan = dma_request_chan(adc_dev->mfd_tscadc->dev, "fifo1");
>>>> +	if (IS_ERR(dma->chan)) {
>>>> +		int ret = PTR_ERR(dma->chan);
>>>> +
>>>> +		dma->chan = NULL;
>>>> +		return ret;
>>>
>>> You don't need the 'ret' variable:
>>> 		return PTR_ERR(dma->chan);
>>
>> So you mean change all *if (dma->chan)* to *if (IS_ERR(dma->chan))*?
> 
> Oh, sorry. Your version was fine as you NULL the dma->chan before the return.
> 
>>
>>>
>>>> +	}
>>>>
>>>> With this probe defer will be taken care and ADC will continue without
>>>> DMA when request channel returns -ENODEV.
>>>
>>> I would rather have explicit check for deferred probe:
>>>
>>> err = tiadc_request_dma(pdev, adc_dev);
>>> if (err && err == -EPROBE_DEFER)
>>> 	goto err_dma;
>>
>> But in this case any other failure other than -EPROBE_DEFER will be
>> masked and ADC will be in PIO mode?
> 
> Yes, exactly. If we fail to get the DMA channel we should not use the DMA and
> we only want to handle the deferred probing.
> 

Okay, will update accordingly in next version.

Regards
Mugunthan V N
