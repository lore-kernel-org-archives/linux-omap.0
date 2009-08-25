From: Eduardo Valentin <eduardo.valentin@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: OMAP: Fix setup of XCCR and RCCR
 registers in McBSP DAI
Date: Tue, 25 Aug 2009 09:26:06 +0300
Message-ID: <20090825062606.GB15216@esdhcp037198.research.nokia.com>
References: <1251019467-11677-1-git-send-email-jhnikula@gmail.com>
	<1251019467-11677-3-git-send-email-jhnikula@gmail.com>
Reply-To: eduardo.valentin@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <1251019467-11677-3-git-send-email-jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Jarkko Nikula <jhnikula@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tony@atomide.com" <tony@atomide.com>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Sun, Aug 23, 2009 at 11:24:26AM +0200, Jarkko Nikula wrote:
> Commit ca6e2ce08679c094878d7f39a0349a7db1d13675 is setting up few XCCR and
> RCCR bits for I2S and DPS_A formats. Part of the bits are already set
> for all formats and I believe that XDISABLE and RDISABLE bits are
> format independent.
> 
> As XCCR and RCCR are found only from OMAP2430 and OMAP34xx, I move setup
> of XDISABLE and RDISABLE to where those cpu's are tested and remove format
> dependent part for simplicity.
> 
> Signed-off-by: Jarkko Nikula <jhnikula@gmail.com>
> Cc: Eero Nurkkala <ext-eero.nurkkala@nokia.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@nokia.com>

Acked-by: Eduardo Valentin <eduardo.valentin@nokia.com>

> ---
>  sound/soc/omap/omap-mcbsp.c |    8 ++------
>  1 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index f5387d9..89e8bce 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -379,8 +379,8 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  		regs->xcr2	|= XFIG;
>  	}
>  	if (cpu_is_omap2430() || cpu_is_omap34xx()) {
> -		regs->xccr = DXENDLY(1) | XDMAEN;
> -		regs->rccr = RFULL_CYCLE | RDMAEN;
> +		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
> +		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
>  	}
>  
>  	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
> @@ -388,15 +388,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  		/* 1-bit data delay */
>  		regs->rcr2	|= RDATDLY(1);
>  		regs->xcr2	|= XDATDLY(1);
> -		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
> -		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
>  		break;
>  	case SND_SOC_DAIFMT_DSP_A:
>  		/* 1-bit data delay */
>  		regs->rcr2      |= RDATDLY(1);
>  		regs->xcr2      |= XDATDLY(1);
> -		regs->rccr	|= RFULL_CYCLE | RDMAEN | RDISABLE;
> -		regs->xccr	|= (DXENDLY(1) | XDMAEN | XDISABLE);
>  		/* Invert FS polarity configuration */
>  		temp_fmt ^= SND_SOC_DAIFMT_NB_IF;
>  		break;
> -- 
> 1.6.3.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Eduardo Valentin
