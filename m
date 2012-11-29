From: Jon Hunter <jon-hunter-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v6 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Thu, 29 Nov 2012 14:28:44 -0600
Message-ID: <50B7C57C.3070701@ti.com>
References: <1354204892-22762-1-git-send-email-zonque@gmail.com>
 <1354204892-22762-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1354204892-22762-6-git-send-email-zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: x0148406-l0cyMroinI0@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, avinashphilip-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-omap@vger.kernel.org


On 11/29/2012 10:01 AM, Daniel Mack wrote:
> This patch adds basic DT bindings for OMAP GPMC.
> 
> The actual peripherals are instantiated from child nodes within the GPMC
> node, and the only type of device that is currently supported is NAND.
> 
> Code was added to parse the generic GPMC timing parameters and some
> documentation with examples on how to use them.
> 
> Successfully tested on an AM33xx board.
> 
> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  76 +++++++++
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
>  arch/arm/mach-omap2/gpmc.c                         | 171 ++++++++++++++++++++-
>  3 files changed, 322 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> 
> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> new file mode 100644
> index 0000000..ba3d6a5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> @@ -0,0 +1,76 @@
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
> + - num-cs:		The maximum number of chip-select lines that controller
> +			can support.
> + - num-waitpins:	The maximum number of wait pins that controller can
> +			support.
> + - ranges:		Must be set up to reflect the memory layout with four
> +			integer values for each chip-select line in use:
> +
> +			   <cs-number> 0 <physical address of mapping> <size>
> +
> +			Note that this property is not currently parsed.
> +			Calculated values derived from the contents of the
> +			per-CS register GPMC_CONFIG7 (as set up by the
> +			bootloader) are used. That will change in the future,
> +			so be sure to fill the correct values here.
> +
> +Timing properties for child nodes. All are optional and default to 0.
> +
> + - gpmc,sync-clk:	Minimum clock period for synchronous mode, in picoseconds
> +
> + Chip-select signal timings corresponding to GPMC_CONFIG2:
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
> + OE signals timings corresponding to GPMC_CONFIG4:
> + - gpmc,oe-on:		Assertion time
> + - gpmc,oe-off:		Deassertion time
> +
> + Access time and cycle time timings corresponding to GPMC_CONFIG5:
> + - gpmc,page-burst-access: Multiple access word delay
> + - gpmc,access:		Start-cycle to first data valid delay
> + - gpmc,rd-cycle:	Total read cycle time
> + - gpmc,wr-cycle:	Total write cycle time
> +
> +The following are only on OMAP3430:
> + - gpmc,wr-access
> + - gpmc,wr-data-mux-bus

Actually, these are applicable to AM335x as well. I believe that the
comment should be "applicable to OMAP3+ and AM335x". The gpmc driver was
updated to set the flags for these features based upon gpmc version ID.

> +
> +
> +Example for an AM33xx board:
> +
> +	gpmc: gpmc@50000000 {
> +		compatible = "ti,gpmc";
> +		ti,hwmods = "gpmc";
> +		reg = <0x50000000 0x2000>;
> +		interrupts = <100>;
> +
> +		num-cs = <8>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0x08000000 0x10000000>; /* CS0 @addr 0x8000000, size 0x10000000 */

Nit, you have num-wait pins as a required property but not shown here in
the example.

> +
> +		/* child nodes go here */
> +	};
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> new file mode 100644
> index 0000000..58c876f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> @@ -0,0 +1,76 @@
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
> + - reg:		The CS line the peripheral is connected to
> +
> +Optional properties:
> +
> + - nand-bus-width: 		Set this numeric value to 16 if the hardware
> +				is wired that way. If not specified, a bus
> +				width of 8 is assumed.
> +
> + - ti,nand-ecc-opt:		A string setting the ECC layout to use. One of:
> +
> +		"sw"		Software method (default)
> +		"hw"		Hardware method
> +		"hw-romcode"	gpmc hamming mode method & romcode layout
> +		"bch4"		4-bit BCH ecc code
> +		"bch8"		8-bit BCH ecc code
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

Nit, good to make reg size consistent with the above example.

> +		interrupts = <100>;
> +		num-cs = <8>;
> +		num-waitpins = <8>;

Nit, AM335x only has 2 wait-pins. Number of wait-pins is typically less
than number of CS pins.

Other than these minor comments, looks good to me. Thanks for updating.

Cheers
Jon
