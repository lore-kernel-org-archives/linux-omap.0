From: Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 15:07:23 +0200
Message-ID: <4A1D3B0B.3060808@tis.icnet.pl>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200905270857.28125.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <200905270857.28125.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Hi Peter,

On Wuesday 27 May 2009 07:57 Peter Ujfalusi wrote:
> On Tuesday 26 May 2009 16:17:23 ext Janusz Krzysztofik wrote:
>> 4. the following McBSP register settings changes:
>>
>> -	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
>> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
>> +	.xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
>>
>> -	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
>> +	.srgr1 = CLKGDV(0),
>>
>> -	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
>> +       .srgr2 = GSYNC,
>>
>> -	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
> 
> Since I don't have the original osk/aic23 thing, this does not mean to much...
> Just a bit confusing.

OK, once again then.

original omap-alsa mcbsp register settings for osk board, as found in 
linux-2.6.16/arch/arm/mach-omap1/board-osk.c:
-----
#define DEFAULT_BITPERSAMPLE 16

static struct omap_mcbsp_reg_cfg mcbsp_regs = {
         .spcr2 = FREE | FRST | GRST | XRST | XINTM(3),
         .spcr1 = RINTM(3) | RRST,
         .rcr2 = RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
             RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
         .rcr1 = RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_16),
         .xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
             XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
         .xcr1 = XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_16),
         .srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
         .srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
         /*.pcr0 = FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* 
mcbsp: master */
         .pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
};
-----
the same for ams-delta, as found in Mark Underwood patch:
-----
static struct omap_mcbsp_reg_cfg mcbsp_regs = {
         .spcr2 = FREE | XRST | GRST | XINTM(3) | FRST,
         .spcr1 =  RINTM(3) | RRST,
         .rcr2 =  RPHASE | RWDLEN2(OMAP_MCBSP_WORD_16) | RFRLEN2(0),
         .rcr1 = RWDLEN1(OMAP_MCBSP_WORD_16) | RFRLEN1(0),
         .xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
         .xcr1 =  XWDLEN1(OMAP_MCBSP_WORD_16) | XFRLEN1(0),
         .srgr1 = CLKGDV(0),
         .srgr2 = GSYNC,
};
-----
currnet soc-audio mcbsp config for osk, as found in 
linux-2.6.29/sound/soc/omap/osk5912.c:
-----
         err = snd_soc_dai_set_fmt(cpu_dai,
                                   SND_SOC_DAIFMT_DSP_B |
                                   SND_SOC_DAIFMT_NB_NF |
                                   SND_SOC_DAIFMT_CBM_CFM);
-----
Using exactly the same does not work on my ams-delta.

 > The configuration suggest slave McBSP with NB_IF
> polarity, dual phase format, 16 bit words, 16*2 long frames, the FS pulse is 
> probably a pulse... Suggesting kind of DSP mode, but with not so correct 
> configuration, which happens to be working.

So I will try the following then:
         err = snd_soc_dai_set_fmt(cpu_dai,
                                   SND_SOC_DAIFMT_DSP_B |
                                   SND_SOC_DAIFMT_NB_IF |
                                   SND_SOC_DAIFMT_CBM_CFM);
and this:
         err = snd_soc_dai_set_fmt(cpu_dai,
                                   SND_SOC_DAIFMT_DSP_A |
                                   SND_SOC_DAIFMT_NB_IF |
                                   SND_SOC_DAIFMT_CBM_CFM);
and give you a feedback.

>> ... aplay
>> and arecord wait forever, cat to/from /dev/dsp breaks with hardware
>> error messgae.
>> DMA interrput counters stay at 0.
> 
> This means that the McBSP module is not transmitting/receiving any data.
> Which suggests that the clocking is not working in your setup. Check the slave 
> master mode for the codec.

Do you mean trying with codec as slave and McBSP as master, like this?
         err = snd_soc_dai_set_fmt(cpu_dai,
                                   SND_SOC_DAIFMT_DSP_B |
                                   SND_SOC_DAIFMT_NB_IF |
                                   SND_SOC_DAIFMT_CBS_CFS);
I'll give it a try as well.

> Also worth checking the PIN configuration for the McBSP1 module, just in case 
> it is correct.

Do you mean mux setup? Reading OMAP5910 Data Manual I found only 2 
relevant signals, MCBSP1.FSX and MCBSP1.DX, that could be swapped from 
pin H15 to H18 and vice versa. However, there is no pin configuration 
entry for neither, both in 2.6.16 and 2.6.29 arch/arm/mach-omap1/mux.c, 
so I assume default setup should just work.

I keep on digging.

Thanks,
Janusz
