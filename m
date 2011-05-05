From: Mike Rapoport <mike@compulab.co.il>
Subject: Re: [PATCH] arm: omap3: cm-t35: add support for cm-t3730
Date: Thu, 05 May 2011 12:51:19 +0300
Message-ID: <4DC27317.7020206@compulab.co.il>
References: <1304585595-10023-1-git-send-email-grinberg@compulab.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:51206
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751295Ab1EEJvX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 May 2011 05:51:23 -0400
In-Reply-To: <1304585595-10023-1-git-send-email-grinberg@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Igor Grinberg <grinberg@compulab.co.il>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/05/11 11:53, Igor Grinberg wrote:
> cm-t3730 is basically the same board as cm-t35, but has DM3730 SoC
> assembled and therefore some changes are required.
> 
> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
> ---
>  arch/arm/mach-omap2/Kconfig        |    2 +-
>  arch/arm/mach-omap2/board-cm-t35.c |   62 +++++++++++++++++++++++++++---------
>  2 files changed, 48 insertions(+), 16 deletions(-)

Acked-by: Mike Rapoport <mike@compulab.co.il>

> 
> diff --git a/arch/arm/mach-omap2/Kconfig b/arch/arm/mach-omap2/Kconfig
> index b997a35..920b6bc 100644
> --- a/arch/arm/mach-omap2/Kconfig
> +++ b/arch/arm/mach-omap2/Kconfig
> @@ -266,7 +266,7 @@ config MACH_OMAP_ZOOM3
>  	select REGULATOR_FIXED_VOLTAGE
>  
>  config MACH_CM_T35
> -	bool "CompuLab CM-T35 module"
> +	bool "CompuLab CM-T35/CM-T3730 modules"
>  	depends on ARCH_OMAP3
>  	default y
>  	select OMAP_PACKAGE_CUS
> diff --git a/arch/arm/mach-omap2/board-cm-t35.c b/arch/arm/mach-omap2/board-cm-t35.c
> index 6063be8..c0f6ce0 100644
> --- a/arch/arm/mach-omap2/board-cm-t35.c
> +++ b/arch/arm/mach-omap2/board-cm-t35.c
> @@ -524,7 +524,7 @@ static void __init cm_t35_init_early(void)
>  }
>  
>  #ifdef CONFIG_OMAP_MUX
> -static struct omap_board_mux board_mux[] __initdata = {
> +static struct omap_board_mux cm_t35_common_board_mux[] __initdata = {
>  	/* nCS and IRQ for CM-T35 ethernet */
>  	OMAP3_MUX(GPMC_NCS5, OMAP_MUX_MODE0),
>  	OMAP3_MUX(UART3_CTS_RCTX, OMAP_MUX_MODE4 | OMAP_PIN_INPUT_PULLUP),
> @@ -580,17 +580,12 @@ static struct omap_board_mux board_mux[] __initdata = {
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
> +
>  	OMAP3_MUX(DSS_DATA6, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA7, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
>  	OMAP3_MUX(DSS_DATA8, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT),
> @@ -603,12 +598,6 @@ static struct omap_board_mux board_mux[] __initdata = {
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
> @@ -621,6 +610,39 @@ static struct omap_board_mux board_mux[] __initdata = {
>  
>  	{ .reg_offset = OMAP_MUX_TERMINATOR },
>  };
> +
> +static void cm_t35_mux_init(void)
> +{
> +	int mux_mode = OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT;
> +
> +	omap3_mux_init(cm_t35_common_board_mux, OMAP_PACKAGE_CUS);
> +
> +	if (cpu_is_omap34xx()) {
> +		omap_mux_init_signal("gpio_70", mux_mode);
> +		omap_mux_init_signal("gpio_71", mux_mode);
> +		omap_mux_init_signal("gpio_72", mux_mode);
> +		omap_mux_init_signal("gpio_73", mux_mode);
> +		omap_mux_init_signal("gpio_74", mux_mode);
> +		omap_mux_init_signal("gpio_75", mux_mode);
> +	} else if (cpu_is_omap3630()) {
> +		mux_mode = OMAP_MUX_MODE3 | OMAP_PIN_OUTPUT;
> +		omap_mux_init_signal("sys_boot0", mux_mode);
> +		omap_mux_init_signal("sys_boot1", mux_mode);
> +		omap_mux_init_signal("sys_boot3", mux_mode);
> +		omap_mux_init_signal("sys_boot4", mux_mode);
> +		omap_mux_init_signal("sys_boot5", mux_mode);
> +		omap_mux_init_signal("sys_boot6", mux_mode);
> +	}
> +
> +	omap_mux_init_signal("dss_data18", mux_mode);
> +	omap_mux_init_signal("dss_data19", mux_mode);
> +	omap_mux_init_signal("dss_data20", mux_mode);
> +	omap_mux_init_signal("dss_data21", mux_mode);
> +	omap_mux_init_signal("dss_data22", mux_mode);
> +	omap_mux_init_signal("dss_data23", mux_mode);
> +}
> +#else
> +static inline void cm_t35_mux_init(void) {}
>  #endif
>  
>  static struct omap_board_config_kernel cm_t35_config[] __initdata = {
> @@ -630,7 +652,7 @@ static void __init cm_t35_init(void)
>  {
>  	omap_board_config = cm_t35_config;
>  	omap_board_config_size = ARRAY_SIZE(cm_t35_config);
> -	omap3_mux_init(board_mux, OMAP_PACKAGE_CUS);
> +	cm_t35_mux_init();
>  	omap_serial_init();
>  	cm_t35_init_i2c();
>  	cm_t35_init_nand();
> @@ -652,3 +674,13 @@ MACHINE_START(CM_T35, "Compulab CM-T35")
>  	.init_machine	= cm_t35_init,
>  	.timer		= &omap_timer,
>  MACHINE_END
> +
> +MACHINE_START(CM_T3730, "Compulab CM-T3730")
> +	.boot_params	= 0x80000100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= cm_t35_init_early,
> +	.init_irq	= omap_init_irq,
> +	.init_machine	= cm_t35_init,
> +	.timer		= &omap_timer,
> +MACHINE_END


-- 
Sincerely yours,
Mike.
