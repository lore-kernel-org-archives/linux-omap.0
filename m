From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: omap: fix up
	SND_OMAP_SOC_OMAP_ABE_TWL6040 dependency
Date: Wed, 25 Feb 2015 17:31:47 +0200
Message-ID: <54EDEAE3.6080605@ti.com>
References: <22890811.0MuvZ4MxOU@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <22890811.0MuvZ4MxOU@wuerfel>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Arnd Bergmann <arnd@arndb.de>, broonie@kernel.org
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/25/2015 05:05 PM, Arnd Bergmann wrote:
> The change to enable OMAP5 support on this platform was a little too
> eager in adding a 'select' for a particular clock driver that might
> not be enabled in all configurations, which in turn leads to a build
> error:
> =

> warning: (SND_OMAP_SOC_OMAP_ABE_TWL6040) selects COMMON_CLK_PALMAS which =
has unmet direct dependencies (COMMON_CLK && MFD_PALMAS)
> drivers/built-in.o: In function `palmas_clks_probe':
> drivers/clk/clk-palmas.c:228: undefined reference to `palmas_ext_control_=
req_config'
> =

> I do not see a strong dependency here, so it's probably better to
> drop this select and to avoid adding more complexity here.
> =

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 5163c1eede8e9 ("ASoC: omap: Kconfig: Support for omap5-uevm analog=
 audio")
> =

> diff --git a/sound/soc/omap/Kconfig b/sound/soc/omap/Kconfig
> index e7c78b0406b5..e74d8db4619d 100644
> --- a/sound/soc/omap/Kconfig
> +++ b/sound/soc/omap/Kconfig
> @@ -105,7 +105,6 @@ config SND_OMAP_SOC_OMAP_ABE_TWL6040
>  	select SND_OMAP_SOC_MCPDM
>  	select SND_SOC_TWL6040
>  	select SND_SOC_DMIC
> -	select COMMON_CLK_PALMAS if SOC_OMAP5

Would it be better to have this changed to:
	select COMMON_CLK_PALMAS if MFD_PALMAS
instead of removing.

All OMAP5 boards uses Palmas as PMIC and the boards where twl6040 audio is =
in
use the 32K clock for the codec is coming from Palmas.
Without this clock the twl6040 will not boot up causing errors during probe=
 time.

>  	help
>  	  Say Y if you want to add support for SoC audio on OMAP boards using
>  	  ABE and twl6040 codec. This driver currently supports:
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> =



-- =

P=E9ter
