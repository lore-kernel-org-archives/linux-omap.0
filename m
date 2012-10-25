From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 4/4] OMAP: mtd: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Wed, 24 Oct 2012 20:53:54 -0500
Message-ID: <50889BB2.3090107@ti.com>
References: <1350935758-9215-1-git-send-email-zonque@gmail.com> <1350935758-9215-5-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:49582 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759190Ab2JYByO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 24 Oct 2012 21:54:14 -0400
In-Reply-To: <1350935758-9215-5-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com


On 10/22/2012 02:55 PM, Daniel Mack wrote:
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
>  Documentation/devicetree/bindings/bus/gpmc.txt     |  59 +++++++++
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  65 ++++++++++
>  arch/arm/mach-omap2/gpmc.c                         | 139 +++++++++++++++++++++
>  3 files changed, 263 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/gpmc.txt b/Documentation/devicetree/bindings/bus/gpmc.txt
> new file mode 100644
> index 0000000..ef1c6e1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/gpmc.txt
> @@ -0,0 +1,59 @@
> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
> +
> +The actual devices are instantiated from the child nodes of a GPMC node.
> +
> +Required properties:
> +
> + - compatible: Should be set to "ti,gpmc"
> +
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
> +		reg = <0x50000000 0x1000000>;

Nit-pick, that size is quite large for a register range. I recommend
looking at the HWMOD data file
(arch/arm/mach-omap2/omap_hwmod_33xx_data.c) and see how much space is
allocated for the registers (see structure am33xx_gpmc_addr_space).

Cheers
Jon
