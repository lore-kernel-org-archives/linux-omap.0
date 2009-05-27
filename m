From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: Please help in adding ams-delta support to ASoC
Date: Wed, 27 May 2009 09:59:49 +0300
Message-ID: <20090527095949.51ed4b83.jhnikula@gmail.com>
References: <4A1BEBE3.8010306@tis.icnet.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <4A1BEBE3.8010306@tis.icnet.pl>
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
Cc: linux-omap@vger.kernel.org, alsa-devel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi

On Tue, 26 May 2009 15:17:23 +0200
Janusz Krzysztofik <jkrzyszt@tis.icnet.pl> wrote:

Grr, these McBSP bits are always almost un-readable :-)

> 4. the following McBSP register settings changes:
> 
> -	.xcr2 = XPHASE | XFRLEN2(OMAP_MCBSP_WORD_8) |
> -	    XWDLEN2(OMAP_MCBSP_WORD_16) | XDATDLY(0) | XFIG,
> +	.xcr2 = XPHASE | XWDLEN2(OMAP_MCBSP_WORD_16) | XFRLEN2(0),
> 
XFIG is only difference (OMAP_MCBSP_WORD_8 = 0) -> transfer is aborted
in case of unexpected frame sync.

> -	.srgr1 = FWID(DEFAULT_BITPERSAMPLE - 1),
> +	.srgr1 = CLKGDV(0),
> 
Width of frame sync signal set to 1 here -> DSP_B format because no
data delay set.

> -	.srgr2 = GSYNC | CLKSP | FSGM | FPER(DEFAULT_BITPERSAMPLE *
> 2 - 1),
> +       .srgr2 = GSYNC,
> 
> -	.pcr0 = CLKXP | CLKRP,  /* mcbsp: slave */
> 
No CLKXM, CLKRM and FSGM set -> codec is providing the frame sync and
bit-clock signals -> SND_SOC_DAIFMT_CBM_CFM.

CLKXP and CLKRP not set -> rising edge of bit clock drives the
transitions. This with DSP_B indicates inverted bit clock so
SND_SOC_DAIFMT_IB_NF.

I wonder why the frame sync period (FWID) wasn't set in that original
patch but probably McBSP is able to work without :-)

> safely access the device, however it does not work as expected. aplay 
> and arecord wait forever, cat to/from /dev/dsp breaks with hardware 
> error messgae. DMA interrput counters stay at 0. However, codec 

Looks like McBSP is not getting bit-clock and frame-sync signals from
the codec. Do you have any way to measure is the codec sending those?

Another possibility are the OMAP pins muxed for McBSP? I assume they
are if the bootloader is still the same but worth to find check was
previous kernel doing any runtime remuxing for those pins with
omap_cfg_reg calls.

> First of all, I'd like to make sure if my problem is related to my
> code only. As I am new in these areas, I would like to ask you if the
> omap asoc framework is stable enough to relay on. If yes, could you
> please look at my dirty code (attached) an give me some hints? I can
> provide you with more information if necessary.
> 
I hope it's stable enough for you to get going. It would be nice to get
this working since it would be the first OMAP5910 == OMAP1510 based
machine driver. OMAP1510 doesn't support DMA chaining so there are few
cpu_is_omap1510() code snippets in sound/soc/omap/omap-pcm.c which I
think I have only simulated using OMAP2420.


-- 
Jarkko
