From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 02 Jun 2009 13:38:40 +0200
Message-ID: <4A250F40.8070609@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200905270857.28125.peter.ujfalusi@nokia.com>
	<4A1D3B0B.3060808@tis.icnet.pl>
	<200906020847.19108.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200906020847.19108.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

Peter Ujfalusi wrote:
> On Wednesday 27 May 2009 16:07:23 ext Janusz Krzysztofik wrote:
>> static struct omap_mcbsp_reg_cfg mcbsp_regs = {
>>          .spcr2 = FREE | XRST | GRST | XINTM(3) | FRST,
>>          .spcr1 =  RINTM(3) | RRST,
>>          .rcr2 =  RPHASE | RWDLEN2(OMAP_MCBSP_WORD_16) | RFRLEN2(0),
>>          .rcr1 = RWDLEN1(OMAP_MCBSP_WORD_16) | RFRLEN1(0),
>>          .xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
>>          .xcr1 =  XWDLEN1(OMAP_MCBSP_WORD_16) | XFRLEN1(0),
>>          .srgr1 = CLKGDV(0),
>>          .srgr2 = GSYNC,
>> };
> 
> I wonder has this been working at all???
> FPER is not configured in srgr2 (actually it is 0, which means that the frame 
> period is 1...)
> FWID is not configured in srgr1 (it is 0, which means the FS is a pulse, 
> length is 1)
> Since CLKXP, CLKRP is 0, it suggests inverted bitclock.
> FSXP, FSRP is 0, so it must have normal FS polarity in DSP mode, or inverted 
> polarity in I2S mode???
> Data delay is 0 for rx and tx.
> 
> In all, I think this is a missconfigured DSP_B mode with inverted bitclock.
> Can you try this:
>           err = snd_soc_dai_set_fmt(cpu_dai,
>                                     SND_SOC_DAIFMT_DSP_B |
>                                     SND_SOC_DAIFMT_IB_NF |
>                                     SND_SOC_DAIFMT_CBM_CFM);

Already tried before, did not help.

>> So I will try the following then:
>>          err = snd_soc_dai_set_fmt(cpu_dai,
>>                                    SND_SOC_DAIFMT_DSP_B |
>>                                    SND_SOC_DAIFMT_NB_IF |
>>                                    SND_SOC_DAIFMT_CBM_CFM);
>> and this:
>>          err = snd_soc_dai_set_fmt(cpu_dai,
>>                                    SND_SOC_DAIFMT_DSP_A |
>>                                    SND_SOC_DAIFMT_NB_IF |
>>                                    SND_SOC_DAIFMT_CBM_CFM);
>> and give you a feedback.

Sorry, I did not answer since I gave up trying different dai format 
settings after discovering that the original driver still worked with 
register settings taken directly form its prototype osk board code.

Anyway, I think I'll have to get back here after DMA interrupts start 
working.

Thanks,
Janusz
