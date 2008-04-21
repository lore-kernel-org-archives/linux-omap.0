From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap
	clock framework
Date: Mon, 21 Apr 2008 11:40:12 -0700
Message-ID: <20080421184012.GA24257@atomide.com>
References: <20080417.215723.241260895.Hiroshi.DOYU@nokia.com> <200804171214.35936.david-b@pacbell.net> <alpine.DEB.1.00.0804171319020.8530@utopia.booyaka.com> <20080417.225840.105362426.Hiroshi.DOYU@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:60900 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753231AbYDUSkR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 21 Apr 2008 14:40:17 -0400
Content-Disposition: inline
In-Reply-To: <20080417.225840.105362426.Hiroshi.DOYU@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
Cc: paul@pwsan.com, david-b@pacbell.net, linux-omap@vger.kernel.org

* Hiroshi DOYU <Hiroshi.DOYU@nokia.com> [080417 13:02]:
> From: "ext Paul Walmsley" <paul@pwsan.com>
> Subject: Re: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
> Date: Thu, 17 Apr 2008 13:44:04 -0600 (MDT)
> 
> > Hello Hiroshi, David,
> > 
> > On Thu, 17 Apr 2008, David Brownell wrote:
> > 
> > > On Thursday 17 April 2008, Hiroshi DOYU wrote:
> > > 
> > > > And if there will be a little possibility that sysfs attribute can be
> > > > used by userland in the future, keeping sysfs instead of debugfs
> > > > doesn't seem not so illegal, does it?
> > 
> > True, but if we can do a debugfs implementation first, then that seems 
> > like a good way to start, no?  Userspace PM implementations are probably 
> > some months in the future, and we can mandate that debugfs be mounted for 
> > those.
> 
> Agreed. Update ones attached. The diffs against the previous are:
> 
> diff -u b/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> --- b/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -524,7 +524,7 @@
>  
>  	p += sprintf(p, "%s", c->name);
>  	if (c->id != 0)
> -		sprintf(p, "%d", c->id);
> +		sprintf(p, ":%d", c->id);
>  	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
>  	if (IS_ERR(d))
>  		return PTR_ERR(d);
> diff -u b/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
> --- b/include/asm-arm/arch-omap/clock.h
> +++ b/include/asm-arm/arch-omap/clock.h
> @@ -86,7 +86,7 @@
>  	__u8			rate_offset;
>  	__u8			src_offset;
>  #endif
> -#ifdef CONFIG_DEBUG_FS
> +#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
>  	struct dentry		*dent;	/* For visible tree hierarchy */
>  #endif
>  };

Pushing today.

Tony


> 
>  Hiroshi DOYU

> From fa06e7a21c08299eaa61e6c367ec8e737a8ff13b Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Thu, 17 Apr 2008 16:51:41 +0300
> Subject: [PATCH 2/2] ARM: OMAP: CLKFW: Remove procfs entry for debugging clock framework
> 
> This feature can be covered by debugfs for omap clock framework.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/clock.c |   96 --------------------------------------------
>  1 files changed, 0 insertions(+), 96 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 2ae87bf..714dbbf 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -34,41 +34,6 @@ static DEFINE_SPINLOCK(clockfw_lock);
>  
>  static struct clk_functions *arch_clock;
>  
> -#ifdef CONFIG_PM_DEBUG
> -
> -static void print_parents(struct clk *clk)
> -{
> -	struct clk *p;
> -	int printed = 0;
> -
> -	list_for_each_entry(p, &clocks, node) {
> -		if (p->parent == clk && p->usecount) {
> -			if (!clk->usecount && !printed) {
> -				printk("MISMATCH: %s\n", clk->name);
> -				printed = 1;
> -			}
> -			printk("\t%-15s\n", p->name);
> -		}
> -	}
> -}
> -
> -void clk_print_usecounts(void)
> -{
> -	unsigned long flags;
> -	struct clk *p;
> -
> -	spin_lock_irqsave(&clockfw_lock, flags);
> -	list_for_each_entry(p, &clocks, node) {
> -		if (p->usecount)
> -			printk("%-15s: %d\n", p->name, p->usecount);
> -		print_parents(p);
> -
> -	}
> -	spin_unlock_irqrestore(&clockfw_lock, flags);
> -}
> -
> -#endif
> -
>  /*-------------------------------------------------------------------------
>   * Standard clock functions defined in include/linux/clk.h
>   *-------------------------------------------------------------------------*/
> @@ -447,67 +412,6 @@ int __init clk_init(struct clk_functions * custom_clocks)
>  	return 0;
>  }
>  
> -#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_PROC_FS)
> -#include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
> -
> -static void *omap_ck_start(struct seq_file *m, loff_t *pos)
> -{
> -	return *pos < 1 ? (void *)1 : NULL;
> -}
> -
> -static void *omap_ck_next(struct seq_file *m, void *v, loff_t *pos)
> -{
> -	++*pos;
> -	return NULL;
> -}
> -
> -static void omap_ck_stop(struct seq_file *m, void *v)
> -{
> -}
> -
> -int omap_ck_show(struct seq_file *m, void *v)
> -{
> -	struct clk *cp;
> -
> -	list_for_each_entry(cp, &clocks, node)
> -		seq_printf(m,"%s %ld %d\n", cp->name, cp->rate, cp->usecount);
> -
> -	return 0;
> -}
> -
> -static struct seq_operations omap_ck_op = {
> -	.start =	omap_ck_start,
> -	.next =		omap_ck_next,
> -	.stop =		omap_ck_stop,
> -	.show =		omap_ck_show
> -};
> -
> -static int omap_ck_open(struct inode *inode, struct file *file)
> -{
> -	return seq_open(file, &omap_ck_op);
> -}
> -
> -static struct file_operations proc_omap_ck_operations = {
> -	.open		= omap_ck_open,
> -	.read		= seq_read,
> -	.llseek		= seq_lseek,
> -	.release	= seq_release,
> -};
> -
> -int __init omap_ck_init(void)
> -{
> -	struct proc_dir_entry *entry;
> -
> -	entry = create_proc_entry("omap_clocks", 0, NULL);
> -	if (entry)
> -		entry->proc_fops = &proc_omap_ck_operations;
> -	return 0;
> -
> -}
> -__initcall(omap_ck_init);
> -#endif
> -
>  #if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
>  /*
>   *	debugfs support to trace clock tree hierarchy and attributes
> -- 
> 1.5.5.rc2.6.gf58d
> 

> From d0c2ffa4d45ea686020959c9d7a68f1669806d22 Mon Sep 17 00:00:00 2001
> From: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> Date: Thu, 17 Apr 2008 13:51:34 +0300
> Subject: [PATCH 1/2] ARM: OMAP: CLKFW: Initial debugfs support for omap clock framework
> 
> debugfs can provide the infrastructure to trace the dependencies of
> clock tree hierarchy quite visibly. This patch enables to keep track
> of clock tree hierarchy and expose their attributes under each clock
> directry as below:
> 
> 	omap:~# tree -d -L 2 /debug/clock/omap_32k_fck/
> 	/debug/clock/omap_32k_fck/
> 	|-- gpt10_fck
> 	|-- gpt11_fck
> 	|-- gpt1_fck
> 	|-- per_32k_alwon_fck
> 	|   |-- gpio2_fck
> 	|   |-- gpio3_fck
> 	|   |-- gpio4_fck
> 	|   |-- gpio5_fck
> 	|   |-- gpio6_fck
> 	|   `-- wdt3_fck
> 	|-- ts_fck
> 	`-- wkup_32k_fck
> 	    |-- gpio1_fck
> 	    `-- wdt2_fck
> 
> 	14 directories
> 	omap:~# tree  /debug/clock/omap_32k_fck/gpt10_fck/
> 	/debug/clock/omap_32k_fck/gpt10_fck/
> 	|-- flags
> 	|-- rate
> 	`-- usecount
> 
> 	0 directories, 3 files
> 
> Although, compared with David Brownell's small patch, this may look
> bit overkilling, I expect that this debugfs can deal with other PRCM
> complexities at the same time. For example, powerdomain dependencies
> can be expressed by using symbolic links of these clocks if
> powerdomain supports dubgfs as well.
> 
> Signed-off-by: Hiroshi DOYU <Hiroshi.DOYU@nokia.com>
> ---
>  arch/arm/plat-omap/clock.c        |   94 ++++++++++++++++++++++++++++++++++++-
>  include/asm-arm/arch-omap/clock.h |    3 +
>  2 files changed, 96 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index 1bd8781..2ae87bf 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
> @@ -1,7 +1,7 @@
>  /*
>   *  linux/arch/arm/plat-omap/clock.c
>   *
> - *  Copyright (C) 2004 - 2005 Nokia corporation
> + *  Copyright (C) 2004 - 2008 Nokia corporation
>   *  Written by Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>
>   *
>   *  Modified for omap shared clock framework by Tony Lindgren <tony@atomide.com>
> @@ -21,6 +21,7 @@
>  #include <linux/clk.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/debugfs.h>
>  
>  #include <asm/io.h>
>  #include <asm/semaphore.h>
> @@ -506,3 +507,94 @@ int __init omap_ck_init(void)
>  }
>  __initcall(omap_ck_init);
>  #endif
> +
> +#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> +/*
> + *	debugfs support to trace clock tree hierarchy and attributes
> + */
> +static struct dentry *clk_debugfs_root;
> +
> +static int clk_debugfs_register_one(struct clk *c)
> +{
> +	int err;
> +	struct dentry *d, *child;
> +	struct clk *pa = c->parent;
> +	char s[255];
> +	char *p = s;
> +
> +	p += sprintf(p, "%s", c->name);
> +	if (c->id != 0)
> +		sprintf(p, ":%d", c->id);
> +	d = debugfs_create_dir(s, pa ? pa->dent : clk_debugfs_root);
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +	c->dent = d;
> +
> +	d = debugfs_create_u8("usecount", S_IRUGO, c->dent, (u8 *)&c->usecount);
> +	if (IS_ERR(d)) {
> +		err = PTR_ERR(d);
> +		goto err_out;
> +	}
> +	d = debugfs_create_u32("rate", S_IRUGO, c->dent, (u32 *)&c->rate);
> +	if (IS_ERR(d)) {
> +		err = PTR_ERR(d);
> +		goto err_out;
> +	}
> +	d = debugfs_create_x32("flags", S_IRUGO, c->dent, (u32 *)&c->flags);
> +	if (IS_ERR(d)) {
> +		err = PTR_ERR(d);
> +		goto err_out;
> +	}
> +	return 0;
> +
> +err_out:
> +	d = c->dent;
> +	list_for_each_entry(child, &d->d_subdirs, d_u.d_child)
> +		debugfs_remove(child);
> +	debugfs_remove(c->dent);
> +	return err;
> +}
> +
> +static int clk_debugfs_register(struct clk *c)
> +{
> +	int err;
> +	struct clk *pa = c->parent;
> +
> +	if (pa && !pa->dent) {
> +		err = clk_debugfs_register(pa);
> +		if (err)
> +			return err;
> +	}
> +
> +	if (!c->dent) {
> +		err = clk_debugfs_register_one(c);
> +		if (err)
> +			return err;
> +	}
> +	return 0;
> +}
> +
> +static int __init clk_debugfs_init(void)
> +{
> +	struct clk *c;
> +	struct dentry *d;
> +	int err;
> +
> +	d = debugfs_create_dir("clock", NULL);
> +	if (IS_ERR(d))
> +		return PTR_ERR(d);
> +	clk_debugfs_root = d;
> +
> +	list_for_each_entry(c, &clocks, node) {
> +		err = clk_debugfs_register(c);
> +		if (err)
> +			goto err_out;
> +	}
> +	return 0;
> +err_out:
> +	debugfs_remove(clk_debugfs_root); /* REVISIT: Cleanup correctly */
> +	return err;
> +}
> +late_initcall(clk_debugfs_init);
> +
> +#endif /* defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS) */
> diff --git a/include/asm-arm/arch-omap/clock.h b/include/asm-arm/arch-omap/clock.h
> index cce55ba..811af84 100644
> --- a/include/asm-arm/arch-omap/clock.h
> +++ b/include/asm-arm/arch-omap/clock.h
> @@ -86,6 +86,9 @@ struct clk {
>  	__u8			rate_offset;
>  	__u8			src_offset;
>  #endif
> +#if defined(CONFIG_PM_DEBUG) && defined(CONFIG_DEBUG_FS)
> +	struct dentry		*dent;	/* For visible tree hierarchy */
> +#endif
>  };
>  
>  struct clk_functions {
> -- 
> 1.5.5.rc2.6.gf58d
> 

