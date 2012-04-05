From: Kevin Hilman <khilman@ti.com>
Subject: [PATCH] ARM: OMAP2+: PRM: fix compile for OMAP4-only build
Date: Thu,  5 Apr 2012 14:20:37 -0700
Message-ID: <1333660837-23249-1-git-send-email-khilman@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:42336 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752607Ab2DEVUQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 5 Apr 2012 17:20:16 -0400
Received: by pbbjt11 with SMTP id jt11so2087460pbb.7
        for <linux-omap@vger.kernel.org>; Thu, 05 Apr 2012 14:20:14 -0700 (PDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.infradead.org

For OMAP4 only builds, the omap2_prm_* functions have dummy wrappers
to detect incorrect usage.  However, several unrelated omap3 PRM
functions have made it inside the #else clause of the #ifdef wrapping
the omap2_prm stubs, causing them to disappear on OMAP4-only builds.

This was unnoticed until the IO chain support was added and introduced
a new function in this section which is referenced by omap_hwmod.c:

/work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c: In function '_reconfigure_io_chain':
/work/kernel/omap/dev/arch/arm/mach-omap2/omap_hwmod.c:1665:3: error: implicit declaration of function 'omap3xxx_prm_reconfigure_io_chain' [-Werror=implicit-fungiction-declaration]

Fix by using the #ifdef to only wrap the omap2_prm functions that
need stubs on OMAP4-only builds.

Cc: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Kevin Hilman <khilman@ti.com>
---
Paul, this patch applies on top your io_chain_devel_3.5 branch.

 arch/arm/mach-omap2/prm2xxx_3xxx.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/prm2xxx_3xxx.h b/arch/arm/mach-omap2/prm2xxx_3xxx.h
index 1ba3d65..a8c946f 100644
--- a/arch/arm/mach-omap2/prm2xxx_3xxx.h
+++ b/arch/arm/mach-omap2/prm2xxx_3xxx.h
@@ -303,6 +303,8 @@ extern int omap2_prm_is_hardreset_asserted(s16 prm_mod, u8 shift);
 extern int omap2_prm_assert_hardreset(s16 prm_mod, u8 shift);
 extern int omap2_prm_deassert_hardreset(s16 prm_mod, u8 rst_shift, u8 st_shift);
 
+#endif	/* CONFIG_ARCH_OMAP4 */
+
 /* OMAP3-specific VP functions */
 u32 omap3_prm_vp_check_txdone(u8 vp_id);
 void omap3_prm_vp_clear_txdone(u8 vp_id);
@@ -323,8 +325,6 @@ extern void omap3xxx_prm_ocp_barrier(void);
 extern void omap3xxx_prm_save_and_clear_irqen(u32 *saved_mask);
 extern void omap3xxx_prm_restore_irqen(u32 *saved_mask);
 
-#endif	/* CONFIG_ARCH_OMAP4 */
-
 #endif
 
 /*
-- 
1.7.9.2

