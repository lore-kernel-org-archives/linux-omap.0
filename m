From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [alsa-devel] [PATCH RFC 2/2] ASoC: simple-card: Move dai-link
 level	properties away from dai subnodes
Date: Mon, 24 Mar 2014 11:45:11 +0200
Message-ID: <532FFEA7.9060406@ti.com>
References: <cover.1395419906.git.jsarha@ti.com>	<0b1c0e2e6766c3a63f598c3b9435d4744b0e2835.1395419906.git.jsarha@ti.com> <87lhw08nqk.wl%kuninori.morimoto.gx@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34353 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752265AbaCXJpX (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 24 Mar 2014 05:45:23 -0400
In-Reply-To: <87lhw08nqk.wl%kuninori.morimoto.gx@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, liam.r.girdwood@linux.intel.com, detheridge@ti.com, kuninori.morimoto.gx@renesas.com, moinejf@free.fr, Li.Xiubo@freescale.com, peter.ujfalusi@ti.com, broonie@kernel.org, bcousson@baylibre.com

On 03/24/2014 02:05 AM, Kuninori Morimoto wrote:
>
> Hi Jyri
>
>> The properties like format, bitclock-master, frame-master,
>> bitclock-inversion, and frame-inversion should be common to the dais
>> connected with a dai-link. For bitclock-master and frame-master
>> properties to be unambiguous they need to indicate the mastering dai
>> node with a phandle.
>>
>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>> ---
> (snip)
>>   	/*
>> -	 * bitclock-inversion, frame-inversion
>> -	 * bitclock-master,    frame-master
>> -	 * and specific "format" if it has
>> -	 */
>> -	dai->fmt = snd_soc_of_parse_daifmt(np, NULL);
>> -	dai->fmt |= daifmt;
>> -
>> -	/*
>>   	 * dai->sysclk come from
>>   	 *  "clocks = <&xxx>" (if system has common clock)
>>   	 *  or "system-clock-frequency = <xxx>"
>
> [1/2] patch exchanged snd_soc_of_parse_daifmt() parameter,
> but, user code exchanged in [2/2].
> It breaks git-bisect.
>

Fixed that. Thanks!

>> +	dai_props->cpu_dai.fmt = daifmt;
>> +	switch (((np == bitclkmaster)<<4)|(np == framemaster)) {
>> +	case 0x11:
>> +		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFS;
>> +		break;
>> +	case 0x10:
>> +		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBS_CFM;
>> +		break;
>> +	case 0x01:
>> +		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFS;
>> +		break;
>> +	default:
>> +		dai_props->cpu_dai.fmt |= SND_SOC_DAIFMT_CBM_CFM;
>> +		break;
>> +	}
>
> The user of snd_soc_of_parse_daifmt() is only simple-card (?)
> I think SND_SOC_DAIFMT_CBxx_CFx cared by snd_soc_of_parse_daifmt() somehow
> is very reasonable.
>

Yes, that is what git grep tells me. snd_soc_of_parse_daifmt() can still 
take care of SND_SOC_DAIFMT_CB?_CF? parsing in simple cases. I just felt 
that adding the full phandle parsing to the function would break its 
genericity and make the function parameters hard to understand.

Best regards,
Jyri
