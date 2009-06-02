From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Tue, 2 Jun 2009 08:47:19 +0300
Message-ID: <200906020847.19108.peter.ujfalusi@nokia.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
	<200905270857.28125.peter.ujfalusi@nokia.com>
	<4A1D3B0B.3060808@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A1D3B0B.3060808@tis.icnet.pl>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, ext Janusz Krzysztofik <jkrzyszt@tis.icnet.pl>
List-Id: linux-omap@vger.kernel.org

On Wednesday 27 May 2009 16:07:23 ext Janusz Krzysztofik wrote:
> Hi Peter,
>
> On Wuesday 27 May 2009 07:57 Peter Ujfalusi wrote:
> > On Tuesday 26 May 2009 16:17:23 ext Janusz Krzysztofik wrote:
> >> 4. the following McBSP register settings changes:
> >>
> >> -	.xcr2 =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> >> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
> >> +	.xcr2 =3D XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
> >>
> >> -	.srgr1 =3D FWID(DEFAULT_BITPERSAMPLE - 1),
> >> +	.srgr1 =3D CLKGDV(0),
> >>
> >> -	.srgr2 =3D GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 - 1),
> >> +       .srgr2 =3D GSYNC,
> >>
> >> -	.pcr0 =3D CLKXP | CLKRP,  /* mcbsp: slave */
> >
> > Since I don't have the original osk/aic23 thing, this does not mean to
> > much... Just a bit confusing.
>
> OK, once again then.
>
> original omap-alsa mcbsp register settings for osk board, as found in
> linux-2.6.16/arch/arm/mach-omap1/board-osk.c:
> -----
> #define DEFAULT_BITPERSAMPLE 16
>
> static struct omap_mcbsp_reg_cfg mcbsp_regs =3D {
>          .spcr2 =3D FREE | FRST | GRST | XRST | XINTM(3),
>          .spcr1 =3D RINTM(3) | RRST,
>          .rcr2 =3D RPHASE | RFRLEN2(OMAP_MCBSP_WORD_8) |
>              RWDLEN2(OMAP_MCBSP_WORD_16) | RDATDLY(0),
>          .rcr1 =3D RFRLEN1(OMAP_MCBSP_WORD_8) | RWDLEN1(OMAP_MCBSP_WORD_1=
6),
>          .xcr2 =3D XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
>              XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
>          .xcr1 =3D XFRLEN1(OMAP_MCBSP_WORD_8) | XWDLEN1(OMAP_MCBSP_WORD_1=
6),
>          .srgr1 =3D FWID(DEFAULT_BITPERSAMPLE - 1),
>          .srgr2 =3D GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE * 2 -
> 1), /*.pcr0 =3D FSXM | FSRM | CLKXM | CLKRM | CLKXP | CLKRP,*/ /* mcbsp:
> master */
>          .pcr0 =3D CLKXP | CLKRP,  /* mcbsp: slave */
> };
> -----
> the same for ams-delta, as found in Mark Underwood patch:
> -----
> static struct omap_mcbsp_reg_cfg mcbsp_regs =3D {
>          .spcr2 =3D FREE | XRST | GRST | XINTM(3) | FRST,
>          .spcr1 =3D  RINTM(3) | RRST,
>          .rcr2 =3D  RPHASE | RWDLEN2(OMAP_MCBSP_WORD_16) | RFRLEN2(0),
>          .rcr1 =3D RWDLEN1(OMAP_MCBSP_WORD_16) | RFRLEN1(0),
>          .xcr2 =3D XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
>          .xcr1 =3D  XWDLEN1(OMAP_MCBSP_WORD_16) | XFRLEN1(0),
>          .srgr1 =3D CLKGDV(0),
>          .srgr2 =3D GSYNC,
> };

I wonder has this been working at all???
FPER is not configured in srgr2 (actually it is 0, which means that the fra=
me =

period is 1...)
FWID is not configured in srgr1 (it is 0, which means the FS is a pulse, =

length is 1)
Since CLKXP, CLKRP is 0, it suggests inverted bitclock.
FSXP, FSRP is 0, so it must have normal FS polarity in DSP mode, or inverte=
d =

polarity in I2S mode???
Data delay is 0 for rx and tx.

In all, I think this is a missconfigured DSP_B mode with inverted bitclock.
Can you try this:
          err =3D snd_soc_dai_set_fmt(cpu_dai,
                                    SND_SOC_DAIFMT_DSP_B |
                                    SND_SOC_DAIFMT_IB_NF |
                                    SND_SOC_DAIFMT_CBM_CFM);



> -----
> currnet soc-audio mcbsp config for osk, as found in
> linux-2.6.29/sound/soc/omap/osk5912.c:
> -----
>          err =3D snd_soc_dai_set_fmt(cpu_dai,
>                                    SND_SOC_DAIFMT_DSP_B |
>                                    SND_SOC_DAIFMT_NB_NF |
>                                    SND_SOC_DAIFMT_CBM_CFM);
> -----
> Using exactly the same does not work on my ams-delta.
>
>  > The configuration suggest slave McBSP with NB_IF
> >
> > polarity, dual phase format, 16 bit words, 16*2 long frames, the FS pul=
se
> > is probably a pulse... Suggesting kind of DSP mode, but with not so
> > correct configuration, which happens to be working.
>
> So I will try the following then:
>          err =3D snd_soc_dai_set_fmt(cpu_dai,
>                                    SND_SOC_DAIFMT_DSP_B |
>                                    SND_SOC_DAIFMT_NB_IF |
>                                    SND_SOC_DAIFMT_CBM_CFM);
> and this:
>          err =3D snd_soc_dai_set_fmt(cpu_dai,
>                                    SND_SOC_DAIFMT_DSP_A |
>                                    SND_SOC_DAIFMT_NB_IF |
>                                    SND_SOC_DAIFMT_CBM_CFM);
> and give you a feedback.
>
> >> ... aplay
> >> and arecord wait forever, cat to/from /dev/dsp breaks with hardware
> >> error messgae.
> >> DMA interrput counters stay at 0.
> >
> > This means that the McBSP module is not transmitting/receiving any data.
> > Which suggests that the clocking is not working in your setup. Check the
> > slave master mode for the codec.
>
> Do you mean trying with codec as slave and McBSP as master, like this?
>          err =3D snd_soc_dai_set_fmt(cpu_dai,
>                                    SND_SOC_DAIFMT_DSP_B |
>                                    SND_SOC_DAIFMT_NB_IF |
>                                    SND_SOC_DAIFMT_CBS_CFS);
> I'll give it a try as well.
>
> > Also worth checking the PIN configuration for the McBSP1 module, just in
> > case it is correct.
>
> Do you mean mux setup? Reading OMAP5910 Data Manual I found only 2
> relevant signals, MCBSP1.FSX and MCBSP1.DX, that could be swapped from
> pin H15 to H18 and vice versa. However, there is no pin configuration
> entry for neither, both in 2.6.16 and 2.6.29 arch/arm/mach-omap1/mux.c,
> so I assume default setup should just work.
>
> I keep on digging.
>
> Thanks,
> Janusz
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- =

P=E9ter
