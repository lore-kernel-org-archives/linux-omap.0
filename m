From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH 14/14] omap4: Fix bootup crash observed with higher CPU clocks
Date: Fri, 17 Sep 2010 15:17:58 +0530
Message-ID: <1284716878-27667-15-git-send-email-santosh.shilimkar@ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-2-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-3-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-4-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-5-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-6-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-7-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-8-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-9-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-10-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-11-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-12-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-13-git-send-email-santosh.shilimkar@ti.com>
 <1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45877 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819Ab0IQJsL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 17 Sep 2010 05:48:11 -0400
In-Reply-To: <1284716878-27667-14-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Rajendra Nayak <rnayak@ti.com>

This patch is temporary fix to below crash. This is observed when
CPU is clocked more than 600 MHz.

Unhandled fault: imprecise external abort (0x1406) at 0xbf9ef65c
Internal error: : 1406 [#1] PREEMPT SMP
last sysfs file:
Modules linked in:
CPU: 0    Not tainted  (2.6.36-rc3+ #18)
PC is at kernel_thread_helper+0x0/0x14
LR is at kernel_thread_helper+0x0/0x14
pc : [<c003ce14>]    lr : [<c003ce14>]    psr: 00000093
sp : dc83bff8  ip : 00000000  fp : 00000000
r10: 00000000  r9 : 00000000  r8 : 00000000
r7 : 00000013  r6 : c003ce28  r5 : c008935c  r4 : 00000000
r3 : 00000000  r2 : 00000000  r1 : 00000000  r0 : 00000000
Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM  Segment kernel
Control: 10c53c7f  Table: 8000404a  DAC: 00000017
Process swapper (pid: 2, stack limit = 0xdc83a2f0)
Stack: (0xdc83bff8 to 0xdc83c000)
bfe0: 00000000 ffffffff
[<c003ce14>] (kernel_thread_helper+0x0/0x14) from [<fffffffe>] (0xfffffffe)
Code: c03a0ba3 c03a5fcb c045c880 c0394035 (eb017701)
---[ end trace 1b75b31a2719ed1c ]---

The timer hwmod adaptation will eventually fix it in a proper way.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/dmtimer.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/plat-omap/dmtimer.c b/arch/arm/plat-omap/dmtimer.c
index 44bafda..1d706cf 100644
--- a/arch/arm/plat-omap/dmtimer.c
+++ b/arch/arm/plat-omap/dmtimer.c
@@ -581,7 +581,7 @@ int omap_dm_timer_set_source(struct omap_dm_timer *timer, int source)
 	 * When the functional clock disappears, too quick writes seem
 	 * to cause an abort. XXX Is this still necessary?
 	 */
-	__delay(150000);
+	__delay(300000);
 
 	return ret;
 }
-- 
1.6.0.4

