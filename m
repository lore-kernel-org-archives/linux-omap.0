From: Abhijit.Pagare@india.ti.com
Subject: [PATCH 4/5] ARM: OMAP4: PM: Adapt the existing OMAP2/3 and common
	Power Domain Frameworks.
Date: Fri, 11 Dec 2009 16:15:55 +0530
Message-ID: <18252.692212309$1260528494@news.gmane.org>
References: <1260528356-11621-1-git-send-email-a0393848@linfarm476.(none)>
	<1260528356-11621-2-git-send-email-a0393848@linfarm476.(none)>
	<1260528356-11621-3-git-send-email-a0393848@linfarm476.(none)>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1260528356-11621-3-git-send-email-a0393848@linfarm476.(none)>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Rajendra Nayak <rnayak@ti.com>, Abhijit Pagare <abhijitpagare@ti.com>, Benoit Cousson <b-cousson@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Abhijit Pagare <abhijitpagare@ti.com>

Taking care of the platform specific and common power domains with proper checks.
Also refining some Macros according to the latest OMAP4 requirements.

Signed-off-by: Abhijit Pagare <abhijitpagare@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>
---
 arch/arm/mach-omap2/powerdomains.h            |   40 ++++++++++++++++++++++--
 arch/arm/plat-omap/include/plat/powerdomain.h |   10 +++---
 2 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains.h b/arch/arm/mach-omap2/powerdomains.h
index 057b2e3..81cf274 100644
--- a/arch/arm/mach-omap2/powerdomains.h
+++ b/arch/arm/mach-omap2/powerdomains.h
@@ -12,6 +12,12 @@
  * published by the Free Software Foundation.
  */
 
+/*
+ * To Do List
+ * -> Move the Sleep/Wakeup dependencies from Power Domain framework to
+ *    Clock Domain Framework
+ */
+
 #ifndef ARCH_ARM_MACH_OMAP2_POWERDOMAINS
 #define ARCH_ARM_MACH_OMAP2_POWERDOMAINS
 
@@ -71,6 +77,7 @@
 
 /* OMAP2/3-common powerdomains and wakeup dependencies */
 
+#ifndef CONFIG_ARCH_OMAP4
 /*
  * 2420/2430 PM_WKDEP_GFX: CORE, MPU, WKUP
  * 3430ES1 PM_WKDEP_GFX: adds IVA2, removes CORE
@@ -97,6 +104,7 @@ static struct pwrdm_dep gfx_sgx_wkdeps[] = {
 	},
 	{ NULL },
 };
+#endif
 
 /*
  * 3430: CM_SLEEPDEP_CAM: MPU
@@ -114,17 +122,20 @@ static struct pwrdm_dep cam_gfx_sleepdeps[] = {
 
 #include "powerdomains24xx.h"
 #include "powerdomains34xx.h"
+#include "powerdomains44xx.h"
 
 
 /*
  * OMAP2/3 common powerdomains
  */
 
+#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+
 /*
  * The GFX powerdomain is not present on 3430ES2, but currently we do not
  * have a macro to filter it out at compile-time.
  */
-static struct powerdomain gfx_pwrdm = {
+static struct powerdomain gfx_omap2_pwrdm = {
 	.name		  = "gfx_pwrdm",
 	.prcm_offs	  = GFX_MOD,
 	.omap_chip	  = OMAP_CHIP_INIT(CHIP_IS_OMAP24XX |
@@ -142,20 +153,23 @@ static struct powerdomain gfx_pwrdm = {
 	},
 };
 
-static struct powerdomain wkup_pwrdm = {
+static struct powerdomain wkup_omap2_pwrdm = {
 	.name		= "wkup_pwrdm",
 	.prcm_offs	= WKUP_MOD,
 	.omap_chip	= OMAP_CHIP_INIT(CHIP_IS_OMAP24XX | CHIP_IS_OMAP3430),
 	.dep_bit	= OMAP_EN_WKUP_SHIFT,
 };
 
+#endif
 
 
 /* As powerdomains are added or removed above, this list must also be changed */
 static struct powerdomain *powerdomains_omap[] __initdata = {
 
-	&gfx_pwrdm,
-	&wkup_pwrdm,
+#if defined(CONFIG_ARCH_OMAP24XX) | defined(CONFIG_ARCH_OMAP34XX)
+	&wkup_omap2_pwrdm,
+	&gfx_omap2_pwrdm,
+#endif
 
 #ifdef CONFIG_ARCH_OMAP24XX
 	&dsp_pwrdm,
@@ -186,6 +200,24 @@ static struct powerdomain *powerdomains_omap[] __initdata = {
 	&dpll5_pwrdm,
 #endif
 
+#ifdef CONFIG_ARCH_OMAP4
+	&core_44xx_pwrdm,
+	&gfx_44xx_pwrdm,
+	&abe_44xx_pwrdm,
+	&dss_44xx_pwrdm,
+	&tesla_44xx_pwrdm,
+	&wkup_44xx_pwrdm,
+	&cpu0_44xx_pwrdm,
+	&cpu1_44xx_pwrdm,
+	&emu_44xx_pwrdm,
+	&mpu_44xx_pwrdm,
+	&ivahd_44xx_pwrdm,
+	&cam_44xx_pwrdm,
+	&l3init_44xx_pwrdm,
+	&l4per_44xx_pwrdm,
+	&always_on_core_44xx_pwrdm,
+	&cefuse_44xx_pwrdm,
+#endif
 	NULL
 };
 
diff --git a/arch/arm/plat-omap/include/plat/powerdomain.h b/arch/arm/plat-omap/include/plat/powerdomain.h
index 1835a75..a34ce74 100644
--- a/arch/arm/plat-omap/include/plat/powerdomain.h
+++ b/arch/arm/plat-omap/include/plat/powerdomain.h
@@ -46,16 +46,16 @@
 
 
 /*
- * Number of memory banks that are power-controllable.	On OMAP3430, the
- * maximum is 4.
+ * Number of memory banks that are power-controllable.	On OMAP4430, the
+ * maximum is 5.
  */
-#define PWRDM_MAX_MEM_BANKS	4
+#define PWRDM_MAX_MEM_BANKS	5
 
 /*
  * Maximum number of clockdomains that can be associated with a powerdomain.
- * CORE powerdomain on OMAP3 is the worst case
+ * CORE powerdomain on OMAP4 is the worst case
  */
-#define PWRDM_MAX_CLKDMS	4
+#define PWRDM_MAX_CLKDMS	9
 
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
-- 
1.5.4.7
