From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 16:33:22 +0200
Message-ID: <4A1D4F32.5060002@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl> <20090527095949.51ed4b83.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from d1.icnet.pl ([212.160.220.21]:48620 "EHLO d1.icnet.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754906AbZE0OdZ (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 27 May 2009 10:33:25 -0400
In-Reply-To: <20090527095949.51ed4b83.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org

Hi Jarkko,

On Wed, 27 May 2009 08:59 Jarkko Nikula wrote:
> On Tue, 26 May 2009 15:17:23 +0200
> Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:
>> -	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
>> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
>> +	.xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
>>
> XFIG is only difference (OMAP_MCBSP_WORD_8 = 0) -> transfer is aborted
> in case of unexpected frame sync.

I tried commenting out RFIG and XFIG bits settings in 
sound/soc/omap/omap-mcbsp.c - did not help.

>> -	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
>> +	.srgr1 = CLKGDV(0),
>>
> Width of frame sync signal set to 1 here -> DSP_B format because no
> data delay set.

That's what I have tried mostly.

>> -	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE *
>> 2 - 1),
>> +       .srgr2 = GSYNC,
>>
>> -	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
>>
> No CLKXM, CLKRM and FSGM set -> codec is providing the frame sync and
> bit-clock signals -> SND_SOC_DAIFMT_CBM_CFM.

This is my primary choice as well.

> CLKXP and CLKRP not set -> rising edge of bit clock drives the
> transitions. This with DSP_B indicates inverted bit clock so
> SND_SOC_DAIFMT_IB_NF.

I have given it a try this morning - no go.

> I wonder why the frame sync period (FWID) wasn't set in that original
> patch but probably McBSP is able to work without :-)

from linux-2.6.29/sound/soc/omap/omap-mcbsp.c:
         switch (mcbsp_data->fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
         case SND_SOC_DAIFMT_I2S:
                 regs->srgr2     |= FPER(wlen * 2 - 1);
                 regs->srgr1     |= FWID(wlen - 1);
                 break;
         case SND_SOC_DAIFMT_DSP_B:
                 regs->srgr2     |= FPER(wlen * channels - 1);
                 regs->srgr1     |= FWID(0);
                 break;
         }

So it looks like in case of SND_SOC_DAIFMT_DSP_B, FWID is not set, only 
FPER. However, in the original patch, FPER was not set either.

>> ... aplay 
>> and arecord wait forever, cat to/from /dev/dsp breaks with hardware 
>> error messgae. DMA interrput counters stay at 0. However, codec 
> 
> Looks like McBSP is not getting bit-clock and frame-sync signals from
> the codec. Do you have any way to measure is the codec sending those?

Well, I am not sure, but I'll try if nothing helps.

> Another possibility are the OMAP pins muxed for McBSP? I assume they
> are if the bootloader is still the same

I boot both kernels, working 2.6.16 and not working 2.6.30-rc5, with the 
same u-boot.bin.

 > but worth to find check was
> previous kernel doing any runtime remuxing for those pins with
> omap_cfg_reg calls.

I was not able to find anything relevant.

> ... OMAP1510 doesn't support DMA chaining so there are few
> cpu_is_omap1510() code snippets in sound/soc/omap/omap-pcm.c which I
> think I have only simulated using OMAP2420.

I hope DMA chaining is not an issue here. If I remove the DMA chaining 
workaround from the original patch, I get signle DMA interrupts, so that 
is better than none that I get with my patch.

Thanks,
Janusz
