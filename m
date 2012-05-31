From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv3 3/9] ARM: OMAP3+: voltage: add support for voltagedomain
 usecounts
Date: Thu, 31 May 2012 16:28:56 +0300
Message-ID: <1338470942-20185-4-git-send-email-t-kristo@ti.com>
References: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1338470942-20185-1-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-omap@vger.kernel.org, khilman@ti.com, paul@pwsan.com
Cc: linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

These are updated based on powerdomain usecounts. Also added support
for voltdm->sleep and voltdm->wakeup calls that will be invoked once
voltagedomain enters sleep or wakes up based on usecount numbers. These
will be used for controlling voltage scaling functionality.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/powerdomain.c |    6 +++-
 arch/arm/mach-omap2/voltage.c     |   56 +++++++++++++++++++++++++++++++++++++
 arch/arm/mach-omap2/voltage.h     |   11 +++++++
 3 files changed, 72 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 4800483..317bea1 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -986,7 +986,8 @@ void pwrdm_clkdm_enable(struct powerdomain *pwrdm)
 	if (!pwrdm)
 		return;
 
-	atomic_inc(&pwrdm->usecount);
+	if (atomic_inc_return(&pwrdm->usecount) == 1)
+		voltdm_pwrdm_enable(pwrdm->voltdm.ptr);
 }
 
 void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
@@ -998,6 +999,9 @@ void pwrdm_clkdm_disable(struct powerdomain *pwrdm)
 
 	val = atomic_dec_return(&pwrdm->usecount);
 
+	if (!val)
+		voltdm_pwrdm_disable(pwrdm->voltdm.ptr);
+
 	BUG_ON(val < 0);
 }
 
diff --git a/arch/arm/mach-omap2/voltage.c b/arch/arm/mach-omap2/voltage.c
index 4dc60e8..8c6439b 100644
--- a/arch/arm/mach-omap2/voltage.c
+++ b/arch/arm/mach-omap2/voltage.c
@@ -38,6 +38,7 @@
 
 #include "voltage.h"
 #include "powerdomain.h"
+#include "smartreflex.h"
 
 #include "vc.h"
 #include "vp.h"
@@ -340,6 +341,61 @@ int voltdm_add_pwrdm(struct voltagedomain *voltdm, struct powerdomain *pwrdm)
 }
 
 /**
+ * voltdm_pwrdm_enable - increase usecount for a voltagedomain
+ * @voltdm: struct voltagedomain * to increase count for
+ *
+ * Increases usecount for a given voltagedomain. If the usecount reaches
+ * 1, the domain is awakened from idle and the function will call the
+ * voltagedomain->wakeup callback for this domain.
+ */
+void voltdm_pwrdm_enable(struct voltagedomain *voltdm)
+{
+	if (!voltdm)
+		return;
+
+	if (atomic_inc_return(&voltdm->usecount) == 1) {
+		if (voltdm->wakeup)
+			voltdm->wakeup(voltdm);
+	}
+}
+
+/**
+ * voltdm_pwrdm_disable - decrease usecount for a voltagedomain
+ * @voltdm: struct voltagedomain * to decrease count for
+ *
+ * Decreases the usecount for a given voltagedomain. If the usecount
+ * reaches zero, the domain can idle and the function will call the
+ * voltagedomain->sleep callback, and calculate the overall target
+ * state for the voltagedomain.
+ */
+void voltdm_pwrdm_disable(struct voltagedomain *voltdm)
+{
+	u8 target_state = PWRDM_POWER_OFF;
+	int state;
+	struct powerdomain *pwrdm;
+	int val;
+
+	if (!voltdm)
+		return;
+
+	val = atomic_dec_return(&voltdm->usecount);
+
+	BUG_ON(val < 0);
+
+	if (val == 0) {
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
index 16a1b09..c1f4ae8 100644
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
+	u8 target_state;
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
