From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 2 Nov 2012 05:41:47 -0500
Message-ID: <5093A36B.70101@ti.com>
References: <1351794970-14675-1-git-send-email-zonque@gmail.com> <1351794970-14675-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:41401 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755537Ab2KBKmA (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 2 Nov 2012 06:42:00 -0400
In-Reply-To: <1351794970-14675-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

Hi Daniel,

On 11/01/2012 01:36 PM, Daniel Mack wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instanciated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.
> 
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  73 +++++++++++
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  61 +++++++++
>  arch/arm/mach-omap2/gpmc.c                         | 139 +++++++++++++++++++++
>  3 files changed, 273 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> new file mode 100644
> index 0000000..6f44487
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> @@ -0,0 +1,73 @@
> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
> +
> +The actual devices are instantiated from the child nodes of a GPMC node.
> +
> +Required properties:
> +
> + - compatible:		Should be set to "ti,gpmc"
> + - reg:			A resource specifier for the register space
> +			(see the example below)
> + - ti,hwmods:		Should be set to "ti,gpmc" until the DT transition is
> +			completed.
> + - #address-cells:	Must be set to 2 to allow memory address translation
> + - #size-cells:		Must be set to 1 to allow CS address passing
> + - ranges:		Must be set up to reflect the memory layout
> +			Note that this property is not currently parsed.
> +			Calculated values derived from the contents of
> +			GPMC_CS_CONFIG7 as set up by the bootloader. That will
> +			change in the future, so be sure to fill the correct
> +			values here.

I still think it would be good to add number of chip-selects and
wait-pins here.

> +Timing properties for child nodes. All are optional and default to 0.
> +
> + - gpmc,sync-clk:	Minimum clock period for synchronous mode, in picoseconds
> +
> + Chip-select signal timings corresponding to GPMC_CS_CONFIG2:
> + - gpmc,cs-on:		Assertion time
> + - gpmc,cs-rd-off:	Read deassertion time
> + - gpmc,cs-wr-off:	Write deassertion time
> +
> + ADV signal timings corresponding to GPMC_CONFIG3:
> + - gpmc,adv-on:		Assertion time
> + - gpmc,adv-rd-off:	Read deassertion time
> + - gpmc,adv-wr-off:	Write deassertion time

Nit-pick, looks like you are mixing GPMC_CS_CONFIGx and GPMC_CONFIGx
naming conventions in the above and below. Would be good to make this
consistent.

> +
> + WE signals timings corresponding to GPMC_CONFIG4:
> + - gpmc,we-on:		Assertion time
> + - gpmc,we-off:		Deassertion time
> +
> + OE signals timings corresponding to GPMC_CONFIG4
> + - gpmc,oe-on:		Assertion time
> + - gpmc,oe-off:		Deassertion time
> +
> + Access time and cycle time timings corresponding to GPMC_CONFIG5
> + - gpmc,page-burst-access: Multiple access word delay
> + - gpmc,access:		Start-cycle to first data valid delay
> + - gpmc,rd-cycle:	Total read cycle time
> + - gpmc,wr-cycle:	Total write cycle time
> +
> +The following are only on OMAP3430
> + - gpmc,wr-access
> + - gpmc,wr-data-mux-bus
> +
> +
> +Example for an AM33xx board:
> +
> +	gpmc: gpmc@50000000 {
> +		compatible = "ti,gpmc";
> +		ti,hwmods = "gpmc";
> +		reg = <0x50000000 0x2000>;
> +		interrupt-parent = <&intc>;

We should drop interrupt-parent. We are declaring the interrupt-parent
globally in the dts files and so no need to replicate in each individual
binding.

> +		interrupts = <100>;
> +
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x08000000 0x10000000>; /* CS0 */
> +
> +		/* child nodes go here */
> +	};
> +
> +
> +
> +
> +
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> new file mode 100644
> index 0000000..e0c1e67
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -0,0 +1,61 @@
> +Device tree bindings for GPMC connected NANDs
> +
> +GPMC connected NAND (found on OMAP boards) are represented as child nodes of
> +the GPMC controller with a name of "nand".
> +
> +All timing relevant properties as well as generic gpmc child properties are
> +explained in a separate documents - please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +For NAND specific properties such as ECC modes or bus width, please refer to
> +Documentation/devicetree/bindings/mtd/nand.txt
> +
> +
> +Required properties:
> +
> + - reg: The CS line the peripheral is connected to
> +
> +For inline partiton table parsing (optional):
> +
> + - #address-cells: should be set to 1
> + - #size-cells: should be set to 1
> +
> +Example for an AM33xx board:
> +
> +	gpmc: gpmc@50000000 {
> +		compatible = "ti,gpmc";
> +		ti,hwmods = "gpmc";
> +		reg = <0x50000000 0x1000000>;
> +		interrupt-parent = <&intc>;

Remove interrupt-parent here too.

> +		interrupts = <100>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
> +
> +		nand@0,0 {
> +			reg = <0 0 0>; /* CS0, offset 0 */

The above description says that this is just the chip-select number. Are
the other fields used here? If so, what for?

> +			nand-bus-width = <16>;
> +			nand-ecc-mode = "none";

I am still wondering if the above needs to be mandatory. Or if not then
may be these should be documented as optional and if these a omitted
then what the default configuration would be.

> +
> +			gpmc,sync-clk = <0>;
> +			gpmc,cs-on = <0>;
> +			gpmc,cs-rd-off = <36>;
> +			gpmc,cs-wr-off = <36>;
> +			gpmc,adv-on = <6>;
> +			gpmc,adv-rd-off = <24>;
> +			gpmc,adv-wr-off = <36>;
> +			gpmc,we-off = <30>;
> +			gpmc,oe-off = <48>;
> +			gpmc,access = <54>;
> +			gpmc,rd-cycle = <72>;
> +			gpmc,wr-cycle = <72>;
> +			gpmc,wr-access = <30>;
> +			gpmc,wr-data-mux-bus = <0>;
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* partitions go here */
> +		};
> +	};
> +
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 1dcb30c..b028225 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -25,6 +25,10 @@
>  #include <linux/module.h>
>  #include <linux/interrupt.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>
> +#include <linux/of_mtd.h>
> +#include <linux/of_device.h>
> +#include <linux/mtd/nand.h>
>  
>  #include <linux/platform_data/mtd-nand-omap2.h>
>  
> @@ -37,6 +41,7 @@
>  #include "soc.h"
>  #include "common.h"
>  #include "gpmc.h"
> +#include "gpmc-nand.h"
>  
>  #define	DEVICE_NAME		"omap-gpmc"
>  
> @@ -751,6 +756,131 @@ static int __devinit gpmc_mem_init(void)
>  	return 0;
>  }
>  
> +#ifdef CONFIG_OF
> +static struct of_device_id gpmc_dt_ids[] = {
> +	{ .compatible = "ti,gpmc" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
> +
> +static void gpmc_read_timings_dt(struct device_node *np,
> +				 struct gpmc_timings *gpmc_t)
> +{
> +	u32 val;
> +
> +	memset(gpmc_t, 0, sizeof(*gpmc_t));
> +
> +	/* minimum clock period for syncronous mode */
> +	if (!of_property_read_u32(np, "gpmc,sync-clk", &val))
> +		gpmc_t->sync_clk = val;
> +
> +	/* chip select timtings */
> +	if (!of_property_read_u32(np, "gpmc,cs-on", &val))
> +		gpmc_t->cs_on = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,cs-rd-off", &val))
> +		gpmc_t->cs_rd_off = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,cs-wr-off", &val))
> +		gpmc_t->cs_wr_off = val;
> +
> +	/* ADV signal timings */
> +	if (!of_property_read_u32(np, "gpmc,adv-on", &val))
> +		gpmc_t->adv_on = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,adv-rd-off", &val))
> +		gpmc_t->adv_rd_off = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,adv-wr-off", &val))
> +		gpmc_t->adv_wr_off = val;
> +
> +	/* WE signal timings */
> +	if (!of_property_read_u32(np, "gpmc,we-on", &val))
> +		gpmc_t->we_on = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,we-off", &val))
> +		gpmc_t->we_off = val;
> +
> +	/* OE signal timings */
> +	if (!of_property_read_u32(np, "gpmc,oe-on", &val))
> +		gpmc_t->oe_on = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,oe-off", &val))
> +		gpmc_t->oe_off = val;
> +
> +	/* access and cycle timings */
> +	if (!of_property_read_u32(np, "gpmc,page-burst-access", &val))
> +		gpmc_t->page_burst_access = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,access", &val))
> +		gpmc_t->access = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,rd-cycle", &val))
> +		gpmc_t->rd_cycle = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,wr-cycle", &val))
> +		gpmc_t->wr_cycle = val;
> +
> +	/* only for OMAP3430 */
> +	if (!of_property_read_u32(np, "gpmc,wr-access", &val))
> +		gpmc_t->wr_access = val;
> +
> +	if (!of_property_read_u32(np, "gpmc,wr-data-mux-bus", &val))
> +		gpmc_t->wr_data_mux_bus = val;
> +}
> +
> +static int gpmc_probe_dt(struct platform_device *pdev)
> +{
> +	u32 val;
> +	struct device_node *child;
> +	struct gpmc_timings gpmc_t;
> +	const struct of_device_id *of_id =
> +		of_match_device(gpmc_dt_ids, &pdev->dev);
> +
> +	if (!of_id)
> +		return 0;
> +
> +	for_each_node_by_name(child, "nand") {
> +		struct omap_nand_platform_data *gpmc_nand_data;
> +
> +		if (of_property_read_u32(child, "reg", &val) < 0) {
> +			dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +				child->full_name);
> +			continue;
> +		}
> +
> +		gpmc_nand_data = devm_kzalloc(&pdev->dev,
> +					      sizeof(*gpmc_nand_data),
> +					      GFP_KERNEL);
> +		if (!gpmc_nand_data) {
> +			dev_err(&pdev->dev, "unable to allocate memory?");
> +			return -ENOMEM;
> +		}
> +
> +		gpmc_nand_data->cs = val;
> +		gpmc_nand_data->of_node = child;
> +
> +		val = of_get_nand_ecc_mode(child);
> +		if (val >= 0)
> +			gpmc_nand_data->ecc_opt = val;
> +
> +		val = of_get_nand_bus_width(child);
> +		if (val == 16)
> +			gpmc_nand_data->devsize = NAND_BUSWIDTH_16;

Do we need any error checking here? I believe we only support 8-bit and
16-bit width devices and so if 16-bit is not set then we default to 8-bit.

> +
> +		gpmc_read_timings_dt(child, &gpmc_t);
> +		gpmc_nand_init(gpmc_nand_data, &gpmc_t);

I believe that you need an "of_node_put()" when you are done with the child.

Thanks
Jon
