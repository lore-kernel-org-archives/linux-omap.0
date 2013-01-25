From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3 3/3] arm: omap2: gpmc: add DT bindings for OneNAND
Date: Fri, 25 Jan 2013 15:56:33 +0000
Message-ID: <20130125155633.GC16795@e106331-lin.cambridge.arm.com>
References: <1359116591-32730-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:33586 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755926Ab3AYP4j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Jan 2013 10:56:39 -0500
In-Reply-To: <1359116591-32730-3-git-send-email-ezequiel.garcia@free-electrons.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "zonque@gmail.com" <zonque@gmail.com>, "tony@atomide.com" <tony@atomide.com>, "matthias.bgg@googlemail.com" <matthias.bgg@googlemail.com>, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "b-cousson@ti.com" <b-cousson@ti.com>, "grant.likely@secretlab.ca" <grant.likely@secretlab.ca>, "jon-hunter@ti.com" <jon-hunter@ti.com>, Artem Bityutskiy <dedekind1@gmail.com>

Hi,

I have a couple more comments after looking though this a bit more thoroughly.

On Fri, Jan 25, 2013 at 12:23:11PM +0000, Ezequiel Garcia wrote:
> This patch adds device tree bindings for OMAP OneNAND devices.
> Tested on an OMAP3 3430 IGEPv2 board.
> 
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> ---
> Changes from v2:
>  * Remove unneeded of_node_put() as reported by Mark Rutland
> 
> Changes from v1:
>  * Fix typo in Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> 
>  .../devicetree/bindings/mtd/gpmc-onenand.txt       |   43 +++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.c                         |   45 ++++++++++++++++++++
>  2 files changed, 88 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> 
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> new file mode 100644
> index 0000000..deec9da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-onenand.txt
> @@ -0,0 +1,43 @@
> +Device tree bindings for GPMC connected OneNANDs
> +
> +GPMC connected OneNAND (found on OMAP boards) are represented as child nodes of
> +the GPMC controller with a name of "onenand".
> +
> +All timing relevant properties as well as generic gpmc child properties are
> +explained in a separate documents - please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt

Which tree can I find this in?

> +
> +Required properties:
> +
> + - reg:			The CS line the peripheral is connected to
> +
> +Optional properties:
> +
> + - dma-channel:		DMA Channel index
> +
> +For inline partiton table parsing (optional):
> +
> + - #address-cells: should be set to 1
> + - #size-cells: should be set to 1
> +
> +Example for an OMAP3430 board:
> +
> +	gpmc: gpmc@6e000000 {
> +		compatible = "ti,omap3430-gpmc";
> +		ti,hwmods = "gpmc";
> +		reg = <0x6e000000 0x1000000>;
> +		interrupts = <20>;
> +		gpmc,num-cs = <8>;
> +		gpmc,num-waitpins = <4>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +
> +		onenand@0 {
> +			reg = <0 0 0>; /* CS0, offset 0 */
> +
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +
> +			/* partitions go here */
> +		};
> +	};
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index c6255f7..0636d0a 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -39,6 +39,7 @@
>  #include "omap_device.h"
>  #include "gpmc.h"
>  #include "gpmc-nand.h"
> +#include "gpmc-onenand.h"
>  
>  #define	DEVICE_NAME		"omap-gpmc"
>  
> @@ -1259,6 +1260,43 @@ static int gpmc_probe_nand_child(struct platform_device *pdev,
>  }
>  #endif
>  
> +#ifdef CONFIG_MTD_ONENAND
> +static int gpmc_probe_onenand_child(struct platform_device *pdev,
> +				 struct device_node *child)
> +{
> +	u32 val;
> +	struct omap_onenand_platform_data *gpmc_onenand_data;
> +
> +	if (of_property_read_u32(child, "reg", &val) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}

I don't understand the format of the reg property, but it seems odd that you
only need to read one cell from it. Are the remaining address cell and size
cell used anywhere?

> +
> +	gpmc_onenand_data = devm_kzalloc(&pdev->dev, sizeof(*gpmc_onenand_data),
> +					 GFP_KERNEL);
> +	if (!gpmc_onenand_data)
> +		return -ENOMEM;
> +
> +	gpmc_onenand_data->cs = val;
> +	gpmc_onenand_data->of_node = child;
> +	gpmc_onenand_data->dma_channel = -1;
> +
> +	if (!of_property_read_u32(child, "dma-channel", &val))
> +		gpmc_onenand_data->dma_channel = val;
> +
> +	gpmc_onenand_init(gpmc_onenand_data);
> +
> +	return 0;
> +}

[...]

Otherwise looks good.

Thanks,
Mark.


