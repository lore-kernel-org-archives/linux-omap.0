From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 07/18] omap2: add Power/Reset Management shared register bit
	defines to prm.h
Date: Fri, 25 May 2007 02:23:29 -0600
Message-ID: <20070525082501.833275353@pwsan.com>
References: <20070525082322.168056647@pwsan.com>
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-Disposition: inline;
	filename=0007-omap2-add-Power-Reset-Management-shared-register-bi.patch
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

Add Power/Reset Management register bit defines to prm.h that are
shared between OMAP24XX and OMAP3430.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
---
 arch/arm/mach-omap2/prm.h |  151 +++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/prm.h b/arch/arm/mach-omap2/prm.h
index a2e166d..dfe09f7 100644
--- a/arch/arm/mach-omap2/prm.h
+++ b/arch/arm/mach-omap2/prm.h
@@ -116,4 +116,155 @@ static u32 __attribute__((unused)) prm_read_mod_reg(s16 module, s16 idx)
 	return prm_read_reg(OMAP_PRM_REGADDR(module, idx));
 }
 
+
+/*
+ * Bits common to specific registers
+ *
+ * The 3430 register and bit names are generally used,
+ * since they tend to make more sense
+ */
+
+/* PM_EVGENONTIM_MPU */
+/* Named PM_EVEGENONTIM_MPU on the 24XX */
+#define OMAP_ONTIMEVAL_SHIFT				0
+#define OMAP_ONTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PM_EVGENOFFTIM_MPU */
+/* Named PM_EVEGENOFFTIM_MPU on the 24XX */
+#define OMAP_OFFTIMEVAL_SHIFT				0
+#define OMAP_OFFTIMEVAL_MASK				(0xffffffff << 0)
+
+/* PRM_CLKSETUP and PRCM_VOLTSETUP */
+/* Named PRCM_CLKSSETUP on the 24XX */
+#define OMAP_SETUP_TIME_SHIFT				0
+#define OMAP_SETUP_TIME_MASK				(0xffff << 0)
+
+/* PRM_CLKSRC_CTRL */
+/* Named PRCM_CLKSRC_CTRL on the 24XX */
+#define OMAP_SYSCLKDIV_SHIFT				6
+#define OMAP_SYSCLKDIV_MASK				(0x3 << 6)
+#define OMAP_AUTOEXTCLKMODE_SHIFT			3
+#define OMAP_AUTOEXTCLKMODE_MASK			(0x3 << 3)
+#define OMAP_SYSCLKSEL_SHIFT				0
+#define OMAP_SYSCLKSEL_MASK				(0x3 << 0)
+
+/* PM_EVGENCTRL_MPU */
+#define OMAP_OFFLOADMODE_SHIFT				3
+#define OMAP_OFFLOADMODE_MASK				(0x3 << 3)
+#define OMAP_ONLOADMODE_SHIFT				1
+#define OMAP_ONLOADMODE_MASK				(0x3 << 1)
+#define OMAP_ENABLE					(1 << 0)
+
+/* PRM_RSTTIME */
+/* Named RM_RSTTIME_WKUP on the 24xx */
+#define OMAP_RSTTIME2_SHIFT				8
+#define OMAP_RSTTIME2_MASK				(0x1f << 8)
+#define OMAP_RSTTIME1_SHIFT				0
+#define OMAP_RSTTIME1_MASK				(0xff << 0)
+
+
+/* PRM_RSTCTRL */
+/* Named RM_RSTCTRL_WKUP on the 24xx */
+/* 2420 calls RST_DPLL3 'RST_DPLL' */
+#define OMAP_RST_DPLL3					(1 << 2)
+#define OMAP_RST_GS					(1 << 1)
+
+
+/*
+ * Bits common to module-shared registers
+ *
+ * Not all registers of a particular type support all of these bits -
+ * check TRM if you are unsure
+ */
+
+/*
+ * 24XX: PM_PWSTST_CORE, PM_PWSTST_GFX, PM_PWSTST_MPU, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_INTRANSITION				(1 << 20)
+
+
+/*
+ * 24XX: PM_PWSTST_GFX, PM_PWSTST_DSP
+ *
+ * 2430: PM_PWSTST_MDM
+ *
+ * 3430: PM_PWSTST_IVA2, PM_PWSTST_MPU, PM_PWSTST_CORE, PM_PWSTST_GFX,
+ *	 PM_PWSTST_DSS, PM_PWSTST_CAM, PM_PWSTST_PER, PM_PWSTST_EMU,
+ *	 PM_PWSTST_NEON
+ */
+#define OMAP_POWERSTATEST_SHIFT				0
+#define OMAP_POWERSTATEST_MASK				(0x3 << 0)
+
+/*
+ * 24XX: RM_RSTST_MPU and RM_RSTST_DSP - on 24XX, 'COREDOMAINWKUP_RST' is
+ *	 called 'COREWKUP_RST'
+ *
+ * 3430: RM_RSTST_IVA2, RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSS,
+ *	 RM_RSTST_CAM, RM_RSTST_PER, RM_RSTST_NEON
+ */
+#define OMAP_COREDOMAINWKUP_RST				(1 << 3)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_GFX, RM_RSTST_DSP
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_DOMAINWKUP_RST				(1 << 2)
+
+/*
+ * 24XX: RM_RSTST_MPU, RM_RSTST_WKUP, RM_RSTST_DSP
+ *	 On 24XX, 'GLOBALWARM_RST' is called 'GLOBALWMPU_RST'.
+ *
+ * 2430: RM_RSTST_MDM
+ *
+ * 3430: RM_RSTST_CORE, RM_RSTST_EMU
+ */
+#define OMAP_GLOBALWARM_RST				(1 << 1)
+#define OMAP_GLOBALCOLD_RST				(1 << 0)
+
+/*
+ * 24XX: PM_WKDEP_GFX, PM_WKDEP_MPU, PM_WKDEP_CORE, PM_WKDEP_DSP
+ *	 2420 TRM sometimes uses "EN_WAKEUP" instead of "EN_WKUP"
+ *
+ * 2430: PM_WKDEP_MDM
+ *
+ * 3430: PM_WKDEP_IVA2, PM_WKDEP_GFX, PM_WKDEP_DSS, PM_WKDEP_CAM,
+ *	 PM_WKDEP_PER
+ */
+#define OMAP_EN_WKUP					(1 << 4)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSP
+ *
+ * 2430: PM_PWSTCTRL_MDM
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *	 PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON
+ */
+#define OMAP_LOGICRETSTATE				(1 << 2)
+
+/*
+ * 24XX: PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE, PM_PWSTCTRL_GFX,
+ *       PM_PWSTCTRL_DSP, PM_PWSTST_MPU
+ *
+ * 2430: PM_PWSTCTRL_MDM shared bits
+ *
+ * 3430: PM_PWSTCTRL_IVA2, PM_PWSTCTRL_MPU, PM_PWSTCTRL_CORE,
+ *	 PM_PWSTCTRL_GFX, PM_PWSTCTRL_DSS, PM_PWSTCTRL_CAM, PM_PWSTCTRL_PER,
+ *	 PM_PWSTCTRL_NEON shared bits
+ */
+#define OMAP_POWERSTATE_SHIFT				0
+#define OMAP_POWERSTATE_MASK				(0x3 << 0)
+
+
 #endif
-- 
1.5.1.3

-- 
