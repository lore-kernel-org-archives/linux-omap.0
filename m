From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH] arm: omap2plus: move NAND_BLOCK_SIZE out of boards
Date: Wed, 11 May 2011 11:37:24 +0300
Message-ID: <4DCA4AC4.10002@compulab.co.il>
References: <1305099827-19832-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1305099827-19832-1-git-send-email-grinberg@compulab.co.il>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Please, ignore this,
I have another idea which I will send in the near future.

Sorry for the noise...

On 05/11/11 10:43, Igor Grinberg wrote:
> Each board defining mtd partitions also defined NAND_BLOCK_SIZE as
> SZ_128K. Move the define to common-board-devices.h
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/board-cm-t35.c         |    2 --
>  arch/arm/mach-omap2/board-cm-t3517.c       |    2 --
>  arch/arm/mach-omap2/board-devkit8000.c     |    2 --
>  arch/arm/mach-omap2/board-omap3beagle.c    |    2 --
>  arch/arm/mach-omap2/board-omap3pandora.c   |    2 --
>  arch/arm/mach-omap2/board-omap3touchbook.c |    2 --
>  arch/arm/mach-omap2/board-overo.c          |    2 --
>  arch/arm/mach-omap2/common-board-devices.h |    3 +++
>  8 files changed, 3 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index e0e2d48..4727a99 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -63,8 +63,6 @@
>  #define SB_T35_SMSC911X_CS	4
>  #define SB_T35_SMSC911X_GPIO	65
>  
> -#define NAND_BLOCK_SIZE		SZ_128K
> -
>  #if defined(CONFIG_SMSC911X) || defined(CONFIG_SMSC911X_MODULE)
>  #include <linux/smsc911x.h>
>  #include <plat/gpmc-smsc911x.h>
> diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
> index a27e3ee..7699eb6 100644
> --- a/arch/arm/mach-omap2/board-cm-t3517.c
> +++ b/arch/arm/mach-omap2/board-cm-t3517.c
> @@ -204,8 +204,6 @@ static inline int cm_t3517_init_usbh(void)
>  #endif
>  
>  #if defined(CONFIG_MTD_NAND_OMAP2) || defined(CONFIG_MTD_NAND_OMAP2_MODULE)
> -#define NAND_BLOCK_SIZE		SZ_128K
> -
>  static struct mtd_partition cm_t3517_nand_partitions[] = {
>  	{
>  		.name           = "xloader",
> diff --git a/arch/arm/mach-omap2/board-devkit8000.c b/arch/arm/mach-omap2/board-devkit8000.c
> index 405542a..ddcdca8 100644
> --- a/arch/arm/mach-omap2/board-devkit8000.c
> +++ b/arch/arm/mach-omap2/board-devkit8000.c
> @@ -61,8 +61,6 @@
>  #include "timer-gp.h"
>  #include "common-board-devices.h"
>  
> -#define NAND_BLOCK_SIZE		SZ_128K
> -
>  #define OMAP_DM9000_GPIO_IRQ	25
>  #define OMAP3_DEVKIT_TS_GPIO	27
>  
> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
> index bc30ab0..039b904 100644
> --- a/arch/arm/mach-omap2/board-omap3beagle.c
> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
> @@ -54,8 +54,6 @@
>  #include "pm.h"
>  #include "common-board-devices.h"
>  
> -#define NAND_BLOCK_SIZE		SZ_128K
> -
>  /*
>   * OMAP3 Beagle revision
>   * Run time detection of Beagle revision is done by reading GPIO.
> diff --git a/arch/arm/mach-omap2/board-omap3pandora.c b/arch/arm/mach-omap2/board-omap3pandora.c
> index 6c22d3f..439920f 100644
> --- a/arch/arm/mach-omap2/board-omap3pandora.c
> +++ b/arch/arm/mach-omap2/board-omap3pandora.c
> @@ -57,8 +57,6 @@
>  #define PANDORA_WIFI_NRESET_GPIO	23
>  #define OMAP3_PANDORA_TS_GPIO		94
>  
> -#define NAND_BLOCK_SIZE			SZ_128K
> -
>  static struct mtd_partition omap3pandora_nand_partitions[] = {
>  	{
>  		.name           = "xloader",
> diff --git a/arch/arm/mach-omap2/board-omap3touchbook.c b/arch/arm/mach-omap2/board-omap3touchbook.c
> index 392278d..c655a81 100644
> --- a/arch/arm/mach-omap2/board-omap3touchbook.c
> +++ b/arch/arm/mach-omap2/board-omap3touchbook.c
> @@ -56,8 +56,6 @@
>  
>  #include <asm/setup.h>
>  
> -#define NAND_BLOCK_SIZE		SZ_128K
> -
>  #define OMAP3_AC_GPIO		136
>  #define OMAP3_TS_GPIO		162
>  #define TB_BL_PWM_TIMER		9
> diff --git a/arch/arm/mach-omap2/board-overo.c b/arch/arm/mach-omap2/board-overo.c
> index e152c13..42656a2 100644
> --- a/arch/arm/mach-omap2/board-overo.c
> +++ b/arch/arm/mach-omap2/board-overo.c
> @@ -65,8 +65,6 @@
>  #define OVERO_GPIO_USBH_CPEN	168
>  #define OVERO_GPIO_USBH_NRESET	183
>  
> -#define NAND_BLOCK_SIZE SZ_128K
> -
>  #define OVERO_SMSC911X_CS      5
>  #define OVERO_SMSC911X_GPIO    176
>  #define OVERO_SMSC911X2_CS     4
> diff --git a/arch/arm/mach-omap2/common-board-devices.h b/arch/arm/mach-omap2/common-board-devices.h
> index eb80b3b..5a3c414 100644
> --- a/arch/arm/mach-omap2/common-board-devices.h
> +++ b/arch/arm/mach-omap2/common-board-devices.h
> @@ -30,6 +30,9 @@ struct ads7846_platform_data;
>  
>  void omap_ads7846_init(int bus_num, int gpio_pendown, int gpio_debounce,
>  		       struct ads7846_platform_data *board_pdata);
> +
> +#define NAND_BLOCK_SIZE		SZ_128K
> +
>  void omap_nand_flash_init(int opts, struct mtd_partition *parts, int n_parts);
>  
>  #endif /* __OMAP_COMMON_BOARD_DEVICES__ */

-- 
Regards,
Igor.
