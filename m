From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet child
 nodes
Date: Thu, 14 Mar 2013 10:48:14 -0500
Message-ID: <5141F13E.8040300@ti.com>
References: <1363273762-17441-1-git-send-email-javier.martinez@collabora.co.uk> <1363273762-17441-4-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43276 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964808Ab3CNPsc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 11:48:32 -0400
In-Reply-To: <1363273762-17441-4-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org

Hi Javier,

On 03/14/2013 10:09 AM, Javier Martinez Canillas wrote:
> Besides being used to interface with external memory devices,
> the General-Purpose Memory Controller can be used to connect
> Pseudo-SRAM devices such as ethernet controllers to OMAP2+
> processors using the TI GPMC as a data bus.
> 
> This patch allows an ethernet chip to be defined as an GPMC
> child device node.
> 
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> ---
>  Documentation/devicetree/bindings/net/gpmc-eth.txt |   90 ++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.c                         |    8 ++
>  2 files changed, 98 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
> new file mode 100644
> index 0000000..c45363c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
> @@ -0,0 +1,90 @@
> +Device tree bindings for Ethernet chip connected to TI GPMC
> +
> +Besides being used to interface with external memory devices, the
> +General-Purpose Memory Controller can be used to connect Pseudo-SRAM devices
> +such as ethernet controllers to processors using the TI GPMC as a data bus.
> +
> +Ethernet controllers connected to TI GPMC are represented as child nodes of
> +the GPMC controller with an "ethernet" name.
> +
> +All timing relevant properties as well as generic GPMC child properties are
> +explained in a separate documents. Please refer to
> +Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +Required properties:
> +- bank-width: 		Address width of the device in bytes. GPMC supports 8-bit
> +			and 16-bit devices and so must be either 1 or 2 bytes.

I am wondering if we should use reg-io-width here. The smsc driver is
using this to determine the width of the device. And so I am wondering
if this could cause problems.

Obviously this complicates gpmc_probe_generic_child() a little, but may
be would could pass the name of the width property to
gpmc_probe_generic_child() as well. What do you think?

> +- compatible:		Compatible string property for the ethernet child device.
> +- gpmc,cs-on:		Chip-select assertion time
> +- gpmc,cs-rd-off:	Chip-select de-assertion time for reads
> +- gpmc,cs-wr-off:	Chip-select de-assertion time for writes
> +- gpmc,oe-on:		Output-enable assertion time
> +- gpmc,oe-off		Output-enable de-assertion time
> +- gpmc,we-on:		Write-enable assertion time
> +- gpmc,we-off:		Write-enable de-assertion time
> +- gpmc,access:		Start cycle to first data capture (read access)
> +- gpmc,rd-cycle:	Total read cycle time
> +- gpmc,wr-cycle:	Total write cycle time
> +- reg:			Chip-select, base address (relative to chip-select)
> +			and size of the memory mapped for the device.
> +			Note that base address will be typically 0 as this
> +			is the start of the chip-select.
> +
> +Optional properties:
> +- gpmc,XXX		Additional GPMC timings and settings parameters. See
> +			Documentation/devicetree/bindings/bus/ti-gpmc.txt
> +
> +Optional properties for partiton table parsing:
> +- #address-cells: should be set to 1
> +- #size-cells: should be set to 1
> +
> +Example:
> +
> +gpmc: gpmc@6e000000 {
> +	compatible = "ti,omap3430-gpmc";
> +	ti,hwmods = "gpmc";
> +	reg = <0x6e000000 0x1000>;
> +	interrupts = <20>;
> +	gpmc,num-cs = <8>;
> +	gpmc,num-waitpins = <4>;
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +
> +	ranges = <5 0 0x2c000000 0x1000000>;
> +
> +	ethernet@5,0 {
> +		compatible = "smsc,lan9221", "smsc,lan9115";
> +		reg = <5 0 0xff>;
> +		bank-width = <2>;
> +
> +		gpmc,mux-add-data;
> +		gpmc,cs-on = <0>;
> +		gpmc,cs-rd-off = <186>;
> +		gpmc,cs-wr-off = <186>;
> +		gpmc,adv-on = <12>;
> +		gpmc,adv-rd-off = <48>;
> +		gpmc,adv-wr-off = <48>;
> +		gpmc,oe-on = <54>;
> +		gpmc,oe-off = <168>;
> +		gpmc,we-on = <54>;
> +		gpmc,we-off = <168>;
> +		gpmc,rd-cycle = <186>;
> +		gpmc,wr-cycle = <186>;
> +		gpmc,access = <114>;
> +		gpmc,page-burst-access = <6>;
> +		gpmc,bus-turnaround = <12>;
> +		gpmc,cycle2cycle-delay = <18>;
> +		gpmc,wr-data-mux-bus = <90>;
> +		gpmc,wr-access = <186>;
> +		gpmc,cycle2cycle-samecsen;
> +		gpmc,cycle2cycle-diffcsen;
> +
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <16>;
> +		vmmc-supply = <&vddvario>;
> +		vmmc_aux-supply = <&vdd33a>;
> +		reg-io-width = <2>;
> +
> +		smsc,save-mac-address;
> +	};
> +};
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index 898b44d..2bc276b 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1559,6 +1559,14 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>  		}
>  	}
>  
> +	for_each_node_by_name(child, "ethernet") {
> +		ret = gpmc_probe_generic_child(pdev, child);
> +		if (ret < 0) {
> +			of_node_put(child);
> +			return ret;
> +		}
> +	}
> +
>  	return 0;
>  }
>  #else

Otherwise looks good to me. Thanks!

Jon

