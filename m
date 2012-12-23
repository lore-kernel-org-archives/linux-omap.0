From: Ezequiel Garcia <elezegarcia@gmail.com>
Subject: Re: [PATCH v8 5/5] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Sun, 23 Dec 2012 18:46:33 -0300
Message-ID: <CALF0-+UbqFF17X1Ok1s1AGKg6SBmvMc1mvjVuZb=Ej7xo+qcmA@mail.gmail.com>
References: <1355481404-27695-1-git-send-email-zonque@gmail.com>
	<1355481404-27695-6-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ia0-f173.google.com ([209.85.210.173]:57198 "EHLO
	mail-ia0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549Ab2LWVqe (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 23 Dec 2012 16:46:34 -0500
Received: by mail-ia0-f173.google.com with SMTP id w21so5518574iac.32
        for <linux-omap@vger.kernel.org>; Sun, 23 Dec 2012 13:46:33 -0800 (PST)
In-Reply-To: <1355481404-27695-6-git-send-email-zonque@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, jon-hunter@ti.com, avinashphilip@ti.com, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com, jacmet@sunsite.dk, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Javier Martinez Canillas <martinez.javier@gmail.com>, Enric Balletbo Serra <eballetbo@gmail.com>

Hi Daniel,

Nice job!

On Fri, Dec 14, 2012 at 7:36 AM, Daniel Mack <zonque@gmail.com> wrote:
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
> Signed-off-by: Daniel Mack <zonque@gmail.com>
> ---
>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  84 ++++++++++
>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  76 +++++++++
>  arch/arm/mach-omap2/gpmc.c                         | 173 +++++++++++++++++++++
>  3 files changed, 333 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>
> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> new file mode 100644
> index 0000000..5ddb2e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
> @@ -0,0 +1,84 @@
> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
> +
> +The actual devices are instantiated from the child nodes of a GPMC node.
> +
> +Required properties:
> +
> + - compatible:         Should be set to one of the following:
> +
> +                       ti,omap2420-gpmc (omap2420)
> +                       ti,omap2430-gpmc (omap2430)
> +                       ti,omap3430-gpmc (omap3430 & omap3630)
> +                       ti,omap4430-gpmc (omap4430 & omap4460 & omap543x)
> +                       ti,am3352-gpmc   (am335x devices)
> +
> + - reg:                        A resource specifier for the register space
> +                       (see the example below)
> + - ti,hwmods:          Should be set to "ti,gpmc" until the DT transition is
> +                       completed.
> + - #address-cells:     Must be set to 2 to allow memory address translation
> + - #size-cells:                Must be set to 1 to allow CS address passing
> + - gpmc,num-cs:                The maximum number of chip-select lines that controller
> +                       can support.
> + - gpmc,num-waitpins:  The maximum number of wait pins that controller can
> +                       support.
> + - ranges:             Must be set up to reflect the memory layout with four
> +                       integer values for each chip-select line in use:
> +
> +                          <cs-number> 0 <physical address of mapping> <size>
> +
> +                       Currently, calculated values derived from the contents
> +                       of the per-CS register GPMC_CONFIG7 (as set up by the
> +                       bootloader) are used for the physical address decoding.
> +                       As this will change in the future, filling correct
> +                       values here is a requirement.
> +
> +Timing properties for child nodes. All are optional and default to 0.
> +
> + - gpmc,sync-clk:      Minimum clock period for synchronous mode, in picoseconds
> +
> + Chip-select signal timings corresponding to GPMC_CONFIG2:
> + - gpmc,cs-on:         Assertion time
> + - gpmc,cs-rd-off:     Read deassertion time
> + - gpmc,cs-wr-off:     Write deassertion time
> +
> + ADV signal timings corresponding to GPMC_CONFIG3:
> + - gpmc,adv-on:                Assertion time
> + - gpmc,adv-rd-off:    Read deassertion time
> + - gpmc,adv-wr-off:    Write deassertion time
> +
> + WE signals timings corresponding to GPMC_CONFIG4:
> + - gpmc,we-on:         Assertion time
> + - gpmc,we-off:                Deassertion time
> +
> + OE signals timings corresponding to GPMC_CONFIG4:
> + - gpmc,oe-on:         Assertion time
> + - gpmc,oe-off:                Deassertion time
> +
> + Access time and cycle time timings corresponding to GPMC_CONFIG5:
> + - gpmc,page-burst-access: Multiple access word delay
> + - gpmc,access:                Start-cycle to first data valid delay
> + - gpmc,rd-cycle:      Total read cycle time
> + - gpmc,wr-cycle:      Total write cycle time
> +
> +The following are only applicable to OMAP3+ and AM335x:
> + - gpmc,wr-access
> + - gpmc,wr-data-mux-bus
> +
> +
> +Example for an AM33xx board:
> +
> +       gpmc: gpmc@50000000 {
> +               compatible = "ti,am3352-gpmc";
> +               ti,hwmods = "gpmc";
> +               reg = <0x50000000 0x2000>;
> +               interrupts = <100>;
> +
> +               gpmc,num-cs = <8>;
> +               gpmc,num-waitpins = <2>;
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               ranges = <0 0 0x08000000 0x10000000>; /* CS0 @addr 0x8000000, size 0x10000000 */
> +
> +               /* child nodes go here */
> +       };
> diff --git a/Documentation/devicetree/bindings/mtd/gpmc-nand.txt b/Documentation/devicetree/bindings/mtd/gpmc-nand.txt
> new file mode 100644
> index 0000000..9f464f9
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
> + - reg:                The CS line the peripheral is connected to
> +
> +Optional properties:
> +
> + - nand-bus-width:             Set this numeric value to 16 if the hardware
> +                               is wired that way. If not specified, a bus
> +                               width of 8 is assumed.
> +
> + - ti,nand-ecc-opt:            A string setting the ECC layout to use. One of:
> +
> +               "sw"            Software method (default)
> +               "hw"            Hardware method
> +               "hw-romcode"    gpmc hamming mode method & romcode layout
> +               "bch4"          4-bit BCH ecc code
> +               "bch8"          8-bit BCH ecc code
> +
> +For inline partiton table parsing (optional):
> +
> + - #address-cells: should be set to 1
> + - #size-cells: should be set to 1
> +
> +Example for an AM33xx board:
> +
> +       gpmc: gpmc@50000000 {
> +               compatible = "ti,am3352-gpmc";
> +               ti,hwmods = "gpmc";
> +               reg = <0x50000000 0x1000000>;
> +               interrupts = <100>;
> +               gpmc,num-cs = <8>;
> +               gpmc,num-waitpins = <2>;
> +               #address-cells = <2>;
> +               #size-cells = <1>;
> +               ranges = <0 0 0x08000000 0x2000>;       /* CS0: NAND */
> +
> +               nand@0,0 {
> +                       reg = <0 0 0>; /* CS0, offset 0 */

I'm a bit confused by this: what are the other two values in "reg"?
I see you've only added a binding for CS.

I've extended a bit on your work and added a binding to enable OneNAND
device on my IGEP board.

I might send some patches in case anyone wants to give it a try.

Thanks,

    Ezequiel
