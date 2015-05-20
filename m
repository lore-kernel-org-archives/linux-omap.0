From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap: fix up
 SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency, again
Date: Wed, 20 May 2015 10:54:32 +0300
Message-ID: <555C3DB8.5050506@ti.com>
References: <3413182.qcoNiOhonF@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <3413182.qcoNiOhonF@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, alsa-devel@alsa-project.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 05/19/2015 03:47 PM, Arnd Bergmann wrote:
> I tried to fix this before and submitted a working patch, but after
> some discussion we came up with what seemed to be a nicer solution,
> resulting in commit 3d4cf65e2d ("ASoC: omap: fix up
> SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency"). Unfortunately, that
> version was incomplete, and we still get this build error:
> =

> drivers/clk/clk-palmas.c:46:16: error: field 'hw' has incomplete type
> drivers/clk/clk-palmas.c: In function 'to_palmas_clks_info':
> drivers/clk/clk-palmas.c:54:74: warning: initialization from incompatible=
 pointer type [-Winc
> =

> This happens only in randconfig builds that turn on MFD_PALMAS
> on a platform other than OMAP2+ when COMPILE_TEST is set
> but COMMON_CLK is not.
> =

> The new approach is only 'select COMMON_CLK_PALMAS' if we know
> that we are on an OMAP5 platform and MFD_PALMAS is already set.
> This patch has survived thousands of randconfig builds and I
> don't see a remaining hole in the logic.

Yeah, debugging Kconfig is not for the faint-hearted ;)

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 3d4cf65e2d ("ASoC: omap: fix up SND_OMAP_SOC_OMAP_ABE_TWL6040 depe=
ndency")
> =

> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index 6768e4f7d7d0..30d0109703a9 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -100,12 +100,13 @@ config SND_OMAP_SOC_OMAP_TWL4030
>  =

>  config SND_OMAP_SOC_OMAP_ABE_TWL6040
>  	tristate "SoC Audio support for OMAP boards using ABE and twl6040 codec"
> -	depends on TWL6040_CORE && SND_OMAP_SOC && (ARCH_OMAP4 || SOC_OMAP5 || =
COMPILE_TEST)
> +	depends on TWL6040_CORE && SND_OMAP_SOC
> +	depends on ARCH_OMAP4 || (SOC_OMAP5 && MFD_PALMAS) || COMPILE_TEST
>  	select SND_OMAP_SOC_DMIC
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
>  	select SND_SOC_DMIC
> -	select COMMON_CLK_PALMAS if MFD_PALMAS
> +	select COMMON_CLK_PALMAS if (SOC_OMAP5 && MFD_PALMAS)
>  	help
>  	  Say Y if you want to add support for SoC audio on OMAP boards using
>  	  ABE and twl6040 codec. This driver currently supports:
> =

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =



-- =

P=E9ter
