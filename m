From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [RFC PATCH 5/8] mtd: rawnand: ams-delta: Request data port GPIO
 resource
Date: Thu, 19 Jul 2018 08:28:34 +0200
Message-ID: <20180719082834.32827212@bbrezillon>
References: <20180718235710.18242-1-jmkrzyszt@gmail.com>
        <20180718235710.18242-6-jmkrzyszt@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180718235710.18242-6-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Tony Lindgren <tony@atomide.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
List-Id: linux-omap@vger.kernel.org

On Thu, 19 Jul 2018 01:57:07 +0200
Janusz Krzysztofik <jmkrzyszt@gmail.com> wrote:

> Data port used by the driver is actually an OMAP MPUIO device, already
> under control of gpio-omap driver.  For that reason we used to not
> request the memory region of the port as that would fail because the
> region is already busy.  Despite that, we are still accessing the port
> by just ioremapping it and performing read/write operations.  Moreover,
> we are doing that without any proteciton from other users legally
> manipulating the port pins over GPIO API.
> 
> The plan is to convert the driver to access the port over functions
> exposed by the gpio-omap driver.  Before that happens, we can already
> obtain exclusive access to the port by requesting an array of its GPIO
> descriptors.  For that to work on Amstrad Delta, respective GPIO lookup
> table entries are added to the board init file.
> 
> Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
> ---
>  arch/arm/mach-omap1/board-ams-delta.c | 11 ++++++++++-
>  drivers/mtd/nand/raw/ams-delta.c      |  8 ++++++++

Can we split that in 2 patches: one adding data entries to the lookup
table, and another one patching the driver to request the gpiod array.

>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
> index eedacdfe9725..16f7bbe47607 100644
> --- a/arch/arm/mach-omap1/board-ams-delta.c
> +++ b/arch/arm/mach-omap1/board-ams-delta.c
> @@ -337,7 +337,8 @@ static struct platform_device ams_delta_nand_device = {
>  	.resource	= ams_delta_nand_resources,
>  };
>  
> -#define OMAP_GPIO_LABEL	"gpio-0-15"
> +#define OMAP_GPIO_LABEL		"gpio-0-15"
> +#define OMAP_MPUIO_LABEL	"mpuio"
>  
>  static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
>  	.table = {
> @@ -349,6 +350,14 @@ static struct gpiod_lookup_table ams_delta_nand_gpio_table = {
>  		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_NWE, "nwe", 0),
>  		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_ALE, "ale", 0),
>  		GPIO_LOOKUP(LATCH2_LABEL, LATCH2_PIN_NAND_CLE, "cle", 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 0, "data", 0, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 1, "data", 1, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 2, "data", 2, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 3, "data", 3, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 4, "data", 4, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 5, "data", 5, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 6, "data", 6, 0),
> +		GPIO_LOOKUP_IDX(OMAP_MPUIO_LABEL, 7, "data", 7, 0),
>  		{ },
>  	},
>  };
> diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
> index d7e4c9dbef67..ad62c0245458 100644
> --- a/drivers/mtd/nand/raw/ams-delta.c
> +++ b/drivers/mtd/nand/raw/ams-delta.c
> @@ -189,6 +189,7 @@ static int ams_delta_init(struct platform_device *pdev)
>  	struct mtd_info *mtd;
>  	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	void __iomem *io_base;
> +	struct gpio_descs *data_gpiods;
>  	int err = 0;
>  
>  	if (!res)
> @@ -289,6 +290,13 @@ static int ams_delta_init(struct platform_device *pdev)
>  		dev_err(&pdev->dev, "CLE GPIO request failed (%d)\n", err);
>  		goto out_mtd;
>  	}
> +	/* Request array of data pins, initialize them as output and set low */
> +	data_gpiods = devm_gpiod_get_array(&pdev->dev, "data", GPIOD_OUT_LOW);
> +	if (IS_ERR(data_gpiods)) {
> +		err = PTR_ERR(data_gpiods);
> +		dev_err(&pdev->dev, "data GPIO request failed: %d\n", err);
> +		goto out_mtd;
> +	}
>  
>  	/* Scan to find existence of the device */
>  	err = nand_scan(mtd, 1);
