From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 02/20] ARM: OMAP4: powerdomain: update mpu / core off counters during device off
Date: Tue, 12 Jun 2012 18:31:17 +0300
Message-ID: <1339515095-9908-3-git-send-email-t-kristo@ti.com>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:45647 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751640Ab2FLPbz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 Jun 2012 11:31:55 -0400
In-Reply-To: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

Currently device off does not have any counters / timers of its own
and it is impossible to track the time spent in this state. In device
off, MPU / CORE powerdomains enter OSWR, so normally the OSWR
state times / counts are increased during device off.

This patch adds a new field to the powerdomain struct for context loss
register, which is checked during pwrdm_read_prev_func_pwrst to see if
a device off type context loss has happened. If this is the case,
the previous functional power state entered is shown as OFF and the
corresponding debug counters / timers are incremented. This patch
also adds a clear for the same register in the
omap4_pwrdm_clear_all_prev_pwrst function.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c           |    4 +++
 arch/arm/mach-omap2/powerdomain.h           |    4 +++
 arch/arm/mach-omap2/powerdomain44xx.c       |   39 +++++++++++++++++++++++++++
 arch/arm/mach-omap2/powerdomains44xx_data.c |    2 +
 4 files changed, 49 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 2043f484..ac63f86 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -884,6 +884,10 @@ int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
 	int prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
 	int prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
 
+	if (arch_pwrdm && arch_pwrdm->pwrdm_lost_context_rff &&
+	    arch_pwrdm->pwrdm_lost_context_rff(pwrdm))
+		return PWRDM_FUNC_PWRST_OFF;
+
 	return pwrdm_pwrst_to_func(pwrdm, prev_pwrst, prev_logic);
 }
 
diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index a3dc859..0729d91 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -99,6 +99,7 @@ struct powerdomain;
  * @name: Powerdomain name
  * @voltdm: voltagedomain containing this powerdomain
  * @prcm_offs: the address offset from CM_BASE/PRM_BASE
+ * @context_offs: the address offset for the CONTEXT register
  * @prcm_partition: (OMAP4 only) the PRCM partition ID containing @prcm_offs
  * @pwrsts: Possible powerdomain power states
  * @pwrsts_logic_ret: Possible logic power states when pwrdm in RETENTION
@@ -123,6 +124,7 @@ struct powerdomain {
 		struct voltagedomain *ptr;
 	} voltdm;
 	const s16 prcm_offs;
+	const s16 context_offs;
 	const u8 pwrsts;
 	const u8 pwrsts_logic_ret;
 	const u8 flags;
@@ -171,6 +173,7 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
+ * @pwrdm_lost_context_rff: Check if pd has lost RFF context (entered off)
  */
 struct pwrdm_ops {
 	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
@@ -195,6 +198,7 @@ struct pwrdm_ops {
 	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
 	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
+	bool	(*pwrdm_lost_context_rff)(struct powerdomain *pwrdm);
 };
 
 int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c b/arch/arm/mach-omap2/powerdomain44xx.c
index c63d580..562f78a 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -88,6 +88,14 @@ static int omap4_pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm)
 					OMAP4430_LASTPOWERSTATEENTERED_MASK,
 					pwrdm->prcm_partition,
 					pwrdm->prcm_offs, OMAP4_PM_PWSTST);
+
+	if (pwrdm->context_offs)
+		omap4_prminst_write_inst_reg(OMAP4430_LOSTCONTEXT_DFF_MASK |
+					     OMAP4430_LOSTCONTEXT_RFF_MASK,
+					     pwrdm->prcm_partition,
+					     pwrdm->prcm_offs,
+					     pwrdm->context_offs);
+
 	return 0;
 }
 
@@ -320,6 +328,36 @@ static int omap4_pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm)
 	return 0;
 }
 
+/**
+ * omap4_pwrdm_lost_context_rff - check if a pwrdm has lost it rff context
+ * @pwrdm: struct powerdomain * to check
+ *
+ * Checks if the powerdomain has lost its RFF context or not. Basically
+ * this means if the device has entered off or not. Returns true if the
+ * context has been lost, false otherwise.
+ */
+bool omap4_pwrdm_lost_context_rff(struct powerdomain *pwrdm)
+{
+	u32 val;
+	s16 inst, offset;
+
+	if (!pwrdm)
+		return false;
+
+	inst = pwrdm->prcm_offs;
+	offset = pwrdm->context_offs;
+
+	if (!offset)
+		return false;
+
+	val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst, offset);
+
+	if (val & OMAP4430_LOSTCONTEXT_RFF_MASK)
+		return true;
+
+	return false;
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
 	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
@@ -342,4 +380,5 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
 	.pwrdm_enable_hdwr_sar	= omap4_pwrdm_enable_hdwr_sar,
 	.pwrdm_disable_hdwr_sar	= omap4_pwrdm_disable_hdwr_sar,
+	.pwrdm_lost_context_rff = omap4_pwrdm_lost_context_rff,
 };
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c b/arch/arm/mach-omap2/powerdomains44xx_data.c
index d8701ce..c4de02f 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -36,6 +36,7 @@ static struct powerdomain core_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.context_offs	  = OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
@@ -205,6 +206,7 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
+	.context_offs	  = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
-- 
1.7.4.1

