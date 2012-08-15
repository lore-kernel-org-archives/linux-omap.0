From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 8/8] ARM: OMAP2+: PM: reorganize the powerdomain API in public and private parts
Date: Wed, 15 Aug 2012 12:02:48 +0200
Message-ID: <1345024968-28951-9-git-send-email-j-pihet@ti.com>
References: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:47542 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753905Ab2HOKDU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 15 Aug 2012 06:03:20 -0400
Received: by wibhq12 with SMTP id hq12so4650376wib.1
        for <linux-omap@vger.kernel.org>; Wed, 15 Aug 2012 03:03:18 -0700 (PDT)
In-Reply-To: <1345024968-28951-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, linux-arm-kernel@lists.infradead.org, khilman@ti.com, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Nishanth Menon <nm@ti.com>
Cc: Jean Pihet <j-pihet@ti.com>

The newly added code for functional power states re-defines the
API to query and control the power domains settings.

The API is now split in the following parts in powerdomain.h:
- the public or external API, to be used by external PM components:
  cpuidle, suspend, pmxxxx, clock* etc.
- the private or internal API, to be used by the low level PM code
  only: powerdomain*, pm-debug, hwmod, voltage, clockdomainxxxx.

No functional change is introduced by this patch.

Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/powerdomain.h |  119 ++++++++++++++++++++-----------------
 1 files changed, 65 insertions(+), 54 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.h b/arch/arm/mach-omap2/powerdomain.h
index df83c7c..0bf613c 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -24,6 +24,11 @@
 
 #include "voltage.h"
 
+/***************************************************************
+ * External API, to be used by external PM components: cpuidle,
+ * suspend, pmxxxx, clock* etc.
+ ***************************************************************/
+
 /* Powerdomain functional power states, used by the external API functions */
 enum pwrdm_func_state {
 	PWRDM_FUNC_PWRST_OFF		= 0x0,
@@ -44,6 +49,62 @@ enum pwrdm_logic_mem_state {
 	PWRDM_MAX_LOGIC_MEM_PWRST	/* Last value, used as the max value */
 };
 
+struct clockdomain;
+struct powerdomain;
+
+struct powerdomain *pwrdm_lookup(const char *name);
+
+int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
+			void *user);
+
+int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
+			 int (*fn)(struct powerdomain *pwrdm,
+				   struct clockdomain *clkdm));
+struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
+
+int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
+
+/* Functions that query and control the power domain state setings */
+int pwrdm_get_achievable_fpwrst(struct powerdomain *pwrdm, u8 fpwrst);
+int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
+			  enum pwrdm_func_state fpwrst);
+int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm);
+int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
+int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
+int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
+int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
+
+int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
+bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
+
+int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
+int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
+bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
+
+int pwrdm_pre_transition(struct powerdomain *pwrdm);
+int pwrdm_post_transition(struct powerdomain *pwrdm);
+int pwrdm_state_switch(struct powerdomain *pwrdm);
+
+extern void omap242x_powerdomains_init(void);
+extern void omap243x_powerdomains_init(void);
+extern void omap3xxx_powerdomains_init(void);
+extern void am33xx_powerdomains_init(void);
+extern void omap44xx_powerdomains_init(void);
+
+
+/***************************************************************
+ * Internal API, to be included by the low level PM code only:
+ * powerdomain*, pm-debug, hwmod, voltage, clockdomainxxxx
+ ***************************************************************/
+
 /* Powerdomain basic power states */
 #define PWRDM_POWER_OFF		0x0
 #define PWRDM_POWER_RET		0x1
@@ -92,9 +153,6 @@ enum pwrdm_logic_mem_state {
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
-struct clockdomain;
-struct powerdomain;
-
 /**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
@@ -221,67 +279,17 @@ int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
 int pwrdm_register_pwrdms(struct powerdomain **pwrdm_list);
 int pwrdm_complete_init(void);
 
-struct powerdomain *pwrdm_lookup(const char *name);
-
-int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-int pwrdm_for_each_nolock(int (*fn)(struct powerdomain *pwrdm, void *user),
-			void *user);
-
-int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
-int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
-			 int (*fn)(struct powerdomain *pwrdm,
-				   struct clockdomain *clkdm));
-struct voltagedomain *pwrdm_get_voltdm(struct powerdomain *pwrdm);
-
-int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
-
-int pwrdm_set_next_fpwrst(struct powerdomain *pwrdm,
-			  enum pwrdm_func_state fpwrst);
-int pwrdm_read_prev_fpwrst(struct powerdomain *pwrdm);
-int pwrdm_read_fpwrst(struct powerdomain *pwrdm);
-int pwrdm_read_next_fpwrst(struct powerdomain *pwrdm);
-int pwrdm_get_achievable_fpwrst(struct powerdomain *pwrdm, u8 fpwrst);
-int omap2_pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
-int omap2_pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
-int omap2_pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
-
 int pwrdm_set_next_pwrst(struct powerdomain *pwrdm, u8 pwrst);
 int pwrdm_read_next_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_pwrst(struct powerdomain *pwrdm);
-int pwrdm_clear_all_prev_pwrst(struct powerdomain *pwrdm);
-
 int pwrdm_set_logic_retst(struct powerdomain *pwrdm, u8 pwrst);
-int pwrdm_set_mem_onst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-int pwrdm_set_mem_retst(struct powerdomain *pwrdm, u8 bank, u8 pwrst);
-
 int pwrdm_read_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_prev_logic_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_logic_retst(struct powerdomain *pwrdm);
-int pwrdm_read_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_prev_mem_pwrst(struct powerdomain *pwrdm, u8 bank);
-int pwrdm_read_mem_retst(struct powerdomain *pwrdm, u8 bank);
-
-int pwrdm_enable_hdwr_sar(struct powerdomain *pwrdm);
-int pwrdm_disable_hdwr_sar(struct powerdomain *pwrdm);
-bool pwrdm_has_hdwr_sar(struct powerdomain *pwrdm);
 
 int pwrdm_wait_transition(struct powerdomain *pwrdm);
-
-int pwrdm_state_switch(struct powerdomain *pwrdm);
-int pwrdm_pre_transition(struct powerdomain *pwrdm);
-int pwrdm_post_transition(struct powerdomain *pwrdm);
 int pwrdm_set_lowpwrstchange(struct powerdomain *pwrdm);
-int pwrdm_get_context_loss_count(struct powerdomain *pwrdm);
-bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm);
-
-extern void omap242x_powerdomains_init(void);
-extern void omap243x_powerdomains_init(void);
-extern void omap3xxx_powerdomains_init(void);
-extern void am33xx_powerdomains_init(void);
-extern void omap44xx_powerdomains_init(void);
 
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
@@ -293,8 +301,11 @@ extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
 extern u32 omap2_pwrdm_get_mem_bank_retst_mask(u8 bank);
 extern u32 omap2_pwrdm_get_mem_bank_stst_mask(u8 bank);
 
+int omap2_pwrdm_fpwrst_to_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
+int omap2_pwrdm_fpwrst_to_logic_pwrst(struct powerdomain *pwrdm, u8 fpwrst);
+int omap2_pwrdm_pwrst_to_fpwrst(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
+
 extern struct powerdomain wkup_omap2_pwrdm;
 extern struct powerdomain gfx_omap2_pwrdm;
 
-
 #endif
-- 
1.7.7.6

