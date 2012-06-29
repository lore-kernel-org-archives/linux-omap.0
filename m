From: Javier Martinez Canillas <javier@dowhile0.org>
Subject: [PATCH 1/1] ARM: OMAP3: PM: don't explicitly enable the IO-chain interrupt
Date: Fri, 29 Jun 2012 03:25:23 +0200
Message-ID: <1340933123-30401-1-git-send-email-javier@dowhile0.org>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:62600 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755866Ab2F2BZy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Jun 2012 21:25:54 -0400
Received: by werb14 with SMTP id b14so825534wer.19
        for <linux-omap@vger.kernel.org>; Thu, 28 Jun 2012 18:25:52 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Javier Martinez Canillas <javier@dowhile0.org>

commit 99b59df0 ARM: OMAP3: PM: fix shared PRCM interrupt leave disabled at boot

set the IRQ_NOAUTOEN flag to the PCRM IO-chain irq to avoid this
interrupt until the PM core code is ready to handle the interrupts.

It seems that this is not needed anymore after the OMAP PRCM I/O chain
code re-implementation introduced on merge commit:

9a17d88 Merge tag 'omap-devel-c-for-3.6' of git://git.kernel.org/pub/scm/linux/kernel/

The IRQ_NOAUTOEN flags is not set for the PRCM I/O irq anymore on the
new implementation. This has the effect that a request_irq() for the
PRCM I/O chain irq will auto-enable the requested IRQ and a later call
to enable_irq() will lead to the following warning:

[    3.849334] WARNING: at kernel/irq/manage.c:436 enable_irq+0x3c/0x78()
[    3.856231] Unbalanced enable for IRQ 297
[    3.860473] Modules linked in:
[    3.863739] [<c001a114>] (unwind_backtrace+0x0/0xf0) from [<c003c7e8>] (warn_slowpath_common+0x4c/0x64)
[    3.873687] [<c003c7e8>] (warn_slowpath_common+0x4c/0x64) from [<c003c894>] (warn_slowpath_fmt+0x30/0x40)
[    3.883819] [<c003c894>] (warn_slowpath_fmt+0x30/0x40) from [<c00993e0>] (enable_irq+0x3c/0x78)
[    3.893035] [<c00993e0>] (enable_irq+0x3c/0x78) from [<c067b1e8>] (omap3_pm_init+0x328/0x5f4)
[    3.902099] [<c067b1e8>] (omap3_pm_init+0x328/0x5f4) from [<c067161c>] (init_machine_late+0x1c/0x28)
[    3.911773] [<c067161c>] (init_machine_late+0x1c/0x28) from [<c0008648>] (do_one_initcall+0x34/0x178)
[    3.921539] [<c0008648>] (do_one_initcall+0x34/0x178) from [<c066e8f4>] (kernel_init+0xfc/0x1c0)
[    3.930847] [<c066e8f4>] (kernel_init+0xfc/0x1c0) from [<c00140b0>] (kernel_thread_exit+0x0/0x8)
[    3.940246] ---[ end trace 55a0ad32ca2ca682 ]---

Signed-off-by: Javier Martinez Canillas <javier@dowhile0.org>
---

This patch was generated on top of
git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git
branch: master

 arch/arm/mach-omap2/pm34xx.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index e4fc88c..6f14e26 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -693,7 +693,6 @@ int __init omap3_pm_init(void)
 	ret = request_irq(omap_prcm_event_to_irq("io"),
 		_prcm_int_handle_io, IRQF_SHARED | IRQF_NO_SUSPEND, "pm_io",
 		omap3_pm_init);
-	enable_irq(omap_prcm_event_to_irq("io"));
 
 	if (ret) {
 		pr_err("pm: Failed to request pm_io irq\n");
-- 
1.7.7.6

