From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 3/6] omap: generic: introduce a single check_revision
Date: Sat, 22 May 2010 22:36:36 -0500
Message-ID: <1274585799-16226-4-git-send-email-nm@ti.com>
References: <1274585799-16226-1-git-send-email-nm@ti.com>
 <1274585799-16226-2-git-send-email-nm@ti.com>
 <1274585799-16226-3-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:58084 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752710Ab0EWDgs (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 22 May 2010 23:36:48 -0400
In-Reply-To: <1274585799-16226-3-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Nishanth Menon <nm@ti.com>, Tony Lindgren <tony@atomide.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Senthilvadivu Gurusamy <svadivu@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

Introduce a single omap generic check_revision that routes the
request to the right revision of check_revision.

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
 arch/arm/mach-omap1/io.c              |    3 +--
 arch/arm/mach-omap2/io.c              |    2 +-
 arch/arm/plat-omap/common.c           |   11 +++++++++++
 arch/arm/plat-omap/include/plat/cpu.h |   13 ++++++++++++-
 4 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 0178d33..aad837b 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -21,7 +21,6 @@
 
 #include "clock.h"
 
-extern void omap1_check_revision(void);
 extern void omap_sram_init(void);
 
 /*
@@ -103,7 +102,7 @@ void __init omap1_map_common_io(void)
 	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
 	 */
-	omap1_check_revision();
+	omap_check_revision();
 
 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index b4860b6..e7fe326 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -239,7 +239,7 @@ static void __init _omap2_map_common_io(void)
 	local_flush_tlb_all();
 	flush_cache_all();
 
-	omap2_check_revision();
+	omap_check_revision();
 	omap_sram_init();
 	omap_vram_reserve_sdram();
 }
diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 219c01e..459a45f 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -81,6 +81,17 @@ const void *omap_get_var_config(u16 tag, size_t *len)
 }
 EXPORT_SYMBOL(omap_get_var_config);
 
+void __init omap_check_revision()
+{
+#ifdef CONFIG_ARCH_OMAP1
+	if (cpu_is_omap7xx() || cpu_is_omap15xx() || cpu_is_omap16xx())
+		omap1_check_revision();
+#endif
+#ifdef CONFIG_ARCH_OMAP2PLUS
+	if (cpu_is_omap24xx() || cpu_is_omap34xx() || cpu_is_omap44xx())
+		omap2_check_revision();
+#endif
+}
 /*
  * 32KHz clocksource ... always available, on pretty most chips except
  * OMAP 730 and 1510.  Other timers could be used as clocksources, with
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 7514174..5f12a0b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -431,7 +431,18 @@ IS_OMAP_TYPE(3517, 0x3517)
 
 
 int omap_chip_is(struct omap_chip_id oci);
-void omap2_check_revision(void);
+#ifdef CONFIG_ARCH_OMAP2PLUS
+extern void omap2_check_revision(void);
+#else
+static inline void omap2_check_revision(void) {}
+#endif
+
+#ifdef CONFIG_ARCH_OMAP1
+extern void omap1_check_revision(void);
+#else
+static inline void omap1_check_revision(void) {}
+#endif
+void omap_check_revision(void);
 
 /*
  * Runtime detection of OMAP3 features
-- 
1.6.3.3

