From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCH 03/18] ARM: OMAP2/3: CM: remove some external dependencies
Date: Tue, 4 Mar 2014 18:19:03 +0200
Message-ID: <1393949958-816-4-git-send-email-t-kristo@ti.com>
References: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48460 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751282AbaCDQUN (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 4 Mar 2014 11:20:13 -0500
In-Reply-To: <1393949958-816-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, khilman@linaro.org
Cc: linux-arm-kernel@lists.infradead.org

Done in preparation to move the CM driver to its own driver folder.
These drivers will not have access to functionality under mach-omap2 anymore.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/cm2xxx.c |   15 ++-------------
 arch/arm/mach-omap2/cm3xxx.c |   13 +------------
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/arm/mach-omap2/cm2xxx.c b/arch/arm/mach-omap2/cm2xxx.c
index ce25abb..8be6ea5 100644
--- a/arch/arm/mach-omap2/cm2xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx.c
@@ -18,9 +18,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "soc.h"
-#include "iomap.h"
-#include "common.h"
 #include "prm2xxx.h"
 #include "cm.h"
 #include "cm2xxx.h"
@@ -390,7 +387,7 @@ void omap2xxx_cm_set_mod_dividers(u32 mpu, u32 dsp, u32 gfx, u32 core, u32 mdm)
 	tmp = omap2_cm_read_mod_reg(CORE_MOD, CM_CLKSEL1) &
 		OMAP24XX_CLKSEL_DSS2_MASK;
 	omap2_cm_write_mod_reg(core | tmp, CORE_MOD, CM_CLKSEL1);
-	if (cpu_is_omap2430())
+	if (mdm)
 		omap2_cm_write_mod_reg(mdm, OMAP2430_MDM_MOD, CM_CLKSEL);
 }
 
@@ -405,19 +402,11 @@ static struct cm_ll_data omap2xxx_cm_ll_data = {
 
 int __init omap2xxx_cm_init(void)
 {
-	if (!cpu_is_omap24xx())
-		return 0;
-
 	return cm_register(&omap2xxx_cm_ll_data);
 }
 
 static void __exit omap2xxx_cm_exit(void)
 {
-	if (!cpu_is_omap24xx())
-		return;
-
-	/* Should never happen */
-	WARN(cm_unregister(&omap2xxx_cm_ll_data),
-	     "%s: cm_ll_data function pointer mismatch\n", __func__);
+	cm_unregister(&omap2xxx_cm_ll_data);
 }
 __exitcall(omap2xxx_cm_exit);
diff --git a/arch/arm/mach-omap2/cm3xxx.c b/arch/arm/mach-omap2/cm3xxx.c
index 60c2c9f..129a4e7 100644
--- a/arch/arm/mach-omap2/cm3xxx.c
+++ b/arch/arm/mach-omap2/cm3xxx.c
@@ -18,9 +18,6 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
-#include "soc.h"
-#include "iomap.h"
-#include "common.h"
 #include "prm2xxx_3xxx.h"
 #include "cm.h"
 #include "cm3xxx.h"
@@ -673,19 +670,11 @@ static struct cm_ll_data omap3xxx_cm_ll_data = {
 
 int __init omap3xxx_cm_init(void)
 {
-	if (!cpu_is_omap34xx())
-		return 0;
-
 	return cm_register(&omap3xxx_cm_ll_data);
 }
 
 static void __exit omap3xxx_cm_exit(void)
 {
-	if (!cpu_is_omap34xx())
-		return;
-
-	/* Should never happen */
-	WARN(cm_unregister(&omap3xxx_cm_ll_data),
-	     "%s: cm_ll_data function pointer mismatch\n", __func__);
+	cm_unregister(&omap3xxx_cm_ll_data);
 }
 __exitcall(omap3xxx_cm_exit);
-- 
1.7.9.5

