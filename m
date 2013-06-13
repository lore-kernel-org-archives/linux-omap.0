From: Rajendra Nayak <rnayak@ti.com>
Subject: [PATCH 3/3] ARM: OMAP: dma: Fix the kfree ordering
Date: Thu, 13 Jun 2013 18:39:20 +0530
Message-ID: <1371128960-24822-4-git-send-email-rnayak@ti.com>
References: <1371128960-24822-1-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:36512 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756786Ab3FMNKC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 13 Jun 2013 09:10:02 -0400
In-Reply-To: <1371128960-24822-1-git-send-email-rnayak@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>

kfree of 'p' followed by kfree of 'd' where d = p->dma_attr
certainly seems wrong.

Results in a Oops when probe fails and ends up at exit_dma_lch_fail:

[    0.612579] Unable to handle kernel NULL pointer dereference at virtual address 00000048
[    0.620971] pgd = c0004000
[    0.623840] [00000048] *pgd=00000000
[    0.627593] Internal error: Oops: 5 [#1] SMP ARM
[    0.632415] Modules linked in:
[    0.635650] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 3.10.0-rc5-00003-g435cd37-dirty #7
[    0.644042] task: ed8613c0 ti: ed862000 task.ti: ed862000
[    0.649688] PC is at kfree+0x64/0x178
[    0.653533] LR is at kfree+0x34/0x178
[    0.657379] pc : [<c0114e64>]    lr : [<c0114e34>]    psr: 40000193
[    0.657379] sp : ed863e50  ip : 00080000  fp : ed9e7000
[    0.669342] r10: c07cb990  r9 : 00000001  r8 : c0d95840
[    0.674804] r7 : a0000113  r6 : 00000000  r5 : c0802240  r4 : 00000802
[    0.681579] r3 : c0dc0000  r2 : 80000000  r1 : 80802240  r0 : c0802240
[    0.688385] Flags: nZcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
[    0.696075] Control: 10c53c7d  Table: 8000404a  DAC: 00000017
[    0.702056] Process swapper/0 (pid: 1, stack limit = 0xed862240)
[    0.708312] Stack: (0xed863e50 to 0xed864000)
[    0.712860] 3e40:                                     c0857a68 00000000 fffffffa 80000000
[    0.721343] 3e60: ffffffff 00000001 20000113 c0040ee8 ed9e98b0 00000030 ed9e7044 ed9e7010
[    0.729858] 3e80: c0da9434 ed9e7044 00000000 c081acd4 00000000 c079e460 00000000 c035ba38
[    0.738342] 3ea0: c035ba20 c035a594 ed9e7010 c081acd4 ed9e7044 00000000 ed862000 c035a7bc
[    0.746826] 3ec0: c081acd4 c035a728 ed863ed0 c0358dac ed88cea8 ed965110 ed8613c0 c081acd4
[    0.755310] 3ee0: c0836c00 ed9ebec0 00000000 c03596f0 c06933dc c0856440 c0856440 c081acd4
[    0.763793] 3f00: c0856440 c075c3d4 ed862000 c035ad90 c0856440 c07728e8 c0856440 c075c3d4
[    0.772308] 3f20: ed862000 c0008744 00000000 c072eaac c072eaac 00000000 00000001 60000113
[    0.780792] 3f40: c06f2418 00000000 00000003 00000003 60000113 c079e44c 00000004 c0856440
[    0.789276] 3f60: c075c3d4 000000a5 c07ba740 c079e460 00000000 c075c308 00000003 00000003
[    0.797760] 3f80: c075c3d4 00000000 00000000 c0545568 00000000 00000000 00000000 00000000
[    0.806243] 3fa0: 00000000 c0545570 00000000 c00143a8 00000000 00000000 00000000 00000000
[    0.814727] 3fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    0.823211] 3fe0: 00000000 00000000 00000000 00000000 00000013 00000000 a2ae33a6 b733c363
[    0.831726] [<c0114e64>] (kfree+0x64/0x178) from [<c0040ee8>] (omap_system_dma_probe+0x208/0x294)
[    0.840942] [<c0040ee8>] (omap_system_dma_probe+0x208/0x294) from [<c035ba38>] (platform_drv_probe+0x18/0x1c)
[    0.851226] [<c035ba38>] (platform_drv_probe+0x18/0x1c) from [<c035a594>] (driver_probe_device+0x90/0x224)
[    0.861236] [<c035a594>] (driver_probe_device+0x90/0x224) from [<c035a7bc>] (__driver_attach+0x94/0x98)
[    0.870971] [<c035a7bc>] (__driver_attach+0x94/0x98) from [<c0358dac>] (bus_for_each_dev+0x68/0x8c)
[    0.880340] [<c0358dac>] (bus_for_each_dev+0x68/0x8c) from [<c03596f0>] (bus_add_driver+0x208/0x2a4)
[    0.889831] [<c03596f0>] (bus_add_driver+0x208/0x2a4) from [<c035ad90>] (driver_register+0x78/0x194)
[    0.899291] [<c035ad90>] (driver_register+0x78/0x194) from [<c0008744>] (do_one_initcall+0x30/0x168)
[    0.908782] [<c0008744>] (do_one_initcall+0x30/0x168) from [<c075c308>] (kernel_init_freeable+0xf4/0x1c0)
[    0.918701] [<c075c308>] (kernel_init_freeable+0xf4/0x1c0) from [<c0545570>] (kernel_init+0x8/0xe4)
[    0.928100] [<c0545570>] (kernel_init+0x8/0xe4) from [<c00143a8>] (ret_from_fork+0x14/0x2c)
[    0.936767] Code: e3160902 1590001c e590601c e1a00005 (e5961048)
[    0.943145] ---[ end trace f2e8a388a9e63b21 ]---

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/plat-omap/dma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/dma.c b/arch/arm/plat-omap/dma.c
index 8a71f75..8e16503 100644
--- a/arch/arm/plat-omap/dma.c
+++ b/arch/arm/plat-omap/dma.c
@@ -2111,8 +2111,8 @@ exit_dma_irq_fail:
 	}
 
 exit_dma_lch_fail:
-	kfree(p);
 	kfree(d);
+	kfree(p);
 	kfree(dma_chan);
 	return ret;
 }
-- 
1.7.9.5

