From: Igor Grinberg <grinberg@compulab.co.il>
Subject: Re: [PATCH V2 2/2] mcx: support for HTKW mcx board
Date: Thu, 15 Dec 2011 12:40:49 +0200
Message-ID: <4EE9CEB1.3050003@compulab.co.il>
References: <1323910383-1184-1-git-send-email-yanok@emcraft.com> <1323910383-1184-3-git-send-email-yanok@emcraft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 50.23.254.54-static.reverse.softlayer.com ([50.23.254.54]:36409
	"EHLO softlayer.compulab.co.il" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753694Ab1LOKlA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 15 Dec 2011 05:41:00 -0500
In-Reply-To: <1323910383-1184-3-git-send-email-yanok@emcraft.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ilya Yanok <yanok@emcraft.com>
Cc: linux-omap@vger.kernel.org, sasha_d@emcraft.com

Hi Ilya,

On 12/15/11 02:53, Ilya Yanok wrote:
> Support for the HTKW mcx board (TI AM3517 based) including serial,
> Ethernet, I2C, USB host, HSMMC, DSS and RTC.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> 
> ---
> Requires updated mach-types file and previously posted AM35xx-EMAC
> patch: http://article.gmane.org/gmane.linux.ports.arm.omap/66861
> 
> Changes from V1:
>  - Kconfig option name fixed
>  - Makefile entry sanitized
>  - Unneeded headers removed
>  - EMAC initialization moved to separate file/patch
>  - Use gpio_{request,free}_{array,one} where possible
>  - don't use platform data for touchscreen, we only need to pass
>    irq number, do it via client.irq
>  - check mcx_ts_init return value
>  - Moved DEBUG_LL_OMAP3 entry to be in aplhabetical order
>  - check return value of gpio_request for USB pwr pin
>  - use pr_err instead of printk for error printing
>  - added a fixed regulator for vdds_dsi
>  - added SDcard card-detect pin
> 
>  arch/arm/mach-omap2/Kconfig                  |    6 +
>  arch/arm/mach-omap2/Makefile                 |    1 +
>  arch/arm/mach-omap2/board-mcx.c              |  495 ++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/uncompress.h |    1 +
>  4 files changed, 503 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/mach-omap2/board-mcx.c

[...]

> diff --git a/arch/arm/mach-omap2/board-mcx.c b/arch/arm/mach-omap2/board-mcx.c
> new file mode 100644
> index 0000000..6375fa1
> --- /dev/null
> +++ b/arch/arm/mach-omap2/board-mcx.c

[...]

> +static void __init mcx_display_init(void)
> +{
> +	int r;
> +
> +	r = gpio_request_array(mcx_dss_gpios, ARRAY_SIZE(mcx_dss_gpios));
> +	if (r) {
> +		pr_err("failed to get DSS control GPIOs\n");
> +		return;
> +	}
> +
> +	omap_mux_init_gpio(LCD_BKLIGHT_EN, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(LCD_LVL_SFHT_BUF_ENn, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(LCD_PWR_ENn, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(HDMI_TRCVR_PDn, OMAP_PIN_OUTPUT);

Shouldn't you mux the pins, before you access the GPIO
(e.g. before the gpio_request_array()).
Are there any safety problems?

> +
> +	r = omap_display_init(&mcx_dss_data);
> +	if (r) {
> +		pr_err("Failed to register DSS device\n");
> +		gpio_free_array(mcx_dss_gpios, ARRAY_SIZE(mcx_dss_gpios));
> +	}
> +}

[...]

> +#define TOUCH_INT_GPIO	170
> +
> +static int __init mcx_ts_init(void)
> +{
> +	struct i2c_board_info mcx_edt_ts[] = {
> +		{
> +			I2C_BOARD_INFO("edt_ts", 0x38),
> +			.irq = gpio_to_irq(TOUCH_INT_GPIO),
> +		},
> +	};
> +	int err;
> +
> +	err = gpio_request_one(TOUCH_INT_GPIO, GPIOF_IN, "TOUCH_INT");
> +	if (err < 0) {
> +		pr_err("failed to get TOUCH_INT gpio\n");
> +		return -ENODEV;
> +	}
> +	omap_mux_init_gpio(TOUCH_INT_GPIO, OMAP_PIN_INPUT);

Same here...

> +
> +	return i2c_register_board_info(3, mcx_edt_ts, 1);
> +}

[...]

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
> +#define SD_CARD_CD		61
> +#define SD_CARD_WP		65
> +
> +static struct omap2_hsmmc_info mmc[] = {
> +	{
> +		.mmc		= 1,
> +		.caps		= MMC_CAP_4_BIT_DATA,
> +		.gpio_cd        = SD_CARD_CD,
> +		.gpio_wp        = SD_CARD_WP,
> +		.ocr_mask	= MMC_VDD_32_33 | MMC_VDD_33_34 |
> +					MMC_VDD_165_195,

The ocr_mask will be overridden, by the following patch:
-----------------
commit e89715a7e48d505f42813a4e3ee0f0efb49832ba
Author: Abhilash K V <abhilash.kv@ti.com>
Date:   Fri Dec 9 12:27:36 2011 -0800

    ARM: OMAP: hsmmc: Support for AM3517 MMC1 voltages
--------------

in Tony's hsmmc branch.

IMO it should be fixed, by adding a check if the ocr_mask is
already set...
I can't send a patch for this right now...

[...]

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

Hmm... pullup for output? Is this needed for kind of safety?

[...]

> +static void __init mcx_init(void)
> +{
> +	int err;
> +
> +	omap3_mux_init(board_mux, OMAP_PACKAGE_CBB);
> +	mcx_i2c_init();
> +	platform_add_devices(mcx_devices, ARRAY_SIZE(mcx_devices));
> +	omap_serial_init();

Shouldn't this one be before the mcx_i2c_init() call?

> +
> +	mcx_display_init();
> +
> +	/* Configure EHCI ports */
> +	err = gpio_request_one(USB_HOST_PWR_EN, GPIOF_OUT_INIT_HIGH,
> +			"USB_HOST_PWR_EN");
> +	if (err)
> +		pr_warn("Failed to request USB host power enable GPIO\n");

empty line here will improve the readability.

> +	omap_mux_init_gpio(USB_HOST_PWR_EN, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(USB_PHY1_RESET, OMAP_PIN_OUTPUT);
> +	omap_mux_init_gpio(USB_PHY2_RESET, OMAP_PIN_OUTPUT);

once again mux after gpio_request?

> +	usbhs_init(&usbhs_bdata);
> +	omap_nand_flash_init(NAND_BUSWIDTH_16, mcx_nand_partitions,
> +			     ARRAY_SIZE(mcx_nand_partitions));
> +	/* Ethernet */
> +	am35xx_ethernet_init(MCX_MDIO_FREQUENCY, 1);
> +
> +	/* MMC init */
> +	omap_mux_init_gpio(SD_CARD_WP, OMAP_PIN_INPUT);
> +	omap_mux_init_gpio(SD_CARD_CD, OMAP_PIN_INPUT);
> +	omap2_hsmmc_init(mmc);
> +}

[...]


-- 
Regards,
Igor.
