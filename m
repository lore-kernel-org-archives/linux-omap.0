From: jean.pihet@newoldbits.com
Subject: [PATCH 07/26] OMAP3+: hwmod: get rid of vdd_name field
Date: Tue, 22 Nov 2011 16:05:51 +0100
Message-ID: <1321974370-25800-8-git-send-email-j-pihet@ti.com>
References: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:38321 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756988Ab1KVPHC (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 22 Nov 2011 10:07:02 -0500
Received: by mail-fx0-f46.google.com with SMTP id n18so497590fag.19
        for <linux-omap@vger.kernel.org>; Tue, 22 Nov 2011 07:07:01 -0800 (PST)
In-Reply-To: <1321974370-25800-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, paul@pwsan.com, khilman@ti.com, balbi@ti.com, rjw@sisk.pl
Cc: Jean Pihet <j-pihet@ti.com>

From: Jean Pihet <j-pihet@ti.com>

Remove the vdd_name field from hwmod, which was only used by the SmartReflex
code and has been removed. SmartReflex will use a name field in its internal
structures instead.

Based on Paul's original code for the SmartReflex driver conversion.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c   |    4 ----
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c   |    3 ---
 arch/arm/plat-omap/include/plat/omap_hwmod.h |    3 ---
 3 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 403421a..cb8e78c 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -2607,7 +2607,6 @@ static struct omap_hwmod omap34xx_sr1_hwmod = {
 	.name		= "sr1",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2627,7 +2626,6 @@ static struct omap_hwmod omap36xx_sr1_hwmod = {
 	.name		= "sr1",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr1_fck",
-	.vdd_name	= "mpu_iva",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2661,7 +2659,6 @@ static struct omap_hwmod omap34xx_sr2_hwmod = {
 	.name		= "sr2",
 	.class		= &omap34xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
@@ -2681,7 +2678,6 @@ static struct omap_hwmod omap36xx_sr2_hwmod = {
 	.name		= "sr2",
 	.class		= &omap36xx_smartreflex_hwmod_class,
 	.main_clk	= "sr2_fck",
-	.vdd_name	= "core",
 	.prcm		= {
 		.omap2 = {
 			.prcm_reg_id = 1,
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index 3fbeadc..1b43ff1 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -4006,7 +4006,6 @@ static struct omap_hwmod omap44xx_smartreflex_core_hwmod = {
 	.mpu_irqs	= omap44xx_smartreflex_core_irqs,
 
 	.main_clk	= "smartreflex_core_fck",
-	.vdd_name	= "core",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_CORE_CLKCTRL_OFFSET,
@@ -4066,7 +4065,6 @@ static struct omap_hwmod omap44xx_smartreflex_iva_hwmod = {
 	.clkdm_name	= "l4_ao_clkdm",
 	.mpu_irqs	= omap44xx_smartreflex_iva_irqs,
 	.main_clk	= "smartreflex_iva_fck",
-	.vdd_name	= "iva",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_IVA_CLKCTRL_OFFSET,
@@ -4126,7 +4124,6 @@ static struct omap_hwmod omap44xx_smartreflex_mpu_hwmod = {
 	.clkdm_name	= "l4_ao_clkdm",
 	.mpu_irqs	= omap44xx_smartreflex_mpu_irqs,
 	.main_clk	= "smartreflex_mpu_fck",
-	.vdd_name	= "mpu",
 	.prcm = {
 		.omap4 = {
 			.clkctrl_offs = OMAP4_CM_ALWON_SR_MPU_CLKCTRL_OFFSET,
diff --git a/arch/arm/plat-omap/include/plat/omap_hwmod.h b/arch/arm/plat-omap/include/plat/omap_hwmod.h
index 8b372ed..bdc6ee4 100644
--- a/arch/arm/plat-omap/include/plat/omap_hwmod.h
+++ b/arch/arm/plat-omap/include/plat/omap_hwmod.h
@@ -480,8 +480,6 @@ struct omap_hwmod_class {
  * @main_clk: main clock: OMAP clock name
  * @_clk: pointer to the main struct clk (filled in at runtime)
  * @opt_clks: other device clocks that drivers can request (0..*)
- * @vdd_name: voltage domain name
- * @voltdm: pointer to voltage domain (filled in at runtime)
  * @masters: ptr to array of OCP ifs that this hwmod can initiate on
  * @slaves: ptr to array of OCP ifs that this hwmod can respond on
  * @dev_attr: arbitrary device attributes that can be passed to the driver
@@ -524,7 +522,6 @@ struct omap_hwmod {
 	struct omap_hwmod_opt_clk	*opt_clks;
 	char				*clkdm_name;
 	struct clockdomain		*clkdm;
-	char				*vdd_name;
 	struct omap_hwmod_ocp_if	**masters; /* connect to *_IA */
 	struct omap_hwmod_ocp_if	**slaves;  /* connect to *_TA */
 	void				*dev_attr;
-- 
1.7.5.4

