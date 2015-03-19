From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 00/35] ARM: OMAP2+: PRCM / SCM cleanups against 4.0-rc1
Date: Thu, 19 Mar 2015 09:48:13 +0200
Message-ID: <550A7F3D.3090602@ti.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com> <20150318220702.GA31346@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38522 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750778AbbCSHsk (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 03:48:40 -0400
In-Reply-To: <20150318220702.GA31346@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

On 03/19/2015 12:07 AM, Tony Lindgren wrote:
> * Tero Kristo <t-kristo@ti.com> [150318 07:45]:
>> Hi,
>>
>> Changes in this set compared to v3:
>>
>> - Changed the SCM module DT node layout based on comments from Tony;
>>    basically the wkup / core are split into their own nodes now. This
>>    applies for omap3, omap4, omap5 and dra7, rest of the SoCs have their
>>    control module integrated as one instance (Patch 26, 30, 33, 34)
>> - Changed the tisyscon node name to scm_conf. This name is more
>>    descriptive for the purpose being used, scm_conf was already used
>>    as an alias (Patch 24, 25, 27, 29)
>> - Rest of the patches have no changes compared to v3.
>>
>> Testing done:
>> - am335x-evm      : boot
>> - am335x-evmsk    : boot
>> - am3517-evm      : boot
>> - am43x-epos-evm  : boot
>> - am437x-gp-evm   : boot
>> - omap3-beagle-xm : boot
>> - omap3-beagle    : boot, suspend-resume (ret/off), cpuidle (ret/off)
>> - am335x-boneblack: boot
>> - am335x-bone     : boot
>> - dra7xx-evm      : boot
>> - omap3-n900      : boot
>> - omap5-uevm      : boot
>> - omap4-panda-es  : boot, suspend-resume (ret), cpuidle (ret)
>> - omap4-panda     : boot
>> - omap2430-sdp    : boot
>> - omap3430-sdp    : boot
>> - omap4-sdp-es23plus: boot
>>
>> Test branch pushed at:
>> - tree: https://github.com/t-kristo/linux-pm.git
>> - branch: 4.0-rc1-prcm-cleanup-v4
>
> Boots for me also for 2430-sdp.
>
> But for dm8168-evm, it fails early on, see below.

Yea seems I forgot to add dm81x support properly. Try this diff:

diff --git a/arch/arm/mach-omap2/cm_common.c 
b/arch/arm/mach-omap2/cm_common.c
index 2582651..23559aa 100644
--- a/arch/arm/mach-omap2/cm_common.c
+++ b/arch/arm/mach-omap2/cm_common.c
@@ -271,6 +271,8 @@ static const struct of_device_id 
omap_cm_dt_match_table[] __initconst = {
  	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
  	{ .compatible = "ti,am3-prcm", .data = &am3_prcm_data },
  	{ .compatible = "ti,am4-prcm", .data = &am4_prcm_data },
+	{ .compatible = "ti,dm814-prcm", .data = &am3_prcm_data },
+	{ .compatible = "ti,dm816-prcm", .data = &am3_prcm_data },
  	{ }
  };



>
> Regards,
>
> Tony
>
> [    0.000000] TI816X ES1.1 (neon )
> [    0.000000] Unable to handle kernel NULL pointer dereference at virtual address 00000514
> [    0.000000] pgd = c0004000
> [    0.000000] [00000514] *pgd=00000000
> [    0.000000] Internal error: Oops: 5 [#1] SMP ARM
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted 4.0.0-rc4-next-20150318-00040-gc5b9bf4 #291
> [    0.000000] Hardware name: Generic ti816x (Flattened Device Tree)
> [    0.000000] task: c08c2048 ti: c08bc000 task.ti: c08bc000
> [    0.000000] PC is at am33xx_clkdm_wakeup+0x18/0x3c
> [    0.000000] LR is at clkdm_wakeup_nolock+0x48/0x68
> [    0.000000] pc : [<c0030f4c>]    lr : [<c0033918>]    psr: a0000193
> [    0.000000] sp : c08bdf30  ip : c094f528  fp : c076d94c
> [    0.000000] r10: 80000200  r9 : c08c38dc  r8 : c08c38dc
> [    0.000000] r7 : c112d444  r6 : c094f69c  r5 : c08cdba8  r4 : c08cf1c8
> [    0.000000] r3 : 00000014  r2 : 00000514  r1 : 00000514  r0 : c08cf1c8
> [    0.000000] Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
> [    0.000000] Control: 10c5387d  Table: 80004019  DAC: 00000015
> [    0.000000] Process swapper (pid: 0, stack limit = 0xc08bc218)
> [    0.000000] Stack: (0xc08bdf30 to 0xc08be000)
> [    0.000000] df20:                                     c08c2048 c08cf1c8 c08cdba8 c0033950
> [    0.000000] df40: 00000003 c08cf1c8 c08cdba8 c0033b18 c089df40 2f800000 c08c1d0c c0859fb8
> [    0.000000] df60: c0859f8c c08544a8 c08bdf78 c08bdf88 c094e8c0 ef7fce80 00000000 00000000
> [    0.000000] df80: 00000000 c094e780 00000000 00000000 c076bdb0 c08bdfb4 00000000 00000000
> [    0.000000] dfa0: c094e780 ffffffff c08be8c0 00000001 00000000 c094e780 00000000 c085094c
> [    0.000000] dfc0: 00000000 00000000 00000000 00000000 00000000 c089f778 c094e994 c08be96c
> [    0.000000] dfe0: c089f774 c08c3a04 80004059 413fc082 00000000 80008074 00000000 00000000
> [    0.000000] [<c0030f4c>] (am33xx_clkdm_wakeup) from [<c0033918>] (clkdm_wakeup_nolock+0x48/0x68)
> [    0.000000] [<c0033918>] (clkdm_wakeup_nolock) from [<c0033950>] (clkdm_wakeup+0x18/0x2c)
> [    0.000000] [<c0033950>] (clkdm_wakeup) from [<c0033b18>] (clkdm_complete_init+0xb4/0xf8)
> [    0.000000] [<c0033b18>] (clkdm_complete_init) from [<c0859fb8>] (ti816x_init_early+0x2c/0x64)
> [    0.000000] [<c0859fb8>] (ti816x_init_early) from [<c08544a8>] (setup_arch+0x8d4/0x9b8)
> [    0.000000] [<c08544a8>] (setup_arch) from [<c085094c>] (start_kernel+0x98/0x3e8)
> [    0.000000] [<c085094c>] (start_kernel) from [<80008074>] (0x80008074)
> [    0.000000] Code: e1d010be e59c2000 e0831001 e0822001 (e5923000)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
> [    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task!
>

