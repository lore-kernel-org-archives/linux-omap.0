From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 1/6] ARM: OMAP2+: Update 81xx clock and power domains for
 default, active and sgx
Date: Fri,  4 Dec 2015 15:31:04 -0800
Message-ID: <1449271869-7614-2-git-send-email-tony@atomide.com>
References: <1449271869-7614-1-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449271869-7614-1-git-send-email-tony@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Paul Walmsley <paul@pwsan.com>, Matthijs van Duin <matthijsvanduin@gmail.com>, Neil Armstrong <narmstrong@baylibre.com>, Philipp Rosenberger <ilu@linutronix.de>, Tero Kristo <t-kristo@ti.com>, Delio Brignoli <dbrignoli@audioscience.com>, Brian Hutchinson <b.hutchman@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These offsets seem to be common, so let's rename the defines. And let's
set up the default_l3_slow_81xx_clkdm with active and default powerdomains
for dm814x. These are needed for usb to work.

Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/clockdomains81xx_data.c | 29 +++++++++++++++--------------
 arch/arm/mach-omap2/cm81xx.h                |  6 +++---
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 10 ++++++----
 3 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-omap2/clockdomains81xx_data.c b/arch/arm/mach-omap2/clockdomains81xx_data.c
index 53442c8..3b5fb05 100644
--- a/arch/arm/mach-omap2/clockdomains81xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains81xx_data.c
@@ -83,6 +83,14 @@ static struct clockdomain mmu_cfg_81xx_clkdm = {
 	.flags		= CLKDM_CAN_SWSUP,
 };
 
+static struct clockdomain default_l3_slow_81xx_clkdm = {
+	.name		= "default_l3_slow_clkdm",
+	.pwrdm		= { .name = "default_pwrdm" },
+	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
+	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
+	.flags		= CLKDM_CAN_SWSUP,
+};
+
 /* 816x only */
 
 static struct clockdomain alwon_mpu_816x_clkdm = {
@@ -96,7 +104,7 @@ static struct clockdomain alwon_mpu_816x_clkdm = {
 static struct clockdomain active_gem_816x_clkdm = {
 	.name		= "active_gem_clkdm",
 	.pwrdm		= { .name = "active_pwrdm" },
-	.cm_inst	= TI816X_CM_ACTIVE_MOD,
+	.cm_inst	= TI81XX_CM_ACTIVE_MOD,
 	.clkdm_offs	= TI816X_CM_ACTIVE_GEM_CLKDM,
 	.flags		= CLKDM_CAN_SWSUP,
 };
@@ -128,7 +136,7 @@ static struct clockdomain ivahd2_816x_clkdm = {
 static struct clockdomain sgx_816x_clkdm = {
 	.name		= "sgx_clkdm",
 	.pwrdm		= { .name = "sgx_pwrdm" },
-	.cm_inst	= TI816X_CM_SGX_MOD,
+	.cm_inst	= TI81XX_CM_SGX_MOD,
 	.clkdm_offs	= TI816X_CM_SGX_CLKDM,
 	.flags		= CLKDM_CAN_SWSUP,
 };
@@ -136,7 +144,7 @@ static struct clockdomain sgx_816x_clkdm = {
 static struct clockdomain default_l3_med_816x_clkdm = {
 	.name		= "default_l3_med_clkdm",
 	.pwrdm		= { .name = "default_pwrdm" },
-	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
 	.clkdm_offs	= TI816X_CM_DEFAULT_L3_MED_CLKDM,
 	.flags		= CLKDM_CAN_SWSUP,
 };
@@ -144,7 +152,7 @@ static struct clockdomain default_l3_med_816x_clkdm = {
 static struct clockdomain default_ducati_816x_clkdm = {
 	.name		= "default_ducati_clkdm",
 	.pwrdm		= { .name = "default_pwrdm" },
-	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
 	.clkdm_offs	= TI816X_CM_DEFAULT_DUCATI_CLKDM,
 	.flags		= CLKDM_CAN_SWSUP,
 };
@@ -152,19 +160,11 @@ static struct clockdomain default_ducati_816x_clkdm = {
 static struct clockdomain default_pci_816x_clkdm = {
 	.name		= "default_pci_clkdm",
 	.pwrdm		= { .name = "default_pwrdm" },
-	.cm_inst	= TI816X_CM_DEFAULT_MOD,
+	.cm_inst	= TI81XX_CM_DEFAULT_MOD,
 	.clkdm_offs	= TI816X_CM_DEFAULT_PCI_CLKDM,
 	.flags		= CLKDM_CAN_SWSUP,
 };
 
-static struct clockdomain default_l3_slow_816x_clkdm = {
-	.name		= "default_l3_slow_clkdm",
-	.pwrdm		= { .name = "default_pwrdm" },
-	.cm_inst	= TI816X_CM_DEFAULT_MOD,
-	.clkdm_offs	= TI816X_CM_DEFAULT_L3_SLOW_CLKDM,
-	.flags		= CLKDM_CAN_SWSUP,
-};
-
 static struct clockdomain *clockdomains_ti814x[] __initdata = {
 	&alwon_l3_slow_81xx_clkdm,
 	&alwon_l3_med_81xx_clkdm,
@@ -172,6 +172,7 @@ static struct clockdomain *clockdomains_ti814x[] __initdata = {
 	&alwon_ethernet_81xx_clkdm,
 	&mmu_81xx_clkdm,
 	&mmu_cfg_81xx_clkdm,
+	&default_l3_slow_81xx_clkdm,
 	NULL,
 };
 
@@ -198,7 +199,7 @@ static struct clockdomain *clockdomains_ti816x[] __initdata = {
 	&default_l3_med_816x_clkdm,
 	&default_ducati_816x_clkdm,
 	&default_pci_816x_clkdm,
-	&default_l3_slow_816x_clkdm,
+	&default_l3_slow_81xx_clkdm,
 	NULL,
 };
 
diff --git a/arch/arm/mach-omap2/cm81xx.h b/arch/arm/mach-omap2/cm81xx.h
index 45cb407..3a0ccf0 100644
--- a/arch/arm/mach-omap2/cm81xx.h
+++ b/arch/arm/mach-omap2/cm81xx.h
@@ -18,15 +18,15 @@
 #define __ARCH_ARM_MACH_OMAP2_CM_TI81XX_H
 
 /* TI81XX common CM module offsets */
+#define TI81XX_CM_ACTIVE_MOD			0x0400	/* 256B */
+#define TI81XX_CM_DEFAULT_MOD			0x0500	/* 256B */
 #define TI81XX_CM_ALWON_MOD			0x1400	/* 1KB */
+#define TI81XX_CM_SGX_MOD			0x0900	/* 256B */
 
 /* TI816X CM module offsets */
-#define TI816X_CM_ACTIVE_MOD			0x0400	/* 256B */
-#define TI816X_CM_DEFAULT_MOD			0x0500	/* 256B */
 #define TI816X_CM_IVAHD0_MOD			0x0600	/* 256B */
 #define TI816X_CM_IVAHD1_MOD			0x0700	/* 256B */
 #define TI816X_CM_IVAHD2_MOD			0x0800	/* 256B */
-#define TI816X_CM_SGX_MOD			0x0900	/* 256B */
 
 /* ALWON */
 #define TI81XX_CM_ALWON_L3_SLOW_CLKDM		0x0000
diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 2e00c7f..eb27ae0 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -384,14 +384,14 @@ static struct powerdomain isp_814x_pwrdm = {
 	.voltdm		= { .name = "core" },
 };
 
-static struct powerdomain active_816x_pwrdm = {
+static struct powerdomain active_81xx_pwrdm = {
 	.name		  = "active_pwrdm",
 	.prcm_offs	  = TI816X_PRM_ACTIVE_MOD,
 	.pwrsts		  = PWRSTS_OFF_ON,
 	.voltdm		  = { .name = "core" },
 };
 
-static struct powerdomain default_816x_pwrdm = {
+static struct powerdomain default_81xx_pwrdm = {
 	.name		  = "default_pwrdm",
 	.prcm_offs	  = TI81XX_PRM_DEFAULT_MOD,
 	.pwrsts		  = PWRSTS_OFF_ON,
@@ -486,6 +486,8 @@ static struct powerdomain *powerdomains_am35x[] __initdata = {
 static struct powerdomain *powerdomains_ti814x[] __initdata = {
 	&alwon_81xx_pwrdm,
 	&device_81xx_pwrdm,
+	&active_81xx_pwrdm,
+	&default_81xx_pwrdm,
 	&gem_814x_pwrdm,
 	&ivahd_814x_pwrdm,
 	&hdvpss_814x_pwrdm,
@@ -497,8 +499,8 @@ static struct powerdomain *powerdomains_ti814x[] __initdata = {
 static struct powerdomain *powerdomains_ti816x[] __initdata = {
 	&alwon_81xx_pwrdm,
 	&device_81xx_pwrdm,
-	&active_816x_pwrdm,
-	&default_816x_pwrdm,
+	&active_81xx_pwrdm,
+	&default_81xx_pwrdm,
 	&ivahd0_816x_pwrdm,
 	&ivahd1_816x_pwrdm,
 	&ivahd2_816x_pwrdm,
-- 
2.6.2
