From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/7] ASoC: omap: Introduce the
 generic_dmaengine_pcm based sdma-pcm
Date: Mon, 30 Apr 2018 15:50:17 +0300
Message-ID: <c2cb3709-0cd9-630b-9534-5dffbb95384f@ti.com>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
 <20180430065748.3393-2-peter.ujfalusi@ti.com>
 <20180430105515.qkxs5zousf5llveb@earth.universe>
 <e2368ce9-9bbc-15c7-1a62-94ce505cdbe6@ti.com>
 <20180430113900.3vdarclqfvkm66ym@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430113900.3vdarclqfvkm66ym@earth.universe>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, aaro.koskinen@iki.fi, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-omap@vger.kernel.org, jarkko.nikula@bitmer.com
List-Id: linux-omap@vger.kernel.org



On 2018-04-30 14:39, Sebastian Reichel wrote:
> Hi,
> =

> On Mon, Apr 30, 2018 at 02:05:06PM +0300, Peter Ujfalusi wrote:
>> On 2018-04-30 13:55, Sebastian Reichel wrote:
>>> On Mon, Apr 30, 2018 at 09:57:42AM +0300, Peter Ujfalusi wrote:
>>>> [...]
>>>> diff --git a/sound/soc/omap/sdma-pcm.h b/sound/soc/omap/sdma-pcm.h
>>>> new file mode 100644
>>>> index 000000000000..ce13edfc52d8
>>>> --- /dev/null
>>>> +++ b/sound/soc/omap/sdma-pcm.h
>>>> @@ -0,0 +1,21 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/*
>>>> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti=
.com
>>>> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>>> + */
>>>> +
>>>> +#ifndef __SDMA_PCM_H__
>>>> +#define __SDMA_PCM_H__
>>>> +
>>>> +#if IS_ENABLED(CONFIG_SND_SDMA_SOC)
>>>> +int sdma_pcm_platform_register(struct device *dev,
>>>> +			       char *txdmachan, char *rxdmachan);
>>>> +#else
>>>> +static inline int sdma_pcm_platform_register(struct device *dev,
>>>> +					     char *txdmachan, char *rxdmachan)
>>>> +{
>>>> +	return 0;
>>>
>>> I would expect some error code instead?
>>
>> Yeah, it could return -ENODEV.
> =

> I think it should. Returning success without providing the intended
> functionality is bad API design.
> =

>> It is there so the McASP can be compiled for daVinci/am335x/am43xx where
>> we do not have sDMA, only EDMA.
> =

> Are you sure, that you need the stub at all? Looking at the next
> patch the call is guarded with #if IS_BUILTIN(CONFIG_SND_SDMA_SOC)
> || IS_MODULE(CONFIG_SND_SDMA_SOC). I don't think it is called with
> CONFIG_SND_SDMA_SOC being disabled.

True.

> =

> -- Sebastian
> =


- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
