From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/14] PLAT: OMAP: Modifications at devices.c to use
	multislot structures
Date: Thu, 1 Nov 2007 05:55:59 -0700
Message-ID: <20071101125558.GG20403@atomide.com>
References: <46F28BC7.80309@indt.org.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <46F28BC7.80309@indt.org.br>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Carlos Aguiar <carlos.aguiar@indt.org.br>
Cc: omap-linux <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

* Carlos Aguiar <carlos.aguiar@indt.org.br> [070920 08:05]:
> From: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> 
> Modifications at arch/arm/plat-omap/devices.c to use multislot structures.
> 
> Signed-off-by: Carlos Eduardo Aguiar <carlos.aguiar@indt.org.br>
> Signed-off-by: Felipe Balbi <felipe.lima@indt.org.br>
> Signed-off-by: Jarkko Lavinen <jarkko.lavinen@nokia.com>
> ---
>  arch/arm/plat-omap/devices.c |   52 ++++++++++++++++++++---------------------
>  1 files changed, 25 insertions(+), 27 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/devices.c b/arch/arm/plat-omap/devices.c
> index c2828fe..3f6a6af 100644
> --- a/arch/arm/plat-omap/devices.c
> +++ b/arch/arm/plat-omap/devices.c
> @@ -21,6 +21,7 @@
>  
>  #include <asm/arch/tc.h>
>  #include <asm/arch/board.h>
> +#include <asm/arch/mmc.h>
>  #include <asm/arch/mux.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/menelaus.h>
> @@ -231,7 +232,7 @@ static inline void omap_init_kp(void) {}
>  #endif
>  #define	OMAP_MMC2_BASE		0xfffb7c00	/* omap16xx only */
>  
> -static struct omap_mmc_conf mmc1_conf;
> +static struct omap_mmc_platform_data mmc1_data;
>  
>  static u64 mmc1_dmamask = 0xffffffff;
>  
> @@ -252,7 +253,7 @@ static struct platform_device mmc_omap_device1 = {
>  	.id		= 1,
>  	.dev = {
>  		.dma_mask	= &mmc1_dmamask,
> -		.platform_data	= &mmc1_conf,
> +		.platform_data	= &mmc1_data,
>  	},
>  	.num_resources	= ARRAY_SIZE(mmc1_resources),
>  	.resource	= mmc1_resources,
> @@ -260,7 +261,7 @@ static struct platform_device mmc_omap_device1 = {
>  
>  #ifdef	CONFIG_ARCH_OMAP16XX
>  
> -static struct omap_mmc_conf mmc2_conf;
> +static struct omap_mmc_platform_data mmc2_data;
>  
>  static u64 mmc2_dmamask = 0xffffffff;
>  
> @@ -282,7 +283,7 @@ static struct platform_device mmc_omap_device2 = {
>  	.id		= 2,
>  	.dev = {
>  		.dma_mask	= &mmc2_dmamask,
> -		.platform_data	= &mmc2_conf,
> +		.platform_data	= &mmc2_data,
>  	},
>  	.num_resources	= ARRAY_SIZE(mmc2_resources),
>  	.resource	= mmc2_resources,
> @@ -291,20 +292,13 @@ static struct platform_device mmc_omap_device2 = {
>  
>  static void __init omap_init_mmc(void)
>  {
> -	const struct omap_mmc_config	*mmc_conf;
> -	const struct omap_mmc_conf	*mmc;
> +	const struct omap_mmc_platform_data     *mmc;
>  
>  	/* REVISIT: 2430 has HS MMC */
>  	if (cpu_is_omap2430() || cpu_is_omap34xx())
>  		return;
>  
> -	/* NOTE:  assumes MMC was never (wrongly) enabled */
> -	mmc_conf = omap_get_config(OMAP_TAG_MMC, struct omap_mmc_config);
> -	if (!mmc_conf)
> -		return;
> -
> -	/* block 1 is always available and has just one pinout option */
> -	mmc = &mmc_conf->mmc[0];
> +	mmc = &mmc1_data;
>  	if (mmc->enabled) {
>  		if (cpu_is_omap24xx()) {
>  			omap_cfg_reg(H18_24XX_MMC_CMD);

To me it seems you're nuking board specific configuration here? Also,
why remove a valid comment about the block 1 pinouts?

Tony
