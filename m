From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv3 03/20] ARM: OMAP4: PM: add support for device off
Date: Thu, 14 Jun 2012 16:53:40 +0300
Message-ID: <1339682020.2091.184.camel@sokoban>
References: <1339515095-9908-1-git-send-email-t-kristo@ti.com>
 <1339515095-9908-4-git-send-email-t-kristo@ti.com>
 <CAORVsuUJOpQu1qE7qmK9PS79JZJ065egqcpfgmsWNHwnhLUdvw@mail.gmail.com>
Reply-To: t-kristo@ti.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAORVsuUJOpQu1qE7qmK9PS79JZJ065egqcpfgmsWNHwnhLUdvw@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: khilman@ti.com, tony@atomide.com, paul@pwsan.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wed, 2012-06-13 at 17:21 +0200, Jean Pihet wrote:
> Hi Tero,
> 
> I have a few remarks regarding the genericity of this code. I think it
> is better if the code in powerdomain.c stays generic and that the
> platform specific checks and operations be moved in the specific
> functions (via the pwrdm_ops struct).

Okay, I made an alternative implementation. Compared to this:

> 
> On Tue, Jun 12, 2012 at 5:31 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On OMAP4+, device wide off-mode has its own enable mechanism in addition
> > to powerdomain target states. This patch adds support for this on top
> > of functional power states by overloading the OFF state for core pwrdm.
> > On pwrdm level, the deepest power state supported by core pwrdm is OSWR.
> > When user (e.g. suspend) programs core pwrdm target as OFF, the functional
> > power state for the domain will be OSWR with the additional device off
> > enabled. Previous power state information will reflect this also.
> >
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  arch/arm/mach-omap2/powerdomain.c           |   17 +++++++++
> >  arch/arm/mach-omap2/powerdomain.h           |   13 +++++++-
> >  arch/arm/mach-omap2/powerdomain44xx.c       |   48 +++++++++++++++++++++++++++
> >  arch/arm/mach-omap2/powerdomains44xx_data.c |    3 +-
> >  4 files changed, 79 insertions(+), 2 deletions(-)
> >

It becomes something like following. I had to implement pwrdm specific
func_ops struct, which gets set for core pwrdm. It handles the details
of device off enable / check, but I still had to hack around a bit
within the base func pwrst code to actually use the new functions. This
applies on top of the previous code, this is just a rather quick and
dirty implementation just to get some feedback. If this looks feasible,
I can change the v3 dev-off set to use this approach.

Any comments on this?

-Tero



diff --git a/arch/arm/mach-omap2/powerdomain.c
b/arch/arm/mach-omap2/powerdomain.c
index 78a9308..15926cb 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -659,6 +659,35 @@ int pwrdm_get_achievable_func_pwrst(struct
powerdomain *pwrdm, u8 func_pwrst)
 	return new_func_pwrst;
 }
 
+int pwrdm_set_next_func_pwrst(struct powerdomain *pwrdm, u32
func_pwrst)
+{
+	int pwrst, logic;
+	int next_func_pwrst;
+	int ret;
+
+	if (pwrdm->func_ops && pwrdm->func_ops->pwrdm_set_next_func_pwrst)
+		return pwrdm->func_ops->pwrdm_set_next_func_pwrst(pwrdm,
+								  func_pwrst);
+
+	pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	logic = pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
+	next_func_pwrst = pwrdm_read_next_func_pwrst(pwrdm);
+
+	/* Program next power state */
+	if (pwrst != pwrdm_func_to_pwrst(pwrdm, next_func_pwrst)) {
+		ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+		if (ret)
+			return ret;
+	}
+
+	/* Program RET logic state */
+	if ((pwrst == PWRDM_POWER_RET) &&
+	    (logic != pwrdm_func_to_logic_pwrst(pwrdm, next_func_pwrst)))
+		ret = pwrdm_set_logic_retst(pwrdm, logic);
+
+	return ret;
+}
+
 /* Types of sleep_switch used in omap_set_pwrdm_state */
 #define FORCEWAKEUP_SWITCH	0
 #define LOWPOWERSTATE_SWITCH	1
@@ -675,10 +704,9 @@ int pwrdm_get_achievable_func_pwrst(struct
powerdomain *pwrdm, u8 func_pwrst)
 int omap_set_pwrdm_state(struct powerdomain *pwrdm, u32 func_pwrst)
 {
 	int sleep_switch = -1, ret = 0, hwsup = 0;
-	int new_func_pwrst, next_func_pwrst, pwrst, logic;
+	int new_func_pwrst, next_func_pwrst;
+	int pwrst;
 	u8 curr_pwrst;
-	bool extra_off_enable = false;
-	bool has_extra_off = false;
 
 	if (!pwrdm || IS_ERR(pwrdm)) {
 		pr_debug("%s: invalid params: pwrdm=%p\n", __func__, pwrdm);
@@ -689,16 +717,8 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
u32 func_pwrst)
 
 	mutex_lock(&pwrdm->lock);
 
-	/* Check if powerdomain has extra off mode handling */
-	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE) {
-		has_extra_off = true;
-		if (func_pwrst == PWRDM_FUNC_PWRST_OFF)
-			extra_off_enable = true;
-	}
-
 	new_func_pwrst = pwrdm_get_achievable_func_pwrst(pwrdm, func_pwrst);
 	pwrst = pwrdm_func_to_pwrst(pwrdm, new_func_pwrst);
-	logic = pwrdm_func_to_logic_pwrst(pwrdm, new_func_pwrst);
 
 	next_func_pwrst = pwrdm_read_next_func_pwrst(pwrdm);
 	if (new_func_pwrst == next_func_pwrst)
@@ -716,25 +736,15 @@ int omap_set_pwrdm_state(struct powerdomain
*pwrdm, u32 func_pwrst)
 		}
 	}
 
-	pr_debug("%s: set func_pwrst %0x (%0x,%0x) to pwrdm %s\n",
-		 __func__, new_func_pwrst, pwrst, logic, pwrdm->name);
-
 	/* Trace the pwrdm desired target state */
 	trace_power_domain_target(pwrdm->name, new_func_pwrst,
 				  smp_processor_id());
 
-	/* Program next power state */
-	if (pwrst != pwrdm_func_to_pwrst(pwrdm, next_func_pwrst)) {
-		ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
-		if (ret)
-			pr_err("%s: unable to set power state of powerdomain: %s\n",
-			       __func__, pwrdm->name);
-	}
-
-	/* Program RET logic state */
-	if ((pwrst == PWRDM_POWER_RET) &&
-	    (logic != pwrdm_func_to_logic_pwrst(pwrdm, next_func_pwrst)))
-		pwrdm_set_logic_retst(pwrdm, logic);
+	/* Program next functional power state */
+	ret = pwrdm_set_next_func_pwrst(pwrdm, new_func_pwrst);
+	if (ret)
+		pr_err("%s: unable to set power state of powerdomain: %s\n",
+		       __func__, pwrdm->name);
 
 	switch (sleep_switch) {
 	case FORCEWAKEUP_SWITCH:
@@ -750,9 +760,6 @@ int omap_set_pwrdm_state(struct powerdomain *pwrdm,
u32 func_pwrst)
 		break;
 	}
 
-	if (has_extra_off && arch_pwrdm->pwrdm_enable_off)
-		arch_pwrdm->pwrdm_enable_off(pwrdm, extra_off_enable);
-
 out:
 	mutex_unlock(&pwrdm->lock);
 	return ret;
@@ -819,13 +826,13 @@ int pwrdm_read_next_pwrst(struct powerdomain
*pwrdm)
  */
 int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm)
 {
-	int next_pwrst = pwrdm_read_next_pwrst(pwrdm);
-	int next_logic = pwrdm_read_logic_retst(pwrdm);
+	int next_pwrst, next_logic;
 
-	if (pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE &&
-	    arch_pwrdm->pwrdm_read_next_off &&
-	    arch_pwrdm->pwrdm_read_next_off(pwrdm))
-		return PWRDM_FUNC_PWRST_OFF;
+	if (pwrdm->func_ops && pwrdm->func_ops->pwrdm_read_next_func_pwrst)
+		return pwrdm->func_ops->pwrdm_read_next_func_pwrst(pwrdm);
+
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	next_logic = pwrdm_read_logic_retst(pwrdm);
 
 	return pwrdm_pwrst_to_func(pwrdm, next_pwrst, next_logic);
 }
@@ -898,12 +905,13 @@ int pwrdm_read_prev_pwrst(struct powerdomain
*pwrdm)
  */
 int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm)
 {
-	int prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
-	int prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
+	int prev_pwrst, prev_logic;
+
+	if (pwrdm->func_ops && pwrdm->func_ops->pwrdm_read_prev_func_pwrst)
+		return pwrdm->func_ops->pwrdm_read_prev_func_pwrst(pwrdm);
 
-	if (arch_pwrdm && arch_pwrdm->pwrdm_lost_context_rff &&
-	    arch_pwrdm->pwrdm_lost_context_rff(pwrdm))
-		return PWRDM_FUNC_PWRST_OFF;
+	prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
+	prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
 
 	return pwrdm_pwrst_to_func(pwrdm, prev_pwrst, prev_logic);
 }
diff --git a/arch/arm/mach-omap2/powerdomain.h
b/arch/arm/mach-omap2/powerdomain.h
index cc30b94..658a64b 100644
--- a/arch/arm/mach-omap2/powerdomain.h
+++ b/arch/arm/mach-omap2/powerdomain.h
@@ -76,14 +76,6 @@
 						  * powerdomain
 						  */
 /*
- * OMAP4+ has device off feature, which must be enabled separately in
- * addition to power domain next state setup. This feature is
overloaded
- * as EXTRA_OFF_ENABLE for core_pwrdm, and is implemented on top of
- * functional power state
- */
-#define PWRDM_HAS_EXTRA_OFF_ENABLE	(1 << 3)
-
-/*
  * Number of memory banks that are power-controllable.	On OMAP4430, the
  * maximum is 5.
  */
@@ -102,6 +94,20 @@ struct clockdomain;
 struct powerdomain;
 
 /**
+ * struct pwrdm_func_ops - powerdomain specific functional power state
handling
+ * @pwrdm_set_next_func_pwrst - set next functional power state
+ * @pwrdm_read_next_func_pwrst - read the next functional power state
+ * @pwrdm_read_prev_func_pwrst - read the previous functional power
state
+ * @pwrdm_clear_all_prev_func_pwrst - clear previous functional power
state
+ */
+struct pwrdm_func_ops {
+	int (*pwrdm_set_next_func_pwrst)(struct powerdomain *pwrdm, u32
state);
+	int (*pwrdm_read_next_func_pwrst)(struct powerdomain *pwrdm);
+	int (*pwrdm_read_prev_func_pwrst)(struct powerdomain *pwrdm);
+	int (*pwrdm_clear_all_prev_func_pwrst)(struct powerdomain *pwrdm);
+};
+
+/**
  * struct powerdomain - OMAP powerdomain
  * @name: Powerdomain name
  * @voltdm: voltagedomain containing this powerdomain
@@ -119,6 +125,7 @@ struct powerdomain;
  * @voltdm_node: list_head linking all powerdomains in a voltagedomain
  * @state:
  * @state_counter:
+ * @func_ops: powerdomain specific functional power states ops, if any
  * @timer:
  * @state_timer:
  *
@@ -147,6 +154,7 @@ struct powerdomain {
 	unsigned state_counter[PWRDM_MAX_FUNC_PWRSTS];
 	unsigned ret_logic_off_counter;
 	unsigned ret_mem_off_counter[PWRDM_MAX_MEM_BANKS];
+	const struct pwrdm_func_ops *func_ops;
 
 #ifdef CONFIG_PM_DEBUG
 	s64 timer;
@@ -180,9 +188,6 @@ struct powerdomain {
  * @pwrdm_disable_hdwr_sar: Disable Hardware Save-Restore feature for a
pd
  * @pwrdm_set_lowpwrstchange: Enable pd transitions from a shallow to
deep sleep
  * @pwrdm_wait_transition: Wait for a pd state transition to complete
- * @pwrdm_lost_context_rff: Check if pd has lost RFF context (omap4+
device off)
- * @pwrdm_enable_off: Extra off mode enable for pd (omap4+ device off)
- * @pwrdm_read_next_off: Check if pd next state is off (omap4+ device
off)
  */
 struct pwrdm_ops {
 	int	(*pwrdm_func_to_pwrst)(struct powerdomain *pwrdm, u8 func_pwrst);
@@ -207,9 +212,6 @@ struct pwrdm_ops {
 	int	(*pwrdm_disable_hdwr_sar)(struct powerdomain *pwrdm);
 	int	(*pwrdm_set_lowpwrstchange)(struct powerdomain *pwrdm);
 	int	(*pwrdm_wait_transition)(struct powerdomain *pwrdm);
-	bool	(*pwrdm_lost_context_rff)(struct powerdomain *pwrdm);
-	void	(*pwrdm_enable_off)(struct powerdomain *pwrdm, bool enable);
-	bool	(*pwrdm_read_next_off)(struct powerdomain *pwrdm);
 };
 
 int pwrdm_register_platform_funcs(struct pwrdm_ops *custom_funcs);
@@ -232,10 +234,14 @@ struct voltagedomain *pwrdm_get_voltdm(struct
powerdomain *pwrdm);
 
 int pwrdm_get_mem_bank_count(struct powerdomain *pwrdm);
 
+int pwrdm_set_next_func_pwrst(struct powerdomain *pwrdm, u32
func_pwrst);
 int pwrdm_read_prev_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_read_next_func_pwrst(struct powerdomain *pwrdm);
 int pwrdm_get_achievable_func_pwrst(struct powerdomain *pwrdm, u8
func_pwrst);
+int pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8 func_pwrst);
+int pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8
func_pwrst);
+int pwrdm_pwrst_to_func(struct powerdomain *pwrdm, u8 pwrst, u8 logic);
 
 int omap2_pwrdm_func_to_pwrst(struct powerdomain *pwrdm, u8
func_pwrst);
 int omap2_pwrdm_func_to_logic_pwrst(struct powerdomain *pwrdm, u8
func_pwrst);
@@ -279,6 +285,7 @@ extern void omap44xx_powerdomains_init(void);
 extern struct pwrdm_ops omap2_pwrdm_operations;
 extern struct pwrdm_ops omap3_pwrdm_operations;
 extern struct pwrdm_ops omap4_pwrdm_operations;
+extern const struct pwrdm_func_ops omap4_core_pwrdm_func_ops;
 
 /* Common Internal functions used across OMAP rev's */
 extern u32 omap2_pwrdm_get_mem_bank_onstate_mask(u8 bank);
diff --git a/arch/arm/mach-omap2/powerdomain44xx.c
b/arch/arm/mach-omap2/powerdomain44xx.c
index b2bdc0f..ce524ed 100644
--- a/arch/arm/mach-omap2/powerdomain44xx.c
+++ b/arch/arm/mach-omap2/powerdomain44xx.c
@@ -89,12 +89,8 @@ static int omap4_pwrdm_clear_all_prev_pwrst(struct
powerdomain *pwrdm)
 					pwrdm->prcm_partition,
 					pwrdm->prcm_offs, OMAP4_PM_PWSTST);
 
-	if (pwrdm->context_offs)
-		omap4_prminst_write_inst_reg(OMAP4430_LOSTCONTEXT_DFF_MASK |
-					     OMAP4430_LOSTCONTEXT_RFF_MASK,
-					     pwrdm->prcm_partition,
-					     pwrdm->prcm_offs,
-					     pwrdm->context_offs);
+	if (pwrdm->func_ops &&
pwrdm->func_ops->pwrdm_clear_all_prev_func_pwrst)
+		return pwrdm->func_ops->pwrdm_clear_all_prev_func_pwrst(pwrdm);
 
 	return 0;
 }
@@ -336,21 +332,18 @@ static int omap4_pwrdm_disable_hdwr_sar(struct
powerdomain *pwrdm)
  * this means if the device has entered off or not. Returns true if the
  * context has been lost, false otherwise.
  */
-bool omap4_pwrdm_lost_context_rff(struct powerdomain *pwrdm)
+static bool omap4_pwrdm_lost_context_rff(struct powerdomain *pwrdm)
 {
 	u32 val;
-	s16 inst, offset;
+	s16 inst;
 
 	if (!pwrdm)
 		return false;
 
 	inst = pwrdm->prcm_offs;
-	offset = pwrdm->context_offs;
 
-	if (!offset)
-		return false;
-
-	val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst,
offset);
+	val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION, inst,
+					  OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET);
 
 	if (val & OMAP4430_LOSTCONTEXT_RFF_MASK)
 		return true;
@@ -358,6 +351,17 @@ bool omap4_pwrdm_lost_context_rff(struct
powerdomain *pwrdm)
 	return false;
 }
 
+static int omap4_pwrdm_core_clear_all_prev_func_pwrst(struct
powerdomain *pwrdm)
+{
+	omap4_prminst_write_inst_reg(OMAP4430_LOSTCONTEXT_DFF_MASK |
+				     OMAP4430_LOSTCONTEXT_RFF_MASK,
+				     pwrdm->prcm_partition,
+				     pwrdm->prcm_offs,
+
OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET);
+
+	return 0;
+}
+
 /**
  * omap4_device_set_next_state_off - setup device off state
  * @pwrdm: struct powerdomain * to target powerdomain
@@ -367,13 +371,10 @@ bool omap4_pwrdm_lost_context_rff(struct
powerdomain *pwrdm)
  * transition to off mode as soon as all power domains in MPU, IVA
  * and CORE voltage are in OFF or OSWR state (open switch retention)
  */
-void omap4_device_set_next_state_off(struct powerdomain *pwrdm, bool
enable)
+static void omap4_device_set_next_state_off(bool enable)
 {
 	u8 val = enable ? 0x1 : 0x0;
 
-	if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
-		return;
-
 	omap4_prminst_write_inst_reg(val << OMAP4430_DEVICE_OFF_ENABLE_SHIFT,
 				     OMAP4430_PRM_PARTITION,
 				     OMAP4430_PRM_DEVICE_INST,
@@ -388,13 +389,10 @@ void omap4_device_set_next_state_off(struct
powerdomain *pwrdm, bool enable)
  * Checks if device off is enabled or not.
  * Returns true if enabled, false otherwise.
  */
-bool omap4_device_read_next_state_off(struct powerdomain *pwrdm)
+static bool omap4_device_read_next_state_off(void)
 {
 	u32 val;
 
-	if (!(pwrdm->flags & PWRDM_HAS_EXTRA_OFF_ENABLE))
-		return false;
-
 	val = omap4_prminst_read_inst_reg(OMAP4430_PRM_PARTITION,
 					  OMAP4430_PRM_DEVICE_INST,
 					  OMAP4_PRM_DEVICE_OFF_CTRL_OFFSET);
@@ -404,6 +402,68 @@ bool omap4_device_read_next_state_off(struct
powerdomain *pwrdm)
 	return val ? true : false;
 }
 
+static int omap4_pwrdm_core_set_next_func_pwrst(struct powerdomain
*pwrdm,
+						u32 func_pwrst)
+{
+	int pwrst, logic;
+	int next_func_pwrst;
+	int ret;
+	bool off_enable;
+
+	if (func_pwrst == PWRDM_FUNC_PWRST_OFF) {
+		off_enable = true;
+		func_pwrst = PWRDM_FUNC_PWRST_OSWR;
+	} else {
+		off_enable = false;
+	}
+
+	pwrst = pwrdm_func_to_pwrst(pwrdm, func_pwrst);
+	logic = pwrdm_func_to_logic_pwrst(pwrdm, func_pwrst);
+	next_func_pwrst = pwrdm_read_next_func_pwrst(pwrdm);
+
+	/* Program next power state */
+	if (pwrst != pwrdm_func_to_pwrst(pwrdm, next_func_pwrst)) {
+		ret = pwrdm_set_next_pwrst(pwrdm, pwrst);
+		if (ret)
+			return ret;
+	}
+
+	/* Program RET logic state */
+	if ((pwrst == PWRDM_POWER_RET) &&
+	    (logic != pwrdm_func_to_logic_pwrst(pwrdm, next_func_pwrst)))
+		ret = pwrdm_set_logic_retst(pwrdm, logic);
+
+	omap4_device_set_next_state_off(off_enable);
+
+	return ret;
+}
+
+static int omap4_pwrdm_core_read_prev_func_pwrst(struct powerdomain
*pwrdm)
+{
+	int prev_pwrst, prev_logic;
+
+	if (omap4_pwrdm_lost_context_rff(pwrdm))
+		return PWRDM_FUNC_PWRST_OFF;
+
+	prev_pwrst = pwrdm_read_prev_pwrst(pwrdm);
+	prev_logic = pwrdm_read_prev_logic_pwrst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, prev_pwrst, prev_logic);
+}
+
+static int omap4_pwrdm_core_read_next_func_pwrst(struct powerdomain
*pwrdm)
+{
+	int next_pwrst, next_logic;
+
+	if (omap4_device_read_next_state_off())
+		return PWRDM_FUNC_PWRST_OFF;
+
+	next_pwrst = pwrdm_read_next_pwrst(pwrdm);
+	next_logic = pwrdm_read_logic_retst(pwrdm);
+
+	return pwrdm_pwrst_to_func(pwrdm, next_pwrst, next_logic);
+}
+
 struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_func_to_pwrst	= omap2_pwrdm_func_to_pwrst,
 	.pwrdm_func_to_logic_pwrst	= omap2_pwrdm_func_to_logic_pwrst,
@@ -426,7 +486,12 @@ struct pwrdm_ops omap4_pwrdm_operations = {
 	.pwrdm_wait_transition	= omap4_pwrdm_wait_transition,
 	.pwrdm_enable_hdwr_sar	= omap4_pwrdm_enable_hdwr_sar,
 	.pwrdm_disable_hdwr_sar	= omap4_pwrdm_disable_hdwr_sar,
-	.pwrdm_lost_context_rff = omap4_pwrdm_lost_context_rff,
-	.pwrdm_enable_off	= omap4_device_set_next_state_off,
-	.pwrdm_read_next_off	= omap4_device_read_next_state_off,
+};
+
+const struct pwrdm_func_ops omap4_core_pwrdm_func_ops = {
+	.pwrdm_set_next_func_pwrst = omap4_pwrdm_core_set_next_func_pwrst,
+	.pwrdm_read_next_func_pwrst = omap4_pwrdm_core_read_next_func_pwrst,
+	.pwrdm_read_prev_func_pwrst = omap4_pwrdm_core_read_prev_func_pwrst,
+	.pwrdm_clear_all_prev_func_pwrst =
+		omap4_pwrdm_core_clear_all_prev_func_pwrst,
 };
diff --git a/arch/arm/mach-omap2/powerdomains44xx_data.c
b/arch/arm/mach-omap2/powerdomains44xx_data.c
index 13db876..7a2aad9 100644
--- a/arch/arm/mach-omap2/powerdomains44xx_data.c
+++ b/arch/arm/mach-omap2/powerdomains44xx_data.c
@@ -36,8 +36,7 @@ static struct powerdomain core_44xx_pwrdm = {
 	.voltdm		  = { .name = "core" },
 	.prcm_offs	  = OMAP4430_PRM_CORE_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.context_offs	  = OMAP4_RM_L3_1_L3_1_CONTEXT_OFFSET,
-	.pwrsts		  = PWRSTS_RET_ON,
+	.pwrsts		  = PWRSTS_OFF_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 5,
 	.pwrsts_mem_ret	= {
@@ -54,8 +53,8 @@ static struct powerdomain core_44xx_pwrdm = {
 		[3] = PWRSTS_ON,	/* ducati_l2ram */
 		[4] = PWRSTS_ON,	/* ducati_unicache */
 	},
-	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE |
-			    PWRDM_HAS_EXTRA_OFF_ENABLE,
+	.func_ops	  = &omap4_core_pwrdm_func_ops,
+	.flags		  = PWRDM_HAS_LOWPOWERSTATECHANGE,
 };
 
 /* gfx_44xx_pwrdm: 3D accelerator power domain */
@@ -207,7 +206,6 @@ static struct powerdomain mpu_44xx_pwrdm = {
 	.voltdm		  = { .name = "mpu" },
 	.prcm_offs	  = OMAP4430_PRM_MPU_INST,
 	.prcm_partition	  = OMAP4430_PRM_PARTITION,
-	.context_offs	  = OMAP4_RM_MPU_MPU_CONTEXT_OFFSET,
 	.pwrsts		  = PWRSTS_RET_ON,
 	.pwrsts_logic_ret = PWRSTS_OFF_RET,
 	.banks		  = 3,
