From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: OMAP: mcbsp: ensure that CLKX and
 CLKR are not used as ouput pins when they are used as input clock for the
 SRG.
Date: Fri, 16 Jan 2015 11:15:55 +0200
Message-ID: <54B8D6CB.6020801@ti.com>
References: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1421360901-20671-1-git-send-email-niederp@physik.uni-kl.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?windows-1252?Q?Thomas_Niederpr=FCm?= <niederp@physik.uni-kl.de>, jarkko.nikula@bitmer.com
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 01/16/2015 12:28 AM, Thomas Niederpr=FCm wrote:
> This patch fixes faulty behaviour in a setup where the input clock for
> the SRG is fed through the CLKR pin but the McBSP is configured to be
> master (SND_SOC_DAIFMT_CBS_CFS). In that case of course CLKR must not be
> configured as output pin. Otherwise the input clock is messed up
> horribly. The same reasoning applies if CLKX is configured as input for
> the SRG.

If CLKX/CLKR is used as input clock for McBSP then the CBS_CFS is not valid.
In this case you need to use CBM_CFS.

> =

> Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> ---
>  sound/soc/omap/omap-mcbsp.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index bd3ef2a..c89f562 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -530,8 +530,12 @@ static int omap_mcbsp_dai_set_dai_sysclk(struct snd_=
soc_dai *cpu_dai,
>  =

>  	case OMAP_MCBSP_SYSCLK_CLKX_EXT:
>  		regs->srgr2	|=3D CLKSM;
> +		regs->pcr0	|=3D SCLKME;
> +		regs->pcr0	&=3D ~CLKXM;
> +		break;
>  	case OMAP_MCBSP_SYSCLK_CLKR_EXT:
>  		regs->pcr0	|=3D SCLKME;
> +		regs->pcr0	&=3D ~CLKRM;
>  		break;
>  	default:
>  		err =3D -ENODEV;
> =



-- =

P=E9ter
