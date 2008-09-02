From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/4] SOUND: SOC: CODECS: Add support for the TWL4030 audio codec
Date: Tue, 2 Sep 2008 07:25:48 -0700
Message-ID: <5e088bd90809020725g1d0dff70ue84f861ea3e22201@mail.gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	 <1220306279-27977-2-git-send-email-sakoman@gmail.com>
	 <1220306279-27977-3-git-send-email-sakoman@gmail.com>
	 <20080902112633.GB25176@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.178]:17014 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751259AbYIBOZt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 2 Sep 2008 10:25:49 -0400
Received: by wa-out-1112.google.com with SMTP id j37so1675756waf.23
        for <linux-omap@vger.kernel.org>; Tue, 02 Sep 2008 07:25:48 -0700 (PDT)
In-Reply-To: <20080902112633.GB25176@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Tue, Sep 2, 2008 at 4:26 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Mon, Sep 01, 2008 at 02:57:57PM -0700, sakoman@gmail.com wrote:
>> +
>> +config SND_SOC_TWL4030
>> +     tristate
>> +     depends on SND_SOC && I2C
>> +
>
> This should also be added to SND_SOC_ALL_CODECS to ensure testing
> coverage.

Hmm . . . I get no hits grep-ing for SND_SOC_ALL_CODECS.  Could this
be something we are missing in the linux-omap git?

>> +struct twl4030_priv {
>> +     unsigned int dummy;
>> +};
>
> If this is empty it should be removable?

I plan to support further codec features in future patches and have a
strong suspicion that private data may be required.  Is it preferred
to add the infrastructure now, or wait till it is required in the
future?  I opted for the former, but don't really care either way.

>> +static int twl4030_set_bias_level(struct snd_soc_codec *codec,
>> +                               enum snd_soc_bias_level level)
>> +{
>> +
>> +     printk(KERN_INFO "TWL4030 Audio Codec set bias level\n");
>
> This printk() should be removed - it's just debug output.

You are correct.  I will remove this.

>> +     switch (level) {
>> +     case SND_SOC_BIAS_ON:
>> +             break;
>> +     case SND_SOC_BIAS_PREPARE:
>> +             break;
>> +     case SND_SOC_BIAS_STANDBY:
>> +             break;
>> +     case SND_SOC_BIAS_OFF:
>> +             break;
>> +     }
>
> Should you be calling power_up() and power_down() for standby and off
> here?

I was saving power management for another patch after I have time to
actually measure the effects.  That said, I see no reason to not add
the power up/down calls to the places you indicate.  I will do a quick
test and add to my resubmission.

>> +static int twl4030_hw_params(struct snd_pcm_substream *substream,
>> +                        struct snd_pcm_hw_params *params)
>> +{
>
>> +             /* turn off codec before changing format */
>> +             mode = twl4030_read_reg_cache(codec, REG_CODEC_MODE);
>> +             mode &= ~CODECPDZ;
>> +             twl4030_write(codec, REG_CODEC_MODE, mode);
>
> The comments about powering up and down the codec could probably use a
> little clarification given the fact that there are also power_down() and
> power_up() functions.

Good point.  This is just one of those chip quirks that require the
CODECPDZ bit to be 0 when modes are changed rather than any
requirement for a full power up/power down sequence.

>> +static int twl4030_mute(struct snd_soc_dai *dai, int mute)
>> +{
>> +     struct snd_soc_codec *codec = dai->codec;
>> +
>> +     u8 ldac_reg = twl4030_read_reg_cache(codec, REG_ARXL2PGA);
>> +     u8 rdac_reg = twl4030_read_reg_cache(codec, REG_ARXR2PGA);
>> +
>> +     if (mute) {
>> +             twl4030_write(codec, REG_ARXL2PGA, 0x00);
>> +             twl4030_write(codec, REG_ARXR2PGA, 0x00);
>> +             twl4030_write_reg_cache(codec, REG_ARXL2PGA, ldac_reg);
>> +             twl4030_write_reg_cache(codec, REG_ARXR2PGA, rdac_reg);
>> +     } else {
>> +             twl4030_write(codec, REG_ARXL2PGA, ldac_reg);
>> +             twl4030_write(codec, REG_ARXR2PGA, rdac_reg);
>> +     }
>
> It may be better to make these user visible controls - usually the mute
> provided here is specifically for the DAC but these look like controls
> for the PGA.  The intention here is to avoid artifacts from the DAC when
> the input clock stops and start - if there aren't any then user space
> may well appreciate the control.  Either way is fine.

I'm not hearing any clicks & pops, so I will leave this in.

>> +static int twl4030_suspend(struct platform_device *pdev, pm_message_t state)
>> +{
>> +     struct snd_soc_device *socdev = platform_get_drvdata(pdev);
>> +     struct snd_soc_codec *codec = socdev->codec;
>> +
>> +     printk(KERN_INFO "TWL4030 Audio Codec suspend\n");
>> +     twl4030_set_bias_level(codec, SND_SOC_BIAS_OFF);
>> +
>> +     return 0;
>> +}
>
> Merging the power down into set_bias_level() would mean that this would
> do a controlled power down - at present it will be a no-op.
>
> Similarly, adding the power up to the standby configuration would ensure
> a controlled power up of the codec when resuming.  Looking at the power
> up sequence I'm not sure that simply writing back the cache will work
> well?

Agreed.  I will make this change.

> +}
>
>> +     twl4030_init_chip();
>> +     twl4030_power_up(codec, APLL_RATE_44100 | OPT_MODE);
>
> It looks like the driver is assuming a particular clock rate going into
> the codec - does the chip require a fixed clock or is the driver only
> supporting one configuration?  Either is fine.

There is a fixed clock.

Thanks for the comments!

Steve
