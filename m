From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: PM: fix IRQ_NOAUTOEN removal by mis-merge
Date: Fri, 29 Jun 2012 07:03:34 -0700
Message-ID: <1340978614-12558-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog126.obsmtp.com ([74.125.149.155]:38288 "EHLO
	na3sys009aog126.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751968Ab2F2ODm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 29 Jun 2012 10:03:42 -0400
Received: by pbcwz7 with SMTP id wz7so4407621pbc.2
        for <linux-omap@vger.kernel.org>; Fri, 29 Jun 2012 07:03:36 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Javier Martinez Canillas <javier@dowhile0.org>
Cc: linux-arm-kernel@lists.infradead.org, Paul Walmsley <paul@pwsan.com>

commit 99b59df0 (ARM: OMAP3: PM: fix shared PRCM interrupt leave
disabled at boot) added IRQ_NOAUTOEN to the PRCM interrupt so it could
be enabled later if needed.  However, this commit was partially undone
when merging the IO daisy chain rework in 9a17d88e (Merge tag
'omap-devel-c-for-3.6' of
git://git.kernel.org/pub/scm/linux/kernel/git/pjw/omap-pending into
devel-pm

This patch adds back the IRQ_NOAUTOEN fix that was removed by the
merge resolution.

This also fixes the following boot-time warning that showed up after
merging the IO daisy chain rework:

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

Reported-by: Javier Martinez Canillas <javier@dowhile0.org>
Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Tony, this applies on top of your current devel-pm branch.

 arch/arm/mach-omap2/prm2xxx_3xxx.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.c b/arch/arm/mach-omap2/prm2xxx_3xxx.c
index e10fd1e..a0309de 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.c
@@ -351,11 +351,16 @@ static void __init omap3xxx_prm_enable_io_wakeup(void)
 
 static int __init omap3xxx_prcm_init(void)
 {
+	int ret = 0;
+
 	if (cpu_is_omap34xx()) {
 		omap3xxx_prm_enable_io_wakeup();
-		return omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		ret = omap_prcm_register_chain_handler(&omap3_prcm_irq_setup);
+		if (!ret)
+			irq_set_status_flags(omap_prcm_event_to_irq("io"),
+					     IRQ_NOAUTOEN);
 	}
 
-	return 0;
+	return ret;
 }
 subsys_initcall(omap3xxx_prcm_init);
-- 
1.7.9.2

