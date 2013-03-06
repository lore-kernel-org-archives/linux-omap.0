From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Wed, 6 Mar 2013 10:44:29 -0600
Message-ID: <5137726D.10702@ti.com>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <513664EC.2050508@ti.com> <5137192E.1010101@mimc.co.uk> <513744F4.7050503@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:40600 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751027Ab3CFQoo (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 6 Mar 2013 11:44:44 -0500
In-Reply-To: <513744F4.7050503@mimc.co.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mark Jackson <mpfj-list@mimc.co.uk>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>


On 03/06/2013 07:30 AM, Mark Jackson wrote:
> On 06/03/13 10:23, Mark Jackson wrote:
>> On 05/03/13 21:34, Jon Hunter wrote:
>>>
>>> On 03/05/2013 11:30 AM, Jon Hunter wrote:
>>>> On 03/05/2013 10:20 AM, Mark Jackson wrote:
>>>
>>> [snip]
>>>
>>>>> But I can see in physmap_of.c that the device gets registered without any call to
>>>>> devm_pinctrl_get_select_default() and hence no probe deferring takes place is the
>>>>> pinctrl device hasn't yet been started (which it hasn't).
>>>>>
>>>>> Does probe deferral need adding to physmap_of.c, or should the pinctrl device really
>>>>> be registered sooner ?
>>>>
>>>> I see, so the pinctrl driver is not getting probed until later.
>>>
>>> Can you give this version of the patch a go? I have re-worked the patch
>>> so the NOR device will only be registered after the GPMC probe completes.
>>>
>>> By the way, with this version you should remove "simple-bus" from your
>>> gpmc node compatible strings. I now call of_platform_device_create() to
>>> create the child device during the GPMC probe. I think that this is a
>>> safer approach.
>>
>> This is better in that the probe *is* now delayed until the gpmc has been setup,
>> but I still get an oops.
>>
>> However, this time it's in the actual cfi query code.
>>
>> I've traced it down to when it tries to physically access the memory associated
>> with the chip select in question (in this case CS3 @ 0x1a000000).
>>
>> I printed some debug info to show that the GPMC CONFIG7 register is being setup
>> correctly, and I show the physical to virtual memory mapping values, as performed
>> in of_flash_probe(), but when I try to do a test raw_readw() on the virtual address,
>> I get the following:-
>>
>> [    1.222950] omap-gpmc 50000000.gpmc: GPMC revision 6.0
>> [    1.229002] gpmc_read_settings_dt: read/write wait monitoring not enabled!
>> [    1.237916] enabling NAND BCH ecc with 8-bit correction
>> [    1.243843] ONFI param page 0 valid
>> [    1.247531] ONFI flash detected
>> [    1.250856] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08ABAEAWP), 256MiB, page size: 2048, OOB size: 64
>> [    1.263149] 8 ofpart partitions found on MTD device omap2-nand.0
>> [    1.269492] Creating 8 MTD partitions on "omap2-nand.0":
>> [    1.275150] 0x000000000000-0x000000020000 : "spl1"
>> [    1.282593] 0x000000020000-0x000000040000 : "spl2"
>> [    1.288524] 0x000000040000-0x000000060000 : "spl3"
>> [    1.294456] 0x000000060000-0x000000080000 : "spl4"
>> [    1.300270] 0x000000080000-0x0000001e0000 : "boot"
>> [    1.307224] 0x0000001e0000-0x000000200000 : "env"
>> [    1.313093] 0x000000200000-0x000004200000 : "rootfs"
>> [    1.373589] 0x000004200000-0x000010000000 : "data"
>> [    1.541884] gpmc_probe_nor_child 1
>> [    1.545483] GPMC_CS_CONFIG7_0 : 00000f48
>> [    1.549621] GPMC_CS_CONFIG7_1 : 00000f58
>> [    1.553812] GPMC_CS_CONFIG7_2 : 00000f00
>> [    1.557951] GPMC_CS_CONFIG7_3 : 00000c5a
> 
> 0x00000c5a is an invalid mode !!
> 
> I'm trying to use a 64MB address space but not on a 64MB boundary ... oops.

Good catch. So this is now working for you then?

Thanks
Jon

