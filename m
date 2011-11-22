From: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
Subject: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Mon, 21 Nov 2011 17:40:47 -0800
Message-ID: <1321926047-14211-6-git-send-email-mturquette@linaro.org>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321926047-14211-1-git-send-email-mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org
List-Id: linux-omap@vger.kernel.org

Introduces kobject support for the common struct clk, exports per-clk
data via read-only callbacks and models the clk tree topology in sysfs.

Also adds support for generating the clk tree in clk_init and migrating
nodes when input sources are switches in clk_set_parent.

Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
---
 drivers/clk/Kconfig     |   10 +++
 drivers/clk/Makefile    |    1 +
 drivers/clk/clk-sysfs.c |  199 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk.c       |    5 +-
 include/linux/clk.h     |   36 ++++++++-
 5 files changed, 248 insertions(+), 3 deletions(-)
 create mode 100644 drivers/clk/clk-sysfs.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index ba7eb8c..8f8e7ac 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -19,3 +19,13 @@ config GENERIC_CLK_BASIC
 	help
 	   Allow use of basic, single-function clock types.  These
 	   common definitions can be used across many platforms.
+
+config GENERIC_CLK_SYSFS
+	bool "Clock tree topology and debug info"
+	depends on EXPERIMENTAL && GENERIC_CLK
+	help
+	   Creates clock tree represenation in sysfs.  Directory names
+	   and hierarchy represent clock names and tree structure,
+	   respectively.  Each directory exports clock rate, flags,
+	   prepare_count and enable_count info as read-only for debug
+	   purposes.
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 68b20a1..806a9999 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_CLKDEV_LOOKUP)		+= clkdev.o
 obj-$(CONFIG_GENERIC_CLK)		+= clk.o
 obj-$(CONFIG_GENERIC_CLK_BASIC)		+= clk-basic.o
+obj-$(CONFIG_GENERIC_CLK_SYSFS)		+= clk-sysfs.o
diff --git a/drivers/clk/clk-sysfs.c b/drivers/clk/clk-sysfs.c
new file mode 100644
index 0000000..8ccf9e3
--- /dev/null
+++ b/drivers/clk/clk-sysfs.c
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2011 Linaro Ltd <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * Clock tree topology and debug info for the common clock framework
+ */
+
+#include <linux/clk.h>
+#include <linux/kobject.h>
+#include <linux/sysfs.h>
+#include <linux/err.h>
+
+#define MAX_STRING_LENGTH	32
+
+static struct kobject *clk_kobj;
+LIST_HEAD(kobj_list);
+
+struct clk_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct clk *clk, char *buf);
+};
+
+static ssize_t clk_rate_show(struct clk *clk, char *buf)
+{
+	if (IS_ERR_OR_NULL(clk))
+		return -ENODEV;
+
+	return snprintf(buf, MAX_STRING_LENGTH, "%lu\n", clk->rate);
+}
+
+static ssize_t clk_flags_show(struct clk *clk, char *buf)
+{
+	if (IS_ERR_OR_NULL(clk))
+		return -ENODEV;
+
+	return snprintf(buf, MAX_STRING_LENGTH, "0x%lX\n", clk->flags);
+}
+
+static ssize_t clk_prepare_count_show(struct clk *clk, char *buf)
+{
+	if (IS_ERR_OR_NULL(clk))
+		return -ENODEV;
+
+	return snprintf(buf, MAX_STRING_LENGTH, "%d\n", clk->prepare_count);
+}
+
+static ssize_t clk_enable_count_show(struct clk *clk, char *buf)
+{
+	if (IS_ERR_OR_NULL(clk))
+		return -ENODEV;
+
+	return snprintf(buf, MAX_STRING_LENGTH, "%d\n", clk->enable_count);
+}
+
+static ssize_t clk_show(struct kobject *kobj, struct attribute *attr,
+		char *buf)
+{
+	struct clk *clk;
+	struct clk_attribute *clk_attr;
+	ssize_t ret = -EINVAL;
+
+	clk = container_of(kobj, struct clk, kobj);
+	clk_attr = container_of(attr, struct clk_attribute, attr);
+
+	if (!clk || !clk_attr)
+		goto out;
+
+	/* we don't do any locking for debug operations */
+
+	/* refcount++ */
+	kobject_get(&clk->kobj);
+
+	if (clk_attr->show)
+		ret = clk_attr->show(clk, buf);
+	else
+		ret = -EIO;
+
+	/* refcount-- */
+	kobject_put(&clk->kobj);
+
+out:
+	return ret;
+}
+
+static struct clk_attribute clk_rate = __ATTR_RO(clk_rate);
+static struct clk_attribute clk_flags = __ATTR_RO(clk_flags);
+static struct clk_attribute clk_prepare_count = __ATTR_RO(clk_prepare_count);
+static struct clk_attribute clk_enable_count = __ATTR_RO(clk_enable_count);
+
+static struct attribute *clk_default_attrs[] = {
+	&clk_rate.attr,
+	&clk_flags.attr,
+	&clk_prepare_count.attr,
+	&clk_enable_count.attr,
+	NULL,
+};
+
+static const struct sysfs_ops clk_ops = {
+	.show	= clk_show,
+};
+
+static void clk_release(struct kobject *kobj)
+{
+	struct clk *clk;
+
+	clk = container_of(kobj, struct clk, kobj);
+
+	complete(&clk->kobj_unregister);
+}
+
+static struct kobj_type clk_ktype = {
+	.sysfs_ops	= &clk_ops,
+	.default_attrs	= clk_default_attrs,
+	.release	= clk_release,
+};
+
+int clk_kobj_add(struct clk *clk)
+{
+	if (IS_ERR(clk))
+		return -EINVAL;
+
+	/*
+	 * Some kobject trickery!
+	 *
+	 * We want to (ab)use the kobject infrastructure to track our
+	 * tree topology for us, specifically the root clocks (which are
+	 * otherwise not remembered in a global list).
+	 *
+	 * Unfortunately we might not be able to allocate memory yet
+	 * when this path is hit.  This pretty much rules out anything
+	 * that looks or smells like kobject_add, since there are
+	 * allocations for kobject->name and a dependency on sysfs being
+	 * initialized.
+	 *
+	 * To get around this we initialize the kobjects and (ab)use
+	 * struct kobject's list_head member, "entry".  Later on we walk
+	 * this list in clk_sysfs_tree_create() to make proper
+	 * kobject_add calls once it is safe to do so.
+	 *
+	 * FIXME - this is starting to smell alot like clkdev (i.e.
+	 * tracking the clocks in a list)
+	 */
+
+	kobject_init(&clk->kobj, &clk_ktype);
+	list_add_tail(&clk->kobj.entry, &kobj_list);
+	return 0;
+}
+
+int clk_kobj_reparent(struct clk *clk, struct clk *parent)
+{
+	int ret;
+
+	if (!clk || !parent)
+		return -EINVAL;
+
+	ret = kobject_move(&clk->kobj, &parent->kobj);
+	if (ret)
+		pr_warning("%s: failed to reparent %s to %s in sysfs\n",
+				__func__, clk->name, parent->name);
+
+	return ret;
+}
+
+static int __init clk_sysfs_init(void)
+{
+	struct list_head *tmp;
+
+	clk_kobj = kobject_create_and_add("clk", NULL);
+
+	WARN_ON(!clk_kobj);
+
+	list_for_each(tmp, &kobj_list) {
+		struct kobject *kobj;
+		struct clk *clk;
+		struct kobject *parent_kobj = NULL;
+		int ret;
+
+		kobj = container_of(tmp, struct kobject, entry);
+
+		clk = container_of(kobj, struct clk, kobj);
+
+		/* assumes list is ordered */
+		if (clk->parent)
+			parent_kobj = &clk->parent->kobj;
+		else
+			parent_kobj = clk_kobj;
+
+		ret = kobject_add(kobj, parent_kobj, clk->name);
+		if (ret)
+			pr_warning("%s: failed to create sysfs entry for %s\n",
+					__func__, clk->name);
+	}
+
+	return 0;
+}
+late_initcall(clk_sysfs_init);
diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 12c9994..85dabdb 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -436,7 +436,8 @@ void __clk_reparent(struct clk *clk, struct clk *new_parent)
 
 	clk->parent = new_parent;
 
-	/* FIXME update sysfs clock topology */
+	/* update sysfs clock topology */
+	clk_kobj_reparent(clk, clk->parent);
 }
 
 /**
@@ -531,6 +532,8 @@ void clk_init(struct device *dev, struct clk *clk)
 	else
 		clk->rate = 0;
 
+	clk_kobj_add(clk);
+
 	mutex_unlock(&prepare_lock);
 
 	return;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 8ed354a..99337ca 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -14,8 +14,8 @@
 #define __LINUX_CLK_H
 
 #include <linux/kernel.h>
-
-#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/completion.h>
 #include <linux/errno.h>
 
 struct device;
@@ -46,6 +46,10 @@ struct clk {
 	unsigned int		prepare_count;
 	struct hlist_head	children;
 	struct hlist_node	child_node;
+#ifdef CONFIG_GENERIC_CLK_SYSFS
+	struct kobject		kobj;
+	struct completion	kobj_unregister;
+#endif
 };
 
 /**
@@ -177,6 +181,34 @@ int clk_register_gate(struct device *dev, const char *name, unsigned long flags,
  */
 void clk_init(struct device *dev, struct clk *clk);
 
+#ifdef CONFIG_GENERIC_CLK_SYSFS
+/**
+ * clk_kobj_add - create a clk entry in sysfs
+ * @clk: clk to model in sysfs
+ *
+ * Create a directory in sysfs with the same name as clk.  Also creates
+ * read-only entries for the common struct clk members (rate, flags,
+ * prepare_count & enable_count).  The topology of the tree is
+ * represented by the sysfs directory structure itself.
+ */
+int clk_kobj_add(struct clk *clk);
+
+/**
+ * clk_kobj_reparent - reparent a clk entry in sysfs
+ * @clk: the child clk that is switching parents
+ * @parent: the new parent clk
+ *
+ * Simple call to kobject_move to keep sysfs up to date with the
+ * hardware clock topology
+ */
+int clk_kobj_reparent(struct clk *clk, struct clk *parent);
+#else
+static inline int clk_kobj_add(struct clk *clk)
+{ return 0; }
+static inline int clk_kobj_reparent(struct clk *clk, struct clk *parent)
+{ return 0; }
+#endif
+
 #endif /* !CONFIG_GENERIC_CLK */
 
 /**
-- 
1.7.4.1
