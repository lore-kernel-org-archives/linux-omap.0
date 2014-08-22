From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 1/7] ARM: OMAP: DRA7: powerdomain data: fix powerdomain powerstate
Date: Fri, 22 Aug 2014 08:49:27 -0500
Message-ID: <1408715373-25791-2-git-send-email-nm@ti.com>
References: <1408715373-25791-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408715373-25791-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Tero Kristo <t-kristo@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Keerthy <j-keerthy@ti.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

DRA7 supports only CSWR for CPU, MPU power domains. Core power domain
supports upto INA.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h          |    1 +
 arch/arm/mach-omap2/powerdomains7xx_data.c |   14 +++++++-------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index f472711..a754c82 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -39,6 +39,7 @@
 #define PWRSTS_OFF_RET		(PWRSTS_OFF | PWRSTS_RET)
 #define PWRSTS_RET_ON		(PWRSTS_RET | PWRSTS_ON)
 #define PWRSTS_OFF_RET_ON	(PWRSTS_OFF_RET | PWRSTS_ON)
+#define PWRSTS_INA_ON		(PWRSTS_INACTIVE | PWRSTS_ON)
 
 
 /*
diff --git a/arch/arm/mach-omap2/powerdomains7xx_data.c b/arch/arm/mach-omap2/powerdomains7xx_data.c
index 48151d1..287a203 100644
--- a/arch/arm/mach-omap2/powerdomains7xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains7xx_data.c
@@ -160,8 +160,8 @@ static struct powerdomain core_7xx_pwrdm = {
 	.name		  = "core_pwrdm",
 	.prcm_offs	  = DRA7XX_PRM_CORE_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
-	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts		  = PWRSTS_INA_ON,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* core_nret_bank */
@@ -193,8 +193,8 @@ static struct powerdomain cpu0_7xx_pwrdm = {
 	.name		  = "cpu0_pwrdm",
 	.prcm_offs	  = DRA7XX_MPU_PRCM_PRM_C0_INST,
 	.prcm_partition	  = DRA7XX_MPU_PRCM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu0_l1 */
@@ -209,8 +209,8 @@ static struct powerdomain cpu1_7xx_pwrdm = {
 	.name		  = "cpu1_pwrdm",
 	.prcm_offs	  = DRA7XX_MPU_PRCM_PRM_C1_INST,
 	.prcm_partition	  = DRA7XX_MPU_PRCM_PARTITION,
-	.pwrsts		  = PWRSTS_OFF_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 1,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* cpu1_l1 */
@@ -243,7 +243,7 @@ static struct powerdomain mpu_7xx_pwrdm = {
 	.prcm_offs	  = DRA7XX_PRM_MPU_INST,
 	.prcm_partition	  = DRA7XX_PRM_PARTITION,
 	.pwrsts		  = PWRSTS_RET_ON,
-	.pwrsts_logic_ret = PWRSTS_OFF_RET,
+	.pwrsts_logic_ret = PWRSTS_RET,
 	.banks		  = 2,
 	.pwrsts_mem_ret	= {
 		[0] = PWRSTS_OFF_RET,	/* mpu_l2 */
-- 
1.7.9.5
