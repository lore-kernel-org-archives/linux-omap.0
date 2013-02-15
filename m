From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Fri, 15 Feb 2013 01:42:42 -0600
Message-ID: <511DE6F2.7040208@ti.com>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk> <5111304C.7090706@mimc.co.uk> <511134C8.8000008@ti.com> <511137CF.1090706@mimc.co.uk> <51113C74.4070607@ti.com> <51137923.4070301@mimc.co.uk> <511C007A.7080103@ti.com> <20130214101841.GA2429@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:46152 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935495Ab3BOHmy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 15 Feb 2013 02:42:54 -0500
In-Reply-To: <20130214101841.GA2429@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Cc: Mark Jackson <mpfj-list@mimc.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>


On 02/14/2013 04:18 AM, Ezequiel Garcia wrote:
> Hi Jon,
> 
> I'm working on a similar memory controller for plat-orion.
> I have a few questions about your approach.
> 
> On Wed, Feb 13, 2013 at 03:07:06PM -0600, Jon Hunter wrote:
>>
>> On 02/07/2013 03:51 AM, Mark Jackson wrote:
>>> Okay ... I have made some progress, but it's not ideal.
>>>
>>> Currently I've hacked the GPMC DT driver (gpmc_probe_dt(), etc) so it now handles setting up the
>>> chip selects and timings for NOR devices, e.g.
>>>
>>> 		gpmc: gpmc@50000000 {
>>> 			status = "okay";
>>> 			ranges = <0 0 0x08000000 0x08000000>;	/* CS0: NOR 16M */
>>
>> Is that really 16M? Looks more like 128M :-)
>>
>>> 			nor@0,0 {
>>> 				compatible = "spansion,s29gl064n90t", "cfi-flash";
>>> 				reg = <0 0 0>;
>>
>> I think that cfi-flash is expecting a length here. Here is
>> what I have ...
>>
>> +&gpmc {
>> +       ranges = <0 0 0x08000000 0x04000000>;
>> +
>> +       nor@0,0 {
>> +               compatible = "cfi-flash";
>> +               linux,mtd-name= "intel,ge28f256l18b85";
>> +               #address-cells = <1>;
>> +               #size-cells = <1>;
>> +               reg = <0 0 0x04000000>;
>> +               bank-width = <2>;
>> +
>> +               partition@0 {
>> +                       label = "bootloader";
>> +                       reg = <0 0x20000>;
>> +               };
>> +               partition@0x20000 {
>> +                       label = "params";
>> +                       reg = <0x20000 0x20000>;
>> +               };
>> +               partition@0x40000 {
>> +                       label = "kernel";
>> +                       reg = <0x40000 0x200000>;
>> +               };
>> +               partition@0x240000 {
>> +                       label = "file-system";
>> +                       reg = <0x240000 0x3dc0000>;
>> +               };
>> +       };
>>
>>> 	nor-flash@08000000 {
>>> 		compatible = "spansion,s29gl064n90t", "cfi-flash";
>>> 		reg = <0x08000000 0x00800000>;
>>> 		bank-width = <2>;
>>> 	};
>>
>> You don't need this extra entry if you add "simple-bus" to
>> the gpmc node compatible string.
>>
> 
> That would be nice. However, I wonder what happens if cfi-flash probing
> fails: will the gpmc cs request by undone? See below...
> 
>> +               gpmc: gpmc@6800a000 {
>> +                       compatible = "ti,omap2420-gpmc", "simple-bus";
>> +                       ti,hwmods = "gpmc";
>> +                       reg = <0x6800a000 0x1000>;
>> +                       interrupts = <20>;
>> +
>> +                       gpmc,num-cs = <8>;
>> +                       gpmc,num-waitpins = <4>;
>> +                       #address-cells = <2>;
>> +                       #size-cells = <1>;
>> +               };
>>
>> Currently I have the following and this is working for me. 
>> Please note that on my board the bootloader is configuring
>> the timings for me and so this is missing from the below
>> implementation and still needs to be added.
>>
>> Cheers
>> Jon
>>
>> From c0ede833fad704ab452b116154177e3a59166c7e Mon Sep 17 00:00:00 2001
>> From: Jon Hunter <jon-hunter@ti.com>
>> Date: Fri, 8 Feb 2013 16:46:13 -0600
>> Subject: [PATCH] ARM: OMAP2+: Add device-tree support for NOR flash
>>
>> ---
>>  arch/arm/mach-omap2/gpmc.c |   69 ++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 69 insertions(+)
>>
>> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
>> index bc90155..421320b 100644
>> --- a/arch/arm/mach-omap2/gpmc.c
>> +++ b/arch/arm/mach-omap2/gpmc.c
>> @@ -26,6 +26,7 @@
>>  #include <linux/interrupt.h>
>>  #include <linux/platform_device.h>
>>  #include <linux/of.h>
>> +#include <linux/of_address.h>
>>  #include <linux/of_mtd.h>
>>  #include <linux/of_device.h>
>>  #include <linux/mtd/nand.h>
>> @@ -517,6 +518,26 @@ static int gpmc_cs_delete_mem(int cs)
>>  	return r;
>>  }
>>  
>> +static int gpmc_cs_remap(int cs, u32 base)
>> +{
>> +	int r;
>> +	u32 old_base, size;
>> +
>> +	gpmc_cs_get_memconf(cs, &old_base, &size);
>> +	if (base == old_base)
>> +		return 0;
>> +	gpmc_cs_disable_mem(cs);
>> +	r = gpmc_cs_delete_mem(cs);
>> +	if (IS_ERR_VALUE(r))
>> +		return r;
>> +	r = gpmc_cs_insert_mem(cs, base, size);
>> +	if (IS_ERR_VALUE(r))
>> +		return r;
>> +	gpmc_cs_enable_mem(cs, base, size);
>> +
>> +	return 0;
>> +}
>> +
>>  int gpmc_cs_request(int cs, unsigned long size, unsigned long *base)
>>  {
>>  	struct resource *res = &gpmc_cs_mem[cs];
>> @@ -1305,6 +1326,45 @@ static int gpmc_probe_onenand_child(struct platform_device *pdev,
>>  }
>>  #endif
>>  
>> +static int gpmc_probe_nor_child(struct platform_device *pdev,si
>> +				struct device_node *child)
>> +{
>> +	struct resource res;
>> +	unsigned long base;
>> +	int rc, cs;
>> +
>> +	if (of_property_read_u32(child, "reg", &cs) < 0) {
>> +		dev_err(&pdev->dev, "%s has no 'reg' property\n",
>> +			child->full_name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (of_address_to_resource(child, 0, &res)) {
>> +		dev_err(&pdev->dev, "%s has malformed 'reg' property\n",
>> +			child->full_name);
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = gpmc_cs_request(cs, res.end - res.start, &base);
>> +	if (rc < 0)
>> +		pr_err("%s: cannot request GPMC CS %d\n", __func__, cs);
> 
> gpmc_cs_request will request a memory region from the resource allocator
> using allocate_resource().
> How will this be released in case cfi-flash probe fails?
> 
> IMHO, this works fine currently for NAND and OneNAND because we register
> the platform device explicitly and, thus, know if that fails.

You are correct it would not be freed. However, the nice thing about
this approach is that all the nor info (name, bus-width, etc) is kept in
the dts file and we don't need to keep this in some platform code.

For argument sake, although I agree that if the cfi-flash probe fails
ideally we should free the CS, is this really a problem? This is not a
hot-pluggable bus and so even if we do not free the CS, there is no one
else that would be using it. Ok there is also memory space reserved too
but that should not impact other devices either.

I don't really have strong feelings on this either way, but it does seem
nice to minimise the amount of platform data in the mach-omap2 directory.

Cheers
Jon
