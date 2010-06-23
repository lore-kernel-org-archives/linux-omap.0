From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/9] omap2/3: id: fix sparse warning
Date: Tue, 22 Jun 2010 21:16:08 -0500
Message-ID: <1277259375-18521-3-git-send-email-nm@ti.com>
References: <1277259375-18521-1-git-send-email-nm@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:34618 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751152Ab0FWCQ3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 22 Jun 2010 22:16:29 -0400
In-Reply-To: <1277259375-18521-1-git-send-email-nm@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
Cc: Venkatraman S <svenkatr@ti.com>, Senthilvadivu Guruswamy <svadivu@ti.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>, Angelo Arrifano <miknix@gmail.com>, "Zebediah C. McClure" <zmc@lurian.net>, Alistair Buxton <a.j.buxton@gmail.com>, Paul Walmsley <paul@pwsan.com>, Sanjeev Premi <premi@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Kevin Hilman <khilman@deeprootsystems.com>, Tomi Valkeinen <tomi.valkeinen@nokia.com>, Aaro Koskinen <aaro.koskinen@nokia.com>, Vikram Pandita <vikram.pandita@ti.com>, Vishwanath S <vishwa.s@ti.com>, linux-omap@vger.kernel.org

omap24xx_check_revision, omap3_check_features,
omap3_check_revision, omap4_check_revision, omap3_cpuinfo
are not used elsewhere, it should be static

Also fixes the following sparse warnings:
arch/arm/mach-omap2/id.c:105:13: warning: symbol 'omap24xx_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:167:13: warning: symbol 'omap3_check_features' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:189:13: warning: symbol 'omap3_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:270:13: warning: symbol 'omap4_check_revision' was not declared. Should it be static?
arch/arm/mach-omap2/id.c:300:13: warning: symbol 'omap3_cpuinfo' was not declared. Should it be static?

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
 arch/arm/mach-omap2/id.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 37b8a1a..c7bf0e1 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -102,7 +102,7 @@ static struct omap_id omap_ids[] __initdata = {
 static void __iomem *tap_base;
 static u16 tap_prod_id;
 
-void __init omap24xx_check_revision(void)
+static void __init omap24xx_check_revision(void)
 {
 	int i, j;
 	u32 idcode, prod_id;
@@ -164,7 +164,7 @@ void __init omap24xx_check_revision(void)
 		omap3_features |= OMAP3_HAS_ ##feat;			\
 	}
 
-void __init omap3_check_features(void)
+static void __init omap3_check_features(void)
 {
 	u32 status;
 
@@ -186,7 +186,7 @@ void __init omap3_check_features(void)
 	 */
 }
 
-void __init omap3_check_revision(void)
+static void __init omap3_check_revision(void)
 {
 	u32 cpuid, idcode;
 	u16 hawkeye;
@@ -267,7 +267,7 @@ void __init omap3_check_revision(void)
 	}
 }
 
-void __init omap4_check_revision(void)
+static void __init omap4_check_revision(void)
 {
 	u32 idcode;
 	u16 hawkeye;
@@ -297,7 +297,7 @@ void __init omap4_check_revision(void)
 	if (omap3_has_ ##feat())		\
 		printk(#feat" ");
 
-void __init omap3_cpuinfo(void)
+static void __init omap3_cpuinfo(void)
 {
 	u8 rev = GET_OMAP_REVISION();
 	char cpu_name[16], cpu_rev[16];
-- 
1.6.3.3

