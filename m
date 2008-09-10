From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH v2 01/12] OMAP2/3 clockdomains: add CM and PRM clkdms
Date: Wed, 10 Sep 2008 10:47:36 -0600
Message-ID: <20080910164730.17024.2889.stgit@localhost.localdomain>
References: <20080910164631.17024.43733.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:58250 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753388AbYIJQsv (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 10 Sep 2008 12:48:51 -0400
In-Reply-To: <20080910164631.17024.43733.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>

Add clockdomains for the CM and PRM.  These will ultimately replace the
"wkup_clkdm", which appears to not actually exist on the hardware.


Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/clockdomains.h            |   19 +++++++++++++++++++
 arch/arm/plat-omap/include/mach/powerdomain.h |    4 ++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains.h b/arch/arm/mach-omap2/clockdomains.h
index e17c369..ec5a720 100644
--- a/arch/arm/mach-omap2/clockdomains.h
+++ b/arch/arm/mach-omap2/clockdomains.h
@@ -14,6 +14,11 @@
 
 /*
  * OMAP2/3-common clockdomains
+ *
+ * Even though the 2420 has a single PRCM module from the
+ * interconnect's perspective, internally it does appear to have
+ * separate PRM and CM clockdomains.  The usual test case is
+ * sys_clkout/sys_clkout2.
  */
 
 /* This is an implicit clockdomain - it is never defined as such in TRM */
@@ -23,6 +28,18 @@ static struct clockdomain wkup_clkdm = {
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 };
 
+static struct clockdomain prm_clkdm = {
+	.name		= "prm_clkdm",
+	.pwrdm		= { .name = "wkup_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+};
+
+static struct clockdomain cm_clkdm = {
+	.name		= "cm_clkdm",
+	.pwrdm		= { .name = "core_pwrdm" },
+	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
+};
+
 /*
  * 2420-only clockdomains
  */
@@ -266,6 +283,8 @@ static struct clkdm_pwrdm_autodep clkdm_pwrdm_autodeps[] = {
 static struct clockdomain *clockdomains_omap[] = {
 
 	&wkup_clkdm,
+	&cm_clkdm,
+	&prm_clkdm,
 
 #ifdef CONFIG_ARCH_OMAP2420
 	&mpu_2420_clkdm,
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index 4948cb7..69c9e67 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -50,9 +50,9 @@
 
 /*
  * Maximum number of clockdomains that can be associated with a powerdomain.
- * CORE powerdomain is probably the worst case.
+ * CORE powerdomain on OMAP3 is the worst case
  */
-#define PWRDM_MAX_CLKDMS	3
+#define PWRDM_MAX_CLKDMS	4
 
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000


