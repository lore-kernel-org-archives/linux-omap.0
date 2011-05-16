From: Steve Calfee <stevecalfee@gmail.com>
Subject: Re: beagleboardxm 2.6.39rc4 mcbsp problems.
Date: Mon, 16 May 2011 11:07:40 -0700
Message-ID: <4DD167EC.2010007@gmail.com>
References: <1305122135-27938-1-git-send-email-premi@ti.com> <201105130859.12477.peter.ujfalusi@ti.com> <BANLkTi=9pm=xRqgt-tiV9+S594+Zo2ysCQ@mail.gmail.com> <201105161154.55850.peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62861 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab1EPSHp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 16 May 2011 14:07:45 -0400
Received: by pwi15 with SMTP id 15so2231009pwi.19
        for <linux-omap@vger.kernel.org>; Mon, 16 May 2011 11:07:45 -0700 (PDT)
In-Reply-To: <201105161154.55850.peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Jarkko Nikula <jhnikula@gmail.com>, "Premi, Sanjeev" <premi@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Girdwood, Liam" <lrg@ti.com>

On 05/16/11 01:54, Peter Ujfalusi wrote:
> On Saturday 14 May 2011 05:47:33 Steve Calfee wrote:
>> I put in a few debug statements. It appears that my DMA never gets
>> started. I know it can work with a different machine and codec driver,
>> but not mine. I don't see any explicit DMA init, but that must be the
>> problem.  Any more ideas?
> 
> You mean neither omap_pcm_hw_params nor omap_pcm_trigger got called?
> Could you post the output of dmesg related to ASoC? Does the connection 
> between the CPU and codec DAI correct?
> Does McBSP part got initialized (for example does omap_mcbsp_dai_hw_params, 
> omap_mcbsp_dai_trigger got called)?
> 
No, they get called. I just don't get the clock on the bclk pin.

I think I have the mcbsp1 set up correctly - I explictly set the MUX:

static struct omap_board_mux board_mux[] __initdata = {
#if 1
	/* McBSP 1 */
	OMAP3_MUX(MCBSP1_FSX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_CLKX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DR, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
	OMAP3_MUX(MCBSP1_DX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
#endif
	{ .reg_offset = OMAP_MUX_TERMINATOR },
};

And elsewhere I set the mcbsp to use a 4 pin interface:
	/* configure mcbsp1 to just use 4 pins */
	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_CLKR_SRC_CLKX, 0,
				SND_SOC_CLOCK_IN);
	if (ret < 0) {
		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_CLKR_SRC_CLKX\n");
		//return ret;
	}

	ret = snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_FSR_SRC_FSX, 0,
				SND_SOC_CLOCK_IN);
	if (ret < 0) {
		printk(KERN_ERR "can't set CPU system clock OMAP_MCBSP_FSR_SRC_FSX\n");
		//return ret;
	}


Here is some hopefully relevant console output. Note that where I added
debug printk's I also printed the __func__.

# cat /proc/asound/cards
 0 [bbxm           ]:  - bbxm
                      bbxm
# lsmod
Module                  Size  Used by    Not tainted
snd_soc_max98095       26314  1
snd_soc_omap3beaglexm     4818  0
snd_soc_omap_mcbsp      7148  1
gpio_i2cmux             1699  0
i2c_mux                 1408  1 gpio_i2cmux
# aplay /newmail2.wav
[  262.129882] omap_mcbsp_dai_startup: omap-mcbsp-dai.0 bus_id=0 active 0
[  262.137847] omap-mcbsp omap-mcbsp.1: omap_mcbsp_request:
tx_irq_completion t=59 r=60
[  262.146972] omap_mcbsp_dai_startup: rules omap-mcbsp-dai.0 bus_id=0
active 0
[  262.155090] omap_pcm_open: ret 1
[  262.158752] asoc: HiFi <-> omap-mcbsp-dai.0 info:
[  262.163757] asoc: rate mask 0x7fe
[  262.167327] asoc: min ch 1 max ch 2
[  262.170989] asoc: min rate 8000 max rate 96000
Playing WAVE '/newmail2.wav' : Signed 16 bit Little Endian, Rate 8000
Hz, Stereo
[  262.188537] bbxm_hw_params: codec_dai=dfbb9ac0 clk 12288000
[  262.194519] bbxm_hw_params 2: codec_dai=dfbb9ac0 clk 12288000
[  262.200683] omap_mcbsp_dai_set_dai_fmt: configured 0
[  262.205932] bbxm_hw_params 3: codec_dai=dfbb9ac0 clk 12288000
[  262.212036] omap_mcbsp_dai_set_dai_sysclk: mcbsp_data=bf00d5f8 in_freq 0
[  262.219116] omap_mcbsp_dai_set_dai_sysclk: mcbsp_data=bf00d5f8 in_freq 0
[  262.227752] max98095 4-0010: read 2a => 90
[  262.234832] max98095 4-0010: read 27 => 1
[  262.240875] max98095 4-0010: read 2a => 90
[  262.245300] max98095 4-0010: write 28 = 7
[  262.252044] max98095 4-0010: write 29 = 8f
[  262.261779] max98095 4-0010: read 2e => 0
[  262.266265] omap_mcbsp_dai_hw_params: format 1
[  262.270996] omap_mcbsp_dai_hw_params: stream Audio Playback
[  262.276977] omap-mcbsp omap-mcbsp.1: Configuring McBSP1  phys_base:
0x48074000
[  262.284606] omap_pcm_hw_params: ret 0
[  262.290008] omap_pcm_prepare: dma_data bf00d4e0
[  262.298980] max98095 4-0010: read 91 => 0
[  262.303558] max98095 4-0010: write 91 = 3
[  262.311798] max98095 4-0010: read 91 => 3
[  262.316345] max98095 4-0010: write 91 = c3
[  262.326690] snd_pcm_lib_write1: state 2 size 1000
[  262.332031] snd_pcm_lib_write1: offset 0
[  262.336181] snd_pcm_update_state: stream=0 avail=3000
buffer_size=4000 twake=0 tsleep=1
[  262.345825] snd_pcm_lib_write1: state 2 size 1000
[  262.351165] snd_pcm_lib_write1: offset 0
[  262.355346] snd_pcm_update_state: stream=0 avail=2000
buffer_size=4000 twake=0 tsleep=1
[  262.364929] snd_pcm_lib_write1: state 2 size 1000
[  262.370269] snd_pcm_lib_write1: offset 0
[  262.374420] snd_pcm_update_state: stream=0 avail=1000
buffer_size=4000 twake=0 tsleep=1
[  262.383972] snd_pcm_lib_write1: state 2 size 1000
[  262.389312] snd_pcm_lib_write1: offset 0
[  262.393463] snd_pcm_pre_start: state 3
[  262.397399] snd_pcm_do_start: state 3
[  262.401245] omap_pcm_trigger: cmd 1
[  262.404907] omap_start_dma: lch 0
[  262.408843] omap-mcbsp omap-mcbsp.1: **** McBSP1 regs ****
[  262.414581] omap-mcbsp omap-mcbsp.1: DRR2:  0x0000
[  262.419616] omap-mcbsp omap-mcbsp.1: DRR1:  0x0000
[  262.424652] omap-mcbsp omap-mcbsp.1: DXR2:  0x0000
[  262.429656] omap-mcbsp omap-mcbsp.1: DXR1:  0x0000
[  262.434692] omap-mcbsp omap-mcbsp.1: SPCR2: 0x0235
[  262.439727] omap-mcbsp omap-mcbsp.1: SPCR1: 0x0030
[  262.444763] omap-mcbsp omap-mcbsp.1: RCR2:  0x8041
[  262.449768] omap-mcbsp omap-mcbsp.1: RCR1:  0x0040
[  262.454803] omap-mcbsp omap-mcbsp.1: XCR2:  0x8041
[  262.459838] omap-mcbsp omap-mcbsp.1: XCR1:  0x0040
[  262.464843] omap-mcbsp omap-mcbsp.1: SRGR2: 0x001f
[  262.469879] omap-mcbsp omap-mcbsp.1: SRGR1: 0x0f00
[  262.474914] omap-mcbsp omap-mcbsp.1: PCR0:  0x000f
[  262.479919] omap-mcbsp omap-mcbsp.1: ***********************
[  262.485870] snd_pcm_post_start: state 3
[  262.489898] snd_pcm_update_state: stream=0 avail=0 buffer_size=4000
twake=0 tsleep=1
[  262.500854] snd_pcm_lib_write1: state 3 size 1000
[  262.505828] omap_pcm_pointer: offset 64
[  262.509857] snd_pcm_update_hw_ptr0: old_hw_ptr=0 pos=64 in_int=0
[  262.516143] snd_pcm_update_hw_ptr0: stream=0 new_hw_ptr=64 silence_size=0
[  262.523284] snd_pcm_update_state: stream=0 avail=64 buffer_size=4000
twake=1000 tsleep=1
[  262.532226] snd_pcm_lib_write1: offset 0
[  262.536407] snd_pcm_lib_write1: state 3 size 936
[  262.541259] omap_pcm_pointer: offset 64
[  262.545288] snd_pcm_update_hw_ptr0: old_hw_ptr=64 pos=64 in_int=0
[  272.549896] ALSA sound/core/pcm_lib.c:1795: playback write error (DMA
or IRQ trouble?)
[  272.659851] snd_pcm_lib_write1: state 3 size 936
[  272.664703] omap_pcm_pointer: offset 64
[  272.668731] snd_pcm_update_hw_ptr0: old_hw_ptr=64 pos=64 in_int=0
[  282.674957] ALSA sound/core/pcm_lib.c:1795: playback write error (DMA
or IRQ trouble?)
aplay: pcm_write[  282.686767] omap_pcm_trigger: cmd 0
:1682: write error: Input/output error
# [  287.706268] pop wq checking: HiFi Playback status: inactive
waiting: yes
[  287.715148] max98095 4-0010: read 91 => c3
[  287.719726] max98095 4-0010: write 91 = 3
[  287.725585] max98095 4-0010: read 91 => 3
[  287.729980] max98095 4-0010: write 91 = 0
[  287.736785] max98095 4-0010: read 90 => c

