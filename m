From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Choose PCM driver based on configured
 DMA controller
Date: Tue, 2 Jun 2015 14:11:59 +0300
Message-ID: <556D8F7F.7090803@ti.com>
References: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com> <556D8600.1060204@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:46498 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756058AbbFBLMG (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 2 Jun 2015 07:12:06 -0400
In-Reply-To: <556D8600.1060204@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com

I missed two comments first time around...

On 06/02/15 13:31, Peter Ujfalusi wrote:
> On 06/02/2015 11:58 AM, Jyri Sarha wrote:
>> Find the configured DMA controller by asking for a DMA channel in the
>> probe phase and releasing it right after. The controller device can be
>> found via the dma_chan struct and the controller is recognized from
>> the compatible property of its device node. The patch assumes EDMA if
>> there is no device node.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
>>   sound/soc/davinci/davinci-mcasp.c | 61 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 51 insertions(+), 10 deletions(-)
>>
>> diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
>> index d793494..5bc2712 100644
>> --- a/sound/soc/davinci/davinci-mcasp.c
>> +++ b/sound/soc/davinci/davinci-mcasp.c
>> @@ -1565,6 +1565,46 @@ static int davinci_mcasp_init_ch_constraints(struct davinci_mcasp *mcasp)
>>   	return ret;
>>   }
>>
>> +enum {
>> +	MCASP_EDMA = 1,
>
> Why start from 1?
> I'm not sure about the name. It somehow implies that McASP has something to do
> with the dma engine.
> MCASP_SERVICED_BY_E/SDMA
> PLATFORM_USES_E/SDMA
>
> I can not come up with a decent name :(
>
>
>> +	MCASP_SDMA,
>> +};
>> +static const char *sdma_prefix = "ti,omap";
>> +
>> +static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
>> +{
>> +	struct dma_chan *chan;
>> +	const char *tmp;
>> +	int ret = MCASP_EDMA;
>> +
>> +	tmp = mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data;
>> +	chan = dma_request_slave_channel_reason(mcasp->dev, tmp);
>
> this will return with error in case of !dev->of_node.
> The first check should be:
> if (!mcasp->dev->of_node)
> 	return MCASP_EDMA;
>
> since we can only boot in legacy mode with daVinci devices and they are using
> eDMA.
>

Yep, I'll add that back. I tought that I would not need it, but am not 
so familiar with the generic dmaengine pcm...

>> +	if (IS_ERR(chan)) {
>> +		if (PTR_ERR(chan) != -EPROBE_DEFER)
>> +			dev_err(mcasp->dev,
>> +				"Can't verify DMA configuration (%ld)\n",
>> +				PTR_ERR(chan));
>> +		return PTR_ERR(chan);
>> +	}
>> +	BUG_ON(!chan->device || !chan->device->dev);
>> +
>> +	if (chan->device->dev->of_node)
>> +		ret = of_property_read_string(chan->device->dev->of_node,
>> +					      "compatible", &tmp);
>> +	else
>> +		dev_dbg(mcasp->dev, "DMA controller has no of-node\n");
>
> Now this is not likely to happen...
>
>> +
>> +	dma_release_channel(chan);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dev_dbg(mcasp->dev, "DMA controller compatible = \"%s\"\n", tmp);
>> +	if (!strncmp(tmp, sdma_prefix, strlen(sdma_prefix)))
>> +		return MCASP_SDMA;
>> +
>> +	return MCASP_EDMA;
>> +}
>> +
>>   static int davinci_mcasp_probe(struct platform_device *pdev)
>>   {
>>   	struct snd_dmaengine_dai_dma_data *dma_data;
>> @@ -1763,27 +1803,28 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
>>   	if (ret != 0)
>>   		goto err;
>>
>> -	switch (mcasp->version) {
>> +	ret = -EINVAL;
>
> Why? What was the problem with setting the ret in the default case?
>

I would need to have that I three places now for the #else cases, when 
devicetree tries to configure pcm driver that has not been compiled.

>> +	switch (davinci_mcasp_get_dma_type(mcasp)) {
>> +	case MCASP_EDMA:
>>   #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
>>   	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>>   	 IS_MODULE(CONFIG_SND_EDMA_SOC))
>> -	case MCASP_VERSION_1:
>> -	case MCASP_VERSION_2:
>> -	case MCASP_VERSION_3:
>>   		ret = edma_pcm_platform_register(&pdev->dev);
>> -		break;
>> +#else
>> +		dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
>>   #endif
>> +		break;
>> +	case MCASP_SDMA:
>>   #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
>>   	(IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>>   	 IS_MODULE(CONFIG_SND_OMAP_SOC))
>> -	case MCASP_VERSION_4:
>>   		ret = omap_pcm_platform_register(&pdev->dev);
>> -		break;
>> +#else
>> +		dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
>>   #endif
>> +		break;
>>   	default:
>> -		dev_err(&pdev->dev, "Invalid McASP version: %d\n",
>> -			mcasp->version);
>> -		ret = -EINVAL;
>> +		dev_err(&pdev->dev, "No DMA controller found\n");
>>   		break;
>>   	}
>>
>>
>
>

