From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCHv2 0/7] TWL6030 audio codec initial support
Date: Mon, 28 Sep 2009 12:13:58 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E90A39748@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90A391DE@dlee04.ent.ti.com>
 <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC75@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:52629 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751694AbZI1RSy convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Sep 2009 13:18:54 -0400
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02BADABC75@dbde02.ent.ti.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>

Santosh,

Shilimkar, Santosh wrote:
> Misa,
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
>> owner@vger.kernel.org] On Behalf Of Lopez Cruz, Misael
>> Sent: Saturday, September 26, 2009 7:32 AM
>> To: alsa-devel@alsa-project.org; linux-omap@vger.kernel.org
>> Cc: Mark Brown
>> Subject: [PATCHv2 0/7] TWL6030 audio codec initial support
>> 
>> Following patch series adds initial support for TWL6030 codec driver.
>> 
>> TWL6030 codec depends on TWL6030_CORE, which is not accepted yet.
>> The main intention then is to get comments, I'll repost the patches
>> of this series when TWL6030_CORE support gets accepted and rework
>> patches as needed.
> Looking at your series, you have based your patches on
> Balaji's 6030 PMIC series as you mentioned " TWL6030 codec depends on
> TWL6030_CORE". 
> 
> While doing that series, we realized that there is a lot of
> code common between TWL5030 and TWL6030 apart from mainly
> interrupt handling and hence a common file approach is taken
> to avoid code duplication. The patch " [PATCHv2 3/7] ASoC:
> TWL6030: Add twl6030 codec driver" gives me an impression
> that there is opportunity to have a single file supporting
> both IC's. IC specific code can be handled using the runtime
> check depending on the revision.
> Can you explore this ?

TWL6030 CODEC is very different from TWL4030/TWL5030, for example the
digital audio interface of TWL6030 is a PDM-based propietary interface,
and TWL4030/TWL5030 uses I2S/TDM + PCM interfaces.
Audio components and their interconnections are very different as well,
so I don't see any code reuse for audio codec.

Thanks,
-Misa

> You can find more information on above discussion at below thread.
> 
> http://www.mail-archive.com/linux-omap@vger.kernel.org/msg15756.html
> 
> 
> From
>> Changes from v1:
>> - Renamed dai format for PDM as SND_SOC_DAIFMT_PDM
>> - CODEC driver registered as a platform driver
>> - AUDPWRON gpio line handled in the CODEC driver
>> - Handle scenario when no AUDPWRON gpio line is provided
>> - Corrected names of some widgets
>> - Avoid multiple calls to power functions in set_bias_level
>> 
>> Thanks,
>> -Misa
>> 
>> ---
>> 
>> Misael Lopez Cruz (7):
>>       OMAP4: PMIC: Add support for twl6030 codec
>>       ASoC: Add PDM DAI format definition
>>       ASoC: TWL6030: Add twl6030 codec driver
>>       ASoC: TWL6030: Manual power-up/down sequences
>>       ASoC: TWL6030: Add support for low-power mode
>>       ASoC: TWL6030: Enable audio interrupt
>>       ASoC: TWL6030: Power-up seq completion through audio interrupt
>> 
>>  drivers/mfd/twl-core.c     |   15 +
>>  include/linux/i2c/twl.h    |   11 +
>>  include/sound/soc-dai.h    |    1 +
>>  sound/soc/codecs/Kconfig   |    4 +
>>  sound/soc/codecs/Makefile  |    2 +
>>  sound/soc/codecs/twl6030.c | 1179
>> ++++++++++++++++++++++++++++++++++++++++++++
>>  sound/soc/codecs/twl6030.h |  137 +++++
>>  7 files changed, 1349 insertions(+), 0 deletions(-)  create mode
>> 100644 sound/soc/codecs/twl6030.c  create mode 100644
>> sound/soc/codecs/twl6030.h --
>> To unsubscribe from this list: send the line "unsubscribe linux-omap"
>> in the body of a message to majordomo@vger.kernel.org More majordomo
>> info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> Regards,
> Santosh

