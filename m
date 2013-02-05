From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: DT GPMC SRAM and NOR flash support ?
Date: Tue, 5 Feb 2013 11:08:04 -0600
Message-ID: <51113C74.4070607@ti.com>
References: <510BF3D3.3000304@mimc.co.uk> <510BF766.5090608@ti.com> <510C19FC.8090906@mimc.co.uk> <5111304C.7090706@mimc.co.uk> <511134C8.8000008@ti.com> <511137CF.1090706@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:34299 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755372Ab3BERIH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 5 Feb 2013 12:08:07 -0500
In-Reply-To: <511137CF.1090706@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Afzal Mohammed <afzal@ti.com>


On 02/05/2013 10:48 AM, Mark Jackson wrote:
> On 05/02/13 16:35, Jon Hunter wrote:
>>
>> On 02/05/2013 10:16 AM, Mark Jackson wrote:
>>> On 01/02/13 19:39, Mark Jackson wrote:
>>>> On 01/02/13 17:12, Jon Hunter wrote:
>>>>> Hi Mark,
>>>>>
>>>>> On 02/01/2013 10:56 AM, Mark Jackson wrote:
>>>>>> There's plenty of DT support going in for NAND flash, but is there any work going on to support NOR
>>>>>> flash ?
>>>>>
>>>>> What board and device are you working that is using NOR? I have a
>>>>> OMAP2420 H4 with NOR that I have been doing a bit of maintenance for but
>>>>> I don't spend much time on it. Eventually it will have to be done but it
>>>>> is always good to know if there is a pressing need.
>>>>
>>>> We have a custom AM335x CPU board (arriving on my desk within the next few weeks) that has both NAND
>>>> and NOR Flash.
>>>>
>>>>>> And how about SRAM chips or other memory mapped devices ?
>>>>>
>>>>> Not sure about SRAM (trying to think if I have a board with SRAM even),
>>>>> but definitely, boards using the GPMC to interface to ethernet chips
>>>>> need to be added.
>>>>
>>>> The board also contains an FRAM chip (which is just treated as SRAM).
>>>>
>>>> If you'd anything in the pipeline, I'm glad to help in any testing. I've created a custom cape board
>>>> for the BeagleBone which contains the NOR flash and FRAM chips, so I'm not waiting for the new
>>>> hardware to arrive.
>>
>> Sorry for the delay. I personally don't have anything in the pipe.
>>
>> Afzal, do you know of anyone looking at this?
>>
>>> I've experimented with trying to add a mtd-physmap device, but no joy.
>>>
>>> I'm guessing that the current mtd-physmap code is (in some way) currently incompatible with the GPMC
>>> device ?
>>
>> I am not familiar with mtd-physmap to comment. Is that DT specific?
> 
> Well, it's documented in Documentation/devicetree/bindings/mtd/mtd-physmap.txt, showing you can
> specify "cfi-flash" or "mtd-ram" devices, eg (taken from mtd-physmap.txt):-
> 
> 	flash@ff000000 {
> 		compatible = "amd,am29lv128ml", "cfi-flash";
> 		reg = <ff000000 01000000>;
> 		bank-width = <4>;
> 		device-width = <1>;
> 		#address-cells = <1>;
> 		#size-cells = <1>;
> 		fs@0 {
> 			label = "fs";
> 			reg = <0 f80000>;
> 		};
> 		firmware@f80000 {
> 			label ="firmware";
> 			reg = <f80000 80000>;
> 			read-only;
> 		};
> 	};
> 
> 	sram@2,0 {
> 		compatible = "samsung,k6f1616u6a", "mtd-ram";
> 		reg = <2 0 0x00200000>;
> 		bank-width = <2>;
> 	};

Ok, I see that the NOR flash on my omap2420 H4 is named "physmap-flash"
(I have not ported to DT yet). So the GPMC should work with it.

> But I guess the GPMC needs to be configured to enable chip selects, data widths, etc.

Exactly.

> I did get *something* on the address / data bus by adding the patches below, but I'm getting bus
> contention, so something else needs setting up in the GPMC.
> 
> I'm no great device driver writer, but if anyone can give me some pointers, I'm happy to keep digging.
> 
> Cheers
> Mark J.
> 
> diff --git a/arch/arm/mach-omap2/gpmc.c b/arch/arm/mach-omap2/gpmc.c
> index a37e1c9..8f45d18 100644
> --- a/arch/arm/mach-omap2/gpmc.c
> +++ b/arch/arm/mach-omap2/gpmc.c
> @@ -1265,10 +1265,13 @@ static int gpmc_probe_dt(struct platform_device *pdev)
>         struct device_node *child;
>         const struct of_device_id *of_id =
>                 of_match_device(gpmc_dt_ids, &pdev->dev);
> +       unsigned long base;
> 
>         if (!of_id)
>                 return 0;
> 
> +       gpmc_cs_request(0, SZ_16M, &base);
> +

You should check what gpmc_cs_request returns.

Where are the NOR flash timings setup? Or are they already configured by
the bootloader? If so then that is probably ok for now.

>         for_each_node_by_name(child, "nand") {
>                 ret = gpmc_probe_nand_child(pdev, child);
>                 of_node_put(child);

If you look at the gpmc_probe_nand_child(), this function is setting up
the NAND timings for the GPMC.

Ideally, we would have a similar function for nor (ie.
gpmc_probe_nor_child()), that would read the NOR information
(chip-select, size, timings, etc) from DT. However, I understand that
the above is just for test purposes.

Cheers
Jon
