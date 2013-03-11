From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: gpmc: request CS address space for ethernet
 chips
Date: Mon, 11 Mar 2013 12:13:19 -0500
Message-ID: <513E10AF.2080802@ti.com>
References: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:47020 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919Ab3CKRNm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 11 Mar 2013 13:13:42 -0400
In-Reply-To: <1362935902-29720-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Grant Likely <grant.likely@secretlab.ca>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, linux-omap <linux-omap@vger.kernel.org>, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org


On 03/10/2013 12:18 PM, Javier Martinez Canillas wrote:
> Besides being used to interface with external memory devices,
> the General-Purpose Memory Controller can be used to connect
> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
> processors using the GPMC as a data bus.
> 
> The actual mapping between the GPMC address space and OMAP2+
> address space is made using the GPMC DT "ranges" property.
> But also a explicit call to gpmc_cs_request() is needed.

One problem with gpmc_cs_request() is that it will map the chip-select
to any physical location in the 1GB address space for the gpmc
controller. So in other words, it will ignore the ranges property
altogether. If you look at my code for NOR, I have added a
gpmc_cs_remap() function to remap the cs to the location as specified by
the device-tree.

Ideally we should change gpmc_cs_request() so we can pass the desire
base address that we want to map the gpmc cs too. I had started out that
way but it made the code some what messy and so I opted to create a
gpmc_cs_remap() function instead. The goal will be to get rid of
gpmc_cs_remap() once DT migration is completed and we can change
gpmc_cs_request() to map the cs to a specific address (see my FIXME
comment).

Your code probably works today because the cs is setup by the bootloader
and so when you request the cs in the kernel the mapping is not changed
from the bootloader settings. However, if the mapping in DT (ranges
property) is different from that setup by the bootloader then the kernel
would probably crash because the kernel would not remap it as expected.

> So, this patch allows an ethernet chip to be defined as an
> GPMC child node an its chip-select memory address be requested.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
> 
> Jon,
> 
> This patch assumes that we have solved somehow the issue that a
> call to request_irq() is needed before before using a GPIO as an
> IRQ and this is no longer the case when using from Device Trees.
> 
> Anyway, this is independent as how we solve this, whether is
> using Jan's patch [1], adding a .request function pointer to
> irq_chip as suggested by Stephen [2], or any other approach.
> 
> [1]: https://patchwork.kernel.org/patch/2009331/
> [2]: http://www.mail-archive.com/linux-omap@vger.kernel.org/msg85592.html
> 
>  arch/arm/mach-omap2/gpmc.c |   45 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 45 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 4fe9ee7..d1bf48b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -29,6 +29,7 @@
>  #include <linux/of.h>
>  #include <linux/of_mtd.h>
>  #include <linux/of_device.h>
> +#include <linux/of_address.h>
>  #include <linux/mtd/nand.h>
>  
>  #include <linux/platform_data/mtd-nand-omap2.h>
> @@ -1296,6 +1297,42 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
>  }
>  #endif
>  
> +static int gpmc_probe_ethernet_child(struct platform_device *pdev,
> +				     struct device_node *child)
> +{
> +	int ret, cs;
> +	unsigned long base;
> +	struct resource res;
> +	struct platform_device *of_dev;
> +
> +	if (of_property_read_u32(child, "reg", &cs) < 0) {
> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	if (of_address_to_resource(child, 0, &res)) {
> +		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	ret = gpmc_cs_request(cs, resource_size(&res), &base);
> +	if (IS_ERR_VALUE(ret)) {
> +		dev_err(&pdev->dev, "cannot request GPMC CS %d\n", cs);
> +		return ret;
> +	}
> +
> +	of_dev = of_platform_device_create(child, NULL, &pdev->dev);
> +	if (!of_dev) {
> +		dev_err(&pdev->dev, "cannot create platform device for %s\n",
> +			child->full_name);
> +		return -ENODEV;
> +	}
> +
> +	return 0;
> +}

So this function does not setup the cs at all and so that means you are
dependent on having the bootloader configure the cs. I would really like
to get away from that sort of dependency. In fact I am wondering if we
could make the gpmc_probe_nor() function a gpmc_probe_generic() that we
can use for both nor and ethernet as we are doing very similar things
(if we add the timings and gpmc settings to the ethernet binding).

Also I think we need to add some DT binding documentation for this as well.

Cheers
Jon
