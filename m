From: Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH] omap: Fix multi.h when only ARCH_OMAP3 and SOC_AM33XX are selected
Date: Tue,  7 Aug 2012 18:29:45 +0200
Message-ID: <1344356985-21801-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:43531 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754069Ab2HGQ3y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 7 Aug 2012 12:29:54 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Vaibhav Hiremath <hvaibhav@ti.com>, Jan Luebbe <jlu@pengutronix.de>

When only ARCH_OMAP3 (or -2,-4,...) and SOC_AM33XX are selected, multi.h
doesn't set MULTI_OMAP2. In this case, cpu.h will simply define
cpu_is_omap24xx() as 1.

This causes problems for example for omap_hwmod.c:omap_hwmod_init which
checks for cpu_is_omap24xx() first, using the wrong soc_ops for AM33xx.

Fix this by defining MULTI_OMAP2 when using SOC_AM33XX together with
something else.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/plat-omap/include/plat/multi.h |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/plat-omap/include/plat/multi.h b/arch/arm/plat-omap/include/plat/multi.h
index 045e320..324d31b 100644
--- a/arch/arm/plat-omap/include/plat/multi.h
+++ b/arch/arm/plat-omap/include/plat/multi.h
@@ -108,4 +108,13 @@
 # endif
 #endif
 
+#ifdef CONFIG_SOC_AM33XX
+# ifdef OMAP_NAME
+#  undef  MULTI_OMAP2
+#  define MULTI_OMAP2
+# else
+#  define OMAP_NAME am33xx
+# endif
+#endif
+
 #endif	/* __PLAT_OMAP_MULTI_H */
-- 
1.7.10.4

