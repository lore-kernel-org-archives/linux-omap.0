From: Koen Kooi <koen@dominion.thruhere.net>
Subject: Re: [PATCH v3 4/4] arm/dts: Add tps65217 regulator DT data to am335x-bone.dts
Date: Wed, 5 Sep 2012 15:29:30 +0200
Message-ID: <E6F8A61B-A1E9-4B69-88CD-4ECFDC779079@dominion.thruhere.net>
References: <1345547850-29761-1-git-send-email-anilkumar@ti.com> <1345547850-29761-5-git-send-email-anilkumar@ti.com> <A823657F-0D26-429F-8E1C-DF1AE5AB78F4@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA1F1D7@DBDE01.ent.ti.com> <583C0877-1C4C-46B6-A5D0-BDD34D6BB7C8@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA1F3B0@DBDE01.ent.ti.com> <6C2AC14D-1CAC-4B93-910C-B7E52D3355FD@dominion.thruhere.net> <45D5714B-BB2C-49BB-8C5D-F69749EC324A@dominion.thruhere.net> <331ABD5ECB02734CA317220B2BBEABC13EA20AA6@DBDE01.ent.ti.com>
Mime-Version: 1.0 (Mac OS X Mail 6.0 \(1486\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:61238 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298Ab2IEN3W convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 5 Sep 2012 09:29:22 -0400
Received: by weyx8 with SMTP id x8so429702wey.19
        for <linux-omap@vger.kernel.org>; Wed, 05 Sep 2012 06:29:21 -0700 (PDT)
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA20AA6@DBDE01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "AnilKumar, Chimata" <anilkumar@ti.com>
Cc: tony@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, "broonie@opensource.wolfsonmicro.com Brown" <broonie@opensource.wolfsonmicro.com>


Op 28 aug. 2012, om 07:34 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:

> Hi Koen,
> 
> On Fri, Aug 24, 2012 at 13:32:17, Koen Kooi wrote:
>> 
>> Op 24 aug. 2012, om 09:56 heeft Koen Kooi <koen@dominion.thruhere.net> het volgende geschreven:
>> 
>>> 
>>> Op 24 aug. 2012, om 09:26 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
>>> 
>>>> Hi Koen,
>>>> 
>>>> On Fri, Aug 24, 2012 at 11:58:34, Koen Kooi wrote:
>>>>> 
>>>>> Op 24 aug. 2012, om 07:50 heeft "AnilKumar, Chimata" <anilkumar@ti.com> het volgende geschreven:
>>>>> 
>>>>>> Hi Koen,
>>>>>> 
>>>>>> On Thu, Aug 23, 2012 at 19:43:48, Koen Kooi wrote:
>>>>>>> 
>>>>>>> Op 21 aug. 2012, om 13:17 heeft AnilKumar Ch <anilkumar@ti.com> het volgende geschreven:
>>>>>>> 
>>>>>>>> Add tps65217 regulator device tree data to AM335x-Bone by adding
>>>>>>>> regulator consumers with tightened constraints and regulator-name.
>>>>>>>> TPS65217 regulator handle can be obtained by using this regulator
>>>>>>>> name.
>>>>>>>> 
>>>>>>>> This patch also add I2C node with I2C frequency and tps65217 PMIC
>>>>>>>> I2C slave address.
>>>>>>>> 
>>>>>>>> Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
>>>>>>> 
>>>>>>> I tried this and the kernel immediately crashes on my beaglebone. Could you upload the complete git tree and .config you used to test this to somewhere public please?
>>>>>> 
>>>>>> Use this repo to test on beaglebone
>>>>>> https://github.com/hvaibhav/am335x-linux/commits/am335x-upstream-staging-pinctrl
>>>>>> 
>>>>>> This wiki talks about how to build and use?
>>>>>> https://github.com/hvaibhav/am335x-linux/wiki/How-To-Use-Upstream-Tree
>>>>>> 
>>>>>> Note: Enable tps65217 regulator in kernel config.
>>>>> 
>>>>> I used that repo and as a seperate test I rebased that to latest mainline, same thing: as soon as I turn on the TPS in the .config it crashes on boot. Is the pinctrl repo the *exact* repo you used to test the patches on beaglebone?
>>>> 
>>>> I tested on latest mainline after merging to
>>>> am335x-upstream-staging-pinctrl (voltage also changing)
>>>> 
>>>> Can you share your .config and uImage?
>>> 
>>> Config: https://github.com/beagleboard/kernel/blob/beaglebone-3.6/patches/configs/beaglebone
>>> 
>>>> My config details:- (After merge)
>>>> 1. omap2plus_defconfig
>>>> 2. Enable tps65217 MFD driver
>>>> 3. Enable tps65217 regulator driver
>>> 
>>> 
>>> I rebased onto latest mainline and refreshed the base patches from Vaibhav and I now get: 
>>> 
>>> [    0.246796] tps65217 0-0024: TPS65217 ID 0xf version 1.1
>>> 
>>> So it boots! I don't know what made it break before, but it's working now :)
>> 
>> *sigh* I'm an idiot:
>> 
>> root@beaglebone:~# uname -a
>> Linux beaglebone 3.6.0-rc3-00103-gfd02083 #86 SMP Fri Aug 24 09:45:54 CEST 2012 armv7l GNU/Linux
>> root@beaglebone:~# zcat /proc/config.gz | grep 217
>> CONFIG_MFD_TPS65217=y
>> # CONFIG_REGULATOR_TPS65217 is not set
>> 
>> Will retry with regulator driver actually turned on in a bit.
> 
> Is it working after enabling the regulator?

It took me a while to get back to this problem, but it still isn't working for me. I did manage to get more info on the error:

root@bone-mainline:~# insmod tps65217-regulator.ko
[   32.754419] Unable to handle kernel NULL pointer dereference at virtual address 000000c8
[   32.763087] pgd = cea60000
[   32.765969] [000000c8] *pgd=8fbed831, *pte=00000000, *ppte=00000000
[   32.772617] Internal error: Oops: 17 [#1] SMP THUMB2
[   32.777827] Modules linked in: tps65217_regulator(+) ip_tables x_tables snd_soc_omap snd_soc_core regmap_spi snd_pcm snd_timer snd soundcore snd_page_alloc ipv6
[   32.792976] CPU: 0    Not tainted  (3.6.0-rc4 #109)
[   32.798106] PC is at regmap_read+0x8/0x38
[   32.802315] LR is at regulator_get_voltage_sel_regmap+0x15/0x38
[   32.808525] pc : [<c0233c8c>]    lr : [<c0208619>]    psr: 60000033
[   32.808525] sp : ceb2fd20  ip : 00000000  fp : c0ba6168
[   32.820565] r10: c0619fac  r9 : cf926840  r8 : cf0278b0
[   32.826045] r7 : cf92c008  r6 : cf115d40  r5 : 0000000e  r4 : 00000000
[   32.832892] r3 : bf946440  r2 : ceb2fd34  r1 : 0000000e  r0 : 0000000e
[   32.839740] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA Thumb  Segment user
[   32.847406] Control: 50c5387d  Table: 8ea60019  DAC: 00000015
[   32.853431] Process insmod (pid: 176, stack limit = 0xceb2e2f8)
[   32.859638] Stack: (0xceb2fd20 to 0xceb30000)
[   32.864214] fd20: cf027800 bf946440 cf115d40 c0208619 00000001 c00a59b1 cf027800 c0206cc3
[   32.872796] fd40: cf027800 c0209d65 c00fefcb 00000000 c0626ef0 ceb2fd7c cf027810 00000000
[   32.881379] fd60: 00000000 c00fefcb c0379721 ceb28b40 00000001 c061bf74 60000013 00000000
[   32.889961] fd80: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   32.898542] fda0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[   32.907128] fdc0: 00000000 00000000 00000000 00000000 cf072950 00000044 cf92c008 c0db8fd0
[   32.915712] fde0: bf946440 bf948001 00000028 00000030 000003fb bf946397 cf92c008 cf926840
[   32.924296] fe00: cf92c410 c0db8fd0 00000000 00000000 00000000 00000000 bf946768 cf92c008
[   32.932878] fe20: c0baa0b0 c0baa0c0 bf946768 c022af2b c022af19 c022a30d 00000000 cf92c008
[   32.941460] fe40: bf946768 cf92c03c 00000000 bf948001 00000028 c022a49d bf946768 c022a44d
[   32.950041] fe60: 00000000 c0229375 cf81a0a8 cf926810 bf946768 c062d2d8 cea25dc0 c0229cf1
[   32.958623] fe80: bf94665c bf946768 bf946768 bf946854 ceb2e000 00000000 bf948001 c022a839
[   32.967204] fea0: 00000000 c0648640 bf946854 ceb2e000 00000000 bf948001 00000028 bf948009
[   32.975787] fec0: 00000000 c00085ed bf946854 c0047b4b 00000000 cd8fa780 cf8001c0 00000000
[   32.984367] fee0: bf94689c bf946854 00000001 ceb4ef00 00000001 00000030 000003fb c006c94b
[   32.992947] ff00: bf946860 00007fff c006bd2d c0008311 00000002 c0b6bff4 bf9469a8 ceb2e000
[   33.001527] ff20: 00012008 00012008 d0e80000 00019f6b d0e93310 d0e9308b d0e99b70 000009bc
[   33.010108] ff40: 00000c2c 00000000 00000000 0000003b 0000003c 00000021 0000001e 0000001c
[   33.018687] ff60: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 c052ba38
[   33.027267] ff80: 00008a28 00008a28 00012008 bede2eb0 00000080 c000cac4 ceb2e000 00000000
[   33.035844] ffa0: 00000000 c000c921 00008a28 00012008 00012018 00019f6b 00012008 b6f5f248
[   33.044426] ffc0: 00008a28 00012008 bede2eb0 00000080 00020000 00000000 00000003 00000000
[   33.053004] ffe0: 00019f6b bede2c3c 00008c9c b6efd654 60000010 00012018 0070756b 000193fe
[   33.061592] [<c0233c8c>] (regmap_read+0x8/0x38) from [<c0208619>] (regulator_get_voltage_sel_regmap+0x15/0x38)
[   33.072101] [<c0208619>] (regulator_get_voltage_sel_regmap+0x15/0x38) from [<c0206cc3>] (_regulator_get_voltage+0xf/0x40)
[   33.083604] [<c0206cc3>] (_regulator_get_voltage+0xf/0x40) from [<c0209d65>] (regulator_register+0x471/0xe98)
[   33.094028] [<c0209d65>] (regulator_register+0x471/0xe98) from [<bf946397>] (tps65217_regulator_probe+0x5a/0x74 [tps65217_regulator])
[   33.106640] [<bf946397>] (tps65217_regulator_probe+0x5a/0x74 [tps65217_regulator]) from [<c022af2b>] (platform_drv_probe+0x13/0x14)
[   33.119053] [<c022af2b>] (platform_drv_probe+0x13/0x14) from [<c022a30d>] (driver_probe_device+0x69/0x1a8)
[   33.129187] [<c022a30d>] (driver_probe_device+0x69/0x1a8) from [<c022a49d>] (__driver_attach+0x51/0x54)
[   33.139047] [<c022a49d>] (__driver_attach+0x51/0x54) from [<c0229375>] (bus_for_each_dev+0x29/0x44)
[   33.148544] [<c0229375>] (bus_for_each_dev+0x29/0x44) from [<c0229cf1>] (bus_add_driver+0x7d/0x194)
[   33.158039] [<c0229cf1>] (bus_add_driver+0x7d/0x194) from [<c022a839>] (driver_register+0x3d/0xc8)
[   33.167448] [<c022a839>] (driver_register+0x3d/0xc8) from [<bf948009>] (tps65217_regulator_init+0x8/0xf [tps65217_regulator])
[   33.179320] [<bf948009>] (tps65217_regulator_init+0x8/0xf [tps65217_regulator]) from [<c00085ed>] (do_one_initcall+0x25/0x11c)
[   33.191279] [<c00085ed>] (do_one_initcall+0x25/0x11c) from [<c006c94b>] (sys_init_module+0x9b/0x13bc)
[   33.200961] [<c006c94b>] (sys_init_module+0x9b/0x13bc) from [<c000c921>] (ret_fast_syscall+0x1/0x50)
[   33.210542] Code: b570 4604 460d 4608 (f8d4) 10c8 
[   33.215917] ---[ end trace 59e3bd0a3e19dc28 ]---
Segmentation fault

That's linus' tree + devel-dt + vaibhav am335x base patches.