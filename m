From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2 4/4] ARM: OMAP: gpmc: add DT bindings for GPMC timings
 and NAND
Date: Fri, 02 Nov 2012 12:14:28 +0100
Message-ID: <5093AB14.9090402@gmail.com>
References: <1351794970-14675-1-git-send-email-zonque@gmail.com> <1351794970-14675-5-git-send-email-zonque@gmail.com> <5093A36B.70101@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:44279 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762691Ab2KBLPB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 2 Nov 2012 07:15:01 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1337004bkc.19
        for <linux-omap@vger.kernel.org>; Fri, 02 Nov 2012 04:14:59 -0700 (PDT)
In-Reply-To: <5093A36B.70101@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, robherring2@gmail.com, linux-omap@vger.kernel.org, x0148406@ti.com, tony@atomide.com, paul@pwsan.com, nsekhar@ti.com

Hi Jon,

as all comments so far focussed on patch 4/4, could we agree to merge
1-3 of this series already? These are all small and straight-forward
things that don't depend on 4/4. That way, I only need to resend the
last one under discussion.

On 02.11.2012 11:41, Jon Hunter wrote:
> Hi Daniel,
> 
> On 11/01/2012 01:36 PM, Daniel Mack wrote:
>> This patch adds basic DT bindings for OMAP GPMC.
>>
>> The actual peripherals are instanciated from child nodes within the GPMC
>> node, and the only type of device that is currently supported is NAND.
>>
>> Code was added to parse the generic GPMC timing parameters and some
>> documentation with examples on how to use them.
>>
>> Successfully tested on an AM33xx board.
>>
>> Signed-off-by: Daniel Mack <zonque@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/bus/ti-gpmc.txt  |  73 +++++++++++
>>  .../devicetree/bindings/mtd/gpmc-nand.txt          |  61 +++++++++
>>  arch/arm/mach-omap2/gpmc.c                         | 139 +++++++++++++++++++++
>>  3 files changed, 273 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/bus/ti-gpmc.txt
>>  create mode 100644 Documentation/devicetree/bindings/mtd/gpmc-nand.txt
>>
>> diff --git a/Documentation/devicetree/bindings/bus/ti-gpmc.txt b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> new file mode 100644
>> index 0000000..6f44487
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/bus/ti-gpmc.txt
>> @@ -0,0 +1,73 @@
>> +Device tree bindings for OMAP general purpose memory controllers (GPMC)
>> +
>> +The actual devices are instantiated from the child nodes of a GPMC node.
>> +
>> +Required properties:
>> +
>> + - compatible:		Should be set to "ti,gpmc"
>> + - reg:			A resource specifier for the register space
>> +			(see the example below)
>> + - ti,hwmods:		Should be set to "ti,gpmc" until the DT transition is
>> +			completed.
>> + - #address-cells:	Must be set to 2 to allow memory address translation
>> + - #size-cells:		Must be set to 1 to allow CS address passing
>> + - ranges:		Must be set up to reflect the memory layout
>> +			Note that this property is not currently parsed.
>> +			Calculated values derived from the contents of
>> +			GPMC_CS_CONFIG7 as set up by the bootloader. That will
>> +			change in the future, so be sure to fill the correct
>> +			values here.
> 
> I still think it would be good to add number of chip-selects and
> wait-pins here.

The number of chip-selects can be derived from the ranges property.
Namely, each 4-value entry to this property maps to one chip-select. I
can try and make the more clear in the documentation.

>> +Timing properties for child nodes. All are optional and default to 0.
>> +
>> + - gpmc,sync-clk:	Minimum clock period for synchronous mode, in picoseconds
>> +
>> + Chip-select signal timings corresponding to GPMC_CS_CONFIG2:
>> + - gpmc,cs-on:		Assertion time
>> + - gpmc,cs-rd-off:	Read deassertion time
>> + - gpmc,cs-wr-off:	Write deassertion time
>> +
>> + ADV signal timings corresponding to GPMC_CONFIG3:
>> + - gpmc,adv-on:		Assertion time
>> + - gpmc,adv-rd-off:	Read deassertion time
>> + - gpmc,adv-wr-off:	Write deassertion time
> 
> Nit-pick, looks like you are mixing GPMC_CS_CONFIGx and GPMC_CONFIGx
> naming conventions in the above and below. Would be good to make this
> consistent.

Ok, but these were just copied from arch/arm/mach-omap2/gpmc.h. So it's
wrong there, too.

>> + WE signals timings corresponding to GPMC_CONFIG4:
>> + - gpmc,we-on:		Assertion time
>> + - gpmc,we-off:		Deassertion time
>> +
>> + OE signals timings corresponding to GPMC_CONFIG4
>> + - gpmc,oe-on:		Assertion time
>> + - gpmc,oe-off:		Deassertion time
>> +
>> + Access time and cycle time timings corresponding to GPMC_CONFIG5
>> + - gpmc,page-burst-access: Multiple access word delay
>> + - gpmc,access:		Start-cycle to first data valid delay
>> + - gpmc,rd-cycle:	Total read cycle time
>> + - gpmc,wr-cycle:	Total write cycle time
>> +
>> +The following are only on OMAP3430
>> + - gpmc,wr-access
>> + - gpmc,wr-data-mux-bus
>> +
>> +
>> +Example for an AM33xx board:
>> +
>> +	gpmc: gpmc@50000000 {
>> +		compatible = "ti,gpmc";
>> +		ti,hwmods = "gpmc";
>> +		reg = <0x50000000 0x2000>;
>> +		interrupt-parent = <&intc>;
> 
> We should drop interrupt-parent. We are declaring the interrupt-parent
> globally in the dts files and so no need to replicate in each individual
> binding.

Right, will remove.

>> +		interrupts = <100>;
>> +		#address-cells = <2>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0 0x08000000 0x10000000>;	/* CS0: NAND */
>> +
>> +		nand@0,0 {
>> +			reg = <0 0 0>; /* CS0, offset 0 */
> 
> The above description says that this is just the chip-select number. Are
> the other fields used here? If so, what for?

Thanks to the translation done by the 'ranges' mechanism, these just
denote the offset to the address range specified above. So they can be
left 0.

>> +			nand-bus-width = <16>;
>> +			nand-ecc-mode = "none";
> 
> I am still wondering if the above needs to be mandatory. Or if not then
> may be these should be documented as optional and if these a omitted
> then what the default configuration would be.

In my docs, I referred to Documentation/devicetree/bindings/mtd/nand.txt
which states:

- nand-ecc-mode : String, operation mode of the NAND ecc mode.
  Supported values are: "none", "soft", "hw", "hw_syndrome",
"hw_oob_first", "soft_bch".
- nand-bus-width : 8 or 16 bus width if not present 8

So ecc-mode is mandatory, even though the code currently really defaults
to 0 ("none"). nand-bus-width isn't. I don't know if it makes sense to
duplicate the Documentation here.

>> +static int gpmc_probe_dt(struct platform_device *pdev)
>> +{
>> +	u32 val;
>> +	struct device_node *child;
>> +	struct gpmc_timings gpmc_t;
>> +	const struct of_device_id *of_id =
>> +		of_match_device(gpmc_dt_ids, &pdev->dev);
>> +
>> +	if (!of_id)
>> +		return 0;
>> +
>> +	for_each_node_by_name(child, "nand") {
>> +		struct omap_nand_platform_data *gpmc_nand_data;
>> +
>> +		if (of_property_read_u32(child, "reg", &val) < 0) {
>> +			dev_err(&pdev->dev, "%s has no 'reg' property\n",
>> +				child->full_name);
>> +			continue;
>> +		}
>> +
>> +		gpmc_nand_data = devm_kzalloc(&pdev->dev,
>> +					      sizeof(*gpmc_nand_data),
>> +					      GFP_KERNEL);
>> +		if (!gpmc_nand_data) {
>> +			dev_err(&pdev->dev, "unable to allocate memory?");
>> +			return -ENOMEM;
>> +		}
>> +
>> +		gpmc_nand_data->cs = val;
>> +		gpmc_nand_data->of_node = child;
>> +
>> +		val = of_get_nand_ecc_mode(child);
>> +		if (val >= 0)
>> +			gpmc_nand_data->ecc_opt = val;
>> +
>> +		val = of_get_nand_bus_width(child);
>> +		if (val == 16)
>> +			gpmc_nand_data->devsize = NAND_BUSWIDTH_16;
> 
> Do we need any error checking here? I believe we only support 8-bit and
> 16-bit width devices and so if 16-bit is not set then we default to 8-bit.

Yes, that's that the code does. If val != 16, ->devsize is left set to 0
(from kzalloc). There is no NAND_BUSWIDTH_8, so I think that should be ok?

>> +
>> +		gpmc_read_timings_dt(child, &gpmc_t);
>> +		gpmc_nand_init(gpmc_nand_data, &gpmc_t);
> 
> I believe that you need an "of_node_put()" when you are done with the child.

Good point.


Thanks,
Daniel

