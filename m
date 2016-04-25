From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: Re: [PATCH 4/4] ARM: remove duplicate const qualifier
Date: Mon, 25 Apr 2016 11:57:15 +0200
Message-ID: <20160425095715.GA2366@piout.net>
References: <1461577678-29517-1-git-send-email-eric.engestrom@imgtec.com>
 <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1461577678-29517-4-git-send-email-eric.engestrom@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Engestrom <eric.engestrom@imgtec.com>
Cc: linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Russell King <linux@arm.linux.org.uk>, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, Alexander Shiyan <shc_work@mail.ru>, Krzysztof Halasa <khalasa@piap.pl>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, Roland Stigge <stigge@antcom.de>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Rajendra Nayak <rnayak@ti.com>, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>, Viresh Kumar <vireshk@kernel.org>, Shiraz Hashim <shiraz.linux.kernel@gmail.com>, Gregory Fong <gregory.0xf0@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Lee Jones <lee.jones@linaro.org>, Linus
List-Id: linux-omap@vger.kernel.org

Hi,

this requires a commit message.

Also, you should think about separating those changes in multiple patches
to ease inclusion in the kernel.

On 25/04/2016 at 10:47:57 +0100, Eric Engestrom wrote :
> Signed-off-by: Eric Engestrom <eric.engestrom@imgtec.com>
> ---
>  arch/arm/mach-at91/pm.c                 | 2 +-
>  arch/arm/mach-bcm/bcm_kona_smc.c        | 2 +-
>  arch/arm/mach-clps711x/board-autcpu12.c | 2 +-
>  arch/arm/mach-cns3xxx/core.c            | 2 +-
>  arch/arm/mach-davinci/da8xx-dt.c        | 2 +-
>  arch/arm/mach-lpc32xx/phy3250.c         | 2 +-
>  arch/arm/mach-mxs/mach-mxs.c            | 2 +-
>  arch/arm/mach-omap2/prm_common.c        | 2 +-
>  arch/arm/mach-omap2/vc.c                | 2 +-
>  arch/arm/mach-spear/time.c              | 2 +-
>  10 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/pm.c b/arch/arm/mach-at91/pm.c
> index f062701..9ef8604 100644
> --- a/arch/arm/mach-at91/pm.c
> +++ b/arch/arm/mach-at91/pm.c
> @@ -318,7 +318,7 @@ static void at91sam9_sdram_standby(void)
>  		at91_ramc_write(1, AT91_SDRAMC_LPR, saved_lpr1);
>  }
>  
> -static const struct of_device_id const ramc_ids[] __initconst = {
> +static const struct of_device_id ramc_ids[] __initconst = {
>  	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
>  	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
>  	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
> diff --git a/arch/arm/mach-bcm/bcm_kona_smc.c b/arch/arm/mach-bcm/bcm_kona_smc.c
> index cf3f865..a55a7ec 100644
> --- a/arch/arm/mach-bcm/bcm_kona_smc.c
> +++ b/arch/arm/mach-bcm/bcm_kona_smc.c
> @@ -33,7 +33,7 @@ struct bcm_kona_smc_data {
>  	unsigned result;
>  };
>  
> -static const struct of_device_id const bcm_kona_smc_ids[] __initconst = {
> +static const struct of_device_id bcm_kona_smc_ids[] __initconst = {
>  	{.compatible = "brcm,kona-smc"},
>  	{.compatible = "bcm,kona-smc"}, /* deprecated name */
>  	{},
> diff --git a/arch/arm/mach-clps711x/board-autcpu12.c b/arch/arm/mach-clps711x/board-autcpu12.c
> index ba3d7d1..4fdfd92 100644
> --- a/arch/arm/mach-clps711x/board-autcpu12.c
> +++ b/arch/arm/mach-clps711x/board-autcpu12.c
> @@ -160,7 +160,7 @@ static struct platform_device autcpu12_mmgpio_pdev __initdata = {
>  	},
>  };
>  
> -static const struct gpio const autcpu12_gpios[] __initconst = {
> +static const struct gpio autcpu12_gpios[] __initconst = {
>  	{ AUTCPU12_DPOT_CS,	GPIOF_OUT_INIT_HIGH,	"DPOT CS" },
>  	{ AUTCPU12_DPOT_CLK,	GPIOF_OUT_INIT_LOW,	"DPOT CLK" },
>  	{ AUTCPU12_DPOT_UD,	GPIOF_OUT_INIT_LOW,	"DPOT UD" },
> diff --git a/arch/arm/mach-cns3xxx/core.c b/arch/arm/mach-cns3xxx/core.c
> index 9b1dc22..e17a0e02 100644
> --- a/arch/arm/mach-cns3xxx/core.c
> +++ b/arch/arm/mach-cns3xxx/core.c
> @@ -346,7 +346,7 @@ static struct usb_ohci_pdata cns3xxx_usb_ohci_pdata = {
>  	.power_off	= csn3xxx_usb_power_off,
>  };
>  
> -static const struct of_dev_auxdata const cns3xxx_auxdata[] __initconst = {
> +static const struct of_dev_auxdata cns3xxx_auxdata[] __initconst = {
>  	{ "intel,usb-ehci", CNS3XXX_USB_BASE, "ehci-platform", &cns3xxx_usb_ehci_pdata },
>  	{ "intel,usb-ohci", CNS3XXX_USB_OHCI_BASE, "ohci-platform", &cns3xxx_usb_ohci_pdata },
>  	{ "cavium,cns3420-ahci", CNS3XXX_SATA2_BASE, "ahci", NULL },
> diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
> index c4b5808..3d92c93 100644
> --- a/arch/arm/mach-davinci/da8xx-dt.c
> +++ b/arch/arm/mach-davinci/da8xx-dt.c
> @@ -20,7 +20,7 @@
>  
>  #define DA8XX_NUM_UARTS	3
>  
> -static const struct of_device_id const da8xx_irq_match[] __initconst = {
> +static const struct of_device_id da8xx_irq_match[] __initconst = {
>  	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
>  	{ }
>  };
> diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
> index b2f9e22..1ae7230 100644
> --- a/arch/arm/mach-lpc32xx/phy3250.c
> +++ b/arch/arm/mach-lpc32xx/phy3250.c
> @@ -159,7 +159,7 @@ static struct lpc32xx_mlc_platform_data lpc32xx_mlc_data = {
>  	.dma_filter = pl08x_filter_id,
>  };
>  
> -static const struct of_dev_auxdata const lpc32xx_auxdata_lookup[] __initconst = {
> +static const struct of_dev_auxdata lpc32xx_auxdata_lookup[] __initconst = {
>  	OF_DEV_AUXDATA("arm,pl022", 0x20084000, "dev:ssp0", NULL),
>  	OF_DEV_AUXDATA("arm,pl022", 0x2008C000, "dev:ssp1", NULL),
>  	OF_DEV_AUXDATA("arm,pl110", 0x31040000, "dev:clcd", &lpc32xx_clcd_data),
> diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
> index f1ea470..19eeaec 100644
> --- a/arch/arm/mach-mxs/mach-mxs.c
> +++ b/arch/arm/mach-mxs/mach-mxs.c
> @@ -282,7 +282,7 @@ static void __init apx4devkit_init(void)
>  #define TX28_FEC_PHY_RESET	MXS_GPIO_NR(4, 13)
>  #define TX28_FEC_nINT		MXS_GPIO_NR(4, 5)
>  
> -static const struct gpio const tx28_gpios[] __initconst = {
> +static const struct gpio tx28_gpios[] __initconst = {
>  	{ ENET0_MDC__GPIO_4_0, GPIOF_OUT_INIT_LOW, "GPIO_4_0" },
>  	{ ENET0_MDIO__GPIO_4_1, GPIOF_OUT_INIT_LOW, "GPIO_4_1" },
>  	{ ENET0_RX_EN__GPIO_4_2, GPIOF_OUT_INIT_LOW, "GPIO_4_2" },
> diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
> index 5b2f513..f1ca947 100644
> --- a/arch/arm/mach-omap2/prm_common.c
> +++ b/arch/arm/mach-omap2/prm_common.c
> @@ -713,7 +713,7 @@ static struct omap_prcm_init_data scrm_data __initdata = {
>  };
>  #endif
>  
> -static const struct of_device_id const omap_prcm_dt_match_table[] __initconst = {
> +static const struct of_device_id omap_prcm_dt_match_table[] __initconst = {
>  #ifdef CONFIG_SOC_AM33XX
>  	{ .compatible = "ti,am3-prcm", .data = &am3_prm_data },
>  #endif
> diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
> index 2028167f..d76b1e5 100644
> --- a/arch/arm/mach-omap2/vc.c
> +++ b/arch/arm/mach-omap2/vc.c
> @@ -559,7 +559,7 @@ struct i2c_init_data {
>  	u8 hsscll_12;
>  };
>  
> -static const struct i2c_init_data const omap4_i2c_timing_data[] __initconst = {
> +static const struct i2c_init_data omap4_i2c_timing_data[] __initconst = {
>  	{
>  		.load = 50,
>  		.loadbits = 0x3,
> diff --git a/arch/arm/mach-spear/time.c b/arch/arm/mach-spear/time.c
> index 9ccffc1..aaaa678 100644
> --- a/arch/arm/mach-spear/time.c
> +++ b/arch/arm/mach-spear/time.c
> @@ -204,7 +204,7 @@ static void __init spear_clockevent_init(int irq)
>  	setup_irq(irq, &spear_timer_irq);
>  }
>  
> -static const struct of_device_id const timer_of_match[] __initconst = {
> +static const struct of_device_id timer_of_match[] __initconst = {
>  	{ .compatible = "st,spear-timer", },
>  	{ },
>  };
> -- 
> 2.7.4
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
