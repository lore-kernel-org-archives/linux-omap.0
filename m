From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: davinci-mcasp: Choose PCM driver based on configured
 DMA controller
Date: Tue, 2 Jun 2015 14:55:10 +0300
Message-ID: <556D999E.8000306@ti.com>
References: <bcd986aa18bf41643f1d190739381a890313ac61.1433235274.git.jsarha@ti.com> <556D8600.1060204@ti.com> <556D8F7F.7090803@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:59161 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752948AbbFBLzX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Jun 2015 07:55:23 -0400
In-Reply-To: <556D8F7F.7090803@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, misael.lopez@ti.com

On 06/02/2015 02:11 PM, Jyri Sarha wrote:
>>> -    switch (mcasp->version) {
>>> +    ret =3D -EINVAL;
>>
>> Why? What was the problem with setting the ret in the default case?
>>
>=20
> I would need to have that I three places now for the #else cases, whe=
n
> devicetree tries to configure pcm driver that has not been compiled.

I see now, thanks for pointing out ;)

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

--=20
P=C3=A9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
