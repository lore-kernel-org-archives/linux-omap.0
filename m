From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] PM: Fix compile warnings with !CONFIG_OMAP_PM_SRF
Date: Thu, 12 Mar 2009 15:00:14 -0700
Message-ID: <87hc1y4d1t.fsf@deeprootsystems.com>
References: <1236891507-5687-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ag-out-0708.google.com ([72.14.246.241]:1839 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbZCLWAU (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 12 Mar 2009 18:00:20 -0400
Received: by ag-out-0708.google.com with SMTP id 26so1240241agb.10
        for <linux-omap@vger.kernel.org>; Thu, 12 Mar 2009 15:00:18 -0700 (PDT)
In-Reply-To: <1236891507-5687-1-git-send-email-premi@ti.com> (Sanjeev Premi's message of "Fri\, 13 Mar 2009 02\:28\:27 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> Fixes the compile warnings:
>
>   CC      arch/arm/mach-omap2/pm.o
> arch/arm/mach-omap2/pm.c:47: warning: 'vdd1_locked' defined but not used
> arch/arm/mach-omap2/pm.c:48: warning: 'vdd2_locked' defined but not used
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Thanks, pushing to PM, with a slight change.  I moved the definitions
down into another #ifdef CONFIG_OMAP_PM_SRF instead of adding a new
one.

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index 61c6dfb..0fe6f1a 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -44,8 +44,10 @@ unsigned short clocks_off_while_idle;
>  unsigned short enable_off_mode;
>  unsigned short voltage_off_while_idle;
>  atomic_t sleep_block = ATOMIC_INIT(0);
> +#ifdef CONFIG_OMAP_PM_SRF
>  static int vdd1_locked;
>  static int vdd2_locked;
> +#endif
>  
>  static ssize_t idle_show(struct kobject *, struct kobj_attribute *, char *);
>  static ssize_t idle_store(struct kobject *k, struct kobj_attribute *,
> -- 
> 1.5.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
