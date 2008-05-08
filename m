From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 2/11] ARM: OMAP: Add calls to omap2_set_globals_*()
Date: Thu,  8 May 2008 15:49:26 -0700
Message-ID: <1210286975-29506-3-git-send-email-tony@atomide.com>
References: omap-fixes-2008-05-08-154932
 <1210286975-29506-1-git-send-email-tony@atomide.com>
 <1210286975-29506-2-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61399 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761121AbYEHWtk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 8 May 2008 18:49:40 -0400
In-Reply-To: <1210286975-29506-2-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Kyungmin Park <kmpark@infradead.org>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Add the omap2_set_globals_{242x,243x,343x}() functions. These
functions are called early upon boot in the map_io() functions in the
board-specific init files.

This patch was accidentally left out of the earlier series.

This fixes omap2 booting as noted by Kyungmin Park <kmpark@infradead.org>.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kyungmin Park <kmpark@infradead.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/board-2430sdp.c |    1 +
 arch/arm/mach-omap2/board-apollon.c |    1 +
 arch/arm/mach-omap2/board-generic.c |    1 +
 arch/arm/mach-omap2/board-h4.c      |    1 +
 include/asm-arm/arch-omap/common.h  |    4 ++++
 5 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-2430sdp.c b/arch/arm/mach-omap2/board-2430sdp.c
index 1c12d7c..1682eb7 100644
--- a/arch/arm/mach-omap2/board-2430sdp.c
+++ b/arch/arm/mach-omap2/board-2430sdp.c
@@ -208,6 +208,7 @@ static void __init omap_2430sdp_init(void)
 
 static void __init omap_2430sdp_map_io(void)
 {
+	omap2_set_globals_243x();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-apollon.c b/arch/arm/mach-omap2/board-apollon.c
index a1e1e67..620fa0f 100644
--- a/arch/arm/mach-omap2/board-apollon.c
+++ b/arch/arm/mach-omap2/board-apollon.c
@@ -394,6 +394,7 @@ static void __init omap_apollon_init(void)
 
 static void __init omap_apollon_map_io(void)
 {
+	omap2_set_globals_242x();
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 9093815..df8be08 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -65,6 +65,7 @@ static void __init omap_generic_init(void)
 
 static void __init omap_generic_map_io(void)
 {
+	omap2_set_globals_242x(); /* should be 242x, 243x, or 343x */
 	omap2_map_common_io();
 }
 
diff --git a/arch/arm/mach-omap2/board-h4.c b/arch/arm/mach-omap2/board-h4.c
index d1915f9..0d28f68 100644
--- a/arch/arm/mach-omap2/board-h4.c
+++ b/arch/arm/mach-omap2/board-h4.c
@@ -420,6 +420,7 @@ static void __init omap_h4_init(void)
 
 static void __init omap_h4_map_io(void)
 {
+	omap2_set_globals_242x();
 	omap2_map_common_io();
 }
 
diff --git a/include/asm-arm/arch-omap/common.h b/include/asm-arm/arch-omap/common.h
index 224e009..36a3b62 100644
--- a/include/asm-arm/arch-omap/common.h
+++ b/include/asm-arm/arch-omap/common.h
@@ -47,4 +47,8 @@ static inline int omap_register_i2c_bus(int bus_id, u32 clkrate,
 }
 #endif
 
+void omap2_set_globals_242x(void);
+void omap2_set_globals_243x(void);
+void omap2_set_globals_343x(void);
+
 #endif /* __ARCH_ARM_MACH_OMAP_COMMON_H */
-- 
1.5.3.6

