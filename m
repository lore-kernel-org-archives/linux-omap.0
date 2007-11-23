From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH: Resending] - onenand - OMAP3 support - Kconfig update
Date: Fri, 23 Nov 2007 13:28:31 -0800
Message-ID: <20071123212831.GJ559@atomide.com>
References: <00c601c82aa7$faf8e620$ec8818ac@ent.ti.com>
	<010001c82b47$71eae130$ec8818ac@ent.ti.com>
	<014f01c82cc4$82ad3260$ec8818ac@ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <014f01c82cc4$82ad3260$ec8818ac@ent.ti.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Sameer <x0081444@ti.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

* Sameer <x0081444@ti.com> [071121 21:00]:
> 
> Hi,
> Please ignore the previous patch.
> The following patch provides the onenand support for OMAP3.
> The patch enables the onenand in def_config file, enable onenand Kconfig for OMAP3 and enables omap2_sleep_block() only if CONFIG_PM
> is defined.
> Also adding the signed off by line which was missed in the previous mail.
> 
> 
> Regards,
> -Sameer
> 
> Signed-off-by: Nishant Kamat <nskamat@ti.com>
> Signed-off-by: Sameer <sameersu@ti.com>
> ---
> Index: linux-omap-git-20071030/arch/arm/configs/omap_3430sdp_defconfig
> ===================================================================
> --- linux-omap-git-20071030.orig/arch/arm/configs/omap_3430sdp_defconfig
> 2007-11-08 11:28:56.000000000 -0600
> +++ linux-omap-git-20071030/arch/arm/configs/omap_3430sdp_defconfig
> 2007-11-08 11:29:23.000000000 -0600
> @@ -461,7 +461,10 @@
>  CONFIG_MTD_ONENAND=y
>  CONFIG_MTD_ONENAND_VERIFY_WRITE=y
>  # CONFIG_MTD_ONENAND_GENERIC is not set
> +CONFIG_MTD_ONENAND_OMAP2=y
>  # CONFIG_MTD_ONENAND_OTP is not set
> +# CONFIG_MTD_ONENAND_2X_PROGRAM is not set
> +# CONFIG_MTD_ONENAND_SIM is not set
> 
>  #
>  # UBI - Unsorted block images
> Index: linux-omap-git-20071030/drivers/mtd/onenand/Kconfig
> ===================================================================
> --- linux-omap-git-20071030.orig/drivers/mtd/onenand/Kconfig    2007-11-08
> 11:25:21.000000000 -0600
> +++ linux-omap-git-20071030/drivers/mtd/onenand/Kconfig 2007-11-08
> 11:25:44.000000000 -0600
> @@ -28,10 +28,10 @@
>           Support for OneNAND flash via platform device driver.
> 
>  config MTD_ONENAND_OMAP2
> -       tristate "OneNAND on OMAP2 support"
> -       depends on MTD_ONENAND && ARCH_OMAP2
> +       tristate "OneNAND on OMAP2/OMAP3 support"
> +       depends on MTD_ONENAND && (ARCH_OMAP2 || ARCH_OMAP3)
>         help
> -         Support for a OneNAND flash device connected to an OMAP2 CPU
> +         Support for a OneNAND flash device connected to an OMAP2/OMAP3 CPU
>           via the GPMC memory controller.
> 
>  config MTD_ONENAND_OTP
> Index: linux-omap-git-20071030/drivers/mtd/onenand/omap2.c
> ===================================================================
> --- linux-omap-git-20071030.orig/drivers/mtd/onenand/omap2.c    2007-11-08
> 12:01:45.000000000 -0600
> +++ linux-omap-git-20071030/drivers/mtd/onenand/omap2.c 2007-11-08
> 12:02:08.000000000 -0600
> @@ -39,7 +39,6 @@
>  #include <asm/arch/onenand.h>
>  #include <asm/arch/gpio.h>
>  #include <asm/arch/gpmc.h>
> -#include <asm/arch/pm.h>
> 
>  #include <linux/dma-mapping.h>
>  #include <asm/dma-mapping.h>
> @@ -47,6 +46,13 @@
> 
>  #include <asm/arch/board.h>
> 
> +#ifdef CONFIG_PM
> +#include <asm/arch/pm.h>
> +#else
> +#define omap2_block_sleep()    /* NULL */
> +#define omap2_allow_sleep()    /* NULL */
> +#endif
> +
>  #define ONENAND_IO_SIZE                SZ_128K
>  #define ONENAND_BUFRAM_SIZE    (1024 * 5)
> 

How about defining these in asm/arch/pm.h instead?

Tony
