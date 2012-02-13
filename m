From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/3] ARM: OMAP2+: Move SDRC related functions from io.h into
 local common.h
Date: Mon, 13 Feb 2012 15:53:46 -0800
Message-ID: <20120213235346.26087.24457.stgit@kaulin.local>
References: <20120213235216.26087.66303.stgit@kaulin.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25489 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757611Ab2BMXxt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 18:53:49 -0500
In-Reply-To: <20120213235216.26087.66303.stgit@kaulin.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

These should be local to omap2/3/4.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.h         |    5 +++++
 arch/arm/plat-omap/include/plat/io.h |    4 ----
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/common.h b/arch/arm/mach-omap2/common.h
index febffde..5aa1acb 100644
--- a/arch/arm/mach-omap2/common.h
+++ b/arch/arm/mach-omap2/common.h
@@ -235,5 +235,10 @@ static inline u32 omap4_mpuss_read_prev_context_state(void)
 	return 0;
 }
 #endif
+
+struct omap_sdrc_params;
+extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
+				      struct omap_sdrc_params *sdrc_cs1);
+
 #endif /* __ASSEMBLER__ */
 #endif /* __ARCH_ARM_MACH_OMAP2PLUS_COMMON_H */
diff --git a/arch/arm/plat-omap/include/plat/io.h b/arch/arm/plat-omap/include/plat/io.h
index 0696bae..f5b386b 100644
--- a/arch/arm/plat-omap/include/plat/io.h
+++ b/arch/arm/plat-omap/include/plat/io.h
@@ -266,10 +266,6 @@ extern void omap_writeb(u8 v, u32 pa);
 extern void omap_writew(u16 v, u32 pa);
 extern void omap_writel(u32 v, u32 pa);
 
-struct omap_sdrc_params;
-extern void omap_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
-				      struct omap_sdrc_params *sdrc_cs1);
-
 extern void __init omap_init_consistent_dma_size(void);
 
 #endif

