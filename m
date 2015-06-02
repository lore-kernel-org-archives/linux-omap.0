From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Choose PCM driver based on configured
 DMA controller
Date: Tue, 2 Jun 2015 13:53:33 +0300
Message-ID: <556D8B2D.80103@ti.com>
References: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com> <556D8600.1060204@ti.com> <556D8810.9070302@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56916 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbbFBKxm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 06:53:42 -0400
In-Reply-To: <556D8810.9070302@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com

On 06/02/2015 01:40 PM, Jyri Sarha wrote:
>>> +enum {
>>> +    MCASP_EDMA =3D 1,
>>
>> Why start from 1?
>=20
> This is just an implementation detail, for "if" statement below. Mayb=
e I
> should restucture for better readability.

No need to change if it makes the code flow better. I was just asking.

>> I'm not sure about the name. It somehow implies that McASP has somet=
hing to do
>> with the dma engine.
>> MCASP_SERVICED_BY_E/SDMA
>> PLATFORM_USES_E/SDMA
>>
>> I can not come up with a decent name :(
>>
>=20
> What about PCM_EDMA/PCM_SDMA? This is a local definition after all.

Sounds much better!

>>> +    MCASP_SDMA,
>>> +};
>>> +static const char *sdma_prefix =3D "ti,omap";
>>> +
>>> +static int davinci_mcasp_get_dma_type(struct davinci_mcasp *mcasp)
>>> +{
>>> +    struct dma_chan *chan;
>>> +    const char *tmp;
>>> +    int ret =3D MCASP_EDMA;
>>> +
>>> +    tmp =3D mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data=
;
>>> +    chan =3D dma_request_slave_channel_reason(mcasp->dev, tmp);
>>
>> this will return with error in case of !dev->of_node.
>> The first check should be:
>> if (!mcasp->dev->of_node)
>>     return MCASP_EDMA;
>>
>> since we can only boot in legacy mode with daVinci devices and they =
are using
>> eDMA.
>>
>>> +    if (IS_ERR(chan)) {
>>> +        if (PTR_ERR(chan) !=3D -EPROBE_DEFER)
>>> +            dev_err(mcasp->dev,
>>> +                "Can't verify DMA configuration (%ld)\n",
>>> +                PTR_ERR(chan));
>>> +        return PTR_ERR(chan);
>>> +    }
>>> +    BUG_ON(!chan->device || !chan->device->dev);
>>> +
>>> +    if (chan->device->dev->of_node)
>>> +        ret =3D of_property_read_string(chan->device->dev->of_node=
,
>>> +                          "compatible", &tmp);
>>> +    else
>>> +        dev_dbg(mcasp->dev, "DMA controller has no of-node\n");
>>
>> Now this is not likely to happen...
>>
>=20
> Not having of_node happens on am335x, but not having compatible prope=
rty is
> unlikely...

Yes, you are right. The edma dmaengine driver is not probed via DT, but=
 the
arch/arm/common/edma.c will create a platform device for it to load, so=
 it
does not have of_node.
On the other hand omap-dma is probed via DT.

>=20
>>> +
>>> +    dma_release_channel(chan);
>>> +    if (ret)
>>> +        return ret;
>>> +
>>> +    dev_dbg(mcasp->dev, "DMA controller compatible =3D \"%s\"\n", =
tmp);
>>> +    if (!strncmp(tmp, sdma_prefix, strlen(sdma_prefix)))
>>> +        return MCASP_SDMA;
>>> +
>>> +    return MCASP_EDMA;
>>> +}
>>> +
>>>   static int davinci_mcasp_probe(struct platform_device *pdev)
>>>   {
>>>       struct snd_dmaengine_dai_dma_data *dma_data;
>>> @@ -1763,27 +1803,28 @@ static int davinci_mcasp_probe(struct
>>> platform_device *pdev)
>>>       if (ret !=3D 0)
>>>           goto err;
>>>
>>> -    switch (mcasp->version) {
>>> +    ret =3D -EINVAL;
>>
>> Why? What was the problem with setting the ret in the default case?
>>
>>> +    switch (davinci_mcasp_get_dma_type(mcasp)) {
>>> +    case MCASP_EDMA:
>>>   #if IS_BUILTIN(CONFIG_SND_EDMA_SOC) || \
>>>       (IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>>>        IS_MODULE(CONFIG_SND_EDMA_SOC))
>>> -    case MCASP_VERSION_1:
>>> -    case MCASP_VERSION_2:
>>> -    case MCASP_VERSION_3:
>>>           ret =3D edma_pcm_platform_register(&pdev->dev);
>>> -        break;
>>> +#else
>>> +        dev_err(&pdev->dev, "Missing SND_EDMA_SOC\n");
>>>   #endif
>>> +        break;
>>> +    case MCASP_SDMA:
>>>   #if IS_BUILTIN(CONFIG_SND_OMAP_SOC) || \
>>>       (IS_MODULE(CONFIG_SND_DAVINCI_SOC_MCASP) && \
>>>        IS_MODULE(CONFIG_SND_OMAP_SOC))
>>> -    case MCASP_VERSION_4:
>>>           ret =3D omap_pcm_platform_register(&pdev->dev);
>>> -        break;
>>> +#else
>>> +        dev_err(&pdev->dev, "Missing SND_SDMA_SOC\n");
>>>   #endif
>>> +        break;
>>>       default:
>>> -        dev_err(&pdev->dev, "Invalid McASP version: %d\n",
>>> -            mcasp->version);
>>> -        ret =3D -EINVAL;
>>> +        dev_err(&pdev->dev, "No DMA controller found\n");
>>>           break;
>>>       }
>>>
>>>
>>
>>
>=20


--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
