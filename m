From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 5/9] omap: introduce OMAP_SHOW_FEATURE
Date: Tue, 22 Jun 2010 21:16:11 -0500
Message-ID: <1277259375-18521-6-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:45157 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751415Ab0FWCQ1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Jun 2010 22:16:27 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

change OMAP3_SHOW_FEATURE into OMAP_SHOW_FEATURE to make the usage
generic.

Cc: Tony Lindgren <tony@atomide.com>
Cc: Angelo Arrifano <miknix@gmail.com>
Cc: "Zebediah C. McClure" <zmc@lurian.net>
Cc: Alistair Buxton <a.j.buxton@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Sanjeev Premi <premi@ti.com>
Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Senthilvadivu Gurusamy <svadivu@ti.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Vikram Pandita <vikram.pandita@ti.com>
Cc: Vishwanath S <vishwa.s@ti.com>
Cc: linux-omap@vger.kernel.org

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/id.c              |   16 ++++++----------
 arch/arm/plat-omap/include/plat/cpu.h |    6 ++++++
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index c7bf0e1..809e13a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -293,10 +293,6 @@ static void __init omap4_check_revision(void)
 	pr_err("Unknown OMAP4 CPU id\n");
 }
 
-#define OMAP3_SHOW_FEATURE(feat)		\
-	if (omap3_has_ ##feat())		\
-		printk(#feat" ");
-
 static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
@@ -358,12 +354,12 @@ static void __init omap3_cpuinfo(void)
 	/* Print verbose information */
 	pr_info("%s ES%s (", cpu_name, cpu_rev);
 
-	OMAP3_SHOW_FEATURE(l2cache);
-	OMAP3_SHOW_FEATURE(iva);
-	OMAP3_SHOW_FEATURE(sgx);
-	OMAP3_SHOW_FEATURE(neon);
-	OMAP3_SHOW_FEATURE(isp);
-	OMAP3_SHOW_FEATURE(192mhz_clk);
+	OMAP_SHOW_FEATURE(3, l2cache);
+	OMAP_SHOW_FEATURE(3, iva);
+	OMAP_SHOW_FEATURE(3, sgx);
+	OMAP_SHOW_FEATURE(3, neon);
+	OMAP_SHOW_FEATURE(3, isp);
+	OMAP_SHOW_FEATURE(3, 192mhz_clk);
 
 	printk(")\n");
 }
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index c71dbf4..f8ecbc4 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -450,6 +450,12 @@ static inline unsigned int omap##rev##_has_ ##feat(void)		\
 	return omap##rev##_features & OMAP##rev##_HAS_ ##flag;		\
 }									\
 
+#define OMAP_SHOW_FEATURE(rev, feat)					\
+{									\
+	if (omap##rev##_has_ ##feat())					\
+		printk(#feat" ");					\
+}									\
+
 /*
  * Runtime detection of OMAP3 features
  */
-- 
1.6.3.3

