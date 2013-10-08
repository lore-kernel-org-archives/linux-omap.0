From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [RESEND PATCH v3 03/11] ASoC: davinci-mcasp: Add DMA register
 locations to DT
Date: Tue, 8 Oct 2013 12:13:59 +0300
Message-ID: <5253CCD7.2080606@ti.com>
References: <cover.1379590035.git.jsarha@ti.com> <66bdda0c0b75d737d649260b9ec10f9f870c20cd.1379590036.git.jsarha@ti.com> <20131007214718.GA2976@kartoffel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:52244 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754641Ab3JHJOO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 05:14:14 -0400
In-Reply-To: <20131007214718.GA2976@kartoffel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "peter.ujfalusi@ti.com" <peter.ujfalusi@ti.com>, "broonie@kernel.org" <broonie@kernel.org>, "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "bcousson@baylibre.com" <bcousson@baylibre.com>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "joelf@ti.com" <joelf@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, Darren Etheridge <detheridge@ti.com>

On 10/08/2013 12:47 AM, Mark Rutland wrote:
> Hello,
Hi!
I am not the author of this driver so my knowledge may have gaps, when 
it comes to details I have not touched yet. Anyway, I do my best to 
address your comments.

...
>> -- reg : Should contain McASP registers offset and length
>> +- reg : Should contain McASP registers address and length for mpu and
>> +	optionally for dma controller access.
>> +- reg-names : The mandatory reg-range must be named "mpu" and the optional DMA
>> +	      reg-range must be named "dma". For backward compatibility it is
>> +	      good to keep "mpu" first in the list.
>
> I've never heard the term "reg-range" before. The should probably be something
> like "reg entry". How about something like the following instead:
>
Well, an address and length describes a "range", but if it is not 
commonly used term, there is no need to use it here either.

> - reg: Should contain reg specifiers for the entries in the reg-names property.
>
> - reg-names: Should contain:
> 	     * "mpu" for the main registers (required). For compatibility with
> 	       existing software, it is recommended this is the first entry.
> 	     * "dma" for the DMA registers (optional).
>
> That way we don't end up describing each reg entry twice.

The both contain the same information, but your version is certainly 
easier to read. I'll take it. Thanks!

>
> I have some questions however. I took a look at the McASP (TMS320C6000)
> reference guide, and the registers appeared to all be in one contiguous bank,
> and "mpu" and "dma" don't appear to be names of particular registers or names
> of banks of particular registers. Am I looking in the wrong place? Is there
> up-to-date documentation I can look at?
>
> Why are these split across two reg entries, and which particular registers do
> they actually cover?

The need for two different register properties does not come from McASP 
IP, but from SoC design. On AM33XX the McASP registers are mapped for 
MPU through L4 bus, which is no accessible to the DMA controller. The 
McASP data port registers are mapped trough L3 buss to a different 
address for DMA controller. Maybe the second register property could be 
called to "dat" instead of "dma" since only data port registers are 
mapped trough that address.

>
> I have some concern about the description of other properties too. If we're
> going to amend the binding, they should be fixed up too.
>
>>   - interrupts : Interrupt number for McASP
>
> The device also seems to be able to generate multiple interrupts -- which
> interrupt does this actually cover?
>
> The driver doesn't seem to use it (by a grep of irq|interrupt). Have I missed
> something?
>

No you have not. A later patch in this set make the interrupt property 
optional and adds "tx" and "rx" interrupt-names:
http://mailman.alsa-project.org/pipermail/alsa-devel/2013-September/066732.html

>>   - op-mode : I2S/DIT ops mode.
>
> What type is this?

That property selects whether McASP is working in I2S mode or in 
Integrated Digital audio interface Transmitter (DIT) mode for S/PDIF, 
IEC60958-1, AES-3 formats.

>
> What are valid values?

0 and 1. I'll document those. Thanks.

>>   - tdm-slots : Slots for TDM operation.
>
> Here too. This description is completely opaque.
>

I am not absolutely sure here. I'll check the details and try to come up 
with a better description.

Talking about num-serializer and serial-dir property here...

> Taking a look at the version in kernel sources this appears to be a list of
> values, in groups of four?
>
> What is the format of this property?
>
>> @@ -15,7 +19,6 @@ Required properties:
>>   		to "num-serializer" parameter. Each entry is a number indication
>>   		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
>>
>> -

The McASP can have up to 16 serializers for selecting data pin usage. 
The numbers have been grouped into 4x4 matrix only for better 
readability. BTW, the num-serializers property is redundant and it will 
be removed in the next version of the patch series.

>>   Optional properties:
>>
>>   - ti,hwmods : Must be "mcasp<n>", n is controller instance starting 0
>> @@ -31,6 +34,7 @@ mcasp0: mcasp0@1d00000 {
>>   	#address-cells = <1>;
>>   	#size-cells = <0>;
>
> Why does this have #address-cells and #size-cells? There are no children in the
> example.
>

I removed those from the actual dts file, but forgot to do so here. I'll 
fix that. Thanks!

>>   	reg = <0x100000 0x3000>;
>> +	reg-names "mpu";
>>   	interrupts = <82 83>;
>>   	op-mode = <0>;		/* MCASP_IIS_MODE */
>>   	tdm-slots = <2>;
>
> A few questions from a brief skim of the documentation:
>
> There seem to be external clocks (AHCLKR and ACLKR), but they aren't described.
> Are we always able to use an internal clock instead? Is no external reference
> clock needed?

As far as I understand the choice is to use either McASP internal clock 
or codec provided clock. The selection is made by the machine/platform 
driver by calling snd_soc_dai_set_fmt() and applying the required bits 
in SND_SOC_DAIFMT_MASTER_MASK. I guess the choice may not always be HW 
specific.

>
> The err_release_clk label in the error path confuses me -- which clock(s) does
> the preceding pm_runtime_get ensure remains active? One internal to the McASP?
>

I guess that is really up to machine/platform driver that configures dapm.

> It looks like some pins can be used as GPIO -- is there not a need for something
> like pinctrl for configuring this?
>

That is true, but since driver does not support it and there is no 
example of GPIO usage, no guess work has been done about the required DT 
properties.

> Cheers,
> Mark.
>
>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
>> index 32ddb7f..a056fc5 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -1001,18 +1001,40 @@ static const struct snd_soc_component_driver davinci_mcasp_component = {
>>   	.name		= "davinci-mcasp",
>>   };
>>
>> +/* Some HW specific values and defaults. The rest is filled in from DT. */
>> +static struct snd_platform_data dm646x_mcasp_pdata = {
>> +	.tx_dma_offset = 0x400,
>> +	.rx_dma_offset = 0x400,
>> +	.asp_chan_q = EVENTQ_0,
>> +	.version = MCASP_VERSION_1,
>> +};
>> +
>> +static struct snd_platform_data da830_mcasp_pdata = {
>> +	.tx_dma_offset = 0x2000,
>> +	.rx_dma_offset = 0x2000,
>> +	.asp_chan_q = EVENTQ_0,
>> +	.version = MCASP_VERSION_2,
>> +};
>> +
>> +static struct snd_platform_data omap2_mcasp_pdata = {
>> +	.tx_dma_offset = 0,
>> +	.rx_dma_offset = 0,
>> +	.asp_chan_q = EVENTQ_0,
>> +	.version = MCASP_VERSION_3,
>> +};
>> +
>>   static const struct of_device_id mcasp_dt_ids[] = {
>>   	{
>>   		.compatible = "ti,dm646x-mcasp-audio",
>> -		.data = (void *)MCASP_VERSION_1,
>> +		.data = &dm646x_mcasp_pdata,
>>   	},
>>   	{
>>   		.compatible = "ti,da830-mcasp-audio",
>> -		.data = (void *)MCASP_VERSION_2,
>> +		.data = &da830_mcasp_pdata,
>>   	},
>>   	{
>>   		.compatible = "ti,omap2-mcasp-audio",
>> -		.data = (void *)MCASP_VERSION_3,
>> +		.data = &omap2_mcasp_pdata,
>>   	},
>>   	{ /* sentinel */ }
>>   };
>> @@ -1035,20 +1057,13 @@ static struct snd_platform_data *davinci_mcasp_set_pdata_from_of(
>>   		pdata = pdev->dev.platform_data;
>>   		return pdata;
>>   	} else if (match) {
>> -		pdata = devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>> -		if (!pdata) {
>> -			ret = -ENOMEM;
>> -			goto nodata;
>> -		}
>> +		pdata = (struct snd_platform_data *) match->data;
>>   	} else {
>>   		/* control shouldn't reach here. something is wrong */
>>   		ret = -EINVAL;
>>   		goto nodata;
>>   	}
>>
>> -	if (match->data)
>> -		pdata->version = (u8)((int)match->data);
>> -
>>   	ret = of_property_read_u32(np, "op-mode", &val);
>>   	if (ret >= 0)
>>   		pdata->op_mode = val;
>> @@ -1145,10 +1160,15 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>   		return -EINVAL;
>>   	}
>>
>> -	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>>   	if (!mem) {
>> -		dev_err(&pdev->dev, "no mem resource?\n");
>> -		return -ENODEV;
>> +		dev_warn(dev->dev,
>> +			 "\"mpu\" mem resource not found, using index 0\n");
>> +		mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +		if (!mem) {
>> +			dev_err(&pdev->dev, "no mem resource?\n");
>> +			return -ENODEV;
>> +		}
>>   	}
>>
>>   	ioarea = devm_request_mem_region(&pdev->dev, mem->start,
>> @@ -1182,13 +1202,16 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>   	dev->rxnumevt = pdata->rxnumevt;
>>   	dev->dev = &pdev->dev;
>>
>> +	dma = platform_get_resource_byname(pdev, IORESOURCE_MEM, "dma");
>> +	if (!dma)
>> +		dma = mem;
>> +
>>   	dma_data = &dev->dma_params[SNDRV_PCM_STREAM_PLAYBACK];
>>   	dma_data->asp_chan_q = pdata->asp_chan_q;
>>   	dma_data->ram_chan_q = pdata->ram_chan_q;
>>   	dma_data->sram_pool = pdata->sram_pool;
>>   	dma_data->sram_size = pdata->sram_size_playback;
>> -	dma_data->dma_addr = (dma_addr_t) (pdata->tx_dma_offset +
>> -							mem->start);
>> +	dma_data->dma_addr = dma->start + pdata->tx_dma_offset;
>>
>>   	/* first TX, then RX */
>>   	res = platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> @@ -1205,8 +1228,7 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>   	dma_data->ram_chan_q = pdata->ram_chan_q;
>>   	dma_data->sram_pool = pdata->sram_pool;
>>   	dma_data->sram_size = pdata->sram_size_capture;
>> -	dma_data->dma_addr = (dma_addr_t)(pdata->rx_dma_offset +
>> -							mem->start);
>> +	dma_data->dma_addr = dma->start + pdata->rx_dma_offset;
>>
>>   	res = platform_get_resource(pdev, IORESOURCE_DMA, 1);
>>   	if (!res) {
>> @@ -1266,4 +1288,3 @@ module_platform_driver(davinci_mcasp_driver);
>>   MODULE_AUTHOR("Steve Chen");
>>   MODULE_DESCRIPTION("TI DAVINCI McASP SoC Interface");
>>   MODULE_LICENSE("GPL");
>> -
>> --
>> 1.7.9.5
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>

