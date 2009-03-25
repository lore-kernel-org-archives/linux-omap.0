From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 2/2] OMAP2/3 clock: implement clock rate/parent change
	notifiers
Date: Wed, 25 Mar 2009 10:09:23 -0600
Message-ID: <20090325160921.31866.48712.stgit@localhost.localdomain>
References: <20090325160759.31866.49722.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:41121 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759513AbZCYQLA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Mar 2009 12:11:00 -0400
In-Reply-To: <20090325160759.31866.49722.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tero Kristo <tero.kristo@nokia.com>, Paul Walmsley <paul@pwsan.com>, Hiroshi DOYU <Hiroshi.DOYU@nokia.com>, Nishanth Menon <nm@ti.com>, Jouni =?utf-8?b?SMO2Z2FuZGVy?= <jouni.hogander@nokia.com>

This patch allows core code and driver code to register for
notification when a clock's rate or parent changes.  These are useful
because drivers don't have exclusive control over a clock's rate:
power management code (e.g., CPUFreq) may cause rate changes across
large parts of the clock tree.

There are three notifier messages:

1. a pre-change notifier, called before the change;

2. a post-change notifier, called after the change; and

3. an abort notifier, called if the change fails for any reason after
   the pre-change notifier callbacks have run.

Since the implementation uses a blocking notifier, notifier code may
block waiting for devices to quiesce; but long delays here will reduce
the effectiveness of DVFS.  Since notifier callbacks are called with
clocks_mutex held, callback code must not re-enter the clock framework.

Pre-change notifiers are passed the current clock rate and the
desired clock rate.  (To minimize performance and memory usage impact,
post-change notifiers are passed only the desired clock rate, i.e.,
the clock rate after the rate change.)  The notifiers are called even
if the clock rate is the same before and after the change.  This is
because reprogramming a clock's parent or rate may briefly disrupt the
clock.

There are likely to be few users of these notifiers, compared to the
total number of clocks.  So, rather than storing one notifier per
struct clk, notifiers are stored in a separate, dynamically allocated
list, effectively trading execution speed (in terms of a sequential
scan of the notifier list) for memory savings.  The implementation is
completely hidden from the callbacks and can be easily changed.

Until prototypes for these functions are made available in
include/linux/clk.h, drivers should pass function pointers to
clk_notifier_register() and clk_notifier_unregister() via their
platform_data struct.

This patch is a collaboration between Tero Kristo
<tero.kristo@nokia.com> and Paul Walmsley <paul@pwsan.com> and several
others. Hiroshi Doyu <Hiroshi.DOYU@nokia.com> tracked down and fixed a
bug where blocking_notifier_chain_*() were called while interrupts
were disabled.  Nishanth Menon <nm@ti.com> found and fixed a bug in
the clk_notifier_unregister() path, where a list_del() was missing.
And thanks to Jouni H=C3=B6gander <jouni.hogander@nokia.com> for commen=
ts
and review during the evolution of these patches.

Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: Nishanth Menon <nm@ti.com>
Cc: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 arch/arm/plat-omap/clock.c              |  256 +++++++++++++++++++++++=
++++++++
 arch/arm/plat-omap/include/mach/clock.h |   66 ++++++++
 2 files changed, 322 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index bdf2cd4..eb354ec 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -21,6 +21,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
+#include <linux/notifier.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/bootmem.h>
@@ -34,6 +35,8 @@ static DEFINE_SPINLOCK(clockfw_lock);
=20
 static struct clk_functions *arch_clock;
=20
+static LIST_HEAD(clk_notifier_list);
+
 /**
  * omap_clk_for_each_child - call callback on each child clock of clk
  * @clk: struct clk * to use as the "parent"
@@ -95,6 +98,19 @@ static int _do_propagate_rate(struct clk *clk, unsig=
ned long parent_rate,
 }
=20
 /**
+ * _clk_free_notifier_chain - safely remove struct clk_notifier
+ * @cn: struct clk_notifier *
+ *
+ * Removes the struct clk_notifier @cn from the clk_notifier_list and
+ * frees it.
+ */
+static void _clk_free_notifier_chain(struct clk_notifier *cn)
+{
+	list_del(&cn->node);
+	kfree(cn);
+}
+
+/**
  * omap_clk_add_child - add a child clock @clk2 to @clk
  * @clk: parent struct clk *
  * @clk2: new child struct clk *
@@ -170,6 +186,101 @@ void omap_clk_del_child(struct clk *clk, struct c=
lk *clk2)
 	}
 }
=20
+/**
+ * omap_clk_notify - call clk notifier chain
+ * @clk: struct clk * that is changing rate
+ * @msg: clk notifier type (i.e., CLK_POST_RATE_CHANGE; see mach/clock=
=2Eh)
+ * @old_rate: old rate
+ * @new_rate: new rate
+ *
+ * Triggers a notifier call chain on the post-clk-rate-change notifier
+ * for clock 'clk'.  Passes a pointer to the struct clk and the
+ * previous and current rates to the notifier callback.  Intended to b=
e
+ * called by internal clock code only.  No return value.
+ */
+static void omap_clk_notify(struct clk *clk, unsigned long msg,
+			    unsigned long old_rate, unsigned long new_rate)
+{
+	struct clk_notifier *cn;
+	struct clk_notifier_data cnd;
+
+	cnd.clk =3D clk;
+	cnd.old_rate =3D old_rate;
+	cnd.new_rate =3D new_rate;
+
+	list_for_each_entry(cn, &clk_notifier_list, node) {
+		if (cn->clk =3D=3D clk) {
+			blocking_notifier_call_chain(&cn->notifier_head, msg,
+						     &cnd);
+			break;
+		}
+	}
+}
+
+/**
+ * omap_clk_notify_downstream - trigger clock change notifications
+ * @clk: struct clk * to start the notifications with
+ * @msg: notifier msg - see "Clk notifier callback types" in mach/cloc=
k.h
+ * @param2: (not used - any u8 will do)
+ *
+ * Call clock change notifiers on clocks starting with @clk and includ=
ing
+ * all of @clk's downstream children clocks.  Returns NOTIFY_DONE.
+ */
+static int omap_clk_notify_downstream(struct clk *clk, unsigned long m=
sg,
+				      u8 param2)
+{
+	if (!clk->notifier_count)
+		return NOTIFY_DONE;
+
+	omap_clk_notify(clk, msg, clk->rate, clk->temp_rate);
+
+	if (!omap_clk_has_children(clk))
+		return NOTIFY_DONE;
+
+	return omap_clk_for_each_child(clk, msg, 0, omap_clk_notify_downstrea=
m);
+}
+
+
+/**
+ * _clk_pre_notify_set_parent - handle pre-notification for clk_set_pa=
rent()
+ * @clk: struct clk * changing parent
+ *
+ * When @clk is ready to change its parent, handle pre-notification.
+ * If the architecture does not have an
+ * arch_clock->clk_round_rate_parent() defined, this code will be unab=
le
+ * to verify that the selected parent is valid, and also unable to pas=
s the
+ * post-parent-change clock rate to the notifier.  Returns any error f=
rom
+ * clk_round_rate_parent() or 0 upon success.
+ */
+static int _clk_pre_notify_set_parent(struct clk *clk, struct clk *par=
ent)
+{
+	long rate;
+
+	if (!clk->notifier_count)
+		return 0;
+
+	if (!arch_clock->clk_round_rate_parent) {
+		pr_warning("clock: clk_set_parent(): WARNING: "
+			   "clk_round_rate_parent() undefined: pre-notifiers "
+			   "will get bogus rate\n");
+
+		rate =3D 0;
+	} else {
+		rate =3D arch_clock->clk_round_rate_parent(clk, parent);
+	};
+
+	if (IS_ERR_VALUE(rate))
+		return rate;
+
+	clk->temp_rate =3D rate;
+	propagate_rate(clk, TEMP_RATE);
+
+	omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE, 0);
+
+	return 0;
+}
+
+
 /*--------------------------------------------------------------------=
-----
  * Standard clock functions defined in include/linux/clk.h
  *--------------------------------------------------------------------=
-----*/
@@ -306,10 +417,20 @@ int clk_set_rate(struct clk *clk, unsigned long r=
ate)
 {
 	unsigned long flags;
 	int ret =3D -EINVAL;
+	int msg;
=20
 	if (clk =3D=3D NULL || IS_ERR(clk))
 		return ret;
=20
+	mutex_lock(&clocks_mutex);
+
+	if (clk->notifier_count) {
+		clk->temp_rate =3D rate;
+		propagate_rate(clk, TEMP_RATE);
+
+		omap_clk_notify_downstream(clk, CLK_PRE_RATE_CHANGE, 0);
+	}
+
 	spin_lock_irqsave(&clockfw_lock, flags);
=20
 	if (arch_clock->clk_set_rate) {
@@ -321,6 +442,12 @@ int clk_set_rate(struct clk *clk, unsigned long ra=
te)
=20
 	spin_unlock_irqrestore(&clockfw_lock, flags);
=20
+	msg =3D (ret) ? CLK_ABORT_RATE_CHANGE : CLK_POST_RATE_CHANGE;
+
+	omap_clk_notify_downstream(clk, msg, 0);
+
+	mutex_unlock(&clocks_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_rate);
@@ -330,10 +457,17 @@ int clk_set_parent(struct clk *clk, struct clk *p=
arent)
 	unsigned long flags;
 	struct clk *prev_parent;
 	int ret =3D -EINVAL;
+	int msg;
=20
 	if (clk =3D=3D NULL || IS_ERR(clk) || parent =3D=3D NULL || IS_ERR(pa=
rent))
 		return ret;
=20
+	mutex_lock(&clocks_mutex);
+
+	ret =3D _clk_pre_notify_set_parent(clk, parent);
+	if (IS_ERR_VALUE(ret))
+		goto csp_out;
+
 	spin_lock_irqsave(&clockfw_lock, flags);
=20
 	if (arch_clock->clk_set_parent) {
@@ -349,6 +483,13 @@ int clk_set_parent(struct clk *clk, struct clk *pa=
rent)
=20
 	spin_unlock_irqrestore(&clockfw_lock, flags);
=20
+	msg =3D (ret) ? CLK_ABORT_RATE_CHANGE : CLK_POST_RATE_CHANGE;
+
+	omap_clk_notify_downstream(clk, msg, 0);
+
+csp_out:
+	mutex_unlock(&clocks_mutex);
+
 	return ret;
 }
 EXPORT_SYMBOL(clk_set_parent);
@@ -535,6 +676,121 @@ void clk_init_cpufreq_table(struct cpufreq_freque=
ncy_table **table)
 EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
=20
+/* Clk notifier implementation */
+
+/**
+ * clk_notifier_register - add a clock parameter change notifier
+ * @clk: struct clk * to watch
+ * @nb: struct notifier_block * with callback info
+ *
+ * Request notification for changes to the clock 'clk'.  This uses a
+ * blocking notifier.  Callback code must not call into the clock
+ * framework, as clocks_mutex is held.  Pre-notifier callbacks will be
+ * passed the previous and new rate of the clock.
+ *
+ * clk_notifier_register() must be called from process
+ * context.  Returns -EINVAL if called with null arguments, -ENOMEM
+ * upon allocation failure; otherwise, passes along the return value
+ * of blocking_notifier_chain_register().
+ */
+int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
+{
+	struct clk_notifier *cn =3D NULL, *cn_new =3D NULL;
+	int r;
+	struct clk *clkp;
+
+	if (!clk || !nb)
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+
+	list_for_each_entry(cn, &clk_notifier_list, node)
+		if (cn->clk =3D=3D clk)
+			break;
+
+	if (cn->clk !=3D clk) {
+		cn_new =3D kzalloc(sizeof(struct clk_notifier), GFP_KERNEL);
+		if (!cn_new) {
+			r =3D -ENOMEM;
+			goto cnr_out;
+		};
+
+		cn_new->clk =3D clk;
+		BLOCKING_INIT_NOTIFIER_HEAD(&cn_new->notifier_head);
+
+		list_add(&cn_new->node, &clk_notifier_list);
+		cn =3D cn_new;
+	}
+
+	r =3D blocking_notifier_chain_register(&cn->notifier_head, nb);
+	if (!IS_ERR_VALUE(r)) {
+		clkp =3D clk;
+		do {
+			clkp->notifier_count++;
+		} while ((clkp =3D clkp->parent));
+	} else {
+		if (cn_new)
+			_clk_free_notifier_chain(cn);
+	}
+
+cnr_out:
+	mutex_unlock(&clocks_mutex);
+
+	return r;
+}
+
+/**
+ * clk_notifier_unregister - remove a clock change notifier
+ * @clk: struct clk *
+ * @nb: struct notifier_block * with callback info
+ *
+ * Request no further notification for changes to clock 'clk'.
+ * Returns -EINVAL if called with null arguments; otherwise, passes
+ * along the return value of blocking_notifier_chain_unregister().
+ */
+int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb=
)
+{
+	struct clk_notifier *cn =3D NULL;
+	struct clk *clkp;
+	int r =3D -EINVAL;
+
+	if (!clk || !nb)
+		return -EINVAL;
+
+	mutex_lock(&clocks_mutex);
+
+	list_for_each_entry(cn, &clk_notifier_list, node)
+		if (cn->clk =3D=3D clk)
+			break;
+
+	if (cn->clk !=3D clk) {
+		r =3D -ENOENT;
+		goto cnu_out;
+	};
+
+	r =3D blocking_notifier_chain_unregister(&cn->notifier_head, nb);
+	if (!IS_ERR_VALUE(r)) {
+		clkp =3D clk;
+		do {
+			clkp->notifier_count--;
+		} while ((clkp =3D clkp->parent));
+	}
+
+	/*
+	 * XXX ugh, layering violation.  There should be some
+	 * support in the notifier code for this.
+	 */
+	if (!cn->notifier_head.head)
+		_clk_free_notifier_chain(cn);
+
+cnu_out:
+	mutex_unlock(&clocks_mutex);
+
+	return r;
+}
+
+
+
 /*--------------------------------------------------------------------=
-----*/
=20
 #ifdef CONFIG_OMAP_RESET_CLOCKS
diff --git a/arch/arm/plat-omap/include/mach/clock.h b/arch/arm/plat-om=
ap/include/mach/clock.h
index 89a2662..3927781 100644
--- a/arch/arm/plat-omap/include/mach/clock.h
+++ b/arch/arm/plat-omap/include/mach/clock.h
@@ -10,6 +10,8 @@
  * published by the Free Software Foundation.
  */
=20
+#include <linux/notifier.h>
+
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
=20
@@ -75,6 +77,40 @@ struct clk_child {
 	u8			flags;
 };
=20
+/**
+ * struct clk_notifier - associate a clk with a notifier
+ * @clk: struct clk * to associate the notifier with
+ * @notifier_head: a blocking_notifier_head for this clk
+ * @node: linked list pointers
+ *
+ * A list of struct clk_notifier is maintained by the notifier code.
+ * An entry is created whenever code registers the first notifier on a
+ * particular @clk.  Future notifiers on that @clk are added to the
+ * @notifier_head.
+ */
+struct clk_notifier {
+	struct clk			*clk;
+	struct blocking_notifier_head	notifier_head;
+	struct list_head		node;
+};
+
+/**
+ * struct clk_notifier_data - rate data to pass to the notifier callba=
ck
+ * @clk: struct clk * being changed
+ * @old_rate: previous rate of this clock
+ * @new_rate: new rate of this clock
+ *
+ * For a pre-notifier, old_rate is the clock's rate before this rate
+ * change, and new_rate is what the rate will be in the future.  For a
+ * post-notifier, old_rate and new_rate are both set to the clock's
+ * current rate (this was done to optimize the implementation).
+ */
+struct clk_notifier_data {
+	struct clk		*clk;
+	unsigned long		old_rate;
+	unsigned long		new_rate;
+};
+
 struct clk {
 	struct list_head	node;
 	const char		*name;
@@ -91,6 +127,7 @@ struct clk {
 	void			(*init)(struct clk *);
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
+	u16			notifier_count;
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;
@@ -146,6 +183,8 @@ extern void followparent_recalc(struct clk *clk, un=
signed long parent_rate,
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern void clk_enable_init_clocks(void);
+extern int clk_notifier_register(struct clk *clk, struct notifier_bloc=
k *nb);
+extern int clk_notifier_unregister(struct clk *clk, struct notifier_bl=
ock *nb);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **ta=
ble);
 #endif
@@ -203,4 +242,31 @@ void omap_clk_del_child(struct clk *clk, struct cl=
k *clk2);
 #define CLK_REG_IN_PRM		(1 << 0)
 #define CLK_REG_IN_SCM		(1 << 1)
=20
+/*
+ * Clk notifier callback types
+ *
+ * Since the notifier is called with interrupts disabled, any actions
+ * taken by callbacks must be extremely fast and lightweight.
+ *
+ * CLK_PRE_RATE_CHANGE - called after all callbacks have approved the
+ *     rate change, immediately before the clock rate is changed, to
+ *     indicate that the rate change will proceed.  Drivers must
+ *     immediately terminate any operations that will be affected by
+ *     the rate change.  Callbacks must always return NOTIFY_DONE.
+ *
+ * CLK_ABORT_RATE_CHANGE: called if the rate change failed for some
+ *     reason after CLK_PRE_RATE_CHANGE.  In this case, all registered
+ *     notifiers on the clock will be called with
+ *     CLK_ABORT_RATE_CHANGE. Callbacks must always return
+ *     NOTIFY_DONE.
+ *
+ * CLK_POST_RATE_CHANGE - called after the clock rate change has
+ *     successfully completed.  Callbacks must always return
+ *     NOTIFY_DONE.
+ *
+ */
+#define CLK_PRE_RATE_CHANGE		1
+#define CLK_ABORT_RATE_CHANGE		2
+#define CLK_POST_RATE_CHANGE		3
+
 #endif


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
