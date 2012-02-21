From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 3/8] ARM: OMAP: Move omap_init_consistent_dma_size() to
 local common.h
Date: Tue, 21 Feb 2012 15:40:40 -0800
Message-ID: <20120221234040.18709.17025.stgit@kaulin.local>
References: <20120221233619.18709.87982.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:17191 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751830Ab2BUXkl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 21 Feb 2012 18:40:41 -0500
In-Reply-To: <20120221233619.18709.87982.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We don't want to keep it in io.h as we want to remove io.h
for omap2+ for the common zImage support.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/common.h         |    1 +
 arch/arm/mach-omap2/common.h         |    2 ++
 arch/arm/plat-omap/include/plat/io.h |    2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/common.h b/arch/arm/mach-omap1/common.h
index a9a5146..af658ad 100644
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -58,5 +58,6 @@ void omap1_restart(char, const char *);
 
 extern struct sys_timer omap1_timer;
 extern bool omap_32k_timer_init(void);
+extern void __init omap_init_consistent_dma_size(void);
 
 #endif /* __ARCH_ARM_MACH_OMAP1_COMMON_H */
diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index 5aa1acb..f78ec4e 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -133,6 +133,8 @@ void am33xx_map_io(void);
 void omap4_map_io(void);
 void ti81xx_map_io(void);
 
+extern void __init omap_init_consistent_dma_size(void);
+
 /**
  * omap_test_timeout - busy-loop, testing a condition
  * @cond: condition to test until it evaluates to true
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index f5b386b..28cd796 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -266,8 +266,6 @@ extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
-extern void __init omap_init_consistent_dma_size(void);
-
 #endif
 
 #endif

