From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Support
 SND_SOC_DAIFMT_CBM_CFS for omap3/4
Date: Sun, 21 Jul 2013 19:25:06 +0200
Message-ID: <51EC1972.8020602@ti.com>
References: <20130721162400.GA17491@panicking>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130721162400.GA17491@panicking>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Trimarchi <michael@amarulasolutions.com>
Cc: linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org
List-Id: linux-omap@vger.kernel.org

On 07/21/2013 06:24 PM, Michael Trimarchi wrote:
> Add SND_SOC_DAIFMT_CBM_CFS support for omap3/omap4. The patch was tested =
on
> a pandaboard-es board connected to the pcm1792a codec. mcbspx_fsx must
> configured as output and mcbspx_clkx must be configured as input.

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> =

> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |    5 +++++
>  1 file changed, 5 insertions(+)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index 7483efb..6c19bba 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -433,6 +433,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc=
_dai *cpu_dai,
>  		/* Sample rate generator drives the FS */
>  		regs->srgr2	|=3D FSGM;
>  		break;
> +	case SND_SOC_DAIFMT_CBM_CFS:
> +		/* McBSP slave. FS clock as output */
> +		regs->srgr2	|=3D FSGM;
> +		regs->pcr0	|=3D FSXM;
> +		break;
>  	case SND_SOC_DAIFMT_CBM_CFM:
>  		/* McBSP slave */
>  		break;
> =



-- =

P=E9ter
