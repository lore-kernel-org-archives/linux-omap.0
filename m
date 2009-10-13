From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH] OMAP3 PM Add sysfs entry for EFuse values
Date: Tue, 13 Oct 2009 11:44:17 -0700
Message-ID: <87ws2zkubi.fsf@deeprootsystems.com>
References: <1255358890-9434-1-git-send-email-peter.de-schrijver@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f188.google.com ([209.85.222.188]:55339 "EHLO
	mail-pz0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754173AbZJMSo5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Oct 2009 14:44:57 -0400
Received: by pzk26 with SMTP id 26so9240912pzk.4
        for <linux-omap@vger.kernel.org>; Tue, 13 Oct 2009 11:44:20 -0700 (PDT)
In-Reply-To: <1255358890-9434-1-git-send-email-peter.de-schrijver@nokia.com> (Peter De Schrijver's message of "Mon\, 12 Oct 2009 17\:48\:10 +0300")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>, Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org

"Peter 'p2' De Schrijver" <peter.de-schrijver@nokia.com> writes:

> This patch exports the smartreflex efuse values for all 5 OPPs via
> sysfs. This can be useful to track down silicon specific problems.
>
> Signed-off-by: Peter 'p2' De Schrijver <peter.de-schrijver@nokia.com>

These should be exported via debugfs instead of sysfs.

Also, the SR rewrite is underway and will be merged shortly, so I
recommend waiting until that is in place before we add this.  Unless
Nishanth wants to add it sooner.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 9fa033d..3c506d1 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -759,7 +759,24 @@ static struct kobj_attribute sr_vdd2_autocomp = {
>  	.store = omap_sr_vdd2_autocomp_store,
>  };
>  
> +static ssize_t omap_sr_opp1_efuse_show(struct kobject *kobj,
> +					struct kobj_attribute *attr,
> +					char *buf)
> +{
> +	return sprintf(buf, "%08x\n%08x\n%08x\n%08x\n%08x\n", sr1.opp1_nvalue,
> +							sr1.opp2_nvalue,
> +							sr1.opp3_nvalue,
> +							sr1.opp4_nvalue,
> +							sr1.opp5_nvalue);
> +}
>  
> +static struct kobj_attribute sr_efuse = {
> +	.attr = {
> +	.name = "Efuse",
> +	.mode = 0444,
> +	},
> +	.show = omap_sr_opp1_efuse_show,
> +};
>  
>  static int __init omap3_sr_init(void)
>  {
> @@ -807,6 +824,11 @@ static int __init omap3_sr_init(void)
>  	if (ret)
>  		printk(KERN_ERR "sysfs_create_file failed: %d\n", ret);
>  
> +	ret = sysfs_create_file(power_kobj, &sr_efuse.attr);
> +	if (ret)
> +		printk(KERN_ERR "sysfs_create_file failed for OPP data: %d\n",
> +			ret);
> +
>  	return 0;
>  }
>  
> -- 
> 1.6.2.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
