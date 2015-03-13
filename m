From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH RFC (do not merge)] ASoC: davinci-mcasp: Set rule constraint
 if implicit bclk divider is used
Date: Fri, 13 Mar 2015 16:21:44 +0200
Message-ID: <5502F278.2070608@ti.com>
References: <1426246615-12772-1-git-send-email-jsarha@ti.com> <5502D052.1030804@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41484 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbbCMOV4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 13 Mar 2015 10:21:56 -0400
In-Reply-To: <5502D052.1030804@metafoo.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>, alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com

On 03/13/15 13:56, Lars-Peter Clausen wrote:
> On 03/13/2015 12:36 PM, Jyri Sarha wrote:
> [...]
>> In theory this patch does exactly what it is supposed to. It only
>> allows a sample-rate and sample-format combination if the rate can be
>> produced with reasonable accuracy. Unfortunately the alsa-lib and
>> alsa-tools are not able use this information too well. If the requested
>> sample-rate and sample-format is not available the aplay/arecord
>> fails, even if plughw is selected, with:
>>
>> pcm_params.c:170: snd1_pcm_hw_param_get_min: Assertion
>> `!snd_interval_empty(i)' failed.
> [...]
>> +
>> +    /*
>> +     * If we rely on implicit BCLK divider setting we should
>> +     * set constraints based on what we can provide.
>> +     */
>> +    if (mcasp->bclk_master && mcasp->bclk_div == 0 &&
>> mcasp->sysclk_freq)
>> +        return snd_pcm_hw_rule_add(substream->runtime, 0,
>> +                       SNDRV_PCM_HW_PARAM_RATE,
>> +                       davinci_mcasp_hw_rule_rate,
>> +                       mcasp,
>> +                       SNDRV_PCM_HW_PARAM_FRAME_BITS,
>> +                       SNDRV_PCM_HW_PARAM_CHANNELS, -1);
>> +
>
> For things to work correctly you also need reverse rules restricting
> CHANNELS and FRAME_BITS based on the RATE. This might fix the issue you
> are seeing with the ALSA tools.
>

Thanks, that was indeed the case. I mail a new patch once I get my patch 
in order.

Best regards,
Jyri

