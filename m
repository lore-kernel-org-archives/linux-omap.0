From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: CLKFW: Initial sysfs support for omap
 clock framework
Date: Wed, 16 Apr 2008 16:20:32 +0300 (EEST)
Message-ID: <20080416.162032.215319254.Hiroshi.DOYU@nokia.com>
References: <1208335478-19816-1-git-send-email-Hiroshi.DOYU@nokia.com>
	<20080416.115749.68203391.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
 boundary="--Next_Part(Wed_Apr_16_16_20_32_2008_842)--"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:35794 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760239AbYDPNUz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 16 Apr 2008 09:20:55 -0400
Received: from esebh107.NOE.Nokia.com (esebh107.ntc.nokia.com [172.21.143.143])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id m3GDKmkL008393
	for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2008 16:20:52 +0300
In-Reply-To: <20080416.115749.68203391.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Hiroshi.DOYU@nokia.com

----Next_Part(Wed_Apr_16_16_20_32_2008_842)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hi, 

There is still problem with following tree recursively.
Fix the problem as below and attached the new one.
Now all clocks should be there.

diff -u b/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
--- b/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -82,7 +82,6 @@
 static ssize_t attr_store(struct clk *clk, struct clk_attr *attr,
                          const char *buf, size_t count)
 {
-       unsigned long flags;
        unsigned long val;
        int err;
 
@@ -137,17 +136,21 @@
 
 static int clk_sysfs_register(struct clk *clk)
 {
+       int err;
        struct clk *pa = clk->parent;
 
-       if (pa && !pa->kobj.state_initialized)
-               return clk_sysfs_register(pa);
-       else if (!clk->kobj.state_initialized) {
-               int err;
+       if (pa && !pa->kobj.state_initialized) {
+               err = clk_sysfs_register(pa);
+               if (err)
+                       return err;
+       }
+
+       if (!clk->kobj.state_initialized) {
                char name[KOBJ_NAME_LEN];
                char *p = name;
 
                clk->kobj.kset = clock_kset;
-               p += sprintf(name, "%s", clk->name);
+               p += sprintf(p, "%s", clk->name);
                if (clk->id != 0)
                        sprintf(p, "%d", clk->id);
                err = kobject_init_and_add(&clk->kobj, &clk_ktype,


From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Subject: Re: [PATCH 1/1] ARM: OMAP: CLKFW: Initial sysfs support for omap clock framework
Date: Wed, 16 Apr 2008 11:57:49 +0300 (EEST)

> Hi,
> 
> Please ignore the previous one. The correct one is here;)
> 
>        Hiroshi DOYU
> 
> From 0ccce1d2d3f2760af8ad7b1b390429226042ef71 Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Wed, 16 Apr 2008 11:29:07 +0300
> Subject: [PATCH 1/1] ARM: OMAP: CLKFW: Initial sysfs support for omap clock framework
> 
> Sysfs can provide the infrastructure to trace the dependencies of
> clock tree hierarchy quite visibly. This patch enables to keep track
> of clock tree hierarchy and expose their attributes under each clock
> directry as below:
> 
>         omap:~# tree -d /sys/kernel/clock/omap_32k_fck/
>         /sys/kernel/clock/omap_32k_fck/
>         |-- gpt10_fck
>         |-- gpt11_fck
>         |-- gpt1_fck
>         |-- per_32k_alwon_fck
>         |   |-- gpio3_fck
>         |   |-- gpio4_fck
>         |   |-- gpio5_fck
>         |   `-- gpio6_fck
>         |-- ts_fck
>         `-- wkup_32k_fck
>             `-- gpio1_fck
> 
>         11 directories
> 
>         omap:~# tree /sys/kernel/clock/omap_32k_fck/gpt10_fck
>         /sys/kernel/clock/omap_32k_fck/gpt10_fck
>         |-- flags
>         |-- rate
>         `-- usecount
> 
>         0 directories, 3 files
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/clock.c        |  151 +++++++++++++++++++++++++++++++++++++
>  include/asm-arm/arch-omap/clock.h |    2 +
>  2 files changed, 153 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 1bd8781..c794b70 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -33,6 +33,157 @@ static DEFINE_SPINLOCK(clockfw_lock);
>  
>  static struct clk_functions *arch_clock;
>  
> +/*
> + *	Sysfs support to trace clk tree hierarchy
> + */
> +static struct kset *clock_kset;
> +
> +struct clk_attr {
> +	struct attribute attr;
> +	ssize_t (*show)(struct clk *clk, struct clk_attr *attr, char *buf);
> +	ssize_t (*store)(struct clk *clk, struct clk_attr *attr,
> +			 const char *buf, size_t count);
> +};
> +#define to_clk_attr(x) container_of(x, struct clk_attr, attr)
> +
> +static ssize_t clk_attr_store(struct kobject *kobj, struct attribute *attr,
> +			      const char *buf, size_t count)
> +{
> +	struct clk_attr *ca;
> +	struct clk *clk;
> +
> +	ca = to_clk_attr(attr);
> +	clk = to_clk(kobj);
> +
> +	if (!ca->store)
> +		return -EIO;
> +	return ca->store(clk, ca, buf, count);
> +}
> +
> +static ssize_t clk_attr_show(struct kobject *kobj, struct attribute *attr,
> +			     char *buf)
> +{
> +	struct clk_attr *ca;
> +	struct clk *clk;
> +
> +	ca = to_clk_attr(attr);
> +	clk = to_clk(kobj);
> +
> +	if (!ca->show)
> +		return -EIO;
> +	return ca->show(clk, ca, buf);
> +}
> +
> +static struct sysfs_ops clk_sysfs_ops = {
> +	.show	= clk_attr_show,
> +	.store	= clk_attr_store,
> +};
> +
> +static ssize_t attr_store(struct clk *clk, struct clk_attr *attr,
> +			  const char *buf, size_t count)
> +{
> +	unsigned long flags;
> +	unsigned long val;
> +	int err;
> +
> +	sscanf(buf, "%lx", &val);
> +
> +	if (strcmp(attr->attr.name, "rate") == 0) {
> +		err = clk_set_rate(clk, val);
> +		if (err)
> +			count = -EIO;
> +	}
> +	return count;
> +}
> +
> +static ssize_t attr_show(struct clk *clk, struct clk_attr *attr, char *buf)
> +{
> +	int n = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&clockfw_lock, flags);
> +
> +	if (strcmp(attr->attr.name, "rate") == 0)
> +		n = sprintf(buf, "%lu\n", clk->rate);
> +	else if (strcmp(attr->attr.name, "flags") == 0)
> +		n = sprintf(buf, "0x%08x\n", clk->flags);
> +	else if (strcmp(attr->attr.name, "usecount") == 0)
> +		n = sprintf(buf, "%d\n", clk->usecount);
> +
> +	spin_unlock_irqrestore(&clockfw_lock, flags);
> +	return n;
> +}
> +static struct clk_attr rate	= __ATTR(rate, 0444, attr_show, attr_store);
> +static struct clk_attr flags	= __ATTR(flags, 0444, attr_show, NULL);
> +static struct clk_attr usecount	= __ATTR(usecount, 0444, attr_show, NULL);
> +
> +static struct attribute *clk_default_attrs[] = {
> +	&rate.attr,
> +	&flags.attr,
> +	&usecount.attr,
> +	NULL,
> +};
> +
> +static void clk_release(struct kobject *kobj)
> +{
> +	/* REVISIT: Dynamic registration */
> +}
> +
> +static struct kobj_type clk_ktype = {
> +	.sysfs_ops	= &clk_sysfs_ops,
> +	.release	= clk_release,
> +	.default_attrs	= clk_default_attrs,
> +};
> +
> +static int clk_sysfs_register(struct clk *clk)
> +{
> +	struct clk *pa = clk->parent;
> +
> +	if (pa && !pa->kobj.state_initialized)
> +		return clk_sysfs_register(pa);
> +	else if (!clk->kobj.state_initialized) {
> +		int err;
> +		char name[KOBJ_NAME_LEN];
> +		char *p = name;
> +
> +		clk->kobj.kset = clock_kset;
> +		p += sprintf(name, "%s", clk->name);
> +		if (clk->id != 0)
> +			sprintf(p, "%d", clk->id);
> +		err = kobject_init_and_add(&clk->kobj, &clk_ktype,
> +					   pa ? &pa->kobj : NULL, "%s", name);
> +		return err;
> +	}
> +	return 0;
> +}
> +
> +static int __init clk_sysfs_init(void)
> +{
> +	struct clk *clk;
> +	int err;
> +	struct list_head *entry;
> +
> +	clock_kset = kset_create_and_add("clock", NULL, kernel_kobj);
> +	if (!clock_kset)
> +		return -ENOMEM;
> +
> +	list_for_each_entry(clk, &clocks, node) {
> +		err = clk_sysfs_register(clk);
> +		if (err)
> +			goto err_out;
> +	}
> +	return 0;
> +
> +err_out:
> +	list_for_each(entry, &clock_kset->list) {
> +		struct kobject *k = container_of(entry, struct kobject, entry);
> +		kobject_del(k);
> +	}
> +	kset_unregister(clock_kset);
> +	return err;
> +}
> +late_initcall(clk_sysfs_init);
> +
>  #ifdef CONFIG_PM_DEBUG
>  
>  static void print_parents(struct clk *clk)
> diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
> index cce55ba..a806f9f 100644
> --- a/include/asm-arm/arch-omap/clock.h
> +++ b/include/asm-arm/arch-omap/clock.h
> @@ -61,6 +61,7 @@ struct dpll_data {
>  
>  struct clk {
>  	struct list_head	node;
> +	struct kobject		kobj;
>  	struct module		*owner;
>  	const char		*name;
>  	int			id;
> @@ -87,6 +88,7 @@ struct clk {
>  	__u8			src_offset;
>  #endif
>  };
> +#define to_clk(x) container_of(x, struct clk, kobj)
>  
>  struct clk_functions {
>  	int		(*clk_enable)(struct clk *clk);
> -- 
> 1.5.5.rc2.6.gf58d
> 
> 

----Next_Part(Wed_Apr_16_16_20_32_2008_842)--
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-ARM-OMAP-CLKFW-Initial-sysfs-support-for-omap-clo.patch"

>From 5711ee744835d15f017d010cead105a0eb288801 Mon Sep 17 00:00:00 2001
From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Date: Wed, 16 Apr 2008 11:29:07 +0300
Subject: [PATCH 1/1] ARM: OMAP: CLKFW: Initial sysfs support for omap clock framework

Sysfs can provide the infrastructure to trace the dependencies of
clock tree hierarchy quite visibly. This patch enables to keep track
of clock tree hierarchy and expose their attributes under each clock
directry as below:

        omap:~# tree -d /sys/kernel/clock/omap_32k_fck/
        /sys/kernel/clock/omap_32k_fck/
        |-- gpt10_fck
        |-- gpt11_fck
        |-- gpt1_fck
        |-- per_32k_alwon_fck
        |   |-- gpio3_fck
        |   |-- gpio4_fck
        |   |-- gpio5_fck
        |   `-- gpio6_fck
        |-- ts_fck
        `-- wkup_32k_fck
            `-- gpio1_fck

        11 directories

        omap:~# tree /sys/kernel/clock/omap_32k_fck/gpt10_fck
        /sys/kernel/clock/omap_32k_fck/gpt10_fck
        |-- flags
        |-- rate
        `-- usecount

        0 directories, 3 files

Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
---
 arch/arm/plat-omap/clock.c        |  154 +++++++++++++++++++++++++++++++++++++
 include/asm-arm/arch-omap/clock.h |    2 +
 2 files changed, 156 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
index 1bd8781..5e45e62 100644
--- a/arch/arm/plat-omap/clock.c
+++ b/arch/arm/plat-omap/clock.c
@@ -33,6 +33,160 @@ static DEFINE_SPINLOCK(clockfw_lock);
 
 static struct clk_functions *arch_clock;
 
+/*
+ *	Sysfs support to trace clk tree hierarchy
+ */
+static struct kset *clock_kset;
+
+struct clk_attr {
+	struct attribute attr;
+	ssize_t (*show)(struct clk *clk, struct clk_attr *attr, char *buf);
+	ssize_t (*store)(struct clk *clk, struct clk_attr *attr,
+			 const char *buf, size_t count);
+};
+#define to_clk_attr(x) container_of(x, struct clk_attr, attr)
+
+static ssize_t clk_attr_store(struct kobject *kobj, struct attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct clk_attr *ca;
+	struct clk *clk;
+
+	ca = to_clk_attr(attr);
+	clk = to_clk(kobj);
+
+	if (!ca->store)
+		return -EIO;
+	return ca->store(clk, ca, buf, count);
+}
+
+static ssize_t clk_attr_show(struct kobject *kobj, struct attribute *attr,
+			     char *buf)
+{
+	struct clk_attr *ca;
+	struct clk *clk;
+
+	ca = to_clk_attr(attr);
+	clk = to_clk(kobj);
+
+	if (!ca->show)
+		return -EIO;
+	return ca->show(clk, ca, buf);
+}
+
+static struct sysfs_ops clk_sysfs_ops = {
+	.show	= clk_attr_show,
+	.store	= clk_attr_store,
+};
+
+static ssize_t attr_store(struct clk *clk, struct clk_attr *attr,
+			  const char *buf, size_t count)
+{
+	unsigned long val;
+	int err;
+
+	sscanf(buf, "%lx", &val);
+
+	if (strcmp(attr->attr.name, "rate") == 0) {
+		err = clk_set_rate(clk, val);
+		if (err)
+			count = -EIO;
+	}
+	return count;
+}
+
+static ssize_t attr_show(struct clk *clk, struct clk_attr *attr, char *buf)
+{
+	int n = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&clockfw_lock, flags);
+
+	if (strcmp(attr->attr.name, "rate") == 0)
+		n = sprintf(buf, "%lu\n", clk->rate);
+	else if (strcmp(attr->attr.name, "flags") == 0)
+		n = sprintf(buf, "0x%08x\n", clk->flags);
+	else if (strcmp(attr->attr.name, "usecount") == 0)
+		n = sprintf(buf, "%d\n", clk->usecount);
+
+	spin_unlock_irqrestore(&clockfw_lock, flags);
+	return n;
+}
+static struct clk_attr rate	= __ATTR(rate, 0444, attr_show, attr_store);
+static struct clk_attr flags	= __ATTR(flags, 0444, attr_show, NULL);
+static struct clk_attr usecount	= __ATTR(usecount, 0444, attr_show, NULL);
+
+static struct attribute *clk_default_attrs[] = {
+	&rate.attr,
+	&flags.attr,
+	&usecount.attr,
+	NULL,
+};
+
+static void clk_release(struct kobject *kobj)
+{
+	/* REVISIT: Dynamic registration */
+}
+
+static struct kobj_type clk_ktype = {
+	.sysfs_ops	= &clk_sysfs_ops,
+	.release	= clk_release,
+	.default_attrs	= clk_default_attrs,
+};
+
+static int clk_sysfs_register(struct clk *clk)
+{
+	int err;
+	struct clk *pa = clk->parent;
+
+	if (pa && !pa->kobj.state_initialized) {
+		err = clk_sysfs_register(pa);
+		if (err)
+			return err;
+	}
+
+	if (!clk->kobj.state_initialized) {
+		char name[KOBJ_NAME_LEN];
+		char *p = name;
+
+		clk->kobj.kset = clock_kset;
+		p += sprintf(p, "%s", clk->name);
+		if (clk->id != 0)
+			sprintf(p, "%d", clk->id);
+		err = kobject_init_and_add(&clk->kobj, &clk_ktype,
+					   pa ? &pa->kobj : NULL, "%s", name);
+		return err;
+	}
+	return 0;
+}
+
+static int __init clk_sysfs_init(void)
+{
+	struct clk *clk;
+	int err;
+	struct list_head *entry;
+
+	clock_kset = kset_create_and_add("clock", NULL, kernel_kobj);
+	if (!clock_kset)
+		return -ENOMEM;
+
+	list_for_each_entry(clk, &clocks, node) {
+		err = clk_sysfs_register(clk);
+		if (err)
+			goto err_out;
+	}
+	return 0;
+
+err_out:
+	list_for_each(entry, &clock_kset->list) {
+		struct kobject *k = container_of(entry, struct kobject, entry);
+		kobject_del(k);
+	}
+	kset_unregister(clock_kset);
+	return err;
+}
+late_initcall(clk_sysfs_init);
+
 #ifdef CONFIG_PM_DEBUG
 
 static void print_parents(struct clk *clk)
diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
index cce55ba..a806f9f 100644
--- a/include/asm-arm/arch-omap/clock.h
+++ b/include/asm-arm/arch-omap/clock.h
@@ -61,6 +61,7 @@ struct dpll_data {
 
 struct clk {
 	struct list_head	node;
+	struct kobject		kobj;
 	struct module		*owner;
 	const char		*name;
 	int			id;
@@ -87,6 +88,7 @@ struct clk {
 	__u8			src_offset;
 #endif
 };
+#define to_clk(x) container_of(x, struct clk, kobj)
 
 struct clk_functions {
 	int		(*clk_enable)(struct clk *clk);
-- 
1.5.5.rc2.6.gf58d


----Next_Part(Wed_Apr_16_16_20_32_2008_842)----
