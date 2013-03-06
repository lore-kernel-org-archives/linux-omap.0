From: Mark Jackson <mpfj-list@mimc.co.uk>
Subject: Re: [PATCH 11/14] ARM: OMAP2+: Add device-tree support for NOR flash
Date: Wed, 06 Mar 2013 10:23:42 +0000
Message-ID: <5137192E.1010101@mimc.co.uk>
References: <1361899842-30303-1-git-send-email-jon-hunter@ti.com> <1361899842-30303-12-git-send-email-jon-hunter@ti.com> <51360271.1030302@mimc.co.uk> <51360562.20309@ti.com> <51361B46.507@mimc.co.uk> <51362BAB.10403@ti.com> <513664EC.2050508@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mercuryimc.plus.com ([80.229.200.144]:40668 "EHLO
	centos1.newflow.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756487Ab3CFKXo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 6 Mar 2013 05:23:44 -0500
In-Reply-To: <513664EC.2050508@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Daniel Mack <zonque@gmail.com>

On 05/03/13 21:34, Jon Hunter wrote:
> 
> On 03/05/2013 11:30 AM, Jon Hunter wrote:
>> On 03/05/2013 10:20 AM, Mark Jackson wrote:
> 
> [snip]
> 
>>> But I can see in physmap_of.c that the device gets registered without any call to
>>> devm_pinctrl_get_select_default() and hence no probe deferring takes place is the
>>> pinctrl device hasn't yet been started (which it hasn't).
>>>
>>> Does probe deferral need adding to physmap_of.c, or should the pinctrl device really
>>> be registered sooner ?
>>
>> I see, so the pinctrl driver is not getting probed until later.
> 
> Can you give this version of the patch a go? I have re-worked the patch
> so the NOR device will only be registered after the GPMC probe completes.
> 
> By the way, with this version you should remove "simple-bus" from your
> gpmc node compatible strings. I now call of_platform_device_create() to
> create the child device during the GPMC probe. I think that this is a
> safer approach.

This is better in that the probe *is* now delayed until the gpmc has been setup,
but I still get an oops.

However, this time it's in the actual cfi query code.

I've traced it down to when it tries to physically access the memory associated
with the chip select in question (in this case CS3 @ 0x1a000000).

I printed some debug info to show that the GPMC CONFIG7 register is being setup
correctly, and I show the physical to virtual memory mapping values, as performed
in of_flash_probe(), but when I try to do a test raw_readw() on the virtual address,
I get the following:-

[    1.222950] omap-gpmc 50000000.gpmc: GPMC revision 6.0
[    1.229002] gpmc_read_settings_dt: read/write wait monitoring not enabled!
[    1.237916] enabling NAND BCH ecc with 8-bit correction
[    1.243843] ONFI param page 0 valid
[    1.247531] ONFI flash detected
[    1.250856] NAND device: Manufacturer ID: 0x2c, Chip ID: 0xda (Micron MT29F2G08ABAEAWP), 256MiB, page size: 2048, OOB size: 64
[    1.263149] 8 ofpart partitions found on MTD device omap2-nand.0
[    1.269492] Creating 8 MTD partitions on "omap2-nand.0":
[    1.275150] 0x000000000000-0x000000020000 : "spl1"
[    1.282593] 0x000000020000-0x000000040000 : "spl2"
[    1.288524] 0x000000040000-0x000000060000 : "spl3"
[    1.294456] 0x000000060000-0x000000080000 : "spl4"
[    1.300270] 0x000000080000-0x0000001e0000 : "boot"
[    1.307224] 0x0000001e0000-0x000000200000 : "env"
[    1.313093] 0x000000200000-0x000004200000 : "rootfs"
[    1.373589] 0x000004200000-0x000010000000 : "data"
[    1.541884] gpmc_probe_nor_child 1
[    1.545483] GPMC_CS_CONFIG7_0 : 00000f48
[    1.549621] GPMC_CS_CONFIG7_1 : 00000f58
[    1.553812] GPMC_CS_CONFIG7_2 : 00000f00
[    1.557951] GPMC_CS_CONFIG7_3 : 00000c5a
[    1.564789] of_flash_probe ioremap : phys 1a000000 -> virt d3000000
[    1.571468] of_flash_probe test read d3000000 ...
[    1.576440] Unhandled fault: external abort on non-linefetch (0x1028) at 0xd3000000
[    1.584525] Internal error: : 1028 [#1] ARM
[    1.588946] CPU: 0    Not tainted  (3.9.0-rc1-12191-ga00d6d1-dirty #57)
[    1.595943] PC is at of_flash_probe+0x22c/0x5dc
[    1.600724] LR is at of_flash_probe+0x228/0x5dc
[    1.605506] pc : [<c023b28c>]    lr : [<c023b288>]    psr: 20000113
[    1.605506] sp : cf077ba0  ip : cf06c080  fp : c0492150
[    1.617621] r10: 04000000  r9 : cf2ac6d0  r8 : 00000000
[    1.623135] r7 : cf2ac6d0  r6 : cf2b9010  r5 : cf2b9000  r4 : c0c81f60
[    1.630027] r3 : d3000000  r2 : 00000000  r1 : cf06c4d8  r0 : 00000025
[    1.636921] Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    1.644635] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    1.650703] Process kworker/u:0 (pid: 6, stack limit = 0xcf076238)
[    1.657225] Stack: (0xcf077ba0 to 0xcf078000)

Any ideas ?

Cheers
Mark J.
