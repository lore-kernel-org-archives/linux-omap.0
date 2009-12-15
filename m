From: Abhijit Pagare <abhijitpagare@ti.com>
Subject: [v2 PATCH 1/5] ARM: OMAP4: PM: OMAP4 essential basic initialisations.
Date: Tue, 15 Dec 2009 19:15:30 +0530
Message-ID: <1260884734-24579-1-git-send-email-abhijitpagare@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43430 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751243AbZLONpq (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 15 Dec 2009 08:45:46 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Abhijit Pagare <abhijitpagare@ti.com>, Paul Walmsley <paul@pwsan.com>, Benoit Cousson <b-cousson@ti.com>, Rajendra Nayak <rnayak@ti.com>

Some of the OMAP4 specific chip level initialisations are taken care of.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/id.c              |    2 ++
 arch/arm/plat-omap/include/plat/cpu.h |    6 +++++-
 2 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index a091b53..a779240 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -392,6 +392,8 @@ void __init omap2_check_revision(void)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 		else if (omap_rev() == OMAP3630_REV_ES1_0)
 			omap_chip.oc |= CHIP_IS_OMAP3630ES1;
+	} else if (cpu_is_omap44xx()) {
+		omap_chip.oc |= CHIP_IS_OMAP4430;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
 	}
diff --git a/arch/arm/plat-omap/include/plat/cpu.h b/arch/arm/plat-omap/include/plat/cpu.h
index 9a028bd..3181436 100644
--- a/arch/arm/plat-omap/include/plat/cpu.h
+++ b/arch/arm/plat-omap/include/plat/cpu.h
@@ -44,7 +44,7 @@
 int omap_type(void);
 
 struct omap_chip_id {
-	u8 oc;
+	u16 oc;
 	u8 type;
 };
 
@@ -154,6 +154,7 @@ unsigned int omap_rev(void);
  * cpu_is_omap242x():	True for OMAP2420, OMAP2422, OMAP2423
  * cpu_is_omap243x():	True for OMAP2430
  * cpu_is_omap343x():	True for OMAP3430
+ * cpu_is_omap443x():	True for OMAP4430
  */
 #define GET_OMAP_CLASS	(omap_rev() & 0xff)
 
@@ -286,6 +287,7 @@ IS_OMAP_SUBCLASS(443x, 0x443)
  * cpu_is_omap2423():	True for OMAP2423
  * cpu_is_omap2430():	True for OMAP2430
  * cpu_is_omap3430():	True for OMAP3430
+ * cpu_is_omap4430():	True for OMAP4430
  * cpu_is_omap3505():	True for OMAP3505
  * cpu_is_omap3517():	True for OMAP3517
  */
@@ -334,6 +336,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define cpu_is_omap3505()		0
 #define cpu_is_omap3517()		0
 #define cpu_is_omap3430()		0
+#define cpu_is_omap4430()		0
 #define cpu_is_omap3630()		0
 
 /*
@@ -470,6 +473,7 @@ IS_OMAP_TYPE(3517, 0x3517)
 #define CHIP_IS_OMAP3430ES3_0		(1 << 5)
 #define CHIP_IS_OMAP3430ES3_1		(1 << 6)
 #define CHIP_IS_OMAP3630ES1		(1 << 7)
+#define CHIP_IS_OMAP4430		(1 << 8)
 
 #define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
-- 
1.5.4.7

