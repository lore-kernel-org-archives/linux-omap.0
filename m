From: "Hiremath, Vaibhav" <hvaibhav@ti.com>
Subject: RE: [PATCH 11/11] AM3517: Add mmc platform data for am3517evm
Date: Tue, 13 Apr 2010 21:48:21 +0530
Message-ID: <19F8576C6E063C45BE387C64729E7394044E0541FE@dbde02.ent.ti.com>
References: <1271151118-12999-1-git-send-email-stanley.miao@windriver.com>
 <1271151270-13038-3-git-send-email-stanley.miao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42886 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751518Ab0DMQSh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Apr 2010 12:18:37 -0400
In-Reply-To: <1271151270-13038-3-git-send-email-stanley.miao@windriver.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Stanley.Miao" <stanley.miao@windriver.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "tony@atomide.com" <tony@atomide.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Stanley.Miao
> Sent: Tuesday, April 13, 2010 3:05 PM
> To: linux-omap@vger.kernel.org
> Cc: tony@atomide.com; Chikkature Rajashekar, Madhusudhan
> Subject: [PATCH 11/11] AM3517: Add mmc platform data for am3517evm
> 
> Add mmc platform data. Besides, the mmc slot on UI board has a pin conflict
> with LCD, so add macros to resolve it.
> 
[Hiremath, Vaibhav] I am not sure whether your statement is right here. As far I know he conflicts is between UI card USB and Base-board LCD panel.

There is no conflict between MMC2 (which is on UI card) with LCD interface. I may be wrong here, can you please point me to the docs/schematics where you got this info.

Thanks,
Vaibhav

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
