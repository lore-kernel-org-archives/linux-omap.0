From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/4] PM: Dynamic GPIO clock handling
Date: Fri, 5 Sep 2008 07:29:55 -0600 (MDT)
Message-ID: <alpine.DEB.1.00.0809050631590.5763@utopia.booyaka.com>
References: <> <1219851962-28972-1-git-send-email-tero.kristo@nokia.com> <1219851962-28972-2-git-send-email-tero.kristo@nokia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:33661 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752902AbYIEN34 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Sep 2008 09:29:56 -0400
In-Reply-To: <1219851962-28972-2-git-send-email-tero.kristo@nokia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <tero.kristo@nokia.com>, jouni.hogander@nokia.com
Cc: linux-omap@vger.kernel.org

Hello Tero, Jouni,

so is this basically a workaround patch?

a few comments:

On Wed, 27 Aug 2008, Tero Kristo wrote:

> From: ext Jouni Hogander <jouni.hogander@nokia.com>
> 
> In omap3 gpios 2-6 are in per domain. Functional clocks for these
> should be disabled.
> 
> GPIO modules in PER domain are not able to act as a wake up source if
> PER domain is in retention. PER domain sleep transition before MPU is
> prevented by leaving icks active. PER domain still enters retention
> together with MPU. When this happens IOPAD wake up mechanism is used
> for gpios.
> 
> Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
> ---
>  arch/arm/mach-omap2/pm.c     |   20 ++++++++------
>  arch/arm/mach-omap2/pm.h     |    2 +-
>  arch/arm/mach-omap2/pm34xx.c |   56 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 67 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 4652136..1de5f14 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -32,7 +32,7 @@
>  #include "pm.h"
>  
>  unsigned short enable_dyn_sleep;
> -unsigned short clocks_off_while_idle;
> +unsigned short gpio_clocks_off_while_idle;
>  atomic_t sleep_block = ATOMIC_INIT(0);
>  
>  static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
> @@ -42,16 +42,16 @@ static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
>  static struct kobj_attribute sleep_while_idle_attr =
>  	__ATTR(sleep_while_idle, 0644, idle_show, idle_store);
>  
> -static struct kobj_attribute clocks_off_while_idle_attr =
> -	__ATTR(clocks_off_while_idle, 0644, idle_show, idle_store);
> +static struct kobj_attribute gpio_clocks_off_while_idle_attr =
> +	__ATTR(gpio_clocks_off_while_idle, 0644, idle_show, idle_store);
>  
>  static ssize_t idle_show(struct kobject *kobj, struct kobj_attribute *attr,
>  			 char *buf)
>  {
>  	if (attr == &sleep_while_idle_attr)
>  		return sprintf(buf, "%hu\n", enable_dyn_sleep);
> -	else if (attr == &clocks_off_while_idle_attr)
> -		return sprintf(buf, "%hu\n", clocks_off_while_idle);
> +	else if (attr == &gpio_clocks_off_while_idle_attr)
> +		return sprintf(buf, "%hu\n", gpio_clocks_off_while_idle);
>  	else
>  		return -EINVAL;
>  }
> @@ -69,8 +69,8 @@ static ssize_t idle_store(struct kobject *kobj, struct kobj_attribute *attr,
>  
>  	if (attr == &sleep_while_idle_attr)
>  		enable_dyn_sleep = value;
> -	else if (attr == &clocks_off_while_idle_attr)
> -		clocks_off_while_idle = value;
> +	else if (attr == &gpio_clocks_off_while_idle_attr)
> +		gpio_clocks_off_while_idle = value;
>  	else
>  		return -EINVAL;
>  
> @@ -106,10 +106,12 @@ static int __init omap_pm_init(void)
>  	/* disabled till drivers are fixed */
>  	enable_dyn_sleep = 0;
>  	error = sysfs_create_file(power_kobj, &sleep_while_idle_attr.attr);
> -	if (error)
> +	if (error) {
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
> +		return error;
> +	}
>  	error = sysfs_create_file(power_kobj,
> -				  &clocks_off_while_idle_attr.attr);
> +				  &gpio_clocks_off_while_idle_attr.attr);
>  	if (error)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", error);
>  
> diff --git a/arch/arm/mach-omap2/pm.h b/arch/arm/mach-omap2/pm.h
> index 68c9278..d446ea4 100644
> --- a/arch/arm/mach-omap2/pm.h
> +++ b/arch/arm/mach-omap2/pm.h
> @@ -17,7 +17,7 @@ extern int omap2_pm_init(void);
>  extern int omap3_pm_init(void);
>  
>  extern unsigned short enable_dyn_sleep;
> -extern unsigned short clocks_off_while_idle;
> +extern unsigned short gpio_clocks_off_while_idle;
>  extern atomic_t sleep_block;
>  
>  extern void omap2_block_sleep(void);
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index a16eb33..0baf359 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -53,6 +53,43 @@ static void (*saved_idle)(void);
>  
>  static struct powerdomain *mpu_pwrdm;
>  
> +/* Dynamic GPIO clock handling for sleep routines.
> + * omap_sram_idle() will call these functions and they will dynamically
> + * enable / disable GPIO clocks to allow sleep transitions. */

Please use CodingStyle format for multiple-line comments, e.g.,

/*
 * Dynamic GPIO clock handling ...
 * etc. etc. etc.
 */

This also applies to several other comments later in the file.

> +#define NUM_OF_PERGPIOS 5
> +static struct clk *gpio_fcks[NUM_OF_PERGPIOS];
> +
> +/* Enable GPIO clocks from sleep routines if allowed */
> +static void per_gpio_clk_enable(void)
> +{
> +	int i;
> +
> +	if (gpio_clocks_off_while_idle == 0)
> +		return;
> +	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++)
> +		clk_enable(gpio_fcks[i-1]);

Why not just:

    for (i = 0; i < NUM_OF_PERGPIOS; i++)
             clk_enable(gpio_fcks[i]);

?

> +}
> +
> +/* Disable GPIO clocks from sleep routines if allowed */
> +static void per_gpio_clk_disable(void)
> +{
> +	int i;
> +
> +	if (gpio_clocks_off_while_idle == 0)
> +		return;
> +	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++)
> +		clk_disable(gpio_fcks[i-1]);

same as above comment.

> +}
> +
> +/* XXX This is for gpio fclk hack. Will be removed as gpio driver
> + * handles fcks correctly */
> +static void gpio_fclk_mask(u32 *fclk)
> +{
> +	if (gpio_clocks_off_while_idle == 0)
> +		return;
> +	*fclk &= ~(0x1f << 13);
> +}
> +
>  /* PRCM Interrupt Handler for wakeups */
>  static irqreturn_t prcm_interrupt_handler (int irq, void *dev_id)
>  {
> @@ -169,8 +206,14 @@ static void omap_sram_idle(void)
>  
>  	omap2_gpio_prepare_for_retention();
>  
> +	/* Disable GPIO clocks if allowed */
> +	per_gpio_clk_disable();
> +
>  	_omap_sram_idle(NULL, save_state);
>  
> +	/* Enable GPIO clocks if allowed */
> +	per_gpio_clk_enable();
> +
>  	omap2_gpio_resume_after_retention();
>  }
>  
> @@ -203,6 +246,9 @@ static int omap3_fclks_active(void)
>  				  CM_FCLKEN);
>  	fck_per = cm_read_mod_reg(OMAP3430_PER_MOD,
>  				  CM_FCLKEN);
> +
> +	gpio_fclk_mask(&fck_per);
> +
>  	if (fck_core1 | fck_core3 | fck_sgx | fck_dss |
>  	    fck_cam | fck_per | fck_usbhost)
>  		return 1;
> @@ -544,7 +590,8 @@ static int __init pwrdms_setup(struct powerdomain *pwrdm)
>  int __init omap3_pm_init(void)
>  {
>  	struct power_state *pwrst;
> -	int ret;
> +	char clk_name[11];
> +	int ret, i;
>  
>  	printk(KERN_ERR "Power Management for TI OMAP3.\n");
>  
> @@ -580,6 +627,13 @@ int __init omap3_pm_init(void)
>  
>  	pm_idle = omap3_pm_idle;
>  
> +	/* XXX This is for gpio fclk hack. Will be removed as gpio driver
> +	 * handles fcks correctly */
> +	for (i = 1; i < NUM_OF_PERGPIOS + 1; i++) {
> +		sprintf(clk_name, "gpio%d_fck", i + 1);
> +		gpio_fcks[i-1] = clk_get(NULL, clk_name);

same comment as the for-loops above...

> +	}
> +
>  err1:
>  	return ret;
>  err2:
> -- 
> 1.5.4.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


- Paul
