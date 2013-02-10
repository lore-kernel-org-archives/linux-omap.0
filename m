From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] ARM: OMAP4: PM fixes and AESS integration for 3.9
Date: Sun, 10 Feb 2013 09:08:51 -0800
Message-ID: <20130210170849.GM4801@atomide.com>
References: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:39354 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755339Ab3BJRIy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 10 Feb 2013 12:08:54 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1302081812040.28008@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [130208 10:16]:
> Hi Tony,
> 
> The following changes since commit 88b62b915b0b7e25870eb0604ed9a92ba4bfc9f7:
> 
>   Linux 3.8-rc6 (2013-02-01 12:08:14 +1100)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending.git tags/omap-devel-d-for-3.9
> 
> for you to fetch changes up to 0d30ee5a33ae65371f935b64715aa6ca9c9972a5:
> 
>   Merge branches 'sg_aess_reset_devel_3.9' and 'omap4_pm_fixes_a_3.9' into omap4_prcm_devel_a_3.9 (2013-02-08 09:45:12 -0700)
> 
> ----------------------------------------------------------------
> 
> Some OMAP4 power management fixes and audio device integration
> patches.
> 
> Basic test logs are available at:
> 
>     http://www.pwsan.com/omap/testlogs/omap4_prcm_devel_a_3.9/20130208094531/

Looks like this branch merged into the current omap-for-v3.9/tmp-merge
at commit 4dcccca0 causes the following on my omap4 blaze:

[    0.294006] ------------[ cut here ]------------
[    0.298858] WARNING: at arch/arm/mach-omap2/omap_hwmod.c:2417 _init+0x108/0x134()
[    0.306610] omap_hwmod: aess: couldn't init clocks
[    0.311614] Modules linked in:
[    0.314880] [<c001c4e0>] (unwind_backtrace+0x0/0xf4) from [<c0046c40>] (warn_slowpath_common+0x4c/0x64)
[    0.324615] [<c0046c40>] (warn_slowpath_common+0x4c/0x64) from [<c0046cec>] (warn_slowpath_fmt+0x30/0x40)
[    0.334533] [<c0046cec>] (warn_slowpath_fmt+0x30/0x40) from [<c072d0f4>] (_init+0x108/0x134)
[    0.343292] [<c072d0f4>] (_init+0x108/0x134) from [<c002b758>] (omap_hwmod_for_each+0x50/0x64)
[    0.352233] [<c002b758>] (omap_hwmod_for_each+0x50/0x64) from [<c072d250>] (__omap_hwmod_setup_all+0x34/0x4c)
[    0.362518] [<c072d250>] (__omap_hwmod_setup_all+0x34/0x4c) from [<c0008768>] (do_one_initcall+0x2c/0x178)
[    0.372528] [<c0008768>] (do_one_initcall+0x2c/0x178) from [<c071f2a0>] (do_basic_setup+0x94/0xd0)
[    0.381805] [<c071f2a0>] (do_basic_setup+0x94/0xd0) from [<c071f358>] (kernel_init_freeable+0x7c/0x124)
[    0.391540] [<c071f358>] (kernel_init_freeable+0x7c/0x124) from [<c051474c>] (kernel_init+0xc/0x164)
[    0.401031] [<c051474c>] (kernel_init+0xc/0x164) from [<c0014310>] (ret_from_fork+0x14/0x24)
[    0.409912] ---[ end trace 1b75b31a2719ed1c ]---
[    0.414916] Unable to handle kernel NULL pointer dereference at virtual address 00000040
[    0.423309] pgd = c0004000
[    0.426177] [00000040] *pgd=00000000
[    0.429931] Internal error: Oops: 5 [#1] SMP ARM
[    0.434753] Modules linked in:
[    0.437988] CPU: 1    Tainted: G        W     (3.8.0-rc7-00331-g43ceffc #335)
[    0.445373] PC is at omap_hwmod_read+0x14/0x30
[    0.450042] LR is at dispc_disable_outputs+0x2c/0x1e8
[    0.455291] pc : [<c002b6b0>]    lr : [<c002ad48>]    psr: 40000113
[    0.455291] sp : ed839e88  ip : c065d9bc  fp : 00000000
[    0.467254] r10: c071f400  r9 : c072d21c  r8 : c07b9e08
[    0.472686] r7 : 00000003  r6 : c07b639c  r5 : 00000003  r4 : c07a1770
[    0.479461] r3 : 00000040  r2 : 0000000a  r1 : 00000040  r0 : c07b639c
[    0.486267] Flags: nZcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.493835] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    0.499816] Process swapper/0 (pid: 1, stack limit = 0xed838240)
[    0.506072] Stack: (0xed839e88 to 0xed83a000)
[    0.510620] 9e80:                   00000003 c07a1770 00000003 c07b9a78 00000003 c07b52bc
[    0.519104] 9ea0: c071f400 c002af8c 00000000 00000003 c07b52bc c07b52bc c072ce88 ed838000
[    0.527557] 9ec0: c071f400 c002d59c c07b5308 00000003 c07b5308 c072cf70 c072d21c c072d0f4
[    0.536041] 9ee0: c07b52bc c0787540 00000000 c002b758 c0757508 c0773610 c0757508 00000002
[    0.544525] 9f00: 0000009b c072d25c 00000000 c0008768 0000009b 00000001 00000001 c071f400
[    0.552978] 9f20: 00000001 00000001 0000009b c06f64d0 60000113 c0773610 c0757508 00000002
[    0.561462] 9f40: 0000009b c080eacc c07574e4 c071f400 c080eac0 c071f2a0 00000001 00000001
[    0.569946] 9f60: c071f400 00000000 00000000 c07735f0 c07735f0 00000000 00000000 00000000
[    0.578430] 9f80: 00000000 00000000 00000000 c071f358 aaaaaaaa 00000000 c0514740 c051474c
[    0.586883] 9fa0: 00000000 00000000 c0514740 c0014310 00000000 00000000 00000000 00000000
[    0.595367] 9fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.603851] 9fe0: 00000000 00000000 00000000 00000000 00000013 00000000 aabaaaaa aaaaaaaa
[    0.612335] [<c002b6b0>] (omap_hwmod_read+0x14/0x30) from [<c002ad48>] (dispc_disable_outputs+0x2c/0x1e8)
[    0.622222] [<c002ad48>] (dispc_disable_outputs+0x2c/0x1e8) from [<c002af8c>] (omap_dss_reset+0x88/0x198)
[    0.632141] [<c002af8c>] (omap_dss_reset+0x88/0x198) from [<c002d59c>] (_reset+0x20/0x11c)
[    0.640716] [<c002d59c>] (_reset+0x20/0x11c) from [<c072cf70>] (_setup+0xe8/0x164)
[    0.648559] [<c072cf70>] (_setup+0xe8/0x164) from [<c002b758>] (omap_hwmod_for_each+0x50/0x64)
[    0.657470] [<c002b758>] (omap_hwmod_for_each+0x50/0x64) from [<c072d25c>] (__omap_hwmod_setup_all+0x40/0x4c)
[    0.667755] [<c072d25c>] (__omap_hwmod_setup_all+0x40/0x4c) from [<c0008768>] (do_one_initcall+0x2c/0x178)
[    0.677734] [<c0008768>] (do_one_initcall+0x2c/0x178) from [<c071f2a0>] (do_basic_setup+0x94/0xd0)
[    0.687011] [<c071f2a0>] (do_basic_setup+0x94/0xd0) from [<c071f358>] (kernel_init_freeable+0x7c/0x124)
[    0.696746] [<c071f358>] (kernel_init_freeable+0x7c/0x124) from [<c051474c>] (kernel_init+0xc/0x164)
[    0.706207] [<c051474c>] (kernel_init+0xc/0x164) from [<c0014310>] (ret_from_fork+0x14/0x24)
[    0.714935] Code: e3130c01 1a000003 e590305c e0833001 (e5930000) 
[    0.721282] ---[ end trace 1b75b31a2719ed1d ]---
[    0.726135] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    0.726135] 
[    0.735687] CPU0: stopping
[    0.738586] [<c001c4e0>] (unwind_backtrace+0x0/0xf4) from [<c001a1b8>] (handle_IPI+0x134/0x160)
[    0.747589] [<c001a1b8>] (handle_IPI+0x134/0x160) from [<c00085b8>] (gic_handle_irq+0x5c/0x6c)
[    0.756530] [<c00085b8>] (gic_handle_irq+0x5c/0x6c) from [<c051da64>] (__irq_svc+0x44/0x5c)
[    0.765167] Exception stack(0xc0779f58 to 0xc0779fa0)
[    0.770446] 9f40:                                                       c00154bc c0783cd0
[    0.778900] 9f60: 00000000 c07eb6fc c0778000 c080eb90 c0529034 c07851d4 00000000 411fc092
[    0.787384] 9f80: c0780900 00000000 00000000 c0779fa0 c00154bc c00154c0 60000113 ffffffff
[    0.795867] [<c051da64>] (__irq_svc+0x44/0x5c) from [<c00154c0>] (default_idle+0x24/0x44)
[    0.804351] [<c00154c0>] (default_idle+0x24/0x44) from [<c0015ab4>] (cpu_idle+0x90/0x100)
[    0.812835] [<c0015ab4>] (cpu_idle+0x90/0x100) from [<c071f930>] (start_kernel+0x288/0x328)
[    0.821502] [<c071f930>] (start_kernel+0x288/0x328) from [<80008078>] (0x80008078)
