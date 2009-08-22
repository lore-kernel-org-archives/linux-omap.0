From: tom.leiming@gmail.com
Subject: [PATCH] OMAP3:PM: fix lockdep warning caused by omap3_pm_init
Date: Sat, 22 Aug 2009 21:20:26 +0800
Message-ID: <1250947226-2371-1-git-send-email-tom.leiming@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f194.google.com ([209.85.222.194]:33736 "EHLO
	mail-pz0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754201AbZHVNUd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 22 Aug 2009 09:20:33 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com, peterz@infradead.org
Cc: linux-omap@vger.kernel.org, arm-kernel@lists.infradead.org, linux-embedded@vger.kernel.org, linux@arm.linux.org.uk, Ming Lei <tom.leiming@gmail.com>

From: Ming Lei <tom.leiming@gmail.com>

This patch uses kmalloc(size,GFP_ATOMIC) instead of kmalloc(size,GFP_KERNEL)
to allocate memory for instance of struct power_state in pwrdms_setup(),
since it may be called by pwrdm_for_each() with irq disabled.

It is a easy fix for the following lockdep warning caused by
kmalloc(size,GFP_KERNEL) in pwrdms_setup():

Power Management for TI OMAP3.
------------[ cut here ]------------
WARNING: at kernel/lockdep.c:2282 lockdep_trace_alloc+0xe8/0xfc()
Modules linked in:
[<c0032ccc>] (unwind_backtrace+0x0/0xec) from [<c0056934>] (warn_slowpath_common+0x48/0x60)
[<c0056934>] (warn_slowpath_common+0x48/0x60) from [<c007da10>] (lockdep_trace_alloc+0xe8/0xfc)
[<c007da10>] (lockdep_trace_alloc+0xe8/0xfc) from [<c00cd9bc>] (kmem_cache_alloc+0x28/0x178)
[<c00cd9bc>] (kmem_cache_alloc+0x28/0x178) from [<c000f184>] (pwrdms_setup+0x30/0xf8)
[<c000f184>] (pwrdms_setup+0x30/0xf8) from [<c00381c4>] (pwrdm_for_each+0x64/0x84)
[<c00381c4>] (pwrdm_for_each+0x64/0x84) from [<c000ef60>] (omap3_pm_init+0x3f4/0x5ac)
[<c000ef60>] (omap3_pm_init+0x3f4/0x5ac) from [<c002c2c0>] (do_one_initcall+0x30/0x1d4)
[<c002c2c0>] (do_one_initcall+0x30/0x1d4) from [<c00088d8>] (kernel_init+0xa4/0x118)
[<c00088d8>] (kernel_init+0xa4/0x118) from [<c002ddf8>] (kernel_thread_exit+0x0/0x8)
---[ end trace 1e06f8d97dc5a19b ]---

---
This patch is against linux-2.6.31-rc7.

Signed-off-by: Ming Lei <tom.leiming@gmail.com>
---
 arch/arm/mach-omap2/pm34xx.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 488d595..d67b781 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -665,7 +665,7 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
 	if (!pwrdm->pwrsts)
 		return 0;
 
-	pwrst = kmalloc(sizeof(struct power_state), GFP_KERNEL);
+	pwrst = kmalloc(sizeof(struct power_state), GFP_ATOMIC);
 	if (!pwrst)
 		return -ENOMEM;
 	pwrst->pwrdm = pwrdm;
-- 
1.6.0.GIT

