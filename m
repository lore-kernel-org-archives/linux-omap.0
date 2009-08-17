From: Sanjeev Premi <premi@ti.com>
Subject: [PATCH] Fix mismatched ifdefs
Date: Mon, 17 Aug 2009 16:29:15 +0530
Message-ID: <1250506755-920-1-git-send-email-premi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39782 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756895AbZHQK7W (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 17 Aug 2009 06:59:22 -0400
Received: from dbdp31.itg.ti.com ([172.24.170.98])
	by bear.ext.ti.com (8.13.7/8.13.7) with ESMTP id n7HAxHxH012610
	for <linux-omap@vger.kernel.org>; Mon, 17 Aug 2009 05:59:23 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Sanjeev Premi <premi@ti.com>

The #endif at end of the file was missing. However, an
additional #else ... #endif was causing the compiler to
keep going.

The problem was found when compiler started reporting
the newly added inline functions were being reported as
redeclared by the compiler.

Signed-off-by: Sanjeev Premi <premi@ti.com>
---
 arch/arm/plat-omap/include/mach/cpu.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index 11e73d9..4fbc6a9 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -317,8 +317,6 @@ IS_OMAP_TYPE(3430, 0x3430)
 #  undef  cpu_is_omap730
 #  define cpu_is_omap730()		1
 # endif
-#endif
-#else
 # if defined(CONFIG_ARCH_OMAP850)
 #  undef  cpu_is_omap850
 #  define cpu_is_omap850()		1
@@ -433,3 +431,5 @@ IS_OMAP_TYPE(3430, 0x3430)
 
 int omap_chip_is(struct omap_chip_id oci);
 void omap2_check_revision(void);
+
+#endif	/* __ASM_ARCH_OMAP_CPU_H */
-- 
1.6.2.2

