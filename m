From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 4/4] OMAP: Remove dependency of generic opp layer on cpufreq.
Date: Tue, 10 Aug 2010 17:09:17 -0700
Message-ID: <1281485357-20791-5-git-send-email-khilman@deeprootsystems.com>
References: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f174.google.com ([209.85.212.174]:55614 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756157Ab0HKAJ2 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 10 Aug 2010 20:09:28 -0400
Received: by mail-px0-f174.google.com with SMTP id 10so277275pxi.19
        for <linux-omap@vger.kernel.org>; Tue, 10 Aug 2010 17:09:28 -0700 (PDT)
In-Reply-To: <1281485357-20791-1-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Thara Gopinath <thara@ti.com>

From: Thara Gopinath <thara@ti.com>

This patch removes the dependency of the opp layer on cpufreq layer.
OPP layer is now enabled to compile and exist in the system
irrespective of whether cpu freq layer is enabled or not.

[NM Note:
Original Patch: https://patchwork.kernel.org/patch/111664/
Still pending: http://marc.info/?l=linux-omap&m=127530955314582&w=2
To be squashed to patch 1
]

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
index 403b69b..f9feb8d 100644
--- a/arch/arm/plat-omap/include/plat/opp.h
+++ b/arch/arm/plat-omap/include/plat/opp.h
@@ -61,7 +61,7 @@ struct omap_opp_def {
 
 struct omap_opp;
 
-#ifdef CONFIG_CPU_FREQ
+#ifdef CONFIG_PM
 
 unsigned long opp_get_voltage(const struct omap_opp *opp);
 
@@ -156,5 +156,5 @@ void opp_init_cpufreq_table(struct omap_opp *opps,
 {
 }
 
-#endif		/* CONFIG_CPU_FREQ */
+#endif		/* CONFIG_PM */
 #endif		/* __ASM_ARM_OMAP_OPP_H */
-- 
1.7.2.1

