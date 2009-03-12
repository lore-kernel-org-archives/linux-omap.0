From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 83/86] [ARM] OMAP3: update ES level flags to discriminate between post-ES2 revisions
Date: Thu, 12 Mar 2009 11:28:33 -0700
Message-ID: <1236882516-29403-84-git-send-email-khilman@deeprootsystems.com>
References: <1236882516-29403-1-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-2-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-3-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-4-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-5-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-6-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-7-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-8-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-9-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-10-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-11-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-12-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-13-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-14-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-15-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-16-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-17-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-18-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-19-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-20-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-21-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-22-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-23-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-24-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-25-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-26-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-27-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-28-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-29-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-30-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-31-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-32-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-33-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-34-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-35-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-36-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-37-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-38-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-39-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-40-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-41-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-42-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-43-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-44-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-45-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-46-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-47-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-48-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-49-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-50-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-51-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-52-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-53-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-54-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-55-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-56-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-57-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-58-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-59-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-60-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-61-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-62-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-63-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-64-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-65-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-66-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-67-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-68-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-69-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-70-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-71-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-72-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-73-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-74-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-75-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-76-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-77-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-78-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-79-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-80-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-81-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-82-git-send-email-khilman@deeprootsystems.com>
 <1236882516-29403-83-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from qw-out-2122.google.com ([74.125.92.27]:42234 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757268AbZCLSen (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 14:34:43 -0400
Received: by qw-out-2122.google.com with SMTP id 5so1105551qwi.37
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 11:34:40 -0700 (PDT)
In-Reply-To: <1236882516-29403-83-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

From: Paul Walmsley <paul@pwsan.com>

Some OMAP3 chip behaviors change in ES levels after ES2.  Modify the
existing omap_chip flags to add options for ES3.0 and ES3.1.

Add a new macro, CHIP_GE_OMAP3430ES2, to cover ES levels from ES2
onwards - a common pattern for OMAP3 features.  Update all current
users of the omap_chip macros to use this new macro.

Also add CHIP_GE_OMAP3430ES3_1 to cover the USBTLL SAR errata case
(described and fixed in the following patch)

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-omap2/clockdomains.h     |    6 +++---
 arch/arm/mach-omap2/id.c               |    7 ++++++-
 arch/arm/mach-omap2/powerdomains34xx.h |    6 +++---
 arch/arm/plat-omap/include/mach/cpu.h  |   26 ++++++++++++++++++++------
 4 files changed, 32 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index d7db796..281d5da 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -182,7 +182,7 @@ static struct clockdomain sgx_clkdm = {
 	.pwrdm		= { .name = "sgx_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_SGX_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 /*
@@ -237,7 +237,7 @@ static struct clockdomain usbhost_clkdm = {
 	.pwrdm		= { .name = "usbhost_pwrdm" },
 	.flags		= CLKDM_CAN_HWSUP_SWSUP,
 	.clktrctrl_mask = OMAP3430ES2_CLKTRCTRL_USBHOST_MASK,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 static struct clockdomain per_clkdm = {
@@ -287,7 +287,7 @@ static struct clockdomain dpll4_clkdm = {
 static struct clockdomain dpll5_clkdm = {
 	.name		= "dpll5_clkdm",
 	.pwrdm		= { .name = "dpll5_pwrdm" },
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 #endif   /* CONFIG_ARCH_OMAP34XX */
diff --git a/arch/arm/mach-omap2/id.c b/arch/arm/mach-omap2/id.c
index b52a02f..34b5914 100644
--- a/arch/arm/mach-omap2/id.c
+++ b/arch/arm/mach-omap2/id.c
@@ -217,8 +217,13 @@ void __init omap2_check_revision(void)
 		omap_chip.oc = CHIP_IS_OMAP3430;
 		if (omap_rev() == OMAP3430_REV_ES1_0)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES1;
-		else if (omap_rev() > OMAP3430_REV_ES1_0)
+		else if (omap_rev() >= OMAP3430_REV_ES2_0 &&
+			 omap_rev() <= OMAP3430_REV_ES2_1)
 			omap_chip.oc |= CHIP_IS_OMAP3430ES2;
+		else if (omap_rev() == OMAP3430_REV_ES3_0)
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_0;
+		else if (omap_rev() == OMAP3430_REV_ES3_1)
+			omap_chip.oc |= CHIP_IS_OMAP3430ES3_1;
 	} else {
 		pr_err("Uninitialized omap_chip, please fix!\n");
 	}
diff --git a/arch/arm/mach-omap2/powerdomains34xx.h b/arch/arm/mach-omap2/powerdomains34xx.h
index 15c346c..78acfce 100644
--- a/arch/arm/mach-omap2/powerdomains34xx.h
+++ b/arch/arm/mach-omap2/powerdomains34xx.h
@@ -244,7 +244,7 @@ static struct powerdomain dss_pwrdm = {
 static struct powerdomain sgx_pwrdm = {
 	.name		  = "sgx_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_SGX_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.wkdep_srcs	  = gfx_sgx_wkdeps,
 	.sleepdep_srcs	  = cam_gfx_sleepdeps,
 	/* XXX This is accurate for 3430 SGX, but what about GFX? */
@@ -312,7 +312,7 @@ static struct powerdomain neon_pwrdm = {
 static struct powerdomain usbhost_pwrdm = {
 	.name		  = "usbhost_pwrdm",
 	.prcm_offs	  = OMAP3430ES2_USBHOST_MOD,
-	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	  = OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 	.wkdep_srcs	  = per_usbhost_wkdeps,
 	.sleepdep_srcs	  = dss_per_usbhost_sleepdeps,
 	.pwrsts		  = PWRSTS_OFF_RET_ON,
@@ -354,7 +354,7 @@ static struct powerdomain dpll4_pwrdm = {
 static struct powerdomain dpll5_pwrdm = {
 	.name		= "dpll5_pwrdm",
 	.prcm_offs	= PLL_MOD,
-	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP3430ES2),
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_GE_OMAP3430ES2),
 };
 
 
diff --git a/arch/arm/plat-omap/include/mach/cpu.h b/arch/arm/plat-omap/include/mach/cpu.h
index a8e1178..4166a97 100644
--- a/arch/arm/plat-omap/include/mach/cpu.h
+++ b/arch/arm/plat-omap/include/mach/cpu.h
@@ -355,13 +355,27 @@ IS_OMAP_TYPE(3430, 0x3430)
  * use omap_chip_is().
  *
  */
-#define CHIP_IS_OMAP2420       (1 << 0)
-#define CHIP_IS_OMAP2430       (1 << 1)
-#define CHIP_IS_OMAP3430       (1 << 2)
-#define CHIP_IS_OMAP3430ES1    (1 << 3)
-#define CHIP_IS_OMAP3430ES2    (1 << 4)
+#define CHIP_IS_OMAP2420		(1 << 0)
+#define CHIP_IS_OMAP2430		(1 << 1)
+#define CHIP_IS_OMAP3430		(1 << 2)
+#define CHIP_IS_OMAP3430ES1		(1 << 3)
+#define CHIP_IS_OMAP3430ES2		(1 << 4)
+#define CHIP_IS_OMAP3430ES3_0		(1 << 5)
+#define CHIP_IS_OMAP3430ES3_1		(1 << 6)
+
+#define CHIP_IS_OMAP24XX		(CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
+
+/*
+ * "GE" here represents "greater than or equal to" in terms of ES
+ * levels.  So CHIP_GE_OMAP3430ES2 is intended to match all OMAP3430
+ * chips at ES2 and beyond, but not, for example, any OMAP lines after
+ * OMAP3.
+ */
+#define CHIP_GE_OMAP3430ES2		(CHIP_IS_OMAP3430ES2 | \
+					 CHIP_IS_OMAP3430ES3_0 | \
+					 CHIP_IS_OMAP3430ES3_1)
+#define CHIP_GE_OMAP3430ES3_1		(CHIP_IS_OMAP3430ES3_1)
 
-#define CHIP_IS_OMAP24XX       (CHIP_IS_OMAP2420 | CHIP_IS_OMAP2430)
 
 int omap_chip_is(struct omap_chip_id oci);
 int omap_type(void);
-- 
1.6.1.2

