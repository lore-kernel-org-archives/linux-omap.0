From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/9] omap1: rename check_revision
Date: Tue, 22 Jun 2010 21:16:07 -0500
Message-ID: <1277259375-18521-2-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:35613 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751493Ab0FWCQa (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 22:16:30 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

Rename omap_check_revision to omap1_check_revision to make it
evident that this is omap1 features to check. This will allow
us to introduce a omap generic check feature capability

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
 arch/arm/mach-omap1/id.c |    2 +-
 arch/arm/mach-omap1/io.c |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap1/id.c b/arch/arm/mach-omap1/id.c
index a0e3560..91dbb71 100644
--- a/arch/arm/mach-omap1/id.c
+++ b/arch/arm/mach-omap1/id.c
@@ -118,7 +118,7 @@ static u8 __init omap_get_die_rev(void)
 	return die_rev;
 }
 
-void __init omap_check_revision(void)
+void __init omap1_check_revision(void)
 {
 	int i;
 	u16 jtag_id;
diff --git a/arch/arm/mach-omap1/io.c b/arch/arm/mach-omap1/io.c
index 0ce3fec..e4d8680 100644
--- a/arch/arm/mach-omap1/io.c
+++ b/arch/arm/mach-omap1/io.c
@@ -20,7 +20,7 @@
 
 #include "clock.h"
 
-extern void omap_check_revision(void);
+extern void omap1_check_revision(void);
 extern void omap_sram_init(void);
 
 /*
@@ -102,7 +102,7 @@ void __init omap1_map_common_io(void)
 	/* We want to check CPU revision early for cpu_is_omapxxxx() macros.
 	 * IO space mapping must be initialized before we can do that.
 	 */
-	omap_check_revision();
+	omap1_check_revision();
 
 #if defined (CONFIG_ARCH_OMAP730) || defined (CONFIG_ARCH_OMAP850)
 	if (cpu_is_omap7xx()) {
-- 
1.6.3.3

