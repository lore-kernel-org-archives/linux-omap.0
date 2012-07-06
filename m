From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: Re: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
Date: Fri, 6 Jul 2012 13:28:34 +0200
Message-ID: <20120706112834.GA4450@game.jcrosoft.org>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: jgq516@gmail.com
Cc: linux@arm.linux.org.uk, arnd@arndb.de, tony@atomide.com, nicolas.ferre@atmel.com, linux-kernel@vger.kernel.org, ldewangan@nvidia.com, olof@lixom.net, swarren@nvidia.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, hdoyu@nvidia.com
List-Id: linux-omap@vger.kernel.org

On 18:38 Fri 06 Jul     , jgq516@gmail.com wrote:
> From: Xiao Jiang <jgq516@gmail.com>
> 
> Since more and more arm chips support device tree, it'd be better add PROC_DEVICETREE
> in arch/arm/Kconfig to avoid duplicate code.
> 
Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Best Regards,
J.
> Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> ---
>  arch/arm/Kconfig                   |    1 +
>  arch/arm/configs/at91_dt_defconfig |    1 -
>  arch/arm/configs/tegra_defconfig   |    1 -
>  arch/arm/plat-omap/Kconfig         |    1 -
>  4 files changed, 1 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index a91009c..f68896e 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1864,6 +1864,7 @@ config USE_OF
>  	select OF
>  	select OF_EARLY_FLATTREE
>  	select IRQ_DOMAIN
> +	select PROC_DEVICETREE if PROC_FS
>  	help
>  	  Include support for flattened device tree machine descriptions.
>  
> diff --git a/arch/arm/configs/at91_dt_defconfig b/arch/arm/configs/at91_dt_defconfig
> index 67bc571..b856cb6 100644
> --- a/arch/arm/configs/at91_dt_defconfig
> +++ b/arch/arm/configs/at91_dt_defconfig
> @@ -64,7 +64,6 @@ CONFIG_MTD_NAND=y
>  CONFIG_MTD_NAND_ATMEL=y
>  CONFIG_MTD_UBI=y
>  CONFIG_MTD_UBI_GLUEBI=y
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_BLK_DEV_RAM=y
>  CONFIG_BLK_DEV_RAM_COUNT=4
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index 1198dd6..43e7b65 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -72,7 +72,6 @@ CONFIG_IPV6_TUNNEL=y
>  CONFIG_IPV6_MULTIPLE_TABLES=y
>  # CONFIG_WIRELESS is not set
>  # CONFIG_FIRMWARE_IN_KERNEL is not set
> -CONFIG_PROC_DEVICETREE=y
>  CONFIG_BLK_DEV_LOOP=y
>  CONFIG_AD525X_DPOT=y
>  CONFIG_AD525X_DPOT_I2C=y
> diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> index ad95c7a..4e2cb17 100644
> --- a/arch/arm/plat-omap/Kconfig
> +++ b/arch/arm/plat-omap/Kconfig
> @@ -27,7 +27,6 @@ config ARCH_OMAP2PLUS
>  	select GENERIC_IRQ_CHIP
>  	select OMAP_DM_TIMER
>  	select USE_OF
> -	select PROC_DEVICETREE if PROC_FS
>  	help
>  	  "Systems based on OMAP2, OMAP3 or OMAP4"
>  
> -- 
> 1.7.3
> 
