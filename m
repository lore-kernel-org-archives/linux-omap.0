From: "Nayak, Rajendra" <rnayak@ti.com>
Subject: [PATCH 07/09] OMAP3 clock: Revert "OMAP2/3 clock: implement clock
 notifier infrastructure"
Date: Fri, 20 Mar 2009 18:56:27 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB02FAF6EF24@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:41093 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752886AbZCTN0j convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 20 Mar 2009 09:26:39 -0400
Received: from dbdp20.itg.ti.com ([172.24.170.38])
	by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id n2KDQUHM021589
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 08:26:36 -0500
Received: from dbde70.ent.ti.com (localhost [127.0.0.1])
	by dbdp20.itg.ti.com (8.13.8/8.13.8) with ESMTP id n2KDQTf4003083
	for <linux-omap@vger.kernel.org>; Fri, 20 Mar 2009 18:56:29 +0530 (IST)
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Cc: "Nayak, Rajendra" <rnayak@ti.com>

From: Rajendra Nayak <rnayak@ti.com>

This reverts commit cd6cbc96f64a4d7baecf52b5180827021863b23a.

Signed-off-by: Rajendra Nayak <rnayak@ti.com>
Signed-off-by: Tero Kristo <tero.kristo@nokia.com>
---
 arch/arm/plat-omap/clock.c              |  126 --------------------------------
 arch/arm/plat-omap/include/mach/clock.h |   82 --------------------
 2 files changed, 208 deletions(-)

Index: linux-omap-pm/arch/arm/plat-omap/clock.c
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/clock.c	2009-03-20 11:28:42.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/clock.c	2009-03-20 11:29:37.071069789 +0530
@@ -21,7 +21,6 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/cpufreq.h>
-#include <linux/notifier.h>
 #include <linux/debugfs.h>
 #include <linux/io.h>
 #include <linux/bootmem.h>
@@ -35,8 +34,6 @@ static DEFINE_SPINLOCK(clockfw_lock);
 
 static struct clk_functions *arch_clock;
 
-static LIST_HEAD(clk_notifier_list);
-
 /**
  * omap_clk_for_each_child - call callback on each child clock of clk
  * @clk: struct clk * to use as the "parent"
@@ -538,129 +535,6 @@ void clk_init_cpufreq_table(struct cpufr
 EXPORT_SYMBOL(clk_init_cpufreq_table);
 #endif
 
-/**
- * clk_notifier_register - add a clock parameter change notifier
- * @clk: struct clk * to watch
- * @nb: struct notifier_block * with callback info
- *
- * Request notification for changes to the clock 'clk'.  This uses an
- * atomic notifier.  The callback will be called with interrupts
- * disabled; therefore callback code should be very lightweight.
- * Callback code must not call back into the clock framework.
- * Callback code will be passed the previous and new rate of the
- * clock.
- *
- * clk_notifier_register() must be called from process
- * context.  Returns -EINVAL if called with null arguments, -ENOMEM
- * upon allocation failure; otherwise, passes along the return value
- * of atomic_notifier_chain_register().
- */
-int clk_notifier_register(struct clk *clk, struct notifier_block *nb)
-{
-	struct clk_notifier *cn = NULL, *cn_new = NULL;
-	int r;
-	unsigned long flags;
-	struct clk *clkp;
-
-	if (!clk || !nb)
-		return -EINVAL;
-
-	/* Allocate this here speculatively so we can avoid GFP_ATOMIC */
-	cn_new = kzalloc(sizeof(struct clk_notifier), GFP_KERNEL);
-	if (!cn_new)
-		return -ENOMEM;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-
-	list_for_each_entry(cn, &clk_notifier_list, node) {
-		if (cn->clk == clk)
-			break;
-	}
-
-	if (cn->clk != clk) {
-		cn_new->clk = clk;
-		ATOMIC_INIT_NOTIFIER_HEAD(&cn_new->notifier_head);
-
-		list_add(&cn_new->node, &clk_notifier_list);
-		cn = cn_new;
-	} else {
-		kfree(cn_new); /* didn't need it after all */
-	}
-
-	r = atomic_notifier_chain_register(&cn->notifier_head, nb);
-	if (!r) {
-		clkp = clk;
-		do {
-			clkp->notifier_count++;
-		} while ((clkp = clkp->parent));
-	}
-
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return r;
-}
-EXPORT_SYMBOL(clk_notifier_register);
-
-/**
- * clk_notifier_unregister - remove a clock change notifier
- * @clk: struct clk *
- * @nb: struct notifier_block * with callback info
- *
- * Request no further notification for changes to clock 'clk'.  This
- * function presently does not release memory allocated by its
- * corresponding _register function; see inline comments for more
- * information.  Returns -EINVAL if called with null arguments;
- * otherwise, passes along the return value of
- * atomic_notifier_chain_unregister().
- */
-int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb)
-{
-	struct clk_notifier *cn = NULL;
-	struct clk *clkp;
-	int r = -EINVAL;
-	unsigned long flags;
-
-	if (!clk || !nb)
-		return -EINVAL;
-
-	spin_lock_irqsave(&clockfw_lock, flags);
-
-	list_for_each_entry(cn, &clk_notifier_list, node) {
-		if (cn->clk == clk)
-			break;
-	}
-
-	if (cn->clk == clk) {
-		r = atomic_notifier_chain_unregister(&cn->notifier_head, nb);
-
-		if (!r) {
-			clkp = clk;
-			do {
-				clkp->notifier_count--;
-			} while ((clkp = clkp->parent));
-		}
-
-		/*
-		 * XXX ugh, layering violation.  there should be some
-		 * support in the notifier code for this.
-		 */
-		if (!cn->notifier_head.head) {
-			/* Free up my clock node too */
-			list_del(&cn->node);
-			kfree(cn);
-		}
-	} else {
-		r = -ENOENT;
-	}
-
-	spin_unlock_irqrestore(&clockfw_lock, flags);
-
-	return r;
-}
-EXPORT_SYMBOL(clk_notifier_unregister);
-
-
-
 /*-------------------------------------------------------------------------*/
 
 #ifdef CONFIG_OMAP_RESET_CLOCKS
Index: linux-omap-pm/arch/arm/plat-omap/include/mach/clock.h
===================================================================
--- linux-omap-pm.orig/arch/arm/plat-omap/include/mach/clock.h	2009-03-20 11:28:42.000000000 +0530
+++ linux-omap-pm/arch/arm/plat-omap/include/mach/clock.h	2009-03-20 11:28:56.460320734 +0530
@@ -10,8 +10,6 @@
  * published by the Free Software Foundation.
  */
 
-#include <linux/notifier.h>
-
 #ifndef __ARCH_ARM_OMAP_CLOCK_H
 #define __ARCH_ARM_OMAP_CLOCK_H
 
@@ -77,40 +75,6 @@ struct clk_child {
 	u8			flags;
 };
 
-/**
- * struct clk_notifier - associate a clk with a notifier
- * @clk: struct clk * to associate the notifier with
- * @notifier_head: an atomic_notifier_head for this clk
- * @node: linked list pointers
- *
- * A list of struct clk_notifier is maintained by the notifier code.
- * An entry is created whenever code registers the first notifier on a
- * particular @clk.  Future notifiers on that @clk are added to the
- * @notifier_head.
- */
-struct clk_notifier {
-	struct clk			*clk;
-	struct atomic_notifier_head	notifier_head;
-	struct list_head		node;
-};
-
-/**
- * struct clk_notifier_data - XXX documentation here
- * @clk: struct clk * to associate the notifier with
- * @old_rate: previous rate of this clock
- * @new_rate: new rate of this clock
- *
- * new_rate is what the rate will be in the future if this is called
- * in a pre-notifier, and is what the rate is now set to if called in
- * a post-notifier.  old_rate is always the clock's rate before this
- * particular rate change.
- */
-struct clk_notifier_data {
-	struct clk		*clk;
-	unsigned long		old_rate;
-	unsigned long		new_rate;
-};
-
 struct clk {
 	struct list_head	node;
 	const char		*name;
@@ -127,7 +91,6 @@ struct clk {
 	void			(*init)(struct clk *);
 	int			(*enable)(struct clk *);
 	void			(*disable)(struct clk *);
-	u16			notifier_count;
 	__u8			enable_bit;
 	__s8			usecount;
 	u8			idlest_bit;
@@ -181,8 +144,6 @@ extern void followparent_recalc(struct c
 extern void clk_allow_idle(struct clk *clk);
 extern void clk_deny_idle(struct clk *clk);
 extern void clk_enable_init_clocks(void);
-extern int clk_notifier_register(struct clk *clk, struct notifier_block *nb);
-extern int clk_notifier_unregister(struct clk *clk, struct notifier_block *nb);
 #ifdef CONFIG_CPU_FREQ
 extern void clk_init_cpufreq_table(struct cpufreq_frequency_table **table);
 #endif
@@ -240,47 +201,4 @@ void omap_clk_del_child(struct clk *clk,
 #define CLK_REG_IN_PRM		(1 << 0)
 #define CLK_REG_IN_SCM		(1 << 1)
 
-/*
- * Clk notifier callback types
- *
- * Since the notifier is called with interrupts disabled, any actions
- * taken by callbacks must be extremely fast and lightweight.
- *
- * CLK_PREPARE_RATE_CHANGE: called by clock code to get pre-approval
- *     for a rate change.  Upon receiving this notification, device
- *     drivers should expect either a CLK_PRE_RATE_CHANGE event or a
- *     CLK_ABORT_RATE_CHANGE event to follow shortly.  One example of
- *     a possible action might be to switch to PIO mode for future
- *     transfers until a CLK_ABORT_RATE_CHANGE or CLK_POST_RATE_CHANGE
- *     message is received.  Drivers should return NOTIFY_DONE (*not*
- *     NOTIFY_OK) if they approve the rate change, or return
- *     NOTIFY_BAD if they do not approve the change.
- *
- * CLK_ABORT_RATE_CHANGE: called if one of the notifier callbacks
- *     called with CLK_PREPARE_RATE_CHANGE refuses the rate change, or
- *     if the rate change failed for some reason after
- *     CLK_PRE_RATE_CHANGE.  In this case, all registered notifiers on
- *     the clock will be called with CLK_ABORT_RATE_CHANGE -- even if
- *     they had not yet received the CLK_PREPARE_RATE_CHANGE
- *     notification. Callbacks must always return NOTIFY_DONE.
- *
- * CLK_PRE_RATE_CHANGE - called after all callbacks have approved the
- *     rate change, immediately before the clock rate is changed, to
- *     indicate that the rate change will proceed.  Drivers must
- *     immediately terminate any operations that will be affected by
- *     the rate change.  Note that the rate change could still fail,
- *     at which point the driver should receive a
- *     CLK_ABORT_RATE_CHANGE message.  Callbacks must always return
- *     NOTIFY_DONE.
- *
- * CLK_POST_RATE_CHANGE - called after the clock rate change has
- *     successfully completed.  Callbacks must always return
- *     NOTIFY_DONE.
- *
- */
-#define CLK_PREPARE_RATE_CHANGE		1
-#define CLK_ABORT_RATE_CHANGE		2
-#define CLK_PRE_RATE_CHANGE		3
-#define CLK_POST_RATE_CHANGE		4
-
 #endif