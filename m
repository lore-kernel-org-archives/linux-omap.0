From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [alsa-devel] [PATCH 3/5] SOUND: SOC: CODECS: Add support for the TWL4030 audio codec
Date: Thu, 4 Sep 2008 07:48:02 -0700
Message-ID: <5e088bd90809040748u5f487c4fy3f347b851a8d7d7b@mail.gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	 <1220504520-6067-2-git-send-email-sakoman@gmail.com>
	 <1220504520-6067-3-git-send-email-sakoman@gmail.com>
	 <1220504520-6067-4-git-send-email-sakoman@gmail.com>
	 <20080904120441.GB21663@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f16.google.com ([209.85.217.16]:45103 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751AbYIDOsE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 4 Sep 2008 10:48:04 -0400
Received: by gxk9 with SMTP id 9so6357091gxk.13
        for <linux-omap@vger.kernel.org>; Thu, 04 Sep 2008 07:48:02 -0700 (PDT)
In-Reply-To: <20080904120441.GB21663@sirena.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: sakoman@gmail.com, linux-omap@vger.kernel.org, alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>

On Thu, Sep 4, 2008 at 5:04 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Wed, Sep 03, 2008 at 10:01:58PM -0700, sakoman@gmail.com wrote:
>> +     /* initiate offset cancellation */
>> +     twl4030_write(codec, REG_ANAMICL,
>> +             twl4030_reg[REG_ANAMICL] | CNCL_OFFSET_START);
>
> It looks a bit odd to see this reading the register defaults rather than
> the register cache.

True.  I will fix this.

>
>> +     /* wait for offset cancellation to complete */
>> +     twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE, &byte, REG_ANAMICL);
>> +     while ((byte & CNCL_OFFSET_START) == CNCL_OFFSET_START)
>> +             twl4030_i2c_read_u8(TWL4030_MODULE_AUDIO_VOICE,
>> +                                     &byte, REG_ANAMICL);
>
> How long is this likely to take?  If it might take a while then putting
> a delay in between reads might be nice.  As Jarkko said, a timeout would
> be a good idea too in case something went wrong.

It happens quite quickly.  I'll add an exit to the loop and measure
how many passes it takes.  If it is a large number I'll add a delay.

>> +     /* anti-pop when changing analog gain */
>> +     twl4030_write(codec, REG_MISC_SET_1,
>> +             twl4030_reg[REG_MISC_SET_1] | SMOOTH_ANAVOL_EN);
>
> Another one reading the register defaults rather than register cache...

I'll fix this.

>> +     /* disable bias out */
>> +     popn &= ~VMID_EN;
>> +     twl4030_write(codec, REG_HS_POPN_SET, popn);
>
> ...
>
>> +     case SND_SOC_BIAS_ON:
>> +             twl4030_power_up(codec);
>> +             break;
>> +     case SND_SOC_BIAS_PREPARE:
>> +             break;
>> +     case SND_SOC_BIAS_STANDBY:
>> +             twl4030_power_down(codec);
>> +             break;
>
> Normally SND_SOC_BIAS_STANDBY would leave Vmid enabled but your power
> down function turns it off.  The normal thing here is to have standby
> bring the codec up and then apply relatively small tweaks in _ON and
> _PREPARE that do things like improve the quality of the reference
> voltages.  Equally well, since the driver does not yet implement DAPM
> support doing this will give you power savings that you wouldn't
> otherwise get.
>
> Does the codec have any bypass paths that can be set up?  If not it
> shouldn't do much harm either way until you implement DAPM.

How about I add a "TODO" on this?  I'm swamped for the next few weeks
and won't be able to give it the attention it deserves test-wise.

>> +/* AUDIO_IF (0x0E) Fields */
>> +
>> +#define AIF_SLAVE_EN         0x80
>> +#define DATA_WIDTH           0x60
>
> These should really all get namespaced - some of them look relatively
> likely to collide with registers for CPU side stuff.

Good point.

Steve
