From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3 5/5] clk: export tree topology and clk data via sysfs
Date: Tue, 22 Nov 2011 09:37:28 -0700
Message-ID: <CACxGe6sOd6MiyYaok6BsihJtp-NNsm3WQf+aUPGMRFRpSLw2mQ@mail.gmail.com>
References: <1321926047-14211-1-git-send-email-mturquette@linaro.org>
	<1321926047-14211-6-git-send-email-mturquette@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8557450393854623149=="
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1321926047-14211-6-git-send-email-mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Mike Turquette <mturquette-l0cyMroinI0@public.gmane.org>
Cc: linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, sboyd-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, eric.miao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, aul-DWxLp4Yu+b8AvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, skannan-jfJNa2p1gH1BDgjK7y7TUQ@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jeremy.kerr-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org
List-Id: linux-omap@vger.kernel.org

--===============8557450393854623149==
Content-Type: multipart/alternative; boundary=00163646d7dc42bb5a04b2556b70

--00163646d7dc42bb5a04b2556b70
Content-Type: text/plain; charset=ISO-8859-1

On Nov 21, 2011 6:43 PM, "Mike Turquette" <mturquette-l0cyMroinI0@public.gmane.org> wrote:
>
> Introduces kobject support for the common struct clk, exports per-clk
> data via read-only callbacks and models the clk tree topology in sysfs.
>
> Also adds support for generating the clk tree in clk_init and migrating
> nodes when input sources are switches in clk_set_parent.

I'm not convinced this is a good idea. What is the use case for exporting
the clock tree? If it is debug, then I suggest using debugfs to avoid abi
issues.

g.

>
> Signed-off-by: Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
>  drivers/clk/Kconfig     |   10 +++
>  drivers/clk/Makefile    |    1 +
>  drivers/clk/clk-sysfs.c |  199
+++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/clk/clk.c       |    5 +-
>  include/linux/clk.h     |   36 ++++++++-
>  5 files changed, 248 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/clk/clk-sysfs.c
>
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index ba7eb8c..8f8e7ac 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -19,3 +19,13 @@ config GENERIC_CLK_BASIC
>        help
>           Allow use of basic, single-function clock types.  These
>           common definitions can be used across many platforms.
> +
> +config GENERIC_CLK_SYSFS
> +       bool "Clock tree topology and debug info"
> +       depends on EXPERIMENTAL && GENERIC_CLK
> +       help
> +          Creates clock tree represenation in sysfs.  Directory names
> +          and hierarchy represent clock names and tree structure,
> +          respectively.  Each directory exports clock rate, flags,
> +          prepare_count and enable_count info as read-only for debug
> +          purposes.
> diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
> index 68b20a1..806a9999 100644
> --- a/drivers/clk/Makefile
> +++ b/drivers/clk/Makefile
> @@ -2,3 +2,4 @@
>  obj-$(CONFIG_CLKDEV_LOOKUP)            += clkdev.o
>  obj-$(CONFIG_GENERIC_CLK)              += clk.o
>  obj-$(CONFIG_GENERIC_CLK_BASIC)                += clk-basic.o
> +obj-$(CONFIG_GENERIC_CLK_SYSFS)                += clk-sysfs.o
> diff --git a/drivers/clk/clk-sysfs.c b/drivers/clk/clk-sysfs.c
> new file mode 100644
> index 0000000..8ccf9e3
> --- /dev/null
> +++ b/drivers/clk/clk-sysfs.c
> @@ -0,0 +1,199 @@
> +/*
> + * Copyright (C) 2011 Linaro Ltd <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Clock tree topology and debug info for the common clock framework
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/kobject.h>
> +#include <linux/sysfs.h>
> +#include <linux/err.h>
> +
> +#define MAX_STRING_LENGTH      32
> +
> +static struct kobject *clk_kobj;
> +LIST_HEAD(kobj_list);
> +
> +struct clk_attribute {
> +       struct attribute attr;
> +       ssize_t (*show)(struct clk *clk, char *buf);
> +};
> +
> +static ssize_t clk_rate_show(struct clk *clk, char *buf)
> +{
> +       if (IS_ERR_OR_NULL(clk))
> +               return -ENODEV;
> +
> +       return snprintf(buf, MAX_STRING_LENGTH, "%lu\n", clk->rate);
> +}
> +
> +static ssize_t clk_flags_show(struct clk *clk, char *buf)
> +{
> +       if (IS_ERR_OR_NULL(clk))
> +               return -ENODEV;
> +
> +       return snprintf(buf, MAX_STRING_LENGTH, "0x%lX\n", clk->flags);
> +}
> +
> +static ssize_t clk_prepare_count_show(struct clk *clk, char *buf)
> +{
> +       if (IS_ERR_OR_NULL(clk))
> +               return -ENODEV;
> +
> +       return snprintf(buf, MAX_STRING_LENGTH, "%d\n",
clk->prepare_count);
> +}
> +
> +static ssize_t clk_enable_count_show(struct clk *clk, char *buf)
> +{
> +       if (IS_ERR_OR_NULL(clk))
> +               return -ENODEV;
> +
> +       return snprintf(buf, MAX_STRING_LENGTH, "%d\n",
clk->enable_count);
> +}
> +
> +static ssize_t clk_show(struct kobject *kobj, struct attribute *attr,
> +               char *buf)
> +{
> +       struct clk *clk;
> +       struct clk_attribute *clk_attr;
> +       ssize_t ret = -EINVAL;
> +
> +       clk = container_of(kobj, struct clk, kobj);
> +       clk_attr = container_of(attr, struct clk_attribute, attr);
> +
> +       if (!clk || !clk_attr)
> +               goto out;
> +
> +       /* we don't do any locking for debug operations */
> +
> +       /* refcount++ */
> +       kobject_get(&clk->kobj);
> +
> +       if (clk_attr->show)
> +               ret = clk_attr->show(clk, buf);
> +       else
> +               ret = -EIO;
> +
> +       /* refcount-- */
> +       kobject_put(&clk->kobj);
> +
> +out:
> +       return ret;
> +}
> +
> +static struct clk_attribute clk_rate = __ATTR_RO(clk_rate);
> +static struct clk_attribute clk_flags = __ATTR_RO(clk_flags);
> +static struct clk_attribute clk_prepare_count =
__ATTR_RO(clk_prepare_count);
> +static struct clk_attribute clk_enable_count =
__ATTR_RO(clk_enable_count);
> +
> +static struct attribute *clk_default_attrs[] = {
> +       &clk_rate.attr,
> +       &clk_flags.attr,
> +       &clk_prepare_count.attr,
> +       &clk_enable_count.attr,
> +       NULL,
> +};
> +
> +static const struct sysfs_ops clk_ops = {
> +       .show   = clk_show,
> +};
> +
> +static void clk_release(struct kobject *kobj)
> +{
> +       struct clk *clk;
> +
> +       clk = container_of(kobj, struct clk, kobj);
> +
> +       complete(&clk->kobj_unregister);
> +}
> +
> +static struct kobj_type clk_ktype = {
> +       .sysfs_ops      = &clk_ops,
> +       .default_attrs  = clk_default_attrs,
> +       .release        = clk_release,
> +};
> +
> +int clk_kobj_add(struct clk *clk)
> +{
> +       if (IS_ERR(clk))
> +               return -EINVAL;
> +
> +       /*
> +        * Some kobject trickery!
> +        *
> +        * We want to (ab)use the kobject infrastructure to track our
> +        * tree topology for us, specifically the root clocks (which are
> +        * otherwise not remembered in a global list).
> +        *
> +        * Unfortunately we might not be able to allocate memory yet
> +        * when this path is hit.  This pretty much rules out anything
> +        * that looks or smells like kobject_add, since there are
> +        * allocations for kobject->name and a dependency on sysfs being
> +        * initialized.
> +        *
> +        * To get around this we initialize the kobjects and (ab)use
> +        * struct kobject's list_head member, "entry".  Later on we walk
> +        * this list in clk_sysfs_tree_create() to make proper
> +        * kobject_add calls once it is safe to do so.
> +        *
> +        * FIXME - this is starting to smell alot like clkdev (i.e.
> +        * tracking the clocks in a list)
> +        */
> +
> +       kobject_init(&clk->kobj, &clk_ktype);
> +       list_add_tail(&clk->kobj.entry, &kobj_list);
> +       return 0;
> +}
> +
> +int clk_kobj_reparent(struct clk *clk, struct clk *parent)
> +{
> +       int ret;
> +
> +       if (!clk || !parent)
> +               return -EINVAL;
> +
> +       ret = kobject_move(&clk->kobj, &parent->kobj);
> +       if (ret)
> +               pr_warning("%s: failed to reparent %s to %s in sysfs\n",
> +                               __func__, clk->name, parent->name);
> +
> +       return ret;
> +}
> +
> +static int __init clk_sysfs_init(void)
> +{
> +       struct list_head *tmp;
> +
> +       clk_kobj = kobject_create_and_add("clk", NULL);
> +
> +       WARN_ON(!clk_kobj);
> +
> +       list_for_each(tmp, &kobj_list) {
> +               struct kobject *kobj;
> +               struct clk *clk;
> +               struct kobject *parent_kobj = NULL;
> +               int ret;
> +
> +               kobj = container_of(tmp, struct kobject, entry);
> +
> +               clk = container_of(kobj, struct clk, kobj);
> +
> +               /* assumes list is ordered */
> +               if (clk->parent)
> +                       parent_kobj = &clk->parent->kobj;
> +               else
> +                       parent_kobj = clk_kobj;
> +
> +               ret = kobject_add(kobj, parent_kobj, clk->name);
> +               if (ret)
> +                       pr_warning("%s: failed to create sysfs entry for
%s\n",
> +                                       __func__, clk->name);
> +       }
> +
> +       return 0;
> +}
> +late_initcall(clk_sysfs_init);
> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> index 12c9994..85dabdb 100644
> --- a/drivers/clk/clk.c
> +++ b/drivers/clk/clk.c
> @@ -436,7 +436,8 @@ void __clk_reparent(struct clk *clk, struct clk
*new_parent)
>
>        clk->parent = new_parent;
>
> -       /* FIXME update sysfs clock topology */
> +       /* update sysfs clock topology */
> +       clk_kobj_reparent(clk, clk->parent);
>  }
>
>  /**
> @@ -531,6 +532,8 @@ void clk_init(struct device *dev, struct clk *clk)
>        else
>                clk->rate = 0;
>
> +       clk_kobj_add(clk);
> +
>        mutex_unlock(&prepare_lock);
>
>        return;
> diff --git a/include/linux/clk.h b/include/linux/clk.h
> index 8ed354a..99337ca 100644
> --- a/include/linux/clk.h
> +++ b/include/linux/clk.h
> @@ -14,8 +14,8 @@
>  #define __LINUX_CLK_H
>
>  #include <linux/kernel.h>
> -
> -#include <linux/kernel.h>
> +#include <linux/kobject.h>
> +#include <linux/completion.h>
>  #include <linux/errno.h>
>
>  struct device;
> @@ -46,6 +46,10 @@ struct clk {
>        unsigned int            prepare_count;
>        struct hlist_head       children;
>        struct hlist_node       child_node;
> +#ifdef CONFIG_GENERIC_CLK_SYSFS
> +       struct kobject          kobj;
> +       struct completion       kobj_unregister;
> +#endif
>  };
>
>  /**
> @@ -177,6 +181,34 @@ int clk_register_gate(struct device *dev, const char
*name, unsigned long flags,
>  */
>  void clk_init(struct device *dev, struct clk *clk);
>
> +#ifdef CONFIG_GENERIC_CLK_SYSFS
> +/**
> + * clk_kobj_add - create a clk entry in sysfs
> + * @clk: clk to model in sysfs
> + *
> + * Create a directory in sysfs with the same name as clk.  Also creates
> + * read-only entries for the common struct clk members (rate, flags,
> + * prepare_count & enable_count).  The topology of the tree is
> + * represented by the sysfs directory structure itself.
> + */
> +int clk_kobj_add(struct clk *clk);
> +
> +/**
> + * clk_kobj_reparent - reparent a clk entry in sysfs
> + * @clk: the child clk that is switching parents
> + * @parent: the new parent clk
> + *
> + * Simple call to kobject_move to keep sysfs up to date with the
> + * hardware clock topology
> + */
> +int clk_kobj_reparent(struct clk *clk, struct clk *parent);
> +#else
> +static inline int clk_kobj_add(struct clk *clk)
> +{ return 0; }
> +static inline int clk_kobj_reparent(struct clk *clk, struct clk *parent)
> +{ return 0; }
> +#endif
> +
>  #endif /* !CONFIG_GENERIC_CLK */
>
>  /**
> --
> 1.7.4.1
>

--00163646d7dc42bb5a04b2556b70
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p><br>
On Nov 21, 2011 6:43 PM, &quot;Mike Turquette&quot; &lt;<a href=3D"mailto:m=
turquette-l0cyMroinI0@public.gmane.org">mturquette-l0cyMroinI0@public.gmane.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Introduces kobject support for the common struct clk, exports per-clk<=
br>
&gt; data via read-only callbacks and models the clk tree topology in sysfs=
.<br>
&gt;<br>
&gt; Also adds support for generating the clk tree in clk_init and migratin=
g<br>
&gt; nodes when input sources are switches in clk_set_parent.</p>
<p>I&#39;m not convinced this is a good idea. What is the use case for expo=
rting the clock tree? If it is debug, then I suggest using debugfs to avoid=
 abi issues.</p>
<p>g.</p>
<p>&gt;<br>
&gt; Signed-off-by: Mike Turquette &lt;<a href=3D"mailto:mturquette@linaro.=
org">mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; ---<br>
&gt; =A0drivers/clk/Kconfig =A0 =A0 | =A0 10 +++<br>
&gt; =A0drivers/clk/Makefile =A0 =A0| =A0 =A01 +<br>
&gt; =A0drivers/clk/clk-sysfs.c | =A0199 ++++++++++++++++++++++++++++++++++=
+++++++++++++<br>
&gt; =A0drivers/clk/clk.c =A0 =A0 =A0 | =A0 =A05 +-<br>
&gt; =A0include/linux/clk.h =A0 =A0 | =A0 36 ++++++++-<br>
&gt; =A05 files changed, 248 insertions(+), 3 deletions(-)<br>
&gt; =A0create mode 100644 drivers/clk/clk-sysfs.c<br>
&gt;<br>
&gt; diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig<br>
&gt; index ba7eb8c..8f8e7ac 100644<br>
&gt; --- a/drivers/clk/Kconfig<br>
&gt; +++ b/drivers/clk/Kconfig<br>
&gt; @@ -19,3 +19,13 @@ config GENERIC_CLK_BASIC<br>
&gt; =A0 =A0 =A0 =A0help<br>
&gt; =A0 =A0 =A0 =A0 =A0 Allow use of basic, single-function clock types. =
=A0These<br>
&gt; =A0 =A0 =A0 =A0 =A0 common definitions can be used across many platfor=
ms.<br>
&gt; +<br>
&gt; +config GENERIC_CLK_SYSFS<br>
&gt; + =A0 =A0 =A0 bool &quot;Clock tree topology and debug info&quot;<br>
&gt; + =A0 =A0 =A0 depends on EXPERIMENTAL &amp;&amp; GENERIC_CLK<br>
&gt; + =A0 =A0 =A0 help<br>
&gt; + =A0 =A0 =A0 =A0 =A0Creates clock tree represenation in sysfs. =A0Dir=
ectory names<br>
&gt; + =A0 =A0 =A0 =A0 =A0and hierarchy represent clock names and tree stru=
cture,<br>
&gt; + =A0 =A0 =A0 =A0 =A0respectively. =A0Each directory exports clock rat=
e, flags,<br>
&gt; + =A0 =A0 =A0 =A0 =A0prepare_count and enable_count info as read-only =
for debug<br>
&gt; + =A0 =A0 =A0 =A0 =A0purposes.<br>
&gt; diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile<br>
&gt; index 68b20a1..806a9999 100644<br>
&gt; --- a/drivers/clk/Makefile<br>
&gt; +++ b/drivers/clk/Makefile<br>
&gt; @@ -2,3 +2,4 @@<br>
&gt; =A0obj-$(CONFIG_CLKDEV_LOOKUP) =A0 =A0 =A0 =A0 =A0 =A0+=3D clkdev.o<br=
>
&gt; =A0obj-$(CONFIG_GENERIC_CLK) =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D clk.o<br>
&gt; =A0obj-$(CONFIG_GENERIC_CLK_BASIC) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D=
 clk-basic.o<br>
&gt; +obj-$(CONFIG_GENERIC_CLK_SYSFS) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D c=
lk-sysfs.o<br>
&gt; diff --git a/drivers/clk/clk-sysfs.c b/drivers/clk/clk-sysfs.c<br>
&gt; new file mode 100644<br>
&gt; index 0000000..8ccf9e3<br>
&gt; --- /dev/null<br>
&gt; +++ b/drivers/clk/clk-sysfs.c<br>
&gt; @@ -0,0 +1,199 @@<br>
&gt; +/*<br>
&gt; + * Copyright (C) 2011 Linaro Ltd &lt;<a href=3D"mailto:mturquette@lin=
aro.org">mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org</a>&gt;<br>
&gt; + *<br>
&gt; + * This program is free software; you can redistribute it and/or modi=
fy<br>
&gt; + * it under the terms of the GNU General Public License version 2 as<=
br>
&gt; + * published by the Free Software Foundation.<br>
&gt; + *<br>
&gt; + * Clock tree topology and debug info for the common clock framework<=
br>
&gt; + */<br>
&gt; +<br>
&gt; +#include &lt;linux/clk.h&gt;<br>
&gt; +#include &lt;linux/kobject.h&gt;<br>
&gt; +#include &lt;linux/sysfs.h&gt;<br>
&gt; +#include &lt;linux/err.h&gt;<br>
&gt; +<br>
&gt; +#define MAX_STRING_LENGTH =A0 =A0 =A032<br>
&gt; +<br>
&gt; +static struct kobject *clk_kobj;<br>
&gt; +LIST_HEAD(kobj_list);<br>
&gt; +<br>
&gt; +struct clk_attribute {<br>
&gt; + =A0 =A0 =A0 struct attribute attr;<br>
&gt; + =A0 =A0 =A0 ssize_t (*show)(struct clk *clk, char *buf);<br>
&gt; +};<br>
&gt; +<br>
&gt; +static ssize_t clk_rate_show(struct clk *clk, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 if (IS_ERR_OR_NULL(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return snprintf(buf, MAX_STRING_LENGTH, &quot;%lu\n&quot=
;, clk-&gt;rate);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t clk_flags_show(struct clk *clk, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 if (IS_ERR_OR_NULL(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return snprintf(buf, MAX_STRING_LENGTH, &quot;0x%lX\n&qu=
ot;, clk-&gt;flags);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t clk_prepare_count_show(struct clk *clk, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 if (IS_ERR_OR_NULL(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return snprintf(buf, MAX_STRING_LENGTH, &quot;%d\n&quot;=
, clk-&gt;prepare_count);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t clk_enable_count_show(struct clk *clk, char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 if (IS_ERR_OR_NULL(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return snprintf(buf, MAX_STRING_LENGTH, &quot;%d\n&quot;=
, clk-&gt;enable_count);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static ssize_t clk_show(struct kobject *kobj, struct attribute *attr,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 char *buf)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct clk *clk;<br>
&gt; + =A0 =A0 =A0 struct clk_attribute *clk_attr;<br>
&gt; + =A0 =A0 =A0 ssize_t ret =3D -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D container_of(kobj, struct clk, kobj);<br>
&gt; + =A0 =A0 =A0 clk_attr =3D container_of(attr, struct clk_attribute, at=
tr);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (!clk || !clk_attr)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* we don&#39;t do any locking for debug operations */<b=
r>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* refcount++ */<br>
&gt; + =A0 =A0 =A0 kobject_get(&amp;clk-&gt;kobj);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (clk_attr-&gt;show)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D clk_attr-&gt;show(clk, buf);<br>
&gt; + =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EIO;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /* refcount-- */<br>
&gt; + =A0 =A0 =A0 kobject_put(&amp;clk-&gt;kobj);<br>
&gt; +<br>
&gt; +out:<br>
&gt; + =A0 =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct clk_attribute clk_rate =3D __ATTR_RO(clk_rate);<br>
&gt; +static struct clk_attribute clk_flags =3D __ATTR_RO(clk_flags);<br>
&gt; +static struct clk_attribute clk_prepare_count =3D __ATTR_RO(clk_prepa=
re_count);<br>
&gt; +static struct clk_attribute clk_enable_count =3D __ATTR_RO(clk_enable=
_count);<br>
&gt; +<br>
&gt; +static struct attribute *clk_default_attrs[] =3D {<br>
&gt; + =A0 =A0 =A0 &amp;clk_rate.attr,<br>
&gt; + =A0 =A0 =A0 &amp;clk_flags.attr,<br>
&gt; + =A0 =A0 =A0 &amp;clk_prepare_count.attr,<br>
&gt; + =A0 =A0 =A0 &amp;clk_enable_count.attr,<br>
&gt; + =A0 =A0 =A0 NULL,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static const struct sysfs_ops clk_ops =3D {<br>
&gt; + =A0 =A0 =A0 .show =A0 =3D clk_show,<br>
&gt; +};<br>
&gt; +<br>
&gt; +static void clk_release(struct kobject *kobj)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct clk *clk;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk =3D container_of(kobj, struct clk, kobj);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 complete(&amp;clk-&gt;kobj_unregister);<br>
&gt; +}<br>
&gt; +<br>
&gt; +static struct kobj_type clk_ktype =3D {<br>
&gt; + =A0 =A0 =A0 .sysfs_ops =A0 =A0 =A0=3D &amp;clk_ops,<br>
&gt; + =A0 =A0 =A0 .default_attrs =A0=3D clk_default_attrs,<br>
&gt; + =A0 =A0 =A0 .release =A0 =A0 =A0 =A0=3D clk_release,<br>
&gt; +};<br>
&gt; +<br>
&gt; +int clk_kobj_add(struct clk *clk)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 if (IS_ERR(clk))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 /*<br>
&gt; + =A0 =A0 =A0 =A0* Some kobject trickery!<br>
&gt; + =A0 =A0 =A0 =A0*<br>
&gt; + =A0 =A0 =A0 =A0* We want to (ab)use the kobject infrastructure to tr=
ack our<br>
&gt; + =A0 =A0 =A0 =A0* tree topology for us, specifically the root clocks =
(which are<br>
&gt; + =A0 =A0 =A0 =A0* otherwise not remembered in a global list).<br>
&gt; + =A0 =A0 =A0 =A0*<br>
&gt; + =A0 =A0 =A0 =A0* Unfortunately we might not be able to allocate memo=
ry yet<br>
&gt; + =A0 =A0 =A0 =A0* when this path is hit. =A0This pretty much rules ou=
t anything<br>
&gt; + =A0 =A0 =A0 =A0* that looks or smells like kobject_add, since there =
are<br>
&gt; + =A0 =A0 =A0 =A0* allocations for kobject-&gt;name and a dependency o=
n sysfs being<br>
&gt; + =A0 =A0 =A0 =A0* initialized.<br>
&gt; + =A0 =A0 =A0 =A0*<br>
&gt; + =A0 =A0 =A0 =A0* To get around this we initialize the kobjects and (=
ab)use<br>
&gt; + =A0 =A0 =A0 =A0* struct kobject&#39;s list_head member, &quot;entry&=
quot;. =A0Later on we walk<br>
&gt; + =A0 =A0 =A0 =A0* this list in clk_sysfs_tree_create() to make proper=
<br>
&gt; + =A0 =A0 =A0 =A0* kobject_add calls once it is safe to do so.<br>
&gt; + =A0 =A0 =A0 =A0*<br>
&gt; + =A0 =A0 =A0 =A0* FIXME - this is starting to smell alot like clkdev =
(i.e.<br>
&gt; + =A0 =A0 =A0 =A0* tracking the clocks in a list)<br>
&gt; + =A0 =A0 =A0 =A0*/<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 kobject_init(&amp;clk-&gt;kobj, &amp;clk_ktype);<br>
&gt; + =A0 =A0 =A0 list_add_tail(&amp;clk-&gt;kobj.entry, &amp;kobj_list);<=
br>
&gt; + =A0 =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +<br>
&gt; +int clk_kobj_reparent(struct clk *clk, struct clk *parent)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 if (!clk || !parent)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 ret =3D kobject_move(&amp;clk-&gt;kobj, &amp;parent-&gt;=
kobj);<br>
&gt; + =A0 =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&quot;%s: failed to reparent =
%s to %s in sysfs\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__=
, clk-&gt;name, parent-&gt;name);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return ret;<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int __init clk_sysfs_init(void)<br>
&gt; +{<br>
&gt; + =A0 =A0 =A0 struct list_head *tmp;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 clk_kobj =3D kobject_create_and_add(&quot;clk&quot;, NUL=
L);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 WARN_ON(!clk_kobj);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 list_for_each(tmp, &amp;kobj_list) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct kobject *kobj;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct clk *clk;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct kobject *parent_kobj =3D NULL;<br=
>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kobj =3D container_of(tmp, struct kobjec=
t, entry);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk =3D container_of(kobj, struct clk, k=
obj);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* assumes list is ordered */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (clk-&gt;parent)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_kobj =3D &amp;clk=
-&gt;parent-&gt;kobj;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 parent_kobj =3D clk_kobj=
;<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D kobject_add(kobj, parent_kobj, c=
lk-&gt;name);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret)<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning(&quot;%s: fai=
led to create sysfs entry for %s\n&quot;,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 __func__, clk-&gt;name);<br>
&gt; + =A0 =A0 =A0 }<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 return 0;<br>
&gt; +}<br>
&gt; +late_initcall(clk_sysfs_init);<br>
&gt; diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c<br>
&gt; index 12c9994..85dabdb 100644<br>
&gt; --- a/drivers/clk/clk.c<br>
&gt; +++ b/drivers/clk/clk.c<br>
&gt; @@ -436,7 +436,8 @@ void __clk_reparent(struct clk *clk, struct clk *n=
ew_parent)<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0clk-&gt;parent =3D new_parent;<br>
&gt;<br>
&gt; - =A0 =A0 =A0 /* FIXME update sysfs clock topology */<br>
&gt; + =A0 =A0 =A0 /* update sysfs clock topology */<br>
&gt; + =A0 =A0 =A0 clk_kobj_reparent(clk, clk-&gt;parent);<br>
&gt; =A0}<br>
&gt;<br>
&gt; =A0/**<br>
&gt; @@ -531,6 +532,8 @@ void clk_init(struct device *dev, struct clk *clk)=
<br>
&gt; =A0 =A0 =A0 =A0else<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0clk-&gt;rate =3D 0;<br>
&gt;<br>
&gt; + =A0 =A0 =A0 clk_kobj_add(clk);<br>
&gt; +<br>
&gt; =A0 =A0 =A0 =A0mutex_unlock(&amp;prepare_lock);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0return;<br>
&gt; diff --git a/include/linux/clk.h b/include/linux/clk.h<br>
&gt; index 8ed354a..99337ca 100644<br>
&gt; --- a/include/linux/clk.h<br>
&gt; +++ b/include/linux/clk.h<br>
&gt; @@ -14,8 +14,8 @@<br>
&gt; =A0#define __LINUX_CLK_H<br>
&gt;<br>
&gt; =A0#include &lt;linux/kernel.h&gt;<br>
&gt; -<br>
&gt; -#include &lt;linux/kernel.h&gt;<br>
&gt; +#include &lt;linux/kobject.h&gt;<br>
&gt; +#include &lt;linux/completion.h&gt;<br>
&gt; =A0#include &lt;linux/errno.h&gt;<br>
&gt;<br>
&gt; =A0struct device;<br>
&gt; @@ -46,6 +46,10 @@ struct clk {<br>
&gt; =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0prepare_count;<br>
&gt; =A0 =A0 =A0 =A0struct hlist_head =A0 =A0 =A0 children;<br>
&gt; =A0 =A0 =A0 =A0struct hlist_node =A0 =A0 =A0 child_node;<br>
&gt; +#ifdef CONFIG_GENERIC_CLK_SYSFS<br>
&gt; + =A0 =A0 =A0 struct kobject =A0 =A0 =A0 =A0 =A0kobj;<br>
&gt; + =A0 =A0 =A0 struct completion =A0 =A0 =A0 kobj_unregister;<br>
&gt; +#endif<br>
&gt; =A0};<br>
&gt;<br>
&gt; =A0/**<br>
&gt; @@ -177,6 +181,34 @@ int clk_register_gate(struct device *dev, const c=
har *name, unsigned long flags,<br>
&gt; =A0*/<br>
&gt; =A0void clk_init(struct device *dev, struct clk *clk);<br>
&gt;<br>
&gt; +#ifdef CONFIG_GENERIC_CLK_SYSFS<br>
&gt; +/**<br>
&gt; + * clk_kobj_add - create a clk entry in sysfs<br>
&gt; + * @clk: clk to model in sysfs<br>
&gt; + *<br>
&gt; + * Create a directory in sysfs with the same name as clk. =A0Also cre=
ates<br>
&gt; + * read-only entries for the common struct clk members (rate, flags,<=
br>
&gt; + * prepare_count &amp; enable_count). =A0The topology of the tree is<=
br>
&gt; + * represented by the sysfs directory structure itself.<br>
&gt; + */<br>
&gt; +int clk_kobj_add(struct clk *clk);<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * clk_kobj_reparent - reparent a clk entry in sysfs<br>
&gt; + * @clk: the child clk that is switching parents<br>
&gt; + * @parent: the new parent clk<br>
&gt; + *<br>
&gt; + * Simple call to kobject_move to keep sysfs up to date with the<br>
&gt; + * hardware clock topology<br>
&gt; + */<br>
&gt; +int clk_kobj_reparent(struct clk *clk, struct clk *parent);<br>
&gt; +#else<br>
&gt; +static inline int clk_kobj_add(struct clk *clk)<br>
&gt; +{ return 0; }<br>
&gt; +static inline int clk_kobj_reparent(struct clk *clk, struct clk *pare=
nt)<br>
&gt; +{ return 0; }<br>
&gt; +#endif<br>
&gt; +<br>
&gt; =A0#endif /* !CONFIG_GENERIC_CLK */<br>
&gt;<br>
&gt; =A0/**<br>
&gt; --<br>
&gt; 1.7.4.1<br>
&gt;<br>
</p>

--00163646d7dc42bb5a04b2556b70--


--===============8557450393854623149==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linaro-dev mailing list
linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
http://lists.linaro.org/mailman/listinfo/linaro-dev

--===============8557450393854623149==--
