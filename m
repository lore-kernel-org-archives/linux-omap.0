From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH 1/3] ASoC: TWL6030: Add twl6030 codec driver
Date: Tue, 15 Sep 2009 17:39:09 -0500
Message-ID: <67059DBF19D7214F9C66BB0EA91BA90E907FA8DC@dlee04.ent.ti.com>
References: <67059DBF19D7214F9C66BB0EA91BA90E90432706@dlee04.ent.ti.com>
	<20090914172135.GA2481@rakim.wolfsonmicro.main>
	<67059DBF19D7214F9C66BB0EA91BA90E907FA65B@dlee04.ent.ti.com>
	<20090915183009.GA4343@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20090915183009.GA4343@sirena.org.uk>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Nagalla, Hari" <hnagalla@ti.com>
List-Id: linux-omap@vger.kernel.org

Mark Brown wrote:
> On Tue, Sep 15, 2009 at 12:59:44PM -0500, Lopez Cruz, Misael wrote:
>> Mark Brown wrote:
>>> On Mon, Sep 14, 2009 at 12:00:25PM -0500, Lopez Cruz, Misael wrote:
> 
>>>> +/* propietary formats */
>>>> +#define SND_SOC_DAIFMT_MCPDM           0x10 /* Texas Instruments
>>>> McPDM */
> 
>>> This should really be split out into a separate patch.  Are you
>>> absolutely positive that this is a proprietary interface that won't
>>> interoperate with standard PDM?
> 
>> I think channel slot definition won't make it able to interoperate
>> with other PDM interfaces. But I may be wrong.
> 
> I'd not expect full interoperability but I'd expect that at least the
> basic PDM support would interoperate happily.  It wouldn't surprise me
> if more than one manufacturer came up with the same extension
> for multi channel PDM.

If that's the case, then a more appropriate name should be chosen.
Or is it fine for you _MCPDM?

I was thinking in adding _OMAP4_MCPDM, but if you think someone 
else can use the same extension, then _OMAP4 should not go in the
name.

>>>> +static void twl6030_power_up(struct snd_soc_codec *codec) +{
>>>> +       struct snd_soc_device *socdev = codec->socdev;
>>>> +       struct twl6030_setup_data *setup = socdev->codec_data; +
>>>> +       setup->codec_enable(1);
> 
>>> That's interesting...?
> 
>> The codec is turned on/off through an external line (i.e. with a
>> gpio). Then, codec enable is board-dependent.
> 
> Might it make more sense to specify a GPIO line instead, at least by
> default? 

Not sure, if the GPIO line is in TWL6030 (mfd) as well then probably
it's fine, which may be the case for now. But isn't it violating
CODEC independency anyway?

If you mean to sustitute the codec_enable function by the GPIO
line, then it opens the possibility to make the CODEC to request and
operate a GPIO line belonging to a different chip, for example
to the application processor.

On the other hand, if a default GPIO line is provided and if it's
not the correct one, the driver will be waiting forever for
power-up sequence to finish (wait_for_completion). Anyway the
wait_for_completion seems too agresive since codec power-up
sequence might fail and boot process will hang.

>>>> +       /* power on device */
>>>> +       twl6030_set_bias_level(codec, SND_SOC_BIAS_STANDBY); +
>>>> +       twl6030_init_chip(codec);
> 
>>> Is the the right ordering?  I'd have expected to see the one time
>>> init stuff done prior to bringing up the power for the first time.
> 
>> Yes, it's the right order. codec chip cannot be initialized if the
>> codec is not already power-up, registers are not accesible before
>> that. 
> 
> OK.  Looking at this from another angle, shouldn't the chip init be
> rolled into the bias level function to ensure that there aren't any
> cases where it is omitted. 
> 
> It's possible that the core may get facilities to allow more use of
> SND_SOC_BIAS_OFF at runtime which would make this more important.

Yes, that's true. Some register may get unconfigured when codec goes
off. I'll check for those scenarios.
