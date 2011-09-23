From: Benoit Cousson <b-cousson@ti.com>
Subject: [PATCH 01/11] OMAP2+: Add SoC specific map_io functions
Date: Fri, 23 Sep 2011 22:23:09 +0200
Message-ID: <1316809399-19579-2-git-send-email-b-cousson@ti.com>
References: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49635 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752105Ab1IWUY2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 Sep 2011 16:24:28 -0400
In-Reply-To: <1316809399-19579-1-git-send-email-b-cousson@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, grant.likely@secretlab.ca
Cc: paul@pwsan.com, khilman@ti.com, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, Benoit Cousson <b-cousson@ti.com>

Add SoC specific map_io function to be used by the generic DT
board file. This is an intermediate step before having some
generic DT aware map_io function.

Signed-off-by: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/common.c             |   18 ++++++++++++++++++
 arch/arm/plat-omap/include/plat/common.h |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 3f20cbb..de61f15 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -56,6 +56,12 @@ void __init omap2_set_globals_242x(void)
 {
 	__omap2_set_globals(&omap242x_globals);
 }
+
+void __init omap242x_map_io(void)
+{
+	omap2_set_globals_242x();
+	omap242x_map_common_io();
+}
 #endif
 
 #if defined(CONFIG_SOC_OMAP2430)
@@ -74,6 +80,12 @@ void __init omap2_set_globals_243x(void)
 {
 	__omap2_set_globals(&omap243x_globals);
 }
+
+void __init omap243x_map_io(void)
+{
+	omap2_set_globals_243x();
+	omap243x_map_common_io();
+}
 #endif
 
 #if defined(CONFIG_ARCH_OMAP3)
@@ -138,5 +150,11 @@ void __init omap2_set_globals_443x(void)
 	omap2_set_globals_control(&omap4_globals);
 	omap2_set_globals_prcm(&omap4_globals);
 }
+
+void __init omap4_map_io(void)
+{
+	omap2_set_globals_443x();
+	omap44xx_map_common_io();
+}
 #endif
 
diff --git a/arch/arm/plat-omap/include/plat/common.h b/arch/arm/plat-omap/include/plat/common.h
index 5cac97e..abda2c7 100644
--- a/arch/arm/plat-omap/include/plat/common.h
+++ b/arch/arm/plat-omap/include/plat/common.h
@@ -83,7 +83,11 @@ void omap2_set_globals_sdrc(struct omap_globals *);
 void omap2_set_globals_control(struct omap_globals *);
 void omap2_set_globals_prcm(struct omap_globals *);
 
+void omap242x_map_io(void);
+void omap243x_map_io(void);
 void omap3_map_io(void);
+void omap4_map_io(void);
+
 
 /**
  * omap_test_timeout - busy-loop, testing a condition
-- 
1.7.0.4

