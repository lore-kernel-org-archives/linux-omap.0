From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCHv3 04/22] OMAP3: PM: Move smartreflex autocompensation enable disable hooks to PM debugfs.
Date: Tue, 27 Apr 2010 10:57:18 -0700
Message-ID: <87tyqwn5hd.fsf@deeprootsystems.com>
References: <1271408597-3066-1-git-send-email-thara@ti.com>
	<1271408597-3066-2-git-send-email-thara@ti.com>
	<1271408597-3066-3-git-send-email-thara@ti.com>
	<1271408597-3066-4-git-send-email-thara@ti.com>
	<1271408597-3066-5-git-send-email-thara@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:60959 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754234Ab0D0R5X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 13:57:23 -0400
Received: by pvg2 with SMTP id 2so1539454pvg.19
        for <linux-omap@vger.kernel.org>; Tue, 27 Apr 2010 10:57:22 -0700 (PDT)
In-Reply-To: <1271408597-3066-5-git-send-email-thara@ti.com> (Thara Gopinath's message of "Fri\, 16 Apr 2010 14\:32\:59 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Thara Gopinath <thara@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, b-cousson@ti.com, vishwanath.bs@ti.com, sawant@ti.com

Thara Gopinath <thara@ti.com> writes:

> This patch moves the hooks to enable disable smartreflex
> autocompensation to pm debugfs from the /sys/power/.
>
> To enable autocompensation for smartreflex SR<n> do
>         echo 1 > <path>/pm_debug/sr<n>_autocomp
> To disable autocompensation for smartreflex SR<n> do
>         echo 0 > <path>/pm_debug/sr<n>_autocomp
>
> Signed-off-by: Thara Gopinath <thara@ti.com>

some minor comments...

> ---
>  arch/arm/mach-omap2/pm-debug.c    |    4 +-
>  arch/arm/mach-omap2/smartreflex.c |  114 ++++++++++--------------------------
>  arch/arm/mach-omap2/smartreflex.h |    2 +
>  3 files changed, 36 insertions(+), 84 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm-debug.c b/arch/arm/mach-omap2/pm-debug.c
> index 8aafd71..ce46059 100644
> --- a/arch/arm/mach-omap2/pm-debug.c
> +++ b/arch/arm/mach-omap2/pm-debug.c
> @@ -162,7 +162,7 @@ void omap2_pm_dump(int mode, int resume, unsigned int us)
>  
>  static void pm_dbg_regset_store(u32 *ptr);
>  
> -struct dentry *pm_dbg_dir;
> +struct dentry *pm_dbg_dir, *pm_dbg_main_dir;
>  
>  static int pm_dbg_init_done;
>  
> @@ -613,7 +613,7 @@ static int __init pm_dbg_init(void)
>  					   S_IRUGO | S_IWUGO, d,
>  					   &voltage_off_while_idle,
>  					   &pm_dbg_option_fops);
> -
> +	pm_dbg_main_dir = d;
>  	pm_dbg_init_done = 1;
>  
>  	return 0;
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index b4e98e5..2f89d79 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -24,11 +24,11 @@
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/clk.h>
> -#include <linux/sysfs.h>
>  #include <linux/kobject.h>
>  #include <linux/i2c/twl.h>
>  #include <linux/io.h>
>  #include <linux/list.h>
> +#include <linux/debugfs.h>
>  
>  #include <plat/omap34xx.h>
>  #include <plat/clock.h>
> @@ -42,6 +42,7 @@
>  #include "prm-regbits-34xx.h"
>  
>  #define MAX_TRIES 100
> +#define SMARTREFLEX_NAME_LEN	16
>  
>  struct omap_sr {
>  	int			srid;
> @@ -796,103 +797,53 @@ int sr_voltagescale_vcbypass(u32 target_opp, u32 current_opp,
>  	return 0;
>  }
>  
> -/* Sysfs interface to select SR VDD1 auto compensation */
> -static ssize_t omap_sr_vdd1_autocomp_show(struct kobject *kobj,
> -					struct kobj_attribute *attr, char *buf)
> +/* PM Debug Fs enteries to enable disable smartreflex.*/
                                                         ^
need a space before the */

> +

stray blank line

> +static int omap_sr_autocomp_show(void *data, u64 *val)
>  {
> -	struct omap_sr *sr_info = _sr_lookup(SR1);
> +	struct omap_sr *sr_info = (struct omap_sr *) data;

        struct device *dev = &sr_info->pdev->dev;

>  	if (!sr_info) {
> -		pr_warning("omap_sr struct corresponding to SR1 not found\n");
> +		pr_warning("omap_sr struct corresponding to SR%d not found\n",
> +							sr_info->srid);

                dev_err(dev, "struct for SR%d not found\n",
                        sr_info->srid);

>  		return 0;
>  	}
> -	return sprintf(buf, "%d\n", sr_info->is_autocomp_active);
> +	*val = sr_info->is_autocomp_active;
> +	return 0;
>  }
>  
> -static ssize_t omap_sr_vdd1_autocomp_store(struct kobject *kobj,
> -					struct kobj_attribute *attr,
> -					const char *buf, size_t n)
> +static int omap_sr_autocomp_store(void *data, u64 val)
>  {
> -	unsigned short value;
> -
> -	if (sscanf(buf, "%hu", &value) != 1 || (value > 1)) {
> -		pr_err("sr_vdd1_autocomp: Invalid value\n");
> -		return -EINVAL;
> -	}
> -
> -	if (value == 0) {
> -		sr_stop_vddautocomap(SR1);
> -	} else {
> -		u32 current_vdd1opp_no = get_vdd1_opp();
> -		if (!current_vdd1opp_no) {
> -			pr_err("sr_vdd1_autocomp: Current VDD1 opp unknown\n");
> -			return -EINVAL;
> -		}
> -		sr_start_vddautocomap(SR1, current_vdd1opp_no);
> -	}
> -	return n;
> -}
> -
> -static struct kobj_attribute sr_vdd1_autocomp = {
> -	.attr = {
> -	.name = __stringify(sr_vdd1_autocomp),
> -	.mode = 0644,
> -	},
> -	.show = omap_sr_vdd1_autocomp_show,
> -	.store = omap_sr_vdd1_autocomp_store,
> -};
> -
> -/* Sysfs interface to select SR VDD2 auto compensation */
> -static ssize_t omap_sr_vdd2_autocomp_show(struct kobject *kobj,
> -					struct kobj_attribute *attr, char *buf)
> -{
> -	struct omap_sr *sr_info = _sr_lookup(SR2);
> +	struct omap_sr *sr_info = (struct omap_sr *) data;
>  
>  	if (!sr_info) {
> -		pr_warning("omap_sr struct corresponding to SR2 not found\n");
> +		pr_warning("omap_sr struct corresponding to SR%d not found\n",
> +							sr_info->srid);

dev_warn()

>  		return 0;
>  	}
> -	return sprintf(buf, "%d\n", sr_info->is_autocomp_active);
> -}
> -

[...]

Kevin
