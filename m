From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 18/27] ARM: OMAP: Add missing SMS_SYSCONFIG save/restore
Date: Wed, 14 Oct 2009 14:58:01 -0700
Message-ID: <1255557490-16787-19-git-send-email-khilman@deeprootsystems.com>
References: <1255557490-16787-1-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-2-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-3-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-4-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-5-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-6-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-7-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-8-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-9-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-10-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-11-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-12-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-13-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-14-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-15-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-16-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-17-git-send-email-khilman@deeprootsystems.com>
	<1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1255557490-16787-18-git-send-email-khilman@deeprootsystems.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

SMS_SYSCONFIG register gets reset in off mode, added
a save/restore mechanism for that.

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-omap2/pm34xx.c           |    1 +
 arch/arm/mach-omap2/sdrc.c             |   27 +++++++++++++++++++++++++++
 arch/arm/plat-omap/include/mach/sdrc.h |    2 ++
 3 files changed, 30 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
index 93f5988..80934c3 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -400,6 +400,7 @@ static void omap_sram_idle(void)
 			omap3_core_restore_context();
 			omap3_prcm_restore_context();
 			omap3_sram_restore_context();
+			omap2_sms_restore_context();
 		}
 		if (per_next_state < PWRDM_POWER_ON) {
 			per_prev_state =
diff --git a/arch/arm/mach-omap2/sdrc.c b/arch/arm/mach-omap2/sdrc.c
index 9e3bd4f..1a4f132 100644
--- a/arch/arm/mach-omap2/sdrc.c
+++ b/arch/arm/mach-omap2/sdrc.c
@@ -37,12 +37,38 @@ static struct omap_sdrc_params *sdrc_init_params_cs0, *sdrc_init_params_cs1;
 void __iomem *omap2_sdrc_base;
 void __iomem *omap2_sms_base;
 
+struct omap2_sms_regs {
+	u32	sms_sysconfig;
+};
+
+static struct omap2_sms_regs sms_context;
+
 /* SDRC_POWER register bits */
 #define SDRC_POWER_EXTCLKDIS_SHIFT		3
 #define SDRC_POWER_PWDENA_SHIFT			2
 #define SDRC_POWER_PAGEPOLICY_SHIFT		0
 
 /**
+ * omap2_sms_save_context - Save SMS registers
+ *
+ * Save SMS registers that need to be restored after off mode.
+ */
+void omap2_sms_save_context(void)
+{
+	sms_context.sms_sysconfig = sms_read_reg(SMS_SYSCONFIG);
+}
+
+/**
+ * omap2_sms_restore_context - Restore SMS registers
+ *
+ * Restore SMS registers that need to be Restored after off mode.
+ */
+void omap2_sms_restore_context(void)
+{
+	sms_write_reg(sms_context.sms_sysconfig, SMS_SYSCONFIG);
+}
+
+/**
  * omap2_sdrc_get_params - return SDRC register values for a given clock rate
  * @r: SDRC clock rate (in Hz)
  * @sdrc_cs0: chip select 0 ram timings **
@@ -132,4 +158,5 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 	l = (1 << SDRC_POWER_EXTCLKDIS_SHIFT) |
 		(1 << SDRC_POWER_PAGEPOLICY_SHIFT);
 	sdrc_write_reg(l, SDRC_POWER);
+	omap2_sms_save_context();
 }
diff --git a/arch/arm/plat-omap/include/mach/sdrc.h b/arch/arm/plat-omap/include/mach/sdrc.h
index 7b58a5f..772b71e 100644
--- a/arch/arm/plat-omap/include/mach/sdrc.h
+++ b/arch/arm/plat-omap/include/mach/sdrc.h
@@ -120,6 +120,8 @@ void __init omap2_sdrc_init(struct omap_sdrc_params *sdrc_cs0,
 int omap2_sdrc_get_params(unsigned long r,
 			  struct omap_sdrc_params **sdrc_cs0,
 			  struct omap_sdrc_params **sdrc_cs1);
+void omap2_sms_save_context(void);
+void omap2_sms_restore_context(void);
 
 #ifdef CONFIG_ARCH_OMAP2
 
-- 
1.6.4.3
