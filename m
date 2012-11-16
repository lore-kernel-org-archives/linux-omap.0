From: Benoit Cousson <b-cousson@ti.com>
Subject: Re: [PATCH 1/4] ARM: OMAP: usb-host: Device tree support for USB
 Host
Date: Fri, 16 Nov 2012 11:30:30 +0100
Message-ID: <50A615C6.6060604@ti.com>
References: <1352991396-19589-1-git-send-email-rogerq@ti.com> <1352991396-19589-2-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43672 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751001Ab2KPKao (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 16 Nov 2012 05:30:44 -0500
In-Reply-To: <1352991396-19589-2-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Roger Quadros <rogerq@ti.com>
Cc: tony@atomide.com, balbi@ti.com, keshava_mgowda@ti.com, linux-omap@vger.kernel.org, linux-usb@vger.kernel.org

Hi Roger,

On 11/15/2012 03:56 PM, Roger Quadros wrote:
> Provides a means for the OMAP USB host subsystem to be initialized
> from Device tree. This is a first step for device tree migration where
> we specify only the board specific stuff. Things like I/O address space
> and interrupts are not yet specified in the device tree but can be
> done as a next step.
> 
> This patch will allow boards to be booted with our without device tree
> and have USB host functional.
> 
> Signed-off-by: Roger Quadros <rogerq@ti.com>
> ---
>  .../devicetree/bindings/arm/omap/usb-host.txt      |   60 +++++++++++++++++
>  arch/arm/mach-omap2/board-generic.c                |    1 +
>  arch/arm/mach-omap2/common.h                       |    2 +
>  arch/arm/mach-omap2/usb-host.c                     |   71 ++++++++++++++++++++
>  4 files changed, 134 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/omap/usb-host.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/omap/usb-host.txt b/Documentation/devicetree/bindings/arm/omap/usb-host.txt
> new file mode 100644
> index 0000000..f25cfa4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/omap/usb-host.txt
> @@ -0,0 +1,60 @@
> +* usb-host - OMAP USB Host Subsystem
> +
> +The OMAP USB host subsystem consists of the following modules
> +1) USBTLL (Tranceiverless interface)
> +2) USBHOST (Host Controller module) which includes both EHCI and OHCI controllers
> +
> +THe USB Host subsystem can be connected to the external world using 3 PORTs that could
> +be configured in various modes like  UTMI+ for external PHY, ULPI transceiverless link (TLL),
> +Serial TLL, High-speed interchip (HSIC), etc.
> +
> +Required proprties:
> +- compatible: Must be "ti,usb-host";
> +- num_ports: Number of physical ports available
> +
> +Optional properties:
> +- 1 child node for each available port.  These child nodes are usually supplied by the
> +  board support device tree as they are specific to how the ports are wired on the board
> +
> +  - mode: Integer specifying the mode in which the port is used
> +	* OMAP_USBHS_PORT_MODE_UNUSED		= 0,
> +	* OMAP_EHCI_PORT_MODE_PHY		= 1,
> +	* OMAP_EHCI_PORT_MODE_TLL		= 2,
> +	* OMAP_EHCI_PORT_MODE_HSIC		= 3,
> +	* OMAP_OHCI_PORT_MODE_PHY_6PIN_DATSE0 	= 4,
> +	* OMAP_OHCI_PORT_MODE_PHY_6PIN_DPDM 	= 5,
> +	* OMAP_OHCI_PORT_MODE_PHY_3PIN_DATSE0	= 6,
> +	* OMAP_OHCI_PORT_MODE_PHY_4PIN_DPDM	= 7,
> +	* OMAP_OHCI_PORT_MODE_TLL_6PIN_DATSE0	= 8,
> +	* OMAP_OHCI_PORT_MODE_TLL_6PIN_DPDM	= 9,
> +	* OMAP_OHCI_PORT_MODE_TLL_3PIN_DATSE0	= 10,
> +	* OMAP_OHCI_PORT_MODE_TLL_4PIN_DPDM	= 11,
> +	* OMAP_OHCI_PORT_MODE_TLL_2PIN_DATSE0	= 12,
> +	* OMAP_OHCI_PORT_MODE_TLL_2PIN_DPDM	= 13,
> +   - clk: Name of the clock that needs to be active when using the port
> +   - clkrate: Frequency at which the above clk needs to be run at
> +
> +
> +Example:
> +
> +/* In the OMAP Core tree */
> +usbhost: usb-host {
> +	compatible = "ti,usb-host";
> +	num_ports = <3>;
> +};
> +
> +/* In the Board tree */
> +&usbhost {
> +	port@0 {
> +		mode = <1>;
> +		clk = "auxclk3_ck";
> +		clkrate = <19200000>;
> +	};
> +	port@1 {
> +		mode = <0>;
> +	};
> +	port@2 {
> +		mode = <0>;
> +	};
> +};
> +
> diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
> index 601ecdf..4e53b62 100644
> --- a/arch/arm/mach-omap2/board-generic.c
> +++ b/arch/arm/mach-omap2/board-generic.c
> @@ -40,6 +40,7 @@ static void __init omap_generic_init(void)
>  	omap_sdrc_init(NULL, NULL);
>  
>  	of_platform_populate(NULL, omap_dt_match_table, NULL, NULL);
> +	usbhost_init_of();

You should never have to add that kind of hacks in generic board file.
Why do you need that during board init?

In theory, the of_platform_populate will create all the devices, and
during the driver probe you will create the sub nodes.

This way of initializing early from DT node is done only for critical
ARM/OMAP infrastructure stuff like GIC, L2 controller...
It should not be required for USB, that is not even a mandatory IP to
use the OMAP.

Regards,
Benoit


>  }
>  
>  #ifdef CONFIG_SOC_OMAP2420
> diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
> index 7045e4d..b301fcb 100644
> --- a/arch/arm/mach-omap2/common.h
> +++ b/arch/arm/mach-omap2/common.h
> @@ -339,5 +339,7 @@ extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
>  struct omap2_hsmmc_info;
>  extern int omap4_twl6030_hsmmc_init(struct omap2_hsmmc_info *controllers);
>  
> +void __init usbhost_init_of(void);
> +
>  #endif /* __ASSEMBLER__ */
>  #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
> diff --git a/arch/arm/mach-omap2/usb-host.c b/arch/arm/mach-omap2/usb-host.c
> index bfab301..10a297d 100644
> --- a/arch/arm/mach-omap2/usb-host.c
> +++ b/arch/arm/mach-omap2/usb-host.c
> @@ -22,6 +22,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/dma-mapping.h>
> +#include <linux/of.h>
> +#include <linux/of_gpio.h>
>  
>  #include <asm/io.h>
>  
> @@ -556,3 +558,72 @@ void __init usbhs_init(const struct usbhs_omap_board_data *pdata)
>  }
>  
>  #endif
> +
> +static struct usbhs_omap_board_data bdata;
> +
> +#define USBHS_NODE "usb-host"
> +
> +/**
> + * usbhost_init_of - initialize USB Host subsystem from device tree
> + *
> + * Scans the device tree for required information and populates
> + * platform data for the OMAP USB High Speed Host subsystem
> + */
> +void __init usbhost_init_of(void)
> +{
> +	int r;
> +	struct device_node *node, *child;
> +	int num_ports;
> +	int i;
> +
> +	node = of_find_node_by_name(NULL, USBHS_NODE);
> +	if (!node) {
> +		pr_err("%s could not find OF node : %s\n",
> +					__func__, USBHS_NODE);
> +		return;
> +	}
> +
> +	r = of_property_read_u32(node, "num_ports", &num_ports);
> +	if (r) {
> +		pr_err("%s num_ports not specified in OF node %s\n",
> +				__func__, USBHS_NODE);
> +	}
> +
> +	r = of_property_read_bool(node, "phy_reset");
> +	bdata.phy_reset = r;
> +
> +	i = 0;
> +	for_each_child_of_node(node, child) {
> +		int mode;
> +		const char *clk_name;
> +		u32 clk_rate;
> +
> +		r = of_property_read_u32(child, "mode", &mode);
> +		if (r) {
> +			pr_err("%s mode not specified in OF node %s port %d\n",
> +				__func__, USBHS_NODE, i);
> +			bdata.port_mode[i] = OMAP_USBHS_PORT_MODE_UNUSED;
> +		} else {
> +			bdata.port_mode[i] = mode;
> +		}
> +
> +		r = of_get_named_gpio(child, "reset_gpio", 0);
> +		if (gpio_is_valid(r))
> +			bdata.reset_gpio_port[i] = r;
> +		else
> +			bdata.reset_gpio_port[i] = -EINVAL;
> +
> +		clk_name = of_get_property(child, "clk", NULL);
> +		if (clk_name)
> +			bdata.clk[i] = clk_name;
> +
> +		r = of_property_read_u32(child, "clkrate", &clk_rate);
> +		if (!r)
> +			bdata.clkrate[i] = clk_rate;
> +
> +		i++;
> +	}
> +
> +	usbhs_init(&bdata);
> +}
> +
> 

