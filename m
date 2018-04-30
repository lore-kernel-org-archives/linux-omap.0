From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH v2 1/7] ASoC: omap: Introduce the
 generic_dmaengine_pcm based sdma-pcm
Date: Mon, 30 Apr 2018 14:05:06 +0300
Message-ID: <e2368ce9-9bbc-15c7-1a62-94ce505cdbe6@ti.com>
References: <20180430065748.3393-1-peter.ujfalusi@ti.com>
 <20180430065748.3393-2-peter.ujfalusi@ti.com>
 <20180430105515.qkxs5zousf5llveb@earth.universe>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180430105515.qkxs5zousf5llveb@earth.universe>
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



On 2018-04-30 13:55, Sebastian Reichel wrote:
> Hi,
> =

> On Mon, Apr 30, 2018 at 09:57:42AM +0300, Peter Ujfalusi wrote:
>> [...]
>> diff --git a/sound/soc/omap/sdma-pcm.h b/sound/soc/omap/sdma-pcm.h
>> new file mode 100644
>> index 000000000000..ce13edfc52d8
>> --- /dev/null
>> +++ b/sound/soc/omap/sdma-pcm.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + *  Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.c=
om
>> + *  Author: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> + */
>> +
>> +#ifndef __SDMA_PCM_H__
>> +#define __SDMA_PCM_H__
>> +
>> +#if IS_ENABLED(CONFIG_SND_SDMA_SOC)
>> +int sdma_pcm_platform_register(struct device *dev,
>> +			       char *txdmachan, char *rxdmachan);
>> +#else
>> +static inline int sdma_pcm_platform_register(struct device *dev,
>> +					     char *txdmachan, char *rxdmachan)
>> +{
>> +	return 0;
> =

> I would expect some error code instead?

Yeah, it could return -ENODEV.
It is there so the McASP can be compiled for daVinci/am335x/am43xx where
we do not have sDMA, only EDMA.

> =

>> +}
>> +#endif /* CONFIG_SND_SDMA_SOC */
>> +
>> +#endif /* __SDMA_PCM_H__ */
> =

> -- Sebastian
> =


- P=E9ter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
