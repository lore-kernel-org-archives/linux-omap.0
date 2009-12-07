From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/3] [OMAP] Add spi100k configuration to OMAP1
Date: Mon, 7 Dec 2009 10:14:01 -0800
Message-ID: <20091207181401.GE24013@atomide.com>
References: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
 <1260161299-17656-3-git-send-email-darkstar6262@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:54445 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964932AbZLGSOB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Dec 2009 13:14:01 -0500
Content-Disposition: inline
In-Reply-To: <1260161299-17656-3-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Cory Maccarrone <darkstar6262@gmail.com>
Cc: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org

* Cory Maccarrone <darkstar6262@gmail.com> [091206 20:48]:
> This change implements the clocks, platform driver, and register
> information necessary to use the spi100k bus with OMAP 7xx systems.
> 
> The clocks added are dummy clocks because, although we're pretty
> sure there are clocks used for SPI, all current booting methods result
> in proper operation without the enabling of any other clocks.
> 
> Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
> ---
>  arch/arm/mach-omap1/clock.c               |    4 ++
>  arch/arm/mach-omap1/devices.c             |   70 +++++++++++++++++++++++++++++
>  arch/arm/plat-omap/include/plat/omap7xx.h |    3 +
>  arch/arm/plat-omap/include/plat/spi100k.h |   15 ++++++
>  4 files changed, 92 insertions(+), 0 deletions(-)
>  create mode 100644 arch/arm/plat-omap/include/plat/spi100k.h
> 
> diff --git a/arch/arm/mach-omap1/clock.c b/arch/arm/mach-omap1/clock.c
> index dc8ca91..e584c0f 100644
> --- a/arch/arm/mach-omap1/clock.c
> +++ b/arch/arm/mach-omap1/clock.c
> @@ -135,6 +135,10 @@ static struct omap_clk omap_clks[] = {
>  	CLK("i2c_omap.1", "fck",	&i2c_fck,	CK_16XX | CK_1510 | CK_310 | CK_7XX),
>  	CLK("i2c_omap.1", "ick",	&i2c_ick,	CK_16XX),
>  	CLK("i2c_omap.1", "ick",	&dummy_ck,	CK_1510 | CK_310 | CK_7XX),
> +	CLK("omap1_spi100k.1", "fck",	&dummy_ck,	CK_7XX),
> +	CLK("omap1_spi100k.1", "ick",	&dummy_ck,	CK_7XX),
> +	CLK("omap1_spi100k.2", "fck",	&dummy_ck,	CK_7XX),
> +	CLK("omap1_spi100k.2", "ick",	&dummy_ck,	CK_7XX),
>  	CLK("omap_uwire", "fck",	&armxor_ck.clk,	CK_16XX | CK_1510 | CK_310),
>  	CLK("omap-mcbsp.1", "ick",	&dspper_ck,	CK_16XX),
>  	CLK("omap-mcbsp.1", "ick",	&dummy_ck,	CK_1510 | CK_310),
> diff --git a/arch/arm/mach-omap1/devices.c b/arch/arm/mach-omap1/devices.c
> index 23ded2d..9f1c1cc 100644
> --- a/arch/arm/mach-omap1/devices.c
> +++ b/arch/arm/mach-omap1/devices.c
> @@ -24,6 +24,12 @@
>  #include <mach/gpio.h>
>  #include <plat/mmc.h>
>  
> +#if defined(CONFIG_SPI_OMAP_100K)
> +#include <plat/omap7xx.h>
> +#include <plat/spi100k.h>
> +#include <linux/spi/spi.h>
> +#endif
> +

Please don't ifdef includes, you should be able to include them even
if the driver is not selected.


>  /*-------------------------------------------------------------------------*/
>  
>  #if defined(CONFIG_RTC_DRV_OMAP) || defined(CONFIG_RTC_DRV_OMAP_MODULE)
> @@ -196,6 +202,69 @@ void __init omap1_init_mmc(struct omap_mmc_platform_data **mmc_data,
>  
>  /*-------------------------------------------------------------------------*/
>  
> +/* OMAP7xx SPI support */
> +#if defined(CONFIG_SPI_OMAP_100K)
> +
> +#include <plat/omap7xx.h>
> +#include <plat/spi100k.h>
> +#include <linux/spi/spi.h>
> +
> +static struct omap_spi100k_platform_config omap_spi1_config = {
> +        .num_cs         = 2,
> +};
> +
> +static struct resource omap_spi1_resources[] = {
> +	{
> +		.start          = OMAP7XX_SPI1_BASE,
> +		.end            = OMAP7XX_SPI1_BASE + 0x7ff,
> +		.flags          = IORESOURCE_MEM,
> +	},
> +};
> +
> +struct platform_device omap_spi1 = {
> +        .name           = "omap1_spi100k",
> +        .id             = 1,
> +        .num_resources  = ARRAY_SIZE(omap_spi1_resources),
> +        .resource       = omap_spi1_resources,
> +        .dev            = {
> +                .platform_data = &omap_spi1_config,
> +        },
> +};
> +
> +static struct omap_spi100k_platform_config omap_spi2_config = {
> +        .num_cs         = 2,
> +};
> +
> +static struct resource omap_spi2_resources[] = {
> +        {
> +                .start          = OMAP7XX_SPI2_BASE,
> +                .end            = OMAP7XX_SPI2_BASE + 0x7ff,
> +                .flags          = IORESOURCE_MEM,
> +        },
> +};
> +
> +struct platform_device omap_spi2 = {
> +        .name           = "omap1_spi100k",
> +        .id             = 2,
> +        .num_resources  = ARRAY_SIZE(omap_spi2_resources),
> +        .resource       = omap_spi2_resources,
> +        .dev            = {
> +	        .platform_data = &omap_spi2_config,
> +	},
> +};
> +
> +static void omap_init_spi100k(void)
> +{
> +        platform_device_register(&omap_spi1);
> +        platform_device_register(&omap_spi2);
> +}
> +
> +#else
> +static inline void omap_init_spi100k(void) {}
> +#endif

Here you can do the ioremap I mentioned in the comments for
the driver patch.

Regards,

Tony
