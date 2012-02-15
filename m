From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv2 3/8] arm: omap3+: voltage: add support for voltagedomain usecounts
Date: Wed, 15 Feb 2012 17:37:49 +0200
Message-ID: <1329320274-481-4-git-send-email-t-kristo@ti.com>
References: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:52593 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796Ab2BOPiW (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 15 Feb 2012 10:38:22 -0500
In-Reply-To: <1329320274-481-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com, tony@atomide.com
Cc: linux-arm-kernel@lists.infradead.org

These are updated based on powerdomain usecounts. Also added support
for voltdm->sleep and voltdm->wakeup calls that will be invoked once
voltagedomain enters sleep or wakes up based on usecount numbers. These
will be used for controlling voltage scaling functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    6 +++-
 arch/arm/mach-omap2/voltage.c     |   54 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h     |   11 +++++++
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 3b70f69..076eb42 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -990,7 +990,8 @@ void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return;
 
-	atomic_inc(&pwrdm->usecount);
+	if (atomic_inc_return(&pwrdm->usecount) == 1)
+		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
 }
 
 void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
@@ -998,7 +999,8 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return;
 
-	atomic_dec(&pwrdm->usecount);
+	if (!atomic_dec_return(&pwrdm->usecount))
+		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
 }
 
 int pwrdm_pre_transition(void)
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 8a36342..bd5e413 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -38,6 +38,7 @@
 
 #include "voltage.h"
 #include "powerdomain.h"
+#include "smartreflex.h"
 
 #include "vc.h"
 #include "vp.h"
@@ -325,6 +326,59 @@ int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
 }
 
 /**
+ * voltdm_pwrdm_enable - increase usecount for a voltagedomain
+ * @voltdm: struct voltagedomain * to increase count for
+ *
+ * Increases usecount for a given voltagedomain. If the usecount reaches
+ * 1, the domain is awakened from idle and the function will call the
+ * voltagedomain->wakeup callback for this domain, and also enable the
+ * smartreflex for the domain.
+ */
+void voltdm_pwrdm_enable(struct voltagedomain *voltdm)
+{
+	if (!voltdm)
+		return;
+
+	if (atomic_inc_return(&voltdm->usecount) == 1) {
+		if (voltdm->wakeup)
+			voltdm->wakeup(voltdm);
+		omap_sr_enable(voltdm);
+	}
+}
+
+/**
+ * voltdm_pwrdm_disable - decrease usecount for a voltagedomain
+ * @voltdm: struct voltagedomain * to decrease count for
+ *
+ * Decreases the usecount for a given voltagedomain. If the usecount
+ * reaches zero, the domain can idle and the function will call the
+ * voltagedomain->sleep callback, disable smartreflex for the domain,
+ * and calculate the overall target state for the voltagedomain.
+ */
+void voltdm_pwrdm_disable(struct voltagedomain *voltdm)
+{
+	int target_state = -EINVAL;
+	int state;
+	struct powerdomain *pwrdm;
+
+	if (!voltdm)
+		return;
+
+	if (!atomic_dec_return(&voltdm->usecount)) {
+		omap_sr_disable(voltdm);
+		/* Determine target state for voltdm */
+		list_for_each_entry(pwrdm, &voltdm->pwrdm_list, voltdm_node) {
+			state = pwrdm_read_next_pwrst(pwrdm);
+			if (state > target_state)
+				target_state = state;
+		}
+		voltdm->target_state = target_state;
+		if (voltdm->sleep)
+			voltdm->sleep(voltdm);
+	}
+}
+
+/**
  * voltdm_for_each_pwrdm - call function for each pwrdm in a voltdm
  * @voltdm: struct voltagedomain * to iterate over
  * @fn: callback function *
diff --git a/arch/arm/mach-omap2/voltage.h b/arch/arm/mach-omap2/voltage.h
index 16a1b09..8829201 100644
--- a/arch/arm/mach-omap2/voltage.h
+++ b/arch/arm/mach-omap2/voltage.h
@@ -54,10 +54,14 @@ struct omap_vfsm_instance {
  * @pwrdm_list: list_head linking all powerdomains in this voltagedomain
  * @vc: pointer to VC channel associated with this voltagedomain
  * @vp: pointer to VP associated with this voltagedomain
+ * @usecount: number of users for this voltagedomain
+ * @target_state: calculated target state for the children of this domain
  * @read: read a VC/VP register
  * @write: write a VC/VP register
  * @read: read-modify-write a VC/VP register
  * @sys_clk: system clock name/frequency, used for various timing calculations
+ * @sleep: function to call once the domain enters idle
+ * @wakeup: function to call once the domain wakes up from idle
  * @scale: function used to scale the voltage of the voltagedomain
  * @nominal_volt: current nominal voltage for this voltage domain
  * @volt_data: voltage table having the distinct voltages supported
@@ -73,6 +77,9 @@ struct voltagedomain {
 	struct omap_vp_instance *vp;
 	struct omap_voltdm_pmic *pmic;
 
+	atomic_t usecount;
+	int target_state;
+
 	/* VC/VP register access functions: SoC specific */
 	u32 (*read) (u8 offset);
 	void (*write) (u32 val, u8 offset);
@@ -83,6 +90,8 @@ struct voltagedomain {
 		u32 rate;
 	} sys_clk;
 
+	void (*sleep) (struct voltagedomain *voltdm);
+	void (*wakeup) (struct voltagedomain *voltdm);
 	int (*scale) (struct voltagedomain *voltdm,
 		      unsigned long target_volt);
 
@@ -161,6 +170,8 @@ extern void omap44xx_voltagedomains_init(void);
 struct voltagedomain *voltdm_lookup(const char *name);
 void voltdm_init(struct voltagedomain **voltdm_list);
 int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm);
+void voltdm_pwrdm_enable(struct voltagedomain *voltdm);
+void voltdm_pwrdm_disable(struct voltagedomain *voltdm);
 int voltdm_for_each(int (*fn)(struct voltagedomain *voltdm, void *user),
 		    void *user);
 int voltdm_for_each_pwrdm(struct voltagedomain *voltdm,
-- 
1.7.4.1

