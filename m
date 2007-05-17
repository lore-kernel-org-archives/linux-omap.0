From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 02/18] omap2: add OMAP24XX register bit defines shared
	between CM and PRM
Date: Wed, 16 May 2007 18:11:34 -0600
Message-ID: <20070517005443.399985936@pwsan.com>
References: <20070517001132.652728079@pwsan.com>
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline;
	filename=0002-omap2-add-OMAP24XX-register-bit-defines-shared-betw.patch
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add OMAP24XX register bit defines that are shared between the Clock
Management and Power/Reset Management registers.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prcm_common.h |  105 +++++++++++++++++++++++++++++++++++++
 1 files changed, 105 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prcm_common.h b/arch/arm/mach-omap2/prcm_common.h
index 6275cae..5220b05 100644
--- a/arch/arm/mach-omap2/prcm_common.h
+++ b/arch/arm/mach-omap2/prcm_common.h
@@ -33,5 +33,110 @@
 #define OMAP2430_MDM_MOD				0xc00
 
 
+/* 24XX register bits shared between CM & PRM registers */
+
+/* CM_FCLKEN1_CORE, CM_ICLKEN1_CORE, PM_WKEN1_CORE shared bits */
+#define OMAP2420_EN_MMC_SHIFT				26
+#define OMAP2420_EN_MMC					(1 << 26)
+#define OMAP24XX_EN_UART2_SHIFT				22
+#define OMAP24XX_EN_UART2				(1 << 22)
+#define OMAP24XX_EN_UART1_SHIFT				21
+#define OMAP24XX_EN_UART1				(1 << 21)
+#define OMAP24XX_EN_MCSPI2_SHIFT			18
+#define OMAP24XX_EN_MCSPI2				(1 << 18)
+#define OMAP24XX_EN_MCSPI1_SHIFT			17
+#define OMAP24XX_EN_MCSPI1				(1 << 17)
+#define OMAP24XX_EN_MCBSP2_SHIFT			16
+#define OMAP24XX_EN_MCBSP2				(1 << 16)
+#define OMAP24XX_EN_MCBSP1_SHIFT			15
+#define OMAP24XX_EN_MCBSP1				(1 << 15)
+#define OMAP24XX_EN_GPT12_SHIFT				14
+#define OMAP24XX_EN_GPT12				(1 << 14)
+#define OMAP24XX_EN_GPT11_SHIFT				13
+#define OMAP24XX_EN_GPT11				(1 << 13)
+#define OMAP24XX_EN_GPT10_SHIFT				12
+#define OMAP24XX_EN_GPT10				(1 << 12)
+#define OMAP24XX_EN_GPT9_SHIFT				11
+#define OMAP24XX_EN_GPT9				(1 << 11)
+#define OMAP24XX_EN_GPT8_SHIFT				10
+#define OMAP24XX_EN_GPT8				(1 << 10)
+#define OMAP24XX_EN_GPT7_SHIFT				9
+#define OMAP24XX_EN_GPT7				(1 << 9)
+#define OMAP24XX_EN_GPT6_SHIFT				8
+#define OMAP24XX_EN_GPT6				(1 << 8)
+#define OMAP24XX_EN_GPT5_SHIFT				7
+#define OMAP24XX_EN_GPT5				(1 << 7)
+#define OMAP24XX_EN_GPT4_SHIFT				6
+#define OMAP24XX_EN_GPT4				(1 << 6)
+#define OMAP24XX_EN_GPT3_SHIFT				5
+#define OMAP24XX_EN_GPT3				(1 << 5)
+#define OMAP24XX_EN_GPT2_SHIFT				4
+#define OMAP24XX_EN_GPT2				(1 << 4)
+#define OMAP2420_EN_VLYNQ_SHIFT				3
+#define OMAP2420_EN_VLYNQ				(1 << 3)
+
+/* CM_FCLKEN2_CORE, CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_GPIO5_SHIFT				10
+#define OMAP2430_EN_GPIO5				(1 << 10)
+#define OMAP2430_EN_MCSPI3_SHIFT			9
+#define OMAP2430_EN_MCSPI3				(1 << 9)
+#define OMAP2430_EN_MMCHS2_SHIFT			8
+#define OMAP2430_EN_MMCHS2				(1 << 8)
+#define OMAP2430_EN_MMCHS1_SHIFT			7
+#define OMAP2430_EN_MMCHS1				(1 << 7)
+#define OMAP24XX_EN_UART3_SHIFT				2
+#define OMAP24XX_EN_UART3				(1 << 2)
+#define OMAP24XX_EN_USB_SHIFT				0
+#define OMAP24XX_EN_USB					(1 << 0)
+
+/* CM_ICLKEN2_CORE, PM_WKEN2_CORE shared bits */
+#define OMAP2430_EN_MDM_INTC_SHIFT			11
+#define OMAP2430_EN_MDM_INTC				(1 << 11)
+#define OMAP2430_EN_USBHS_SHIFT				6
+#define OMAP2430_EN_USBHS				(1 << 6)
+
+/* CM_IDLEST1_CORE, PM_WKST1_CORE shared bits */
+#define OMAP2420_ST_MMC					(1 << 26)
+#define OMAP24XX_ST_UART2				(1 << 22)
+#define OMAP24XX_ST_UART1				(1 << 21)
+#define OMAP24XX_ST_MCSPI2				(1 << 18)
+#define OMAP24XX_ST_MCSPI1				(1 << 17)
+#define OMAP24XX_ST_GPT12				(1 << 14)
+#define OMAP24XX_ST_GPT11				(1 << 13)
+#define OMAP24XX_ST_GPT10				(1 << 12)
+#define OMAP24XX_ST_GPT9				(1 << 11)
+#define OMAP24XX_ST_GPT8				(1 << 10)
+#define OMAP24XX_ST_GPT7				(1 << 9)
+#define OMAP24XX_ST_GPT6				(1 << 8)
+#define OMAP24XX_ST_GPT5				(1 << 7)
+#define OMAP24XX_ST_GPT4				(1 << 6)
+#define OMAP24XX_ST_GPT3				(1 << 5)
+#define OMAP24XX_ST_GPT2				(1 << 4)
+#define OMAP2420_ST_VLYNQ				(1 << 3)
+
+/* CM_IDLEST2_CORE, PM_WKST2_CORE shared bits */
+#define OMAP2430_ST_MDM_INTC				(1 << 11)
+#define OMAP2430_ST_GPIO5				(1 << 10)
+#define OMAP2430_ST_MCSPI3				(1 << 9)
+#define OMAP2430_ST_MMCHS2				(1 << 8)
+#define OMAP2430_ST_MMCHS1				(1 << 7)
+#define OMAP2430_ST_USBHS				(1 << 6)
+#define OMAP24XX_ST_UART3				(1 << 2)
+#define OMAP24XX_ST_USB					(1 << 0)
+
+/* CM_FCLKEN_WKUP, CM_ICLKEN_WKUP, PM_WKEN_WKUP shared bits */
+#define OMAP24XX_EN_GPIOS_SHIFT				2
+#define OMAP24XX_EN_GPIOS				(1 << 2)
+#define OMAP24XX_EN_GPT1_SHIFT				0
+#define OMAP24XX_EN_GPT1				(1 << 0)
+
+/* PM_WKST_WKUP, CM_IDLEST_WKUP shared bits */
+#define OMAP24XX_ST_GPIOS				(1 << 2)
+#define OMAP24XX_ST_GPT1				(1 << 0)
+
+/* CM_IDLEST_MDM and PM_WKST_MDM shared bits */
+#define OMAP2430_ST_MDM					(1 << 0)
+
+
 #endif
 
-- 
1.5.1.3

-- 
