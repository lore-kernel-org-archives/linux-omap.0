From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: RE: [PATCH 1/3] ASoC: TWL6030: Add twl6030 codec driver
Date: Tue, 15 Sep 2009 12:59:44 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E907FA65B@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
 <20090914172135.GA2481@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:56394 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752731AbZIOR7w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 15 Sep 2009 13:59:52 -0400
In-Reply-To: <20090914172135.GA2481@rakim.wolfsonmicro.main>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>

Mark Brown wrote:
> On Mon, Sep 14, 2009 at 12:00:25PM -0500, Lopez Cruz, Misael wrote:
> 
>> 
>> +/* propietary formats */
>> +#define SND_SOC_DAIFMT_MCPDM           0x10 /* Texas Instruments
>> McPDM */ 
> 
> This should really be split out into a separate patch.  Are you
> absolutely positive that this is a proprietary interface that won't
> interoperate with standard PDM?

I think channel slot definition won't make it able to interoperate with
other PDM interfaces. But I may be wrong.

>> +static void twl6030_power_up(struct snd_soc_codec *codec) +{
>> +       struct snd_soc_device *socdev = codec->socdev;
>> +       struct twl6030_setup_data *setup = socdev->codec_data; +
>> +       setup->codec_enable(1);
> 
> That's interesting...?

The codec is turned on/off through an external line (i.e. with a gpio).
Then, codec enable is board-dependent.

>> +static int twl6030_set_bias_level(struct snd_soc_codec *codec,
>> +                               enum snd_soc_bias_level level) +{
>> +       switch (level) {
>> +       case SND_SOC_BIAS_ON:
>> +               twl6030_power_up(codec);
>> +               break;
>> +       case SND_SOC_BIAS_PREPARE:
>> +               twl6030_power_up(codec);
>> +               break;
>> +       case SND_SOC_BIAS_STANDBY:
>> +               twl6030_power_up(codec);
>> +               break;
>> +       case SND_SOC_BIAS_OFF:
>> +               twl6030_power_down(codec);
>> +               break;
> 
> Is there any reason not to just fold these functions into the bias
> management?  It looks like the only caller and it'd save
> jumping around the file to find stuff.

For the moment, there is no reason. I thought it was more clear to have
separate power_up/power_down functions, but I can merge them in bias
management function.

>> +       /* power on device */
>> +       twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY); +
>> +       twl6030_init_chip(codec);
> 
> Is the the right ordering?  I'd have expected to see the one time init
> stuff done prior to bringing up the power for the first time.

Yes, it's the right order. codec chip cannot be initialized if the codec
is not already power-up, registers are not accesible before that.

