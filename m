From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap: Enable COMPILE_TEST build for
	DT platforms
Date: Mon, 15 Jul 2013 18:43:46 +0200
Message-ID: <51E426C2.5060209@ti.com>
References: <1373903876-26370-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1373903876-26370-1-git-send-email-broonie@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>, Mark Brown <broonie@linaro.org>
List-Id: linux-omap@vger.kernel.org

Hi Mark,

On 07/15/2013 05:57 PM, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> =

> The DT platforms don't have any source dependency on any OMAP stuff so
> allow them to be built when COMPILE_TEST is enabled.

The OMAP3 generic machine driver could be also included in this patch:
SND_OMAP_SOC_OMAP_TWL4030

> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---

Otherwise:
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

>  sound/soc/omap/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 9f5d55e..68dfc0a 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -1,6 +1,6 @@
>  config SND_OMAP_SOC
>  	tristate "SoC Audio for the Texas Instruments OMAP chips"
> -	depends on ARCH_OMAP && DMA_OMAP
> +	depends on (ARCH_OMAP && DMA_OMAP) || COMPILE_TEST
>  	select SND_SOC_DMAENGINE_PCM
>  =

>  config SND_OMAP_SOC_DMIC
> @@ -26,7 +26,7 @@ config SND_OMAP_SOC_N810
>  =

>  config SND_OMAP_SOC_RX51
>  	tristate "SoC Audio support for Nokia RX-51"
> -	depends on SND_OMAP_SOC && MACH_NOKIA_RX51
> +	depends on SND_OMAP_SOC && (MACH_NOKIA_RX51 || COMPILE_TEST)
>  	select SND_OMAP_SOC_MCBSP
>  	select SND_SOC_TLV320AIC3X
>  	select SND_SOC_TPA6130A2
> @@ -87,7 +87,7 @@ config SND_OMAP_SOC_OMAP_TWL4030
>  =

>  config SND_OMAP_SOC_OMAP_ABE_TWL6040
>  	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
> -	depends on TWL6040_CORE && SND_OMAP_SOC && ARCH_OMAP4
> +	depends on TWL6040_CORE && SND_OMAP_SOC && (ARCH_OMAP4 || COMPILE_TEST)
>  	select SND_OMAP_SOC_DMIC
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
> =



-- =

P=E9ter
