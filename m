From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 4/8] arm: omap3: add manual control for mpu / core pwrdm usecounting
Date: Wed, 15 Feb 2012 17:37:50 +0200
Message-ID: <1329320274-481-5-git-send-email-t-kristo@ti.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:58781 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751779Ab2BOPiY (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:24 -0500
In-Reply-To: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

mpu / core powerdomain usecounts are now statically increased
by 1 during MPU activity. This allows the domains to reflect
actual usage, and will allow the usecount to reach 0 just before
entering wfi. Proper powerdomain usecounts are propageted to
voltagedomain level also, and will allow vc callbacks to be
triggered at right point of time.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |   40 +++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 076eb42..b0f9b29 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -47,6 +47,7 @@ enum {
 static LIST_HEAD(pwrdm_list);
 
 static struct pwrdm_ops *arch_pwrdm;
+static struct powerdomain *mpu_pwrdm, *core_pwrdm;
 
 /* Private functions */
 
@@ -1006,11 +1007,17 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 int pwrdm_pre_transition(void)
 {
 	pwrdm_for_each(_pwrdm_pre_transition_cb, NULL);
+	/* Decrease mpu / core usecounts to indicate we are entering idle */
+	pwrdm_clkdm_disable(mpu_pwrdm);
+	pwrdm_clkdm_disable(core_pwrdm);
 	return 0;
 }
 
 int pwrdm_post_transition(void)
 {
+	/* Increase mpu / core usecounts to indicate we are leaving idle */
+	pwrdm_clkdm_enable(mpu_pwrdm);
+	pwrdm_clkdm_enable(core_pwrdm);
 	pwrdm_for_each(_pwrdm_post_transition_cb, NULL);
 	return 0;
 }
@@ -1090,3 +1097,36 @@ bool pwrdm_can_ever_lose_context(struct powerdomain *pwrdm)
 
 	return 0;
 }
+
+/**
+ * pwrdm_usecount_init - initialize special powerdomain usecounts
+ *
+ * Initializes usecounts for the powerdomains that have static
+ * dependencies with MPU idle cycle, namely mpu_pwrdm and core_pwrdm.
+ * These powerdomains will get their usecounts increased / decreased
+ * each sleep cycle so that they reach 0 just before entering wfi,
+ * and are increased to 1 just after it. This allows the dependent
+ * voltage domains to follow idle cycle properly and trigger their
+ * callbacks for sleep / wakeup.
+ */
+static int __init pwrdm_usecount_init(void)
+{
+	mpu_pwrdm = pwrdm_lookup("mpu_pwrdm");
+	if (!mpu_pwrdm) {
+		pr_err("%s: failed to get mpu_pwrdm\n", __func__);
+		return -EINVAL;
+	}
+
+	pwrdm_clkdm_enable(mpu_pwrdm);
+
+	core_pwrdm = pwrdm_lookup("core_pwrdm");
+	if (!core_pwrdm) {
+		pr_err("%s: failed to get core_pwrdm\n", __func__);
+		return -EINVAL;
+	}
+
+	pwrdm_clkdm_enable(core_pwrdm);
+
+	return 0;
+}
+late_initcall(pwrdm_usecount_init);
-- 
1.7.4.1

