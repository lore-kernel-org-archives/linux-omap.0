From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: [PATCH v1 01/14] ARM: OMAP2+: Move stubbed secure_sram_reserve function to a common.c and call it __weak
Date: Thu, 5 Jul 2012 17:38:39 +0530
Message-ID: <1341490136-25901-2-git-send-email-santosh.shilimkar@ti.com>
References: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:33856 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751400Ab2GEMKK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 08:10:10 -0400
In-Reply-To: <1341490136-25901-1-git-send-email-santosh.shilimkar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, R Sricharan <r.sricharan@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

From: R Sricharan <r.sricharan@ti.com>

omap_secure_ram_reserve_memblock is stubbed for OMAP1,2 only builds using a
 ifdef check. But this results in adding CONFIG_ARCH_OMAPxx checks for
future socs that use the real function. So move this to common.c file and
call it __weak.

Signed-off-by: R Sricharan <r.sricharan@ti.com>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/plat-omap/common.c                   |    9 +++++++++
 arch/arm/plat-omap/include/plat/omap-secure.h |    5 -----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 0a9b9a9..89a3723 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -77,3 +77,12 @@ void __init omap_init_consistent_dma_size(void)
 	init_consistent_dma_size(CONFIG_FB_OMAP_CONSISTENT_DMA_SIZE << 20);
 #endif
 }
+
+/*
+ * Stub function for OMAP2 so that common files
+ * continue to build when custom builds are used
+ */
+int __weak omap_secure_ram_reserve_memblock(void)
+{
+	return 0;
+}
diff --git a/arch/arm/plat-omap/include/plat/omap-secure.h b/arch/arm/plat-omap/include/plat/omap-secure.h
index 8c7994c..0e4acd2 100644
--- a/arch/arm/plat-omap/include/plat/omap-secure.h
+++ b/arch/arm/plat-omap/include/plat/omap-secure.h
@@ -3,12 +3,7 @@
 
 #include <linux/types.h>
 
-#if defined(CONFIG_ARCH_OMAP3) || defined(CONFIG_ARCH_OMAP4)
 extern int omap_secure_ram_reserve_memblock(void);
-#else
-static inline void omap_secure_ram_reserve_memblock(void)
-{ }
-#endif
 
 #ifdef CONFIG_OMAP4_ERRATA_I688
 extern int omap_barrier_reserve_memblock(void);
-- 
1.7.9.5

