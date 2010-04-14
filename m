From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 12/12] AM3517: Add mmc platform data for am3517evm
Date: Wed, 14 Apr 2010 20:23:22 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E136BE0@dbde02.ent.ti.com>
References: <1271233822-27286-1-git-send-email-stanley.miao@windriver.com>
 <1271233972-27327-3-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58609 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755777Ab0DNOxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 14 Apr 2010 10:53:36 -0400
In-Reply-To: <1271233972-27327-3-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>


> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Wednesday, April 14, 2010 2:03 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Chikkature Rajashekar, Madhusudhan
> Subject: [PATCH 12/12] AM3517: Add mmc platform data for am3517evm
> 
> Add mmc platform data. Besides, the mmc slot on UI board has a pin conflict
> with LCD, so add macros to resolve it.
[Hiremath, Vaibhav] Can you please describe it details, and mention which pins are getting conflicted.

> 
> Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> ---
>  arch/arm/mach-omap2/Makefile          |    3 +-
>  arch/arm/mach-omap2/board-am3517evm.c |   45
> +++++++++++++++++++++++++++++++++
>  2 files changed, 47 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
> index 4b9fc57..e94afdd 100644
> --- a/arch/arm/mach-omap2/Makefile
> +++ b/arch/arm/mach-omap2/Makefile
> @@ -142,7 +142,8 @@ obj-$(CONFIG_MACH_OMAP3_TOUCHBOOK)	+= board-
> omap3touchbook.o \
>  					   hsmmc.o
>  obj-$(CONFIG_MACH_OMAP_4430SDP)		+= board-4430sdp.o
> 
> -obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o
> +obj-$(CONFIG_MACH_OMAP3517EVM)		+= board-am3517evm.o \
> +					   hsmmc.o
> 
>  # Platform specific device init code
>  obj-y					+= usb-musb.o
> diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-
> omap2/board-am3517evm.c
> index 6a82ac3..8054994 100644
> --- a/arch/arm/mach-omap2/board-am3517evm.c
> +++ b/arch/arm/mach-omap2/board-am3517evm.c
> @@ -26,6 +26,7 @@
>  #include <linux/mtd/mtd.h>
>  #include <linux/mtd/partitions.h>
>  #include <linux/mtd/nand.h>
> +#include <linux/mmc/host.h>
> 
>  #include <mach/hardware.h>
>  #include <mach/am35xx.h>
> @@ -40,7 +41,9 @@
>  #include <plat/display.h>
>  #include <plat/nand.h>
>  #include <plat/gpmc.h>
> +#include <plat/mmc.h>
> 
> +#include "hsmmc.h"
>  #include "mux.h"
> 
>  #define LCD_PANEL_PWR		176
> @@ -440,6 +443,8 @@ static int __init am3517_evm_i2c_init(void)
>  static int lcd_enabled;
>  static int dvi_enabled;
> 
> +#if defined(CONFIG_PANEL_SHARP_LQ043T1DG01) || \
> +	                defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
[Hiremath, Vaibhav] I don't think this is right approach, we are completely blocking the display here which is wrong. 

The approach should be limited to LCD panel and not whole display.

So NAK from me.

>  static void __init am3517_evm_display_init(void)
>  {
>  	int r;
> @@ -501,6 +506,20 @@ static void am3517_evm_panel_disable_lcd(struct
> omap_dss_device *dssdev)
>  	gpio_set_value(LCD_PANEL_PWR, 0);
>  	lcd_enabled = 0;
>  }
> +#else
> +static inline void __init am3517_evm_display_init(void)
> +{
> +}
> +
> +static inline int am3517_evm_panel_enable_lcd(struct omap_dss_device
> *dssdev)
> +{
> +	return 0;
> +}
> +
> +static inline void am3517_evm_panel_disable_lcd(struct omap_dss_device
> *dssdev)
> +{
> +}
> +#endif
> 
>  static struct omap_dss_device am3517_evm_lcd_device = {
>  	.type			= OMAP_DISPLAY_TYPE_DPI,
> @@ -613,6 +632,30 @@ static struct omap_board_mux board_mux[] __initdata = {
>  #define board_mux	NULL
>  #endif
> 
> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +		.mmc            = 1,
> +		.wires          = 4,
> +		.gpio_cd        = 127,
> +		.gpio_wp        = 126,
> +		.ocr_mask       = MMC_VDD_165_195 |
> +				MMC_VDD_26_27 | MMC_VDD_27_28 |
> +				MMC_VDD_29_30 |
> +				MMC_VDD_30_31 | MMC_VDD_31_32,
> +	},
> +#if !defined(CONFIG_PANEL_SHARP_LQ043T1DG01) && \
> +	                !defined(CONFIG_PANEL_SHARP_LQ043T1DG01_MODULE)
> +	{
> +		.mmc            = 2,
> +		.wires          = 4,
> +		.gpio_cd        = 175,
> +		.gpio_wp        = 176,
> +		.ocr_mask       = MMC_VDD_165_195,
> +	},
> +#endif
> +	{}      /* Terminator */
> +};
[Hiremath, Vaibhav] Can you split this patch in 2, first submit only baseboard MMC (MMC1) slot support and then work on MMC2 slot on UI card.

Thanks,
Vaibhav

> +
>  static void __init am3517_evm_init(void)
>  {
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> @@ -636,6 +679,8 @@ static void __init am3517_evm_init(void)
> 
>  	i2c_register_board_info(1, am3517evm_i2c1_boardinfo,
>  				ARRAY_SIZE(am3517evm_i2c1_boardinfo));
> +	/* MMC init function */
> +	omap2_hsmmc_init(mmc);
>  }
> 
>  static void __init am3517_evm_map_io(void)
> --
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
