From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH 2/2] dmaengine: OMAP: Register SDMA controller with Device
 Tree DMA driver
Date: Thu, 7 Feb 2013 18:52:14 -0600
Message-ID: <51144C3E.7070603@ti.com>
References: <1360184596-1603-1-git-send-email-jon-hunter@ti.com> <201302071439.13720.arnd@arndb.de> <5113CD6F.3060108@ti.com> <10081370.NaeII8M1Pj@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:45295 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752575Ab3BHAwd (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 7 Feb 2013 19:52:33 -0500
In-Reply-To: <10081370.NaeII8M1Pj@wuerfel>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "Ujfalusi, Peter" <peter.ujfalusi@ti.com>
Cc: linux-arm-kernel@lists.infradead.org, Matt Porter <mporter@ti.com>, Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, device-tree <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Grant Likely <grant.likely@secretlab.ca>, Vinod Koul <vinod.koul@intel.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>, Sourav Poddar <sourav.poddar@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Balaji T K <balajitk@ti.com>


On 02/07/2013 10:07 AM, Arnd Bergmann wrote:
> On Thursday 07 February 2013 09:51:11 Jon Hunter wrote:
>>>> @@ -673,7 +702,7 @@ static int omap_dma_init(void)
>>>>  {
>>>>      int rc = platform_driver_register(&omap_dma_driver);
>>>>  
>>>> -    if (rc == 0) {
>>>> +    if ((rc == 0) && (!of_have_populated_dt())) {
>>>>              pdev = platform_device_register_full(&omap_dma_dev_info);
>>>>              if (IS_ERR(pdev)) {
>>>>                      platform_driver_unregister(&omap_dma_driver);
>>>
>>> There is already a patch in linux-next that makes this obsolete.
>>> The device is now registered in arch/arm/mach-omap2/dma.c, so
>>> I guess you have to change that location now.
>>
>> Thanks. Will rebase on top of linux-next.
> 
> Actually, there is another problem with that, because then
> you may get into the situation where nobody can apply your
> patch.

Yes Tony mentioned always using a proper branch for pulls. I will base
upon his omap-for-v3.9/multiplatform-v2 (per your inputs, thanks!).
 
> You should never build work on top of linux-next, because
> then your base gets rebuilt every day. Instead, you should
> /test/ your branch merged with linux-next to ensure it works
> with all the other things in place, and when you see conflicts
> like this, you have to find out what they are and then decide
> whether you need to rebase it, and to what.

Ugh, looks like linux-next is broken for omap2+ boards at the moment
and is panic'ing in the twl i2c code ... some else to look into ...

Peter have you seen this on linux-next? I am seeing this on omap2-4 boards.

[    2.286132] Unable to handle kernel NULL pointer dereference at virtual address 00000000
[    2.294738] pgd = c0004000
[    2.297576] [00000000] *pgd=00000000
[    2.301361] Internal error: Oops: 5 [#1] SMP ARM
[    2.306243] Modules linked in:
[    2.309448] CPU: 0    Not tainted  (3.8.0-rc6-next-20130207-00016-g735c237 #35)
[    2.317169] PC is at twl_i2c_read+0x3c/0xec
[    2.321563] LR is at twl_i2c_read+0x1c/0xec
[    2.325988] pc : [<c0333950>]    lr : [<c0333930>]    psr: 80000153
[    2.325988] sp : c702fed0  ip : 00000000  fp : 00000000
[    2.338043] r10: c702e000  r9 : c06e84e8  r8 : c06e51c8
[    2.343536] r7 : 00000001  r6 : 00000006  r5 : c702fef6  r4 : 00000004
[    2.350402] r3 : c129508c  r2 : 00000006  r1 : c702fef6  r0 : 0000000e
[    2.357269] Flags: Nzcv  IRQs on  FIQs off  Mode SVC_32  ISA ARM  Segment kernel
[    2.365051] Control: 10c5387d  Table: 80004019  DAC: 00000017
[    2.371093] Process swapper/0 (pid: 1, stack limit = 0xc702e240)
[    2.377410] Stack: (0xc702fed0 to 0xc7030000)
[    2.382019] fec0:                                     c0d42180 c0d429d0 c70a7640 c07354c4
[    2.390624] fee0: 00000001 c0719798 c0d42180 c06f2cc0 c04e76cc c06ee1ac 00000000 c07354c4
[    2.399230] ff00: 00000007 c06f2d64 00000017 c06fb308 00000000 c06f07a4 c0cb8580 c06edee0
[    2.407836] ff20: c06eded4 c06e8504 c0d42180 c0008768 0000009e c00611b4 00000001 00000000
[    2.416442] ff40: c061994c c06b7548 00000007 00000007 00000000 c07354c4 00000007 c0719798
[    2.425048] ff60: c0d42180 c06e51c8 c07197a0 0000009e 00000000 c06e590c 00000007 00000007
[    2.433654] ff80: c06e51c8 00000000 00000000 c04d26ec 00000000 00000000 00000000 00000000
[    2.442260] ffa0: 00000000 c04d26f4 00000000 c00137b0 00000000 00000000 00000000 00000000
[    2.450866] ffc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    2.459472] ffe0: 00000000 00000000 00000000 00000000 00000013 00000000 80fb6c10 71bbcd20
[    2.468078] [<c0333950>] (twl_i2c_read+0x3c/0xec) from [<c06f2cc0>] (omap3_twl_set_sr_bit+0x3c/0xb4)
[    2.477722] [<c06f2cc0>] (omap3_twl_set_sr_bit+0x3c/0xb4) from [<c06f2d64>] (omap3_twl_init+0x2c/0x70)
[    2.487518] [<c06f2d64>] (omap3_twl_init+0x2c/0x70) from [<c06fb308>] (omap_pmic_late_init+0x18/0x24)
[    2.497222] [<c06fb308>] (omap_pmic_late_init+0x18/0x24) from [<c06f07a4>] (omap2_common_pm_late_init+0x18/0xd0)
[    2.507934] [<c06f07a4>] (omap2_common_pm_late_init+0x18/0xd0) from [<c06edee0>] (omap3_init_late+0xc/0x18)
[    2.518188] [<c06edee0>] (omap3_init_late+0xc/0x18) from [<c06e8504>] (init_machine_late+0x1c/0x28)
[    2.527740] [<c06e8504>] (init_machine_late+0x1c/0x28) from [<c0008768>] (do_one_initcall+0x100/0x16c)
[    2.537536] [<c0008768>] (do_one_initcall+0x100/0x16c) from [<c06e590c>] (kernel_init_freeable+0xfc/0x1c8)
[    2.547698] [<c06e590c>] (kernel_init_freeable+0xfc/0x1c8) from [<c04d26f4>] (kernel_init+0x8/0xe4)
[    2.557250] [<c04d26f4>] (kernel_init+0x8/0xe4) from [<c00137b0>] (ret_from_fork+0x14/0x24)

Cheers
Jon
