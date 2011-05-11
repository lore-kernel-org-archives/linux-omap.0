From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: omap-mcbsp: Remove restrictive checks
 for cpu type
Date: Wed, 11 May 2011 11:16:58 -0700
Message-ID: <4DCAD29A.5050408@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f173.google.com ([209.85.212.173]:60316 "EHLO
	mail-px0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab1EKSRD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 11 May 2011 14:17:03 -0400
Received: by pxi16 with SMTP id 16so498234pxi.4
        for <linux-omap@vger.kernel.org>; Wed, 11 May 2011 11:17:02 -0700 (PDT)
In-Reply-To: <1305122135-27938-1-git-send-email-premi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, Liam Girdwood <lrg@ti.com>

On 05/11/11 06:55, Sanjeev Premi wrote:
> Current checks for cpu type were too restrictive leading
> to failures for other silicons in same family.
> 
> The problem was found while testing audio playback on
> AM37x and AM35x processors. But should exist on OMAP36xx
> as well.
> 
> Signed-off-by: Sanjeev Premi <premi@ti.com>
> cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
> cc: Liam Girdwood <lrg@ti.com>
> cc: Jarkko Nikula <jhnikula@gmail.com>
> ---
> 
>  Changes in v4:
>    Reposting after validating that patch still applies cleanly on
>    linux-omap master [46966f1]
> 
>    Changed the subject as suggested by Jarkko. Since the subject
>    has changed, i have omitted v4.
> 
>  Changes in v3::
>    None. Reposting[1] after subscribing to alsa-devel list
> 
>  Changes in v2:
>    1) Added one more check to the changes.
>    2) Updated commit message to use plurals.
> 
> 

Hi,

I removed all but the linux-omap list for my question.

I am trying to get the beagleboardxm to work with an external codec. I
am trying to use a mcbsp1 via the trainer board where it level shifts to
5 volts. I have applied this patch (I am on 2.6.39rc4), but still no
joy. I have a small analyzer attached to the I/O pins and important
things like the bit clock does not wiggle.

First a side question. In the arch/arm/mach-omap2/Kconfig when I select
BEAGLE, it selects OMAP_PACKAGE_CBB - but my bbxm system reference
manual says "The BeagleBoard-xM processor is the DM3730CBP 1GHz version"
which to me implies the proper package selection should be
OMAP_PACKAGE_CBP. The platform file mux34xx.c has different tables for
them, but I cant quickly tell the difference. Does this matter for mcbspx?

Here is a console dump where I try to aplay a file:
[ 1565.773712] omap_mcbsp_dai_startup: omap-mcbsp-dai.0 bus_id=0 active 0
[ 1565.781829] omap_pcm_open: ret 1
[ 1565.785491] asoc: HiFi <-> omap-mcbsp-dai.0 info:
[ 1565.790527] asoc: rate mask 0x7fe
[ 1565.794006] asoc: min ch 1 max ch 2
[ 1565.797760] asoc: min rate 8000 max rate 96000
[ 1565.826721] bbxm_hw_params: codec_dai=dfbbb9c0 clk 12288000
[ 1565.832702] bbxm_hw_params 2: codec_dai=dfbbb9c0 clk 12288000
[ 1565.838867] omap_mcbsp_dai_set_dai_fmt: configured 0
[ 1565.844146] bbxm_hw_params 3: codec_dai=dfbbb9c0 clk 12288000
[ 1565.850219] omap_mcbsp_dai_set_dai_sysclk: mcbsp_data=bf00d5b8 in_freq 0
[ 1565.857299] omap_mcbsp_dai_set_dai_sysclk: mcbsp_data=bf00d5b8 in_freq 0
[ 1565.864379] omap_mcbsp_dai_set_dai_sysclk: mcbsp_data=bf00d5b8
in_freq 2048000
[ 1565.877319] max98095 4-0010: read 2a => 10
[ 1565.884277] max98095 4-0010: read 27 => 1
[ 1565.891143] max98095 4-0010: read 2a => 10
[ 1565.898956] max98095 4-0010: read 2e => 0
[ 1565.903198] omap_mcbsp_dai_hw_params: format 1
[ 1565.907958] omap_mcbsp_dai_hw_params: stream Audio Playback
[ 1565.913909] omap_mcbsp_dai_hw_params: framesize 32 in_freq=2048000
div=8 rate=8000
[ 1565.921936] omap-mcbsp omap-mcbsp.1: Configuring McBSP1  phys_base:
0x48074000
[ 1565.929565] omap_pcm_hw_params: ret 0
[ 1565.934722] omap_pcm_prepare: dma_data bf00d4a0
[ 1565.945831] max98095 4-0010: read 91 => 0
[ 1565.950347] max98095 4-0010: write 91 = 3
[ 1565.958618] max98095 4-0010: read 91 => 3
[ 1565.963195] max98095 4-0010: write 91 = c3
[ 1565.972351] snd_pcm_lib_write1: state 2 size 1000
[ 1565.977691] snd_pcm_lib_write1: offset 0
[ 1565.981842] snd_pcm_update_state: stream=0 avail=3000
buffer_size=4000 twake=0 tsleep=1
[ 1565.992706] snd_pcm_lib_write1: state 2 size 1000
[ 1565.997985] snd_pcm_lib_write1: offset 0
[ 1566.002227] snd_pcm_update_state: stream=0 avail=2000
buffer_size=4000 twake=0 tsleep=1
[ 1566.011810] snd_pcm_lib_write1: state 2 size 1000
[ 1566.017120] snd_pcm_lib_write1: offset 0
[ 1566.021270] snd_pcm_update_state: stream=0 avail=1000
buffer_size=4000 twake=0 tsleep=1
[ 1566.033050] snd_pcm_lib_write1: state 2 size 1000
[ 1566.038360] snd_pcm_lib_write1: offset 0
[ 1566.042510] snd_pcm_pre_start: state 3
[ 1566.046447] snd_pcm_do_start: state 3
[ 1566.050292] omap_pcm_trigger: cmd 1
[ 1566.053955] omap_start_dma: lch 0
[ 1566.057891] omap-mcbsp omap-mcbsp.1: **** McBSP1 regs ****
[ 1566.063629] omap-mcbsp omap-mcbsp.1: DRR2:  0x0000
[ 1566.068664] omap-mcbsp omap-mcbsp.1: DRR1:  0x0000
[ 1566.073699] omap-mcbsp omap-mcbsp.1: DXR2:  0x0000
[ 1566.078735] omap-mcbsp omap-mcbsp.1: DXR1:  0x0000
[ 1566.083740] omap-mcbsp omap-mcbsp.1: SPCR2: 0x02f5
[ 1566.088775] omap-mcbsp omap-mcbsp.1: SPCR1: 0x0030
[ 1566.093811] omap-mcbsp omap-mcbsp.1: RCR2:  0x8041
[ 1566.098846] omap-mcbsp omap-mcbsp.1: RCR1:  0x0040
[ 1566.103851] omap-mcbsp omap-mcbsp.1: XCR2:  0x8041
[ 1566.108886] omap-mcbsp omap-mcbsp.1: XCR1:  0x0040
[ 1566.113922] omap-mcbsp omap-mcbsp.1: SRGR2: 0x101f
[ 1566.118927] omap-mcbsp omap-mcbsp.1: SRGR1: 0x0f07
[ 1566.123962] omap-mcbsp omap-mcbsp.1: PCR0:  0x0f0f
[ 1566.128997] omap-mcbsp omap-mcbsp.1: ***********************
[ 1566.134918] snd_pcm_post_start: state 3
[ 1566.138977] snd_pcm_update_state: stream=0 avail=0 buffer_size=4000
twake=0 tsleep=1
[ 1566.148681] snd_pcm_lib_write1: state 3 size 1000
[ 1566.153625] omap_pcm_pointer: offset 64
[ 1566.157653] snd_pcm_update_hw_ptr0: old_hw_ptr=0 pos=64 in_int=0
[ 1566.163970] snd_pcm_update_hw_ptr0: stream=0 new_hw_ptr=64 silence_size=0
[ 1566.171081] snd_pcm_update_state: stream=0 avail=64 buffer_size=4000
twake=1000 tsleep=1
[ 1566.180145] snd_pcm_lib_write1: offset 0
[ 1566.184295] snd_pcm_lib_write1: state 3 size 936
[ 1566.189147] omap_pcm_pointer: offset 64
[ 1566.193176] snd_pcm_update_hw_ptr0: old_hw_ptr=64 pos=64 in_int=0
[ 1576.194274] ALSA sound/core/pcm_lib.c:1795: playback write error (DMA
or IRQ trouble?)
[ 1576.304199] snd_pcm_lib_write1: state 3 size 936
[ 1576.309051] omap_pcm_pointer: offset 64
[ 1576.313079] snd_pcm_update_hw_ptr0: old_hw_ptr=64 pos=64 in_int=0
[ 1586.319274] ALSA sound/core/pcm_lib.c:1795: playback write error (DMA
or IRQ trouble?)
[ 1586.337554] omap_pcm_trigger: cmd 0
[ 1591.342651] pop wq checking: HiFi Playback status: inactive waiting: yes
[ 1591.351898] max98095 4-0010: read 91 => c3
[ 1591.356231] max98095 4-0010: write 91 = 3
[ 1591.362030] max98095 4-0010: read 91 => 3
[ 1591.366424] max98095 4-0010: write 91 = 0
[ 1591.373229] max98095 4-0010: read 90 => c
