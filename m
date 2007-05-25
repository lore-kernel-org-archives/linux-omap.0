From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/7] omap2: add OMAP3430 register bit defines shared between
	CM and PRM
Date: Fri, 25 May 2007 02:31:47 -0600
Message-ID: <20070525083243.240774947@pwsan.com>
References: <20070525083145.236366049@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0002-omap2-add-OMAP3430-register-bit-defines-shared-betw.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add OMAP3430 register bit defines that are shared between the Clock
Management and Power/Reset Management registers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm_common.h |  118 +++++++++++++++++++++++++++++++++++++
 1 files changed, 118 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_common.h b/arch/arm/mach-omap2/prcm_common.h
index d2e1bfc..6fd64bf 100644
--- a/arch/arm/mach-omap2/prcm_common.h
+++ b/arch/arm/mach-omap2/prcm_common.h
@@ -148,5 +148,123 @@
 #define OMAP2430_ST_MDM					(1 << 0)
 
 
+/* 3430 register bits shared between CM & PRM registers */
+
+/* CM_REVISION, PRM_REVISION shared bits */
+#define OMAP3430_REV_SHIFT				0
+#define OMAP3430_REV_MASK				(0xff << 0)
+
+/* CM_SYSCONFIG, PRM_SYSCONFIG shared bits */
+#define OMAP3430_AUTOIDLE				(1 << 0)
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_MMC2				(1 << 25)
+#define OMAP3430_EN_MMC1				(1 << 24)
+#define OMAP3430_EN_MCSPI4				(1 << 21)
+#define OMAP3430_EN_MCSPI3				(1 << 20)
+#define OMAP3430_EN_MCSPI2				(1 << 19)
+#define OMAP3430_EN_MCSPI1				(1 << 18)
+#define OMAP3430_EN_I2C3				(1 << 17)
+#define OMAP3430_EN_I2C2				(1 << 16)
+#define OMAP3430_EN_I2C1				(1 << 15)
+#define OMAP3430_EN_UART2				(1 << 14)
+#define OMAP3430_EN_UART1				(1 << 13)
+#define OMAP3430_EN_GPT11				(1 << 12)
+#define OMAP3430_EN_GPT10				(1 << 11)
+#define OMAP3430_EN_MCBSP5				(1 << 10)
+#define OMAP3430_EN_MCBSP1				(1 << 9)
+#define OMAP3430_EN_FSHOSTUSB				(1 << 5)
+#define OMAP3430_EN_D2D					(1 << 3)
+
+/* CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP3430_EN_HSOTGUSB				(1 << 4)
+
+/* PM_WKST1_CORE, CM_IDLEST1_CORE shared bits */
+#define OMAP3430_ST_MMC2				(1 << 25)
+#define OMAP3430_ST_MMC1				(1 << 24)
+#define OMAP3430_ST_MCSPI4				(1 << 21)
+#define OMAP3430_ST_MCSPI3				(1 << 20)
+#define OMAP3430_ST_MCSPI2				(1 << 19)
+#define OMAP3430_ST_MCSPI1				(1 << 18)
+#define OMAP3430_ST_I2C3				(1 << 17)
+#define OMAP3430_ST_I2C2				(1 << 16)
+#define OMAP3430_ST_I2C1				(1 << 15)
+#define OMAP3430_ST_UART2				(1 << 14)
+#define OMAP3430_ST_UART1				(1 << 13)
+#define OMAP3430_ST_GPT11				(1 << 12)
+#define OMAP3430_ST_GPT10				(1 << 11)
+#define OMAP3430_ST_MCBSP5				(1 << 10)
+#define OMAP3430_ST_MCBSP1				(1 << 9)
+#define OMAP3430_ST_FSHOSTUSB				(1 << 5)
+#define OMAP3430_ST_HSOTGUSB				(1 << 4)
+#define OMAP3430_ST_D2D					(1 << 3)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPIO1				(1 << 3)
+#define OMAP3430_EN_GPT1				(1 << 0)
+
+/* CM_FCLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_SR2					(1 << 7)
+#define OMAP3430_EN_SR1					(1 << 6)
+
+/* CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP3430_EN_GPT12				(1 << 1)
+
+/* CM_IDLEST_WKUP, PM_WKST_WKUP shared bits */
+#define OMAP3430_ST_SR2					(1 << 7)
+#define OMAP3430_ST_SR1					(1 << 6)
+#define OMAP3430_ST_GPIO1				(1 << 3)
+#define OMAP3430_ST_GPT12				(1 << 1)
+#define OMAP3430_ST_GPT1				(1 << 0)
+
+/*
+ * CM_SLEEPDEP_GFX, CM_SLEEPDEP_DSS, CM_SLEEPDEP_CAM,
+ * CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_GFX,
+ * PM_WKDEP_DSS, PM_WKDEP_CAM, PM_WKDEP_PER, PM_WKDEP_NEON shared bits
+ */
+#define OMAP3430_EN_MPU					(1 << 1)
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER shared bits */
+#define OMAP3430_EN_GPIO6				(1 << 17)
+#define OMAP3430_EN_GPIO5				(1 << 16)
+#define OMAP3430_EN_GPIO4				(1 << 15)
+#define OMAP3430_EN_GPIO3				(1 << 14)
+#define OMAP3430_EN_GPIO2				(1 << 13)
+#define OMAP3430_EN_UART3				(1 << 11)
+#define OMAP3430_EN_GPT9				(1 << 10)
+#define OMAP3430_EN_GPT8				(1 << 9)
+#define OMAP3430_EN_GPT7				(1 << 8)
+#define OMAP3430_EN_GPT6				(1 << 7)
+#define OMAP3430_EN_GPT5				(1 << 6)
+#define OMAP3430_EN_GPT4				(1 << 5)
+#define OMAP3430_EN_GPT3				(1 << 4)
+#define OMAP3430_EN_GPT2				(1 << 3)
+
+/* CM_FCLKEN_PER, CM_ICLKEN_PER, PM_WKEN_PER, PM_WKST_PER shared bits */
+/* XXX Possible TI documentation bug: should the PM_WKST_PER EN_* bits
+ * be ST_* bits instead? */
+#define OMAP3430_EN_MCBSP4				(1 << 2)
+#define OMAP3430_EN_MCBSP3				(1 << 1)
+#define OMAP3430_EN_MCBSP2				(1 << 0)
+
+/* CM_IDLEST_PER, PM_WKST_PER shared bits */
+#define OMAP3430_ST_GPIO6				(1 << 17)
+#define OMAP3430_ST_GPIO5				(1 << 16)
+#define OMAP3430_ST_GPIO4				(1 << 15)
+#define OMAP3430_ST_GPIO3				(1 << 14)
+#define OMAP3430_ST_GPIO2				(1 << 13)
+#define OMAP3430_ST_UART3				(1 << 11)
+#define OMAP3430_ST_GPT9				(1 << 10)
+#define OMAP3430_ST_GPT8				(1 << 9)
+#define OMAP3430_ST_GPT7				(1 << 8)
+#define OMAP3430_ST_GPT6				(1 << 7)
+#define OMAP3430_ST_GPT5				(1 << 6)
+#define OMAP3430_ST_GPT4				(1 << 5)
+#define OMAP3430_ST_GPT3				(1 << 4)
+#define OMAP3430_ST_GPT2				(1 << 3)
+
+/* CM_SLEEPDEP_PER, PM_WKDEP_IVA2, PM_WKDEP_MPU, PM_WKDEP_PER shared bits */
+#define OMAP3430_EN_CORE				(1 << 0)
+
 #endif
 
-- 
1.5.1.3

-- 
