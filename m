From: Vikram Pandita <vikram.pandita@ti.com>
Subject: [PATCH v2 2/2] omap: 3630: update is_chip variable
Date: Tue, 20 Oct 2009 17:26:26 -0500
Message-ID: <1256077586-11636-2-git-send-email-vikram.pandita@ti.com>
References: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56950 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbZJTW2d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Oct 2009 18:28:33 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id n9KMScfX010997
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-omap@vger.kernel.org>; Tue, 20 Oct 2009 17:28:38 -0500
In-Reply-To: <1256077586-11636-1-git-send-email-vikram.pandita@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: r-woodruff2@ti.com, Vikram Pandita <vikram.pandita@ti.com>, "Menon, Nishanth" <nm@ti.com>

3630 is getting treated like next rev of 3430
omap_chip.oc variable has to be updated for 3630 version
Provide space for 3430 future ES rev (bit7 to bit9)

Otherwise the Core power domain is not getting registered.

This gets used in the registration of power domains in:
"arch/arm/mach-omap2/powerdomains34xx.h"
core_34xx_es3_1_pwrdm
OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES3_1)

Core power doman will get registered for 3630 only when .oc is pouplated
correctly.

Tested on Zoom3(3630) board

Signed-off-by: Vikram Pandita <vikram.pandita@ti.com>
Signed-off-by: Menon, Nishanth <nm@ti.com>
---
 arch/arm/mach-omap2/id.c              |    2 ++
 arch/arm/plat-omap/include/plat/cpu.h |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index 1c15112..189cf7a 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -359,6 +359,8 @@ void __init omap2_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
 		else if (omap_rev() == OMAP3430_REV_ES3_1)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
+		else if (omap_rev() == OMAP3630_REV_ES1_0)
+			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
 	}
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 922bf1c..5c95e4b 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -454,6 +454,8 @@ IS_OMAP_TYPE(3430, 0x3430)
 #define CHIP_IS_OMAP3430ES2		(1 << 4)
 #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
+/* Space for future revisions of 3430: bit7 to bit9 */
+#define CHIP_IS_OMAP3630ES1		(1 << 10)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
@@ -465,8 +467,10 @@ IS_OMAP_TYPE(3430, 0x3430)
  */
 #define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
 					 CHIP_IS_OMAP3430ES3_0 | \
-					 CHIP_IS_OMAP3430ES3_1)
-#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
+					 CHIP_IS_OMAP3430ES3_1 | \
+					 CHIP_IS_OMAP3630ES1)
+#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1 | \
+					 CHIP_IS_OMAP3630ES1)
 
 
 int omap_chip_is(struct omap_chip_id oci);
-- 
1.6.5.rc1.19.g8426

