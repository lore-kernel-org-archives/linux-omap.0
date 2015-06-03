From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 04/12] ARM: OMAP2+: Add custom prwdm_operations for 81xx to support dm814x
Date: Wed,  3 Jun 2015 09:23:13 -0700
Message-ID: <1433348601-8966-5-git-send-email-tony@atomide.com>
References: <1433348601-8966-1-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:13136 "HELO
	pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757774AbbFCQXt (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Jun 2015 12:23:49 -0400
In-Reply-To: <1433348601-8966-1-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Matthijs van Duin <matthijsvanduin@gmail.com>, Paul Walmsley <paul@pwsan.com>, Tero Kristo <t-kristo@ti.com>

Looking at the TI kernel tree I noticed that dm81xx need custom
ti81xx_pwrdm_operations. Let's also change dm816x over to use them
as the registers are different for dm81xx compared to others.

Cc: Matthijs van Duin <matthijsvanduin@gmail.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/powerdomains3xxx_data.c | 122 +++++++++++++++++++++++++++-
 arch/arm/mach-omap2/prcm-common.h           |   6 ++
 2 files changed, 125 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomains3xxx_data.c b/arch/arm/mach-omap2/powerdomains3xxx_data.c
index 70bc706..7829d27 100644
--- a/arch/arm/mach-omap2/powerdomains3xxx_data.c
+++ b/arch/arm/mach-omap2/powerdomains3xxx_data.c
@@ -349,6 +349,41 @@ static struct powerdomain device_81xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 };
 
+static struct powerdomain gem_814x_pwrdm = {
+	.name		= "gem_pwrdm",
+	.prcm_offs	= TI814X_PRM_DSP_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+	.voltdm		= { .name = "dsp" },
+};
+
+static struct powerdomain ivahd_814x_pwrdm = {
+	.name		= "ivahd_pwrdm",
+	.prcm_offs	= TI814X_PRM_HDVICP_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+	.voltdm		= { .name = "iva" },
+};
+
+static struct powerdomain hdvpss_814x_pwrdm = {
+	.name		= "hdvpss_pwrdm",
+	.prcm_offs	= TI814X_PRM_HDVPSS_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+	.voltdm		= { .name = "dsp" },
+};
+
+static struct powerdomain sgx_814x_pwrdm = {
+	.name		= "sgx_pwrdm",
+	.prcm_offs	= TI814X_PRM_GFX_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+	.voltdm		= { .name = "core" },
+};
+
+static struct powerdomain isp_814x_pwrdm = {
+	.name		= "isp_pwrdm",
+	.prcm_offs	= TI814X_PRM_ISP_MOD,
+	.pwrsts		= PWRSTS_OFF_ON,
+	.voltdm		= { .name = "core" },
+};
+
 static struct powerdomain active_816x_pwrdm = {
 	.name		  = "active_pwrdm",
 	.prcm_offs	  = TI816X_PRM_ACTIVE_MOD,
@@ -448,7 +483,18 @@ static struct powerdomain *powerdomains_am35x[] __initdata = {
 	NULL
 };
 
-static struct powerdomain *powerdomains_ti81xx[] __initdata = {
+static struct powerdomain *powerdomains_ti814x[] __initdata = {
+	&alwon_81xx_pwrdm,
+	&device_81xx_pwrdm,
+	&gem_814x_pwrdm,
+	&ivahd_814x_pwrdm,
+	&hdvpss_814x_pwrdm,
+	&sgx_814x_pwrdm,
+	&isp_814x_pwrdm,
+	NULL
+};
+
+static struct powerdomain *powerdomains_ti816x[] __initdata = {
 	&alwon_81xx_pwrdm,
 	&device_81xx_pwrdm,
 	&active_816x_pwrdm,
@@ -460,6 +506,73 @@ static struct powerdomain *powerdomains_ti81xx[] __initdata = {
 	NULL
 };
 
+/* TI81XX specific ops */
+#define TI81XX_PM_PWSTCTRL				0x0000
+#define TI81XX_RM_RSTCTRL				0x0010
+#define TI81XX_PM_PWSTST				0x0004
+
+static int ti81xx_pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst)
+{
+	omap2_prm_rmw_mod_reg_bits(OMAP_POWERSTATE_MASK,
+				   (pwrst << OMAP_POWERSTATE_SHIFT),
+				   pwrdm->prcm_offs, TI81XX_PM_PWSTCTRL);
+	return 0;
+}
+
+static int ti81xx_pwrdm_read_next_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+					     TI81XX_PM_PWSTCTRL,
+					     OMAP_POWERSTATE_MASK);
+}
+
+static int ti81xx_pwrdm_read_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+		(pwrdm->prcm_offs == TI814X_PRM_GFX_MOD) ? TI81XX_RM_RSTCTRL :
+					     TI81XX_PM_PWSTST,
+					     OMAP_POWERSTATEST_MASK);
+}
+
+static int ti81xx_pwrdm_read_logic_pwrst(struct powerdomain *pwrdm)
+{
+	return omap2_prm_read_mod_bits_shift(pwrdm->prcm_offs,
+		(pwrdm->prcm_offs == TI814X_PRM_GFX_MOD) ? TI81XX_RM_RSTCTRL :
+					     TI81XX_PM_PWSTST,
+					     OMAP3430_LOGICSTATEST_MASK);
+}
+
+static int ti81xx_pwrdm_wait_transition(struct powerdomain *pwrdm)
+{
+	u32 c = 0;
+
+	while ((omap2_prm_read_mod_reg(pwrdm->prcm_offs,
+		(pwrdm->prcm_offs == TI814X_PRM_GFX_MOD) ? TI81XX_RM_RSTCTRL :
+				       TI81XX_PM_PWSTST) &
+		OMAP_INTRANSITION_MASK) &&
+		(c++ < PWRDM_TRANSITION_BAILOUT))
+			udelay(1);
+
+	if (c > PWRDM_TRANSITION_BAILOUT) {
+		pr_err("powerdomain: %s timeout waiting for transition\n",
+		       pwrdm->name);
+		return -EAGAIN;
+	}
+
+	pr_debug("powerdomain: completed transition in %d loops\n", c);
+
+	return 0;
+}
+
+/* For dm814x we need to fix up fix GFX pwstst and rstctrl reg offsets */
+static struct pwrdm_ops ti81xx_pwrdm_operations = {
+	.pwrdm_set_next_pwrst	= ti81xx_pwrdm_set_next_pwrst,
+	.pwrdm_read_next_pwrst	= ti81xx_pwrdm_read_next_pwrst,
+	.pwrdm_read_pwrst	= ti81xx_pwrdm_read_pwrst,
+	.pwrdm_read_logic_pwrst	= ti81xx_pwrdm_read_logic_pwrst,
+	.pwrdm_wait_transition	= ti81xx_pwrdm_wait_transition,
+};
+
 void __init omap3xxx_powerdomains_init(void)
 {
 	unsigned int rev;
@@ -467,15 +580,18 @@ void __init omap3xxx_powerdomains_init(void)
 	if (!cpu_is_omap34xx() && !cpu_is_ti81xx())
 		return;
 
-	pwrdm_register_platform_funcs(&omap3_pwrdm_operations);
+	pwrdm_register_platform_funcs(&ti81xx_pwrdm_operations);
 
 	rev = omap_rev();
 
 	if (rev == AM35XX_REV_ES1_0 || rev == AM35XX_REV_ES1_1) {
 		pwrdm_register_pwrdms(powerdomains_am35x);
+	} else if (rev == TI8148_REV_ES1_0 || rev == TI8148_REV_ES2_0 ||
+		   rev == TI8148_REV_ES2_1) {
+		pwrdm_register_pwrdms(powerdomains_ti814x);
 	} else if (rev == TI8168_REV_ES1_0 || rev == TI8168_REV_ES1_1
 			|| rev == TI8168_REV_ES2_0 || rev == TI8168_REV_ES2_1) {
-		pwrdm_register_pwrdms(powerdomains_ti81xx);
+		pwrdm_register_pwrdms(powerdomains_ti816x);
 	} else {
 		pwrdm_register_pwrdms(powerdomains_omap3430_common);
 
diff --git a/arch/arm/mach-omap2/prcm-common.h b/arch/arm/mach-omap2/prcm-common.h
index 6ae0b3a..0ae9466 100644
--- a/arch/arm/mach-omap2/prcm-common.h
+++ b/arch/arm/mach-omap2/prcm-common.h
@@ -51,6 +51,12 @@
 /*
  * TI81XX PRM module offsets
  */
+#define TI814X_PRM_DSP_MOD				0x0a00
+#define TI814X_PRM_HDVICP_MOD				0x0c00
+#define TI814X_PRM_ISP_MOD				0x0d00
+#define TI814X_PRM_HDVPSS_MOD				0x0e00
+#define TI814X_PRM_GFX_MOD				0x0f00
+
 #define TI81XX_PRM_DEVICE_MOD			0x0000
 #define TI816X_PRM_ACTIVE_MOD			0x0a00
 #define TI81XX_PRM_DEFAULT_MOD			0x0b00
-- 
2.1.4

