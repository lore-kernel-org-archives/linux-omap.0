From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 06/10] ARM: OMAP2: Clockdomain: Connect clockdomain code to powerdomain code
Date: Tue, 19 Aug 2008 11:39:57 +0300
Message-ID: <1219135201-10282-7-git-send-email-tony@atomide.com>
References: <20080818163429.GF16455@flint.arm.linux.org.uk>
 <1219135201-10282-1-git-send-email-tony@atomide.com>
 <1219135201-10282-2-git-send-email-tony@atomide.com>
 <1219135201-10282-3-git-send-email-tony@atomide.com>
 <1219135201-10282-4-git-send-email-tony@atomide.com>
 <1219135201-10282-5-git-send-email-tony@atomide.com>
 <1219135201-10282-6-git-send-email-tony@atomide.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:63576 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753399AbYHSIkZ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 19 Aug 2008 04:40:25 -0400
In-Reply-To: <1219135201-10282-6-git-send-email-tony@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.arm.linux.org.uk
Cc: linux-omap@vger.kernel.org, Paul Walmsley <paul@pwsan.com>, Tony Lindgren <tony@atomide.com>

From: Paul Walmsley <paul@pwsan.com>

Thie patch adds code to the powerdomain layer to track the
clockdomains associated with each powerdomain.

It also modifies the clockdomain code to register clockdomains
with their corresponding powerdomain when the clockdomain is registered.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/clockdomain.c b/arch/arm/mach-omap2/clockdomain.c
index f867d8f..b6ff5aa 100644
--- a/arch/arm/mach-omap2/clockdomain.c
+++ b/arch/arm/mach-omap2/clockdomain.c
@@ -219,6 +219,8 @@ int clkdm_register(struct clockdomain *clkdm)
 
 	list_add(&clkdm->node, &clkdm_list);
 
+	pwrdm_add_clkdm(pwrdm, clkdm);
+
 	pr_debug("clockdomain: registered %s\n", clkdm->name);
 	ret = 0;
 
@@ -240,6 +242,8 @@ int clkdm_unregister(struct clockdomain *clkdm)
 	if (!clkdm)
 		return -EINVAL;
 
+	pwrdm_del_clkdm(clkdm->pwrdm, clkdm);
+
 	mutex_lock(&clkdm_mutex);
 	list_del(&clkdm->node);
 	mutex_unlock(&clkdm_mutex);
diff --git a/arch/arm/mach-omap2/powerdomain.c b/arch/arm/mach-omap2/powerdomain.c
index 1ec0038..9a80349 100644
--- a/arch/arm/mach-omap2/powerdomain.c
+++ b/arch/arm/mach-omap2/powerdomain.c
@@ -33,6 +33,7 @@
 
 #include <mach/cpu.h>
 #include <mach/powerdomain.h>
+#include <mach/clockdomain.h>
 
 /* pwrdm_list contains all registered struct powerdomains */
 static LIST_HEAD(pwrdm_list);
@@ -237,6 +238,141 @@ int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm))
 }
 
 /**
+ * pwrdm_add_clkdm - add a clockdomain to a powerdomain
+ * @pwrdm: struct powerdomain * to add the clockdomain to
+ * @clkdm: struct clockdomain * to associate with a powerdomain
+ *
+ * Associate the clockdomain 'clkdm' with a powerdomain 'pwrdm'.  This
+ * enables the use of pwrdm_for_each_clkdm().  Returns -EINVAL if
+ * presented with invalid pointers; -ENOMEM if memory could not be allocated;
+ * or 0 upon success.
+ */
+int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
+{
+	unsigned long flags;
+	int i;
+	int ret = -EINVAL;
+
+	if (!pwrdm || !clkdm)
+		return -EINVAL;
+
+	pr_debug("powerdomain: associating clockdomain %s with powerdomain "
+		 "%s\n", clkdm->name, pwrdm->name);
+
+	write_lock_irqsave(&pwrdm_rwlock, flags);
+
+	for (i = 0; i < PWRDM_MAX_CLKDMS; i++) {
+		if (!pwrdm->pwrdm_clkdms[i])
+			break;
+#ifdef DEBUG
+		if (pwrdm->pwrdm_clkdms[i] == clkdm) {
+			ret = -EINVAL;
+			goto pac_exit;
+		}
+#endif
+	}
+
+	if (i == PWRDM_MAX_CLKDMS) {
+		pr_debug("powerdomain: increase PWRDM_MAX_CLKDMS for "
+			 "pwrdm %s clkdm %s\n", pwrdm->name, clkdm->name);
+		WARN_ON(1);
+		ret = -ENOMEM;
+		goto pac_exit;
+	}
+
+	pwrdm->pwrdm_clkdms[i] = clkdm;
+
+	ret = 0;
+
+pac_exit:
+	write_unlock_irqrestore(&pwrdm_rwlock, flags);
+
+	return ret;
+}
+
+/**
+ * pwrdm_del_clkdm - remove a clockdomain from a powerdomain
+ * @pwrdm: struct powerdomain * to add the clockdomain to
+ * @clkdm: struct clockdomain * to associate with a powerdomain
+ *
+ * Dissociate the clockdomain 'clkdm' from the powerdomain
+ * 'pwrdm'. Returns -EINVAL if presented with invalid pointers;
+ * -ENOENT if the clkdm was not associated with the powerdomain, or 0
+ * upon success.
+ */
+int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm)
+{
+	unsigned long flags;
+	int ret = -EINVAL;
+	int i;
+
+	if (!pwrdm || !clkdm)
+		return -EINVAL;
+
+	pr_debug("powerdomain: dissociating clockdomain %s from powerdomain "
+		 "%s\n", clkdm->name, pwrdm->name);
+
+	write_lock_irqsave(&pwrdm_rwlock, flags);
+
+	for (i = 0; i < PWRDM_MAX_CLKDMS; i++)
+		if (pwrdm->pwrdm_clkdms[i] == clkdm)
+			break;
+
+	if (i == PWRDM_MAX_CLKDMS) {
+		pr_debug("powerdomain: clkdm %s not associated with pwrdm "
+			 "%s ?!\n", clkdm->name, pwrdm->name);
+		ret = -ENOENT;
+		goto pdc_exit;
+	}
+
+	pwrdm->pwrdm_clkdms[i] = NULL;
+
+	ret = 0;
+
+pdc_exit:
+	write_unlock_irqrestore(&pwrdm_rwlock, flags);
+
+	return ret;
+}
+
+/**
+ * pwrdm_for_each_clkdm - call function on each clkdm in a pwrdm
+ * @pwrdm: struct powerdomain * to iterate over
+ * @fn: callback function *
+ *
+ * Call the supplied function for each clockdomain in the powerdomain
+ * 'pwrdm'.  The callback function can return anything but 0 to bail
+ * out early from the iterator.  The callback function is called with
+ * the pwrdm_rwlock held for reading, so no powerdomain structure
+ * manipulation functions should be called from the callback, although
+ * hardware powerdomain control functions are fine.  Returns -EINVAL
+ * if presented with invalid pointers; or passes along the last return
+ * value of the callback function, which should be 0 for success or
+ * anything else to indicate failure.
+ */
+int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
+			 int (*fn)(struct powerdomain *pwrdm,
+				   struct clockdomain *clkdm))
+{
+	unsigned long flags;
+	int ret = 0;
+	int i;
+
+	if (!fn)
+		return -EINVAL;
+
+	read_lock_irqsave(&pwrdm_rwlock, flags);
+
+	for (i = 0; i < PWRDM_MAX_CLKDMS && !ret; i++)
+		ret = (*fn)(pwrdm, pwrdm->pwrdm_clkdms[i]);
+
+	read_unlock_irqrestore(&pwrdm_rwlock, flags);
+
+	return ret;
+}
+
+
+/**
  * pwrdm_add_wkdep - add a wakeup dependency from pwrdm2 to pwrdm1
  * @pwrdm1: wake this struct powerdomain * up (dependent)
  * @pwrdm2: when this struct powerdomain * wakes up (source)
diff --git a/arch/arm/plat-omap/include/mach/powerdomain.h b/arch/arm/plat-omap/include/mach/powerdomain.h
index c8f52c6..5fa666f 100644
--- a/arch/arm/plat-omap/include/mach/powerdomain.h
+++ b/arch/arm/plat-omap/include/mach/powerdomain.h
@@ -44,9 +44,16 @@
  */
 #define PWRDM_MAX_MEM_BANKS	4
 
+/*
+ * Maximum number of clockdomains that can be associated with a powerdomain.
+ * CORE powerdomain is probably the worst case.
+ */
+#define PWRDM_MAX_CLKDMS	3
+
 /* XXX A completely arbitrary number. What is reasonable here? */
 #define PWRDM_TRANSITION_BAILOUT 100000
 
+struct clockdomain;
 struct powerdomain;
 
 /* Encodes dependencies between powerdomains - statically defined */
@@ -98,6 +105,9 @@ struct powerdomain {
 	/* Possible memory bank pwrstates when pwrdm is ON */
 	const u8 pwrsts_mem_on[PWRDM_MAX_MEM_BANKS];
 
+	/* Clockdomains in this powerdomain */
+	struct clockdomain *pwrdm_clkdms[PWRDM_MAX_CLKDMS];
+
 	struct list_head node;
 
 };
@@ -111,6 +121,12 @@ struct powerdomain *pwrdm_lookup(const char *name);
 
 int pwrdm_for_each(int (*fn)(struct powerdomain *pwrdm));
 
+int pwrdm_add_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_del_clkdm(struct powerdomain *pwrdm, struct clockdomain *clkdm);
+int pwrdm_for_each_clkdm(struct powerdomain *pwrdm,
+			 int (*fn)(struct powerdomain *pwrdm,
+				   struct clockdomain *clkdm));
+
 int pwrdm_add_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 int pwrdm_del_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
 int pwrdm_read_wkdep(struct powerdomain *pwrdm1, struct powerdomain *pwrdm2);
