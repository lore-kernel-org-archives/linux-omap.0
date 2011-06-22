From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH v3 3/3] arm: omap3: cm-t35: add support for cm-t3730
Date: Wed, 22 Jun 2011 17:56:18 +0300
Message-ID: <4E020292.4090002@compulab.co.il>
References: <20110614073648.GI3352@atomide.com> <1308086174-3080-3-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:37996
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757949Ab1FVO4V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 22 Jun 2011 10:56:21 -0400
In-Reply-To: <1308086174-3080-3-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mike Rapoport <mike@compulab.co.il>

Tony,

Does this one look better?



On 06/15/11 00:16, Igor Grinberg wrote:

> cm-t3730 is basically the same board as cm-t35,
> but has AM/DM3730 SoC assembled and therefore some changes are required.
>
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> Acked-by: Mike Rapoport <mike@compulab.co.il>
> ---
> v3:	fix MACH_* selection
> 	remove completely the use of cpu_is_*
> v2:	Add debug uart entry
>
>
>  arch/arm/mach-omap2/Kconfig                  |    6 ++-
>  arch/arm/mach-omap2/board-cm-t35.c           |   77 ++++++++++++++++++++-----
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  3 files changed, 67 insertions(+), 17 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index 19d5891..4ae6257 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -266,9 +266,10 @@ config MACH_OMAP_ZOOM3
>  	select REGULATOR_FIXED_VOLTAGE
>  
>  config MACH_CM_T35
> -	bool "CompuLab CM-T35 module"
> +	bool "CompuLab CM-T35/CM-T3730 modules"
>  	depends on ARCH_OMAP3
>  	default y
> +	select MACH_CM_T3730
>  	select OMAP_PACKAGE_CUS
>  
>  config MACH_CM_T3517
> @@ -277,6 +278,9 @@ config MACH_CM_T3517
>  	default y
>  	select OMAP_PACKAGE_CBB
>  
> +config MACH_CM_T3730
> +       bool
> +
>  config MACH_IGEP0020
>  	bool "IGEP v2 board"
>  	depends on ARCH_OMAP3
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 256b81c..ea31281 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -1,5 +1,5 @@
>  /*
> - * board-cm-t35.c (CompuLab CM-T35 module)
> + * CompuLab CM-T35/CM-T3730 modules support
>   *
>   * Copyright (C) 2009-2011 CompuLab, Ltd.
>   * Authors: Mike Rapoport <mike@compulab.co.il>
> @@ -574,17 +574,11 @@ static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
>  
> -	/* DSS */
> +	/* common DSS */
>  	OMAP3_MUX(DSS_PCLK, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_HSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_VSYNC, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_ACBIAS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA0, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA1, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA2, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA3, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA4, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA5, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> @@ -597,12 +591,6 @@ static struct omap_board_mux board_mux[] __initdata = {
>  	OMAP3_MUX(DSS_DATA15, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA16, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA17, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA18, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA19, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA20, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA21, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA22, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> -	OMAP3_MUX(DSS_DATA23, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  
>  	/* display controls */
>  	OMAP3_MUX(MCBSP1_FSR, OMAP_MUX_MODE4 | OMAP_PIN_OUTPUT),
> @@ -615,19 +603,53 @@ static struct omap_board_mux board_mux[] __initdata = {
>  
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
> +
> +static void __init cm_t3x_common_dss_mux_init(int mux_mode)
> +{
> +	omap_mux_init_signal("dss_data18", mux_mode);
> +	omap_mux_init_signal("dss_data19", mux_mode);
> +	omap_mux_init_signal("dss_data20", mux_mode);
> +	omap_mux_init_signal("dss_data21", mux_mode);
> +	omap_mux_init_signal("dss_data22", mux_mode);
> +	omap_mux_init_signal("dss_data23", mux_mode);
> +}
> +
> +static void __init cm_t35_init_mux(void)
> +{
> +	omap_mux_init_signal("gpio_70", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("gpio_71", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("gpio_72", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("gpio_73", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("gpio_74", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("gpio_75", OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +	cm_t3x_common_dss_mux_init(OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT);
> +}
> +
> +static void __init cm_t3730_init_mux(void)
> +{
> +	omap_mux_init_signal("sys_boot0", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sys_boot1", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sys_boot3", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sys_boot4", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sys_boot5", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	omap_mux_init_signal("sys_boot6", OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +	cm_t3x_common_dss_mux_init(OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT);
> +}
> +#else
> +static inline void cm_t35_init_mux(void) {}
> +static inline void cm_t3730_init_mux(void) {}
>  #endif
>  
>  static struct omap_board_config_kernel cm_t35_config[] __initdata = {
>  };
>  
> -static void __init cm_t35_init(void)
> +static void __init cm_t3x_common_init(void)
>  {
>  	omap_board_config = cm_t35_config;
>  	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
>  	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
>  	omap_serial_init();
>  	cm_t35_init_i2c();
> -	cm_t35_init_nand();
>  	omap_ads7846_init(1, CM_T35_GPIO_PENDOWN, 0, NULL);
>  	cm_t35_init_ethernet();
>  	cm_t35_init_led();
> @@ -637,6 +659,19 @@ static void __init cm_t35_init(void)
>  	usbhs_init(&usbhs_bdata);
>  }
>  
> +static void __init cm_t35_init(void)
> +{
> +	cm_t3x_common_init();
> +	cm_t35_init_mux();
> +	cm_t35_init_nand();
> +}
> +
> +static void __init cm_t3730_init(void)
> +{
> +	cm_t3x_common_init();
> +	cm_t3730_init_mux();
> +}
> +
>  MACHINE_START(CM_T35, "Compulab CM-T35")
>  	.boot_params	= 0x80000100,
>  	.reserve	= omap_reserve,
> @@ -646,3 +681,13 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
>  	.init_machine	= cm_t35_init,
>  	.timer		= &omap_timer,
>  MACHINE_END
> +
> +MACHINE_START(CM_T3730, "Compulab CM-T3730")
> +	.boot_params    = 0x80000100,
> +	.reserve        = omap_reserve,
> +	.map_io         = omap3_map_io,
> +	.init_early     = cm_t35_init_early,
> +	.init_irq       = omap_init_irq,
> +	.init_machine   = cm_t3730_init,
> +	.timer          = &omap_timer,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h b/arch/arm/plat-omap/include/plat/uncompress.h
> index ac4b60d..a067484 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -148,6 +148,7 @@ static inline void __arch_decomp_setup(unsigned long arch_id)
>  		/* omap3 based boards using UART3 */
>  		DEBUG_LL_OMAP3(3, cm_t35);
>  		DEBUG_LL_OMAP3(3, cm_t3517);
> +		DEBUG_LL_OMAP3(3, cm_t3730);
>  		DEBUG_LL_OMAP3(3, craneboard);
>  		DEBUG_LL_OMAP3(3, devkit8000);
>  		DEBUG_LL_OMAP3(3, igep0020);

-- 
Regards,
Igor.

