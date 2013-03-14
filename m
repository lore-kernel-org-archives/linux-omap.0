From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH v2 3/3] ARM: OMAP2+: Add GPMC DT support for Ethernet
 child nodes
Date: Thu, 14 Mar 2013 15:43:15 -0500
Message-ID: <51423663.2030108@ti.com>
References: <1363293217-21926-1-git-send-email-javier.martinez@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:57604 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437Ab3CNUna (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 14 Mar 2013 16:43:30 -0400
In-Reply-To: <1363293217-21926-1-git-send-email-javier.martinez@collabora.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>, Russell King <linux@arm.linux.org.uk>, Enric Balletbo i Serra <eballetbo@gmail.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Matthias Brugger <matthias.bgg@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org


On 03/14/2013 03:33 PM, Javier Martinez Canillas wrote:
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
> 
> Changes since v1:
>   - Improve the DT binding documentation explaining that even when the GPMC
>     maximum bus address width is 16-bit, it supports devices with 32-bit
>     registers address width and the device property especifying this has to
>     be set accordingly; suggested by Jon Hunter.
>     
> 
>  Documentation/devicetree/bindings/net/gpmc-eth.txt |  101 ++++++++++++++++++++
>  arch/arm/mach-omap2/gpmc.c                         |    8 ++
>  2 files changed, 109 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/net/gpmc-eth.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/gpmc-eth.txt b/Documentation/devicetree/bindings/net/gpmc-eth.txt
> new file mode 100644
> index 0000000..8c8be58
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/gpmc-eth.txt
> @@ -0,0 +1,101 @@
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
> +For the properties relevant to the ethernet controller connected to the GPMC
> +refer to the binding documentation of the device. For example, the documentation
> +for the SMSC 911x is Documentation/devicetree/bindings/net/smsc911x.txt
> +
> +Child nodes need to specify the GPMC bus address width using the "bank-width"
> +property but is possible that an ethernet controller also has a property to
> +specify the I/O registers address width. Even when the GPMC has a maximum 16-bit
> +address width, it supports devices with 32-bit word registers.
> +For example with an SMSC LAN911x/912x controller connected to the TI GPMC on an
> +OMAP2+ board, "bank-width = <2>;" and "reg-io-width = <4>;".
> +
> +Required properties:
> +- bank-width: 		Address width of the device in bytes. GPMC supports 8-bit
> +			and 16-bit devices and so must be either 1 or 2 bytes.
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

Should we add "reg-io-width" here and say can be 2 or 4 and to refer to
the above description?

> +
> +Optional properties for partiton table parsing:
> +- #address-cells: should be set to 1
> +- #size-cells: should be set to 1

Sorry should have caught this earlier. The above is not relevant for
ethernet.

Otherwise looks good.

Cheers
Jon
