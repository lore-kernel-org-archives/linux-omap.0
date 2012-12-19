From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/8] ARM: OMAP2+: Limi omap initcalls to omap only on
 multiplatform kernels
Date: Wed, 19 Dec 2012 11:26:14 -0800
Message-ID: <20121219192614.22098.89676.stgit@muffinssi.local>
References: <20121219192354.22098.33408.stgit@muffinssi.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:61823 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751521Ab2LST0P (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Dec 2012 14:26:15 -0500
In-Reply-To: <20121219192354.22098.33408.stgit@muffinssi.local>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

We need to make sure that multiplatform kernels don't
run omap initcalls when booted on other SoCs.

Do this by adding wrapper macros for the initcalls that
return early if soc_is_omap() test fails. This allows
us to easily change the defines later if we have SoC
specific init sections available.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/soc.h |   29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm/mach-omap2/soc.h b/arch/arm/mach-omap2/soc.h
index f31d907..092aedd 100644
--- a/arch/arm/mach-omap2/soc.h
+++ b/arch/arm/mach-omap2/soc.h
@@ -42,6 +42,9 @@
 #undef MULTI_OMAP2
 #undef OMAP_NAME
 
+#ifdef CONFIG_ARCH_MULTIPLATFORM
+#define MULTI_OMAP2
+#endif
 #ifdef CONFIG_SOC_OMAP2420
 # ifdef OMAP_NAME
 #  undef  MULTI_OMAP2
@@ -112,6 +115,11 @@ int omap_type(void);
  */
 unsigned int omap_rev(void);
 
+static inline int soc_is_omap(void)
+{
+	return omap_rev() != 0;
+}
+
 /*
  * Get the CPU revision for OMAP devices
  */
@@ -465,5 +473,26 @@ static inline unsigned int omap4_has_ ##feat(void)	\
 
 OMAP4_HAS_FEATURE(perf_silicon, PERF_SILICON)
 
+/*
+ * We need to make sure omap initcalls don't run when
+ * multiplatform kernels are booted on other SoCs.
+ */
+#define omap_initcall(level, fn)		\
+static int __init __used __##fn(void)		\
+{						\
+	if (!soc_is_omap())			\
+		return 0;			\
+	return fn();				\
+}						\
+level(__##fn);
+
+#define omap_early_initcall(fn)		omap_initcall(early_initcall, fn)
+#define omap_core_initcall(fn)		omap_initcall(core_initcall, fn)
+#define omap_postcore_initcall(fn)	omap_initcall(postcore_initcall, fn)
+#define omap_arch_initcall(fn)		omap_initcall(arch_initcall, fn)
+#define omap_subsys_initcall(fn)	omap_initcall(subsys_initcall, fn)
+#define omap_device_initcall(fn)	omap_initcall(device_initcall, fn)
+#define omap_late_initcall(fn)		omap_initcall(late_initcall, fn)
+
 #endif	/* __ASSEMBLY__ */
 

