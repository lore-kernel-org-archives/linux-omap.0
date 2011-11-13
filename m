From: "Pankaj Kumar" <pakuma@codeaurora.org>
Subject: Re: [PATCH 4/4] mcx: initial support for HTKW mcx board
Date: Sun, 13 Nov 2011 09:56:35 -0800 (PST)
Message-ID: <915c35bcf36fca4cbfbfa637029cae40.squirrel@www.codeaurora.org>
References: <1320797568-11169-1-git-send-email-yanok@emcraft.com>
    <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:40292 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1KMR4f (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 13 Nov 2011 12:56:35 -0500
In-Reply-To: <1320797568-11169-5-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: linux-omap@vger.kernel.org, wd@denx.de, dzu@denx.de, sasha_d@emcraft.com, Ilya Yanok <yanok@emcraft.com>

Hi IIya,

> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.
>
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>

> +static struct omap_dss_board_info mcx_dss_data = {
> +	.num_devices	= ARRAY_SIZE(mcx_dss_devices),
> +	.devices	= mcx_dss_devices,
> +	.default_device	= &mcx_lcd_device,
> +};
> +
> +static void __init mcx_display_init(void)
> +{
> +	int r;
> +
> +	/* disable LCD backlight */
> +	r = gpio_request(LCD_BKLIGHT_EN, "LCD_BKLIGHT_EN");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_BKLIGHT_EN gpio\n");
You should use pr_err macro for error conditions to print, instead of printk.
> +		goto err_1;
> +	}
> +	omap_mux_init_gpio(LCD_BKLIGHT_EN, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(LCD_BKLIGHT_EN, 0);
> +
> +	/* Enable VIO-> 3.3v level shifter */
> +	r = gpio_request(LCD_LVL_SFHT_BUF_ENn, "LCD_LVL_SFHT_BUF_ENn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_LVL_SFHT_BUF_ENn gpio\n");

Same here. Deprecate the use of printk for error printing.
> +		goto err_2;
> +	}
> +	omap_mux_init_gpio(LCD_LVL_SFHT_BUF_ENn, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(LCD_LVL_SFHT_BUF_ENn, 0);
> +
> +	/* Enable LCD panel VCC */
> +
> +	r = gpio_request(LCD_PWR_ENn, "LCD_PWR_ENn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get LCD_PWR_ENn\n");
Same Here.
> +		goto err_3;
> +	}
> +	omap_mux_init_gpio(LCD_PWR_ENn, OMAP_PIN_OUTPUT);
> +
> +	gpio_direction_output(LCD_PWR_ENn, 0);
> +
> +	/* Disable HDMI transceiver */
> +	r = gpio_request(HDMI_TRCVR_PDn, "HDMI_TRCVR_PDn");
> +	if (r) {
> +		printk(KERN_ERR "failed to get HDMI_TRCVR_PDn\n");
Same Here.
> +		goto err_4;
> +	}
> +	omap_mux_init_gpio(HDMI_TRCVR_PDn, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(HDMI_TRCVR_PDn, 0);
> +
> +	omap_display_init(&mcx_dss_data);
> +
> +	return;
> +
> +err_4:
> +	gpio_free(HDMI_TRCVR_PDn);
> +err_3:
> +	gpio_free(LCD_LVL_SFHT_BUF_ENn);
> +err_2:
> +	gpio_free(LCD_LVL_SFHT_BUF_ENn);
> +err_1:
> +	gpio_free(LCD_BKLIGHT_EN);
> +}
> +
> +/* TPS65023 specific initialization */
> +/* VDCDC1 -> VDD_CORE */
> +static struct regulator_consumer_supply am3517_vdcdc1_supplies[] = {
> +	{
> +		.supply = "vdd_core",
> +	},
> +};
> +
> +/* VDCDC2 -> VDDSHV */
> +static struct regulator_consumer_supply am3517_vdcdc2_supplies[] = {
> +	{
> +		.supply = "vddshv",
> +	},
> +};
> +
> +/*
> + * VDCDC2 |-> VDDS
> + *	  |-> VDDS_SRAM_CORE_BG
> + *	  |-> VDDS_SRAM_MPU
> + */
> +static struct regulator_consumer_supply am3517_vdcdc3_supplies[] = {
> +	{
> +		.supply = "vdds",
> +	},
> +	{
> +		.supply = "vdds_sram_core_bg",
> +	},
> +	{
> +		.supply = "vdds_sram_mpu",
> +	},
> +};
> +
> +/*
> + * LDO1 |-> VDDA1P8V_USBPHY
> + *	|-> VDDA_DAC
> + */
> +static struct regulator_consumer_supply am3517_ldo1_supplies[] = {
> +	{
> +		.supply = "vdda1p8v_usbphy",
> +	},
> +	{
> +		.supply = "vdda_dac",
> +	},
> +};
> +
> +/* LDO2 -> VDDA3P3V_USBPHY */
> +static struct regulator_consumer_supply am3517_ldo2_supplies[] = {
> +	{
> +		.supply = "vdda3p3v_usbphy",
> +	},
> +};
> +
> +static struct regulator_init_data mcx_regulator_data[] = {
> +	/* DCDC1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1200000,
> +			.max_uV = 1200000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc1_supplies),
> +		.consumer_supplies = am3517_vdcdc1_supplies,
> +	},
> +	/* DCDC2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc2_supplies),
> +		.consumer_supplies = am3517_vdcdc2_supplies,
> +	},
> +	/* DCDC3 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = true,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_vdcdc3_supplies),
> +		.consumer_supplies = am3517_vdcdc3_supplies,
> +	},
> +	/* LDO1 */
> +	{
> +		.constraints = {
> +			.min_uV = 1800000,
> +			.max_uV = 1800000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo1_supplies),
> +		.consumer_supplies = am3517_ldo1_supplies,
> +	},
> +	/* LDO2 */
> +	{
> +		.constraints = {
> +			.min_uV = 3300000,
> +			.max_uV = 3300000,
> +			.valid_modes_mask = REGULATOR_MODE_NORMAL,
> +			.valid_ops_mask = REGULATOR_CHANGE_STATUS,
> +			.always_on = false,
> +			.apply_uV = false,
> +		},
> +		.num_consumer_supplies = ARRAY_SIZE(am3517_ldo2_supplies),
> +		.consumer_supplies = am3517_ldo2_supplies,
> +	},
> +};
> +
> +static struct i2c_board_info __initdata mcx_i2c1_devices[] = {
> +	{
> +		I2C_BOARD_INFO("ds1337", 0x68),
> +	},
> +	{
> +		I2C_BOARD_INFO("tps65023", 0x48),
> +		.flags = I2C_CLIENT_WAKE,
> +		.platform_data = &mcx_regulator_data[0],
> +	},
> +};
> +
> +#define TOUCH_INT_GPIO	170
> +
> +static struct edt_platform_data edt_ts_data = {
> +	.irq_gpio = TOUCH_INT_GPIO,
> +};
> +
> +static int __init mcx_ts_init(void)
> +{
> +	struct i2c_board_info mcx_edt_ts[] = {
> +		{
> +			I2C_BOARD_INFO("edt_ts", 0x38),
> +			.platform_data = &edt_ts_data,
> +		},
> +	};
> +
> +	if (gpio_request(TOUCH_INT_GPIO, "TOUCH_INT")) {
> +		printk(KERN_ERR "failed to get TOUCH_INT gpio\n");
Please use pr_err instead of printk.
> +		return 1;
> +	}
> +
> +	gpio_direction_input(TOUCH_INT_GPIO);
> +
> +	i2c_register_board_info(3, mcx_edt_ts, 1);
> +
> +	return 0;
> +}
> +
> +static int __init mcx_i2c_init(void)
> +{
> +	omap_register_i2c_bus(1, 400, mcx_i2c1_devices,
> +			ARRAY_SIZE(mcx_i2c1_devices));
> +	omap_register_i2c_bus(2, 400, NULL, 0);
> +	omap_register_i2c_bus(3, 400, NULL, 0);
> +	mcx_ts_init();
> +	return 0;
> +}
> +
> +#define USB_HOST_PWR_EN		132
> +#define USB_PHY1_RESET		154
> +#define USB_PHY2_RESET		152
> +
> +static const struct usbhs_omap_board_data usbhs_bdata __initconst = {
> +
> +	.port_mode[0] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[1] = OMAP_EHCI_PORT_MODE_PHY,
> +	.port_mode[2] = OMAP_USBHS_PORT_MODE_UNUSED,
> +
> +	.phy_reset  = true,
> +	.reset_gpio_port[0]  = USB_PHY1_RESET,
> +	.reset_gpio_port[1]  = USB_PHY2_RESET,
> +	.reset_gpio_port[2]  = -EINVAL
> +};
> +
> +#define SD_CARD_WP		65
> +
> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +		.mmc		= 1,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd        = -EINVAL,
> +		.gpio_wp        = SD_CARD_WP,
> +		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
> +					MMC_VDD_165_195,
> +	},
> +	{}      /* Terminator */
> +};
> +
> +#ifdef CONFIG_OMAP_MUX
> +static struct omap_board_mux board_mux[] __initdata = {
> +	OMAP3_MUX(CHASSIS_DMAREQ3, OMAP_MUX_MODE0 | OMAP_PIN_INPUT_PULLDOWN),
> +	OMAP3_MUX(UART1_TX, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
> +			OMAP_PULL_ENA | OMAP_PULL_UP),
> +	OMAP3_MUX(UART1_RX, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(UART1_RTS, OMAP_MUX_MODE0 | OMAP_PIN_INPUT),
> +	OMAP3_MUX(UART1_CTS, OMAP_MUX_MODE0 | OMAP_PIN_OUTPUT |
> +			OMAP_PULL_ENA | OMAP_PULL_UP),
> +	{ .reg_offset = OMAP_MUX_TERMINATOR },
> +};
> +#endif
> +
> +static void __init mcx_init(void)
> +{
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	mcx_i2c_init();
> +	omap_serial_init();
> +
> +	mcx_display_init();
> +
> +	/* Configure EHCI ports */
> +	gpio_request(USB_HOST_PWR_EN, "USB_HOST_PWR_EN");
No error checking for gpio_request?
> +	omap_mux_init_gpio(USB_HOST_PWR_EN, OMAP_PIN_OUTPUT);
> +	gpio_direction_output(USB_HOST_PWR_EN, 1);
> +
> +	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(USB_PHY2_RESET, OMAP_PIN_OUTPUT);
> +	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, mcx_nand_partitions,
> +			     ARRAY_SIZE(mcx_nand_partitions));
> +	/*Ethernet*/
> +	mcx_ethernet_init(&mcx_emac_pdata);
> +
> +	/* MMC init */
> +	omap_mux_init_gpio(SD_CARD_WP, OMAP_PIN_INPUT);
> +	omap2_hsmmc_init(mmc);
> +}
> +
> +static const char *mcx_dt_match[] __initdata = {
> +	"htkw,mcx",
> +	NULL
> +};
> +
> +MACHINE_START(MCX, "htkw mcx")
> +	/* Maintainer: Ilya Yanok */
> +	.atag_offset	= 0x100,
> +	.reserve	= omap_reserve,
> +	.map_io		= omap3_map_io,
> +	.init_early	= am35xx_init_early,
> +	.init_irq	= omap3_init_irq,
> +	.init_machine	= mcx_init,
> +	.timer		= &omap3_timer,
> +	.dt_compat	= mcx_dt_match,
> +MACHINE_END
> diff --git a/arch/arm/plat-omap/include/plat/uncompress.h
> b/arch/arm/plat-omap/include/plat/uncompress.h
> index 2d45ea3..5a1bb62 100644
> --- a/arch/arm/plat-omap/include/plat/uncompress.h
> +++ b/arch/arm/plat-omap/include/plat/uncompress.h
> @@ -168,6 +168,7 @@ static inline void __arch_decomp_setup(unsigned long
> arch_id)
>  		DEBUG_LL_OMAP3(3, omap_ldp);
>  		DEBUG_LL_OMAP3(3, overo);
>  		DEBUG_LL_OMAP3(3, touchbook);
> +		DEBUG_LL_OMAP3(3, mcx);
>
>  		/* omap4 based boards using UART3 */
>  		DEBUG_LL_OMAP4(3, omap_4430sdp);
> --
> 1.7.6.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Thanks,
Pankaj
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.


