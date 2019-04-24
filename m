From: Ladislav Michl <ladis@linux-mips.org>
Subject: Re: [PATCH v3] mtd: rawnand: ams-delta: Drop board specific
 partition info
Date: Thu, 25 Apr 2019 00:14:28 +0200
Message-ID: <20190424221428.GA4172@lenoch>
References: <20190324223344.24590-1-jmkrzyszt@gmail.com>
 <20190424180212.10830-1-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190424180212.10830-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Boris Brezillon <bbrezillon@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Janusz,

On Wed, Apr 24, 2019 at 08:02:12PM +0200, Janusz Krzysztofik wrote:
> After recent modifications, only a hardcoded partition info makes
> the driver device specific.  Other than that, the driver uses GPIO
> exclusively and can be used on any hardware.
> 
> Drop the partition info and use MTD partition parser with default list
> of parser names instead.  For the OF parser to work correctly, pass
> device of_node to mtd.
> 
> Amstrad Delta users should append the following partition info to their
> kernel command line, possibly embedding it in CONFIG_CMDLINE:
> 
> mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
> 256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)

now, when driver is no longer Amstrad Delta specific, why would you want
to have ams-delta-nand hardcoded on kernel cmdline? I'm assuming at some
point this driver will become gpio-nand [*] or something like that and
asking users to change their kernel cmdline twice is just unwise :)

[*] btw, it is really shame gpio-nand name is already taken by driver
living in drivers/mtd/nand/raw/gpio.c which is more likely gpio-mem-nand
used by at least CompuLab CM-X255 and Picochip picoXcell.

Otherwise your work on this driver is so amazing that I just spent
couple of hours finding that phone and compiling some decent userspace
for it :) Thank you!

> For their convenience, that information is added to the board Kconfig
> entry help text, as well as CONFIG_MTD_CMDLINE_PARTS symbol is selected
> automatically from the board Kconfig entry if the NAND driver is also
> selected.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
> Changelog:
> v2->v3:
> - add information on the requirement for passing partition info via
>   kernel command line to the board Kconfig entry help text
> v1->v2:
> - fix a typo poitned out by Aaro - thanks!
> - fix device_node not passed to OF parser via mtd_info
> - commit message reworded and reformatted a bit for better readability
> 
>  arch/arm/mach-omap1/Kconfig      |  7 ++++++-
>  drivers/mtd/nand/raw/ams-delta.c | 29 ++---------------------------
>  2 files changed, 8 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
> index c4694f26b5c4..41a47d251cac 100644
> --- a/arch/arm/mach-omap1/Kconfig
> +++ b/arch/arm/mach-omap1/Kconfig
> @@ -164,17 +164,22 @@ config MACH_NOKIA770
>  	  have such a device.
>  
>  config MACH_AMS_DELTA
> -	bool "Amstrad E3 (Delta)"
> +	bool "Amstrad E3 (Delta) - see help for important information"
>  	depends on ARCH_OMAP1 && ARCH_OMAP15XX
>  	select FIQ
>  	select GPIO_GENERIC_PLATFORM
>  	select LEDS_GPIO_REGISTER
>  	select REGULATOR
>  	select REGULATOR_FIXED_VOLTAGE
> +	select MTD_CMDLINE_PARTS if MTD_NAND_AMS_DELTA
>  	help
>  	  Support for the Amstrad E3 (codename Delta) videophone. Say Y here
>  	  if you have such a device.
>  
> +	  If you are using built-in NAND, append the following partition
> +	  info to kernel command line:
> +	  mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)
> +
>  config MACH_OMAP_GENERIC
>  	bool "Generic OMAP board"
>  	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index 8312182088c1..e0f09179bbda 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -41,31 +41,6 @@ struct ams_delta_nand {
>  	bool			data_in;
>  };
>  
> -/*
> - * Define partitions for flash devices
> - */
> -
> -static const struct mtd_partition partition_info[] = {
> -	{ .name		= "Kernel",
> -	  .offset	= 0,
> -	  .size		= 3 * SZ_1M + SZ_512K },
> -	{ .name		= "u-boot",
> -	  .offset	= 3 * SZ_1M + SZ_512K,
> -	  .size		= SZ_256K },
> -	{ .name		= "u-boot params",
> -	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
> -	  .size		= SZ_256K },
> -	{ .name		= "Amstrad LDR",
> -	  .offset	= 4 * SZ_1M,
> -	  .size		= SZ_256K },
> -	{ .name		= "File system",
> -	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
> -	  .size		= 27 * SZ_1M },
> -	{ .name		= "PBL reserved",
> -	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
> -	  .size		=  3 * SZ_256K },
> -};
> -
>  static void ams_delta_write_commit(struct ams_delta_nand *priv)
>  {
>  	gpiod_set_value(priv->gpiod_nwe, 0);
> @@ -238,6 +213,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	mtd->dev.parent = &pdev->dev;
>  
>  	nand_set_controller_data(this, priv);
> +	nand_set_flash_node(this, pdev->dev.of_node);
>  
>  	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
>  	if (IS_ERR(priv->gpiod_rdy)) {
> @@ -315,8 +291,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  		return err;
>  
>  	/* Register the partitions */
> -	err = mtd_device_register(mtd, partition_info,
> -				  ARRAY_SIZE(partition_info));
> +	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
>  	if (err)
>  		goto err_nand_cleanup;
>  
> -- 
> 2.21.0
