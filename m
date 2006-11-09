From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP: Fix warning in mach-omap1
Date: Fri, 10 Nov 2006 01:24:19 +0200
Message-ID: <20061109232419.GJ16172@atomide.com>
References: <454CB67B.70706@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-Disposition: inline
In-Reply-To: <454CB67B.70706@gmail.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Dirk Behme <dirk.behme@googlemail.com>
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

* Dirk Behme <dirk.behme@googlemail.com> [061104 17:56]:
> Fix warning
> 
> arch/arm/mach-omap1/pm.c: In function 'omap_pm_init':
> arch/arm/mach-omap1/pm.c:765: warning: ignoring return value
> of 'subsys_create_file', declared with attribute
> warn_unused_result
> 
> Signed-off-by: Dirk Behme <dirk.behme_at_gmail.com>
> 

> Index: linux-osk/arch/arm/mach-omap1/pm.c
> ===================================================================
> --- linux-osk.orig/arch/arm/mach-omap1/pm.c
> +++ linux-osk/arch/arm/mach-omap1/pm.c
> @@ -706,6 +706,8 @@ static struct pm_ops omap_pm_ops ={
>  
>  static int __init omap_pm_init(void)
>  {
> +	int error;
> +
>  	printk("Power Management for TI OMAP.\n");
>  
>  	/*
> @@ -762,7 +764,9 @@ static int __init omap_pm_init(void)
>  	omap_pm_init_proc();
>  #endif
>  
> -	subsys_create_file(&power_subsys, &sleep_while_idle_attr);
> +	error = subsys_create_file(&power_subsys, &sleep_while_idle_attr);
> +	if(error)
> +		printk(KERN_ERR "subsys_create_file failed: %d\n", error);
>  
>  	if (cpu_is_omap16xx()) {
>  		/* configure LOW_PWR pin */
> 

Pushing today.

Tony
