From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv4 00/35] ARM: OMAP2+: PRCM / SCM cleanups against 4.0-rc1
Date: Thu, 19 Mar 2015 09:10:34 -0700
Message-ID: <20150319161034.GF31346@atomide.com>
References: <1426689860-17537-1-git-send-email-t-kristo@ti.com>
 <20150318220702.GA31346@atomide.com>
 <550A7F3D.3090602@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:38632 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751996AbbCSQPP (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Mar 2015 12:15:15 -0400
Content-Disposition: inline
In-Reply-To: <550A7F3D.3090602@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [150319 00:48]:
> On 03/19/2015 12:07 AM, Tony Lindgren wrote:
> >
> >But for dm8168-evm, it fails early on, see below.
> 
> Yea seems I forgot to add dm81x support properly. Try this diff:
> 
> diff --git a/arch/arm/mach-omap2/cm_common.c
> b/arch/arm/mach-omap2/cm_common.c
> index 2582651..23559aa 100644
> --- a/arch/arm/mach-omap2/cm_common.c
> +++ b/arch/arm/mach-omap2/cm_common.c
> @@ -271,6 +271,8 @@ static const struct of_device_id
> omap_cm_dt_match_table[] __initconst = {
>  	{ .compatible = "ti,dra7-cm-core", .data = &cm2_data },
>  	{ .compatible = "ti,am3-prcm", .data = &am3_prcm_data },
>  	{ .compatible = "ti,am4-prcm", .data = &am4_prcm_data },
> +	{ .compatible = "ti,dm814-prcm", .data = &am3_prcm_data },
> +	{ .compatible = "ti,dm816-prcm", .data = &am3_prcm_data },
>  	{ }
>  };

Boots a bit further now with that, but then produces:

...
[    0.278020] omap_hwmod: tptc0 using broken dt data from edma
[    0.284133] omap_hwmod: tptc1 using broken dt data from edma
[    0.290207] omap_hwmod: tptc2 using broken dt data from edma
[    0.296307] omap_hwmod: tptc3 using broken dt data from edma
[    0.305359] clocksource jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.317206] pinctrl core: initialized pinctrl subsystem
[    0.339667] NET: Registered protocol family 16
[    0.349174] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.358130] cpuidle: using governor ladder
[    0.362433] cpuidle: using governor menu
[    0.366948] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[    0.375364] pgd = c0004000
[    0.378223] [00000040] *pgd=00000000
[    0.381983] Internal error: Oops: 5 [#1] SMP ARM
[    0.386803] Modules linked in:
[    0.390026] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.0.0-rc4-next-20150318-00040-gc5b9bf4-dirty #305
[    0.399743] Hardware name: Generic ti816x (Flattened Device Tree)
[    0.406078] task: ed894b80 ti: ed896000 task.ti: ed896000
[    0.411704] PC is at omap_ctrl_readl+0x48/0x58
[    0.416347] LR is at omap_type.part.0+0x7c/0xd8
[    0.421078] pc : [<c0023d60>]    lr : [<c0023bd4>]    psr: 60000113
[    0.421078] sp : ed897eb0  ip : 00000000  fp : c089f574
[    0.433022] r10: c0850598  r9 : c089f588  r8 : 00000000
[    0.438466] r7 : c08537ac  r6 : ed902c00  r5 : 00000000  r4 : c094f03c
[    0.445246] r3 : 00000040  r2 : c094ebcc  r1 : 00000000  r0 : 00000040
[    0.452025] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.459605] Control: 10c5387d  Table: 80004019  DAC: 00000015
[    0.465581] Process swapper/0 (pid: 1, stack limit = 0xed896218)
[    0.471825] Stack: (0xed897eb0 to 0xed898000)
[    0.476379] 7ea0:                                     c08c4540 c085ea18 c089df40 00000000
[    0.484854] 7ec0: 00000000 ed902c00 c08537ac c085a208 c089df40 c08a6500 c08b04c4 c0862fdc
[    0.493327] 7ee0: c089df40 c08c1e30 c08c1e30 c0862c78 c089df40 c08537c8 00000000 c0008b84
[    0.501801] 7f00: ed894b80 c08fc494 00000000 ed894b80 ed895100 00000004 00000006 00000000
[    0.510278] 7f20: 00000000 c008a2bc c0850598 ef7fc9d0 ef7fc9cb c005c784 c076c0a0 ef7fc9da
[    0.518753] 7f40: 00000003 00000003 00000000 c08b5f18 c08b5f20 00000003 c094e780 00000093
[    0.527226] 7f60: c094e780 c0850598 c089f574 c0850ea0 00000003 00000003 c0850598 ffffffff
[    0.535699] 7f80: 00000000 00000000 c05d2ca8 00000000 00000000 00000000 00000000 00000000
[    0.544174] 7fa0: 00000000 c05d2cb0 00000000 c000e910 00000000 00000000 00000000 00000000
[    0.552649] 7fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.561122] 7fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 ffffffff
[    0.569598] [<c0023d60>] (omap_ctrl_readl) from [<00000000>] (  (null))
[    0.576471] Code: e28dd00c e49df004 e5921000 e0813003 (e5930000) 
[    0.582860] ---[ end trace 00a172dd2625b740 ]---
[    0.587757] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.587757] 
[    0.597310] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.597310] 

Regards,

Tony
