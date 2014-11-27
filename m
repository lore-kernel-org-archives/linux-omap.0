From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 02/23] ARM: OMAP2+: PRCM: rename of_prcm_init to omap_prcm_init
Date: Thu, 27 Nov 2014 17:51:33 +0200
Message-ID: <1417103514-17027-3-git-send-email-t-kristo@ti.com>
References: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40576 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751100AbaK0Pvk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 27 Nov 2014 10:51:40 -0500
In-Reply-To: <1417103514-17027-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org, paul@pwsan.com, nm@ti.com
Cc: linux-arm-kernel@lists.infradead.org

This avoids conflicts in the global namespace, and is more descriptive
of the purpose anyway.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/io.c         |    2 +-
 arch/arm/mach-omap2/prm.h        |    2 +-
 arch/arm/mach-omap2/prm_common.c |    8 +++++++-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index 4fc8383..4f269be 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -731,7 +731,7 @@ int __init omap_clk_init(void)
 
 	ti_clk_init_features();
 
-	ret = of_prcm_init();
+	ret = omap_prcm_init();
 	if (ret)
 		return ret;
 
diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index 77752e4..a38eaeb 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -19,7 +19,7 @@
 extern void __iomem *prm_base;
 extern u16 prm_features;
 extern void omap2_set_globals_prm(void __iomem *prm);
-int of_prcm_init(void);
+int omap_prcm_init(void);
 # endif
 
 /*
diff --git a/arch/arm/mach-omap2/prm_common.c b/arch/arm/mach-omap2/prm_common.c
index 9f736d2..f155aaf 100644
--- a/arch/arm/mach-omap2/prm_common.c
+++ b/arch/arm/mach-omap2/prm_common.c
@@ -590,7 +590,13 @@ static const struct of_device_id omap_prcm_dt_match_table[] = {
 	{ }
 };
 
-int __init of_prcm_init(void)
+/**
+ * omap_prcm_init - low level init for the PRCM drivers
+ *
+ * Initializes the low level clock infrastructure for PRCM drivers.
+ * Returns 0 in success, negative error value in failure.
+ */
+int __init omap_prcm_init(void)
 {
 	return omap2_clk_provider_init(omap_prcm_dt_match_table);
 }
-- 
1.7.9.5

