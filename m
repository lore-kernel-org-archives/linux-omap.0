From: Thara Gopinath <thara@ti.com>
Subject: [PM-OPP][PATCH 4/4] OMAP: Remove dependency of generic opp layer on cpufreq.
Date: Tue, 13 Jul 2010 11:17:06 +0530
Message-ID: <1279000026-24042-5-git-send-email-thara@ti.com>
References: <1279000026-24042-1-git-send-email-thara@ti.com>
 <1279000026-24042-2-git-send-email-thara@ti.com>
 <1279000026-24042-3-git-send-email-thara@ti.com>
 <1279000026-24042-4-git-send-email-thara@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:44280 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751804Ab0GMFrV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jul 2010 01:47:21 -0400
In-Reply-To: <1279000026-24042-4-git-send-email-thara@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: khilman@deeprootsystems.com, paul@pwsan.com, tony@atomide.com, b-cousson@ti.com, sawant@ti.com, vishwanath.bs@ti.com, premi@ti.com, Thara Gopinath <thara@ti.com>

This patch removes the dependency of the opp layer on cpufreq layer.
OPP layer is now enabled to compile and exist in the system
irrespective of whether cpu freq layer is enabled or not.

Signed-off-by: Thara Gopinath <thara@ti.com>
---
 arch/arm/plat-omap/Makefile           |    4 ++--
 arch/arm/plat-omap/include/plat/opp.h |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index faf831d..852fa33 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -13,7 +13,7 @@ obj-  :=
 obj-$(CONFIG_ARCH_OMAP16XX) += ocpi.o
 
 # OPP support in (OMAP3+ only at the moment)
-ifdef CONFIG_CPU_FREQ
+ifdef CONFIG_PM
 obj-$(CONFIG_ARCH_OMAP3) += opp.o
 obj-$(CONFIG_TWL4030_CORE) += opp_twl_tps.o
 endif
@@ -37,4 +37,4 @@ obj-y += $(i2c-omap-m) $(i2c-omap-y)
 # OMAP mailbox framework
 obj-$(CONFIG_OMAP_MBOX_FWK) += mailbox.o
 
-obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
\ No newline at end of file
+obj-$(CONFIG_OMAP_PM_NOOP) += omap-pm-noop.o
diff --git a/arch/arm/plat-omap/include/plat/opp.h b/arch/arm/plat-omap/include/plat/opp.h
index 29e3d03..7d3e0ef 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -60,7 +60,7 @@ struct omap_opp_def {
 
 struct omap_opp;
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_PM
 
 unsigned long opp_get_voltage(const struct omap_opp *opp);
 
@@ -155,5 +155,5 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
 {
 }
 
-#endif		/* CONFIG_CPU_FREQ */
+#endif		/* CONFIG_PM */
 #endif		/* __ASM_ARM_OMAP_OPP_H */
-- 
1.7.0.rc1.33.g07cf0f

