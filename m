From: Roger Quadros <ext-roger.quadros@nokia.com>
Subject: Re: Smart Reflex pm patches causes a kernel panic
Date: Tue, 19 May 2009 14:48:57 +0300
Message-ID: <4A129CA9.5090804@nokia.com>
References: <95B5E119-3C65-4739-A8BA-B66486850DD4@mac.com> <1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:29703 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbZESLtq (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 May 2009 07:49:46 -0400
In-Reply-To: <1F18D6510CF0474A8C9500565A7E41A205451369C0@NOK-EUMSG-02.mgdnok.nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Tero.Kristo@nokia.com" <Tero.Kristo@nokia.com>
Cc: elvis.dowson@mac.com, khilman@deeprootsystems.com, linux-omap@vger.kernel.org

ext Tero.Kristo@nokia.com wrote:
> Hi Elvis,
> 
> I think I saw something similar last week, and it was caused by not having CONFIG_OMAP_PM_SRF enabled. The actual culprit is the marked line in sr_configure_vp():
> 
>                 vpconfig = PRM_VP1_CONFIG_ERROROFFSET |
>                         PRM_VP1_CONFIG_ERRORGAIN |
>                         PRM_VP1_CONFIG_TIMEOUTEN |
>>>>                        mpu_opps[resource_get_level("vdd1_opp")].vsel <<
>                         OMAP3430_INITVOLTAGE_SHIFT; 
> 
> SR2 has similar code a bit later.
> 
> You will also get a failure if mpu_opps[] and/or l3_opps[] is not defined at all in your board files, this null pointer exception would actually indicate a problem like that more likely.
> 
> -Tero
> 
>> -----Original Message-----
>> From: linux-omap-owner@vger.kernel.org 
>> [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of ext Elvis Dowson
>> Sent: 19 May, 2009 14:21
>> To: Kevin Hilman
>> Cc: Linux OMAP Users
>> Subject: Smart Reflex pm patches causes a kernel panic
>>
>> Hi Kevin,
>> 		  I get a kernel panic on my TI OMAP 3503 when 
>> I incorporate the SR patches. How can I trace and debug this 
>> to find the cause of this null pointer error ?
>>
>> Power Management for TI OMAP3.
>> mmc0: mmc_rescan - card ocr from io_op=0x00000000, err = -110
>> pm_dbg_init()
>> Unable to handle kernel NULL pointer dereference at virtual 
>> address 0000001e pgd = c0004000 [0000001e] *pgd=00000000 
>> Internal error: Oops: 5 [#1] PREEMPT Modules linked in:
>> CPU: 0    Not tainted  (2.6.29-omap1 #1)
>> PC is at sr_configure_vp+0x28/0x1bc
>> LR is at sr_configure_vp+0x1c/0x1bc
>> pc : [<c01055f4>]    lr : [<c01055e8>]    psr: 60000113
>> sp : cf81ff28  ip : cf81ff28  fp : cf81ff3c
>> r10: 00000000  r9 : 00000000  r8 : 00000001
>> r7 : c0012b44  r6 : 00000000  r5 : c05c8660  r4 : c05c8624
>> r3 : 00000000  r2 : 00000001  r1 : 80000113  r0 : 00000000
>> Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
>> Control: 10c5387d  Table: 80004019  DAC: 00000017 Process 
>> swapper (pid: 1, stack limit = 0xcf81e2e8)
>> Stack: (0xcf81ff28 to 0xcf820000)
>> ff20:                   c05c8660 c05c8624 cf81ff5c cf81ff40 c0012bc8  
>> c01055d8
>> ff40: 00000000 08012954 c002d9d0 c002da20 cf81ffd4 cf81ff60 
>> c00f52f8 c0012b50
>> ff60: cf81ff8c cf81ff70 c01cb9e4 c01cb6a8 cf81ff00 cf9a26e0 c01cbae4
>> cf81ff96
>> ff80: cf81ffbc cf81ff90 c014d408 c01cb970 c02fb2b4 35339600 
>> 00000031 00000000
>> ffa0: 00000192 c05d2034 00000000 00000000 cf81ffd4 c002d9d0 
>> c002da20 00000000
>> ffc0: 00000000 00000000 cf81fff4 cf81ffd8 c00083fc c00f52ac 00000000
>> 00000001
>> ffe0: 00000000 00000000 00000000 cf81fff8 c011e2b8 c0008384 
>> 0836d404 5777f140
>> Backtrace:
>> [<c01055cc>] (sr_configure_vp+0x0/0x1bc) from [<c0012bc8>]
>> (omap3_sr_init+0x84/0x114)
>>  r4:c05c8624
>> [<c0012b44>] (omap3_sr_init+0x0/0x114) from [<c00f52f8>]
>> (do_one_initcall+0x58/0x198)
>>  r5:c002da20 r4:c002d9d0
>> [<c00f52a0>] (do_one_initcall+0x0/0x198) from [<c00083fc>] 
>> (kernel_init 
>> +0x84/0xf4)
>>  r8:00000000 r7:00000000 r6:00000000 r5:c002da20 r4:c002d9d0 
>> [<c0008378>] (kernel_init+0x0/0xf4) from [<c011e2b8>] (do_exit 
>> +0x0/0x7d0)
>>  r5:00000000 r4:00000000
>> Code: eb0024a7 e59f3180 e3500000 05933000 (01d301be) ---[ end 
>> trace eadc9c7cb4a7e9eb ]--- Kernel panic - not syncing: 
>> Attempted to kill init!
>>
>>
>> I have extracted the pm patches by doing a
>>
>> git format-patch master
>>
>> on the pm branch. This generates 186 patch files, as of today.
>>
>> Since I don't know which particular patch is causing the 
>> problem, I need to fully exclude the following patch numbers 
>> to prevent the kernel panic.
>>
>> #           
>> file://omap-pm/0149-OMAP3-SR-Fix-init-voltage-on-OPP-change.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0151-OMAP3-SR-Update-VDD1-2-voltages-at-boot.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0152-OMAP3-SR-Use-sysclk-for-SR-CLKLENGTH-calc.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0153-OMAP3-SR-Disable-SR-autocomp-only-for-CORE-
>> trans.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0154-OMAP3-SR-Reset-voltage-level-on-SR-disable.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0155-OMAP3-SR-Replace-printk-s-with-pr_-calls.patch 
>> ;patch=1 \
>> #           file://omap-pm/0156-OMAP3-SR-Remove-redundant- 
>> defines.patch;patch=1 \
>> #           
>> file://omap-pm/0157-OMAP3-SR-Replace-SR_PASS-FAIL-SR_TRUE-FALSE.patch 
>> ;patch=1 \
>> #           file://omap-pm/0158-OMAP3-SR-Replace-0x1-n-with-BIT- 
>> n.patch;patch=1 \
>> #           
>> file://omap-pm/0159-OMAP3-clock-Remove-virt_vdd1-2_prcm_set.patch 
>> ;patch=1 \
>>
>> The following patches (from 167 to 186) are more recent, and 
>> no necessary to reproduce the crash above:
>>
>> #           
>> file://omap-pm/0168-OMAP3-SR-Fix-SR-driver-to-check-for-omap-pm
>> -return.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0169-OMAP3-PM-Don-t-do-unnecessary-searches-in-o
>> map_sr_.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0181-OMAP-PM-SmartReflex-has-build-dependency-on
>> -OMAP-P.patch 
>> ;patch=1 \
>> #           
>> file://omap-pm/0186-OMAP3-PM-Fix-Smartreflex-when-used-with-PM_
>> NOOP-la.patch 
>> ;patch=1 \
>>
>> Excluding the SR patches gives me a workable kernel that 
>> doesn't crash on startup.
>>
>> Best regards,
>>
>> Elvis
>> --
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-omap" in the body of a message to 
>> majordomo@vger.kernel.org More majordomo info at  
>> http://vger.kernel.org/majordomo-info.html
>> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

Elvis,

Currently Smartreflex (SR) is dependent on SRF to get OPP levels. Just make sure 
you select CONFIG_OMAP_PM_SRF when using SR. OR you can disable Smartreflex till 
this issue is fixed.

I am working on a patch that will make Smartreflex independent of SRF. I will 
post this soon.

cheers,
Roger.
