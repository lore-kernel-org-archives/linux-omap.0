From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap2plus: smartreflex: remove sr debug directory in omap_sr_remove()
Date: Fri, 11 Feb 2011 15:50:46 -0800
Message-ID: <87wrl65dwp.fsf@ti.com>
References: <1296912744-4768-1-git-send-email-sawant@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57044 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756887Ab1BKXut (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 11 Feb 2011 18:50:49 -0500
Received: by mail-iy0-f169.google.com with SMTP id 20so3193820iyi.0
        for <linux-omap@vger.kernel.org>; Fri, 11 Feb 2011 15:50:48 -0800 (PST)
In-Reply-To: <1296912744-4768-1-git-send-email-sawant@ti.com> (Anand
	S. Sawant's message of "Sat, 5 Feb 2011 19:02:24 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Anand S Sawant <sawant@ti.com>
Cc: linux-omap@vger.kernel.org

Hi Anand,

Anand S Sawant <sawant@ti.com> writes:

> omap_sr_probe() creates the smartreflex debug directory and its
> underlying nvalue debug directory. These directories are removed in
> omap_sr_remove().
>
> Basic smartreflex functionality tested on OMAP3630 Zoom3 & OMAP4430 SDP
>
> Signed-off-by: Anand S Sawant <sawant@ti.com>

Looks good.

Please repost with the linux-arm-kernel list in CC:
linux-arm-kernel@lists.infradead.org.  Thend, unless there are other
comments/objections, I'll queue this for 2.6.39.

Also, can summarize on which platforms this was tested.  Just curious:
Were you able to build SR as a module to test this?

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++----------
>  1 files changed, 14 insertions(+), 10 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index d7deadf..57df5cf 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -54,6 +54,7 @@ struct omap_sr {
>  	struct list_head		node;
>  	struct omap_sr_nvalue_table	*nvalue_table;
>  	struct voltagedomain		*voltdm;
> +	struct dentry			*dbg_dir;
>  };
>  
>  /* sr_list contains all the instances of smartreflex module */
> @@ -822,7 +823,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	struct omap_sr *sr_info = kzalloc(sizeof(struct omap_sr), GFP_KERNEL);
>  	struct omap_sr_data *pdata = pdev->dev.platform_data;
>  	struct resource *mem, *irq;
> -	struct dentry *vdd_dbg_dir, *dbg_dir, *nvalue_dir;
> +	struct dentry *vdd_dbg_dir, *nvalue_dir;
>  	struct omap_volt_data *volt_data;
>  	int i, ret = 0;
>  
> @@ -894,23 +895,24 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  	if (!vdd_dbg_dir)
>  		return -EINVAL;
>  
> -	dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
> -	if (IS_ERR(dbg_dir)) {
> +	sr_info->dbg_dir = debugfs_create_dir("smartreflex", vdd_dbg_dir);
> +	if (IS_ERR(sr_info->dbg_dir)) {
>  		dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
>  			__func__);
> -		return PTR_ERR(dbg_dir);
> +		return PTR_ERR(sr_info->dbg_dir);
>  	}
>  
> -	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUGO, dbg_dir,
> -				(void *)sr_info, &pm_sr_fops);
> -	(void) debugfs_create_x32("errweight", S_IRUGO, dbg_dir,
> +	/* Using S_IWUSR to fix checkpatch warning */
> +	(void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
> +			sr_info->dbg_dir, (void *)sr_info, &pm_sr_fops);
> +	(void) debugfs_create_x32("errweight", S_IRUGO, sr_info->dbg_dir,
>  			&sr_info->err_weight);
> -	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, dbg_dir,
> +	(void) debugfs_create_x32("errmaxlimit", S_IRUGO, sr_info->dbg_dir,
>  			&sr_info->err_maxlimit);
> -	(void) debugfs_create_x32("errminlimit", S_IRUGO, dbg_dir,
> +	(void) debugfs_create_x32("errminlimit", S_IRUGO, sr_info->dbg_dir,
>  			&sr_info->err_minlimit);
>  
> -	nvalue_dir = debugfs_create_dir("nvalue", dbg_dir);
> +	nvalue_dir = debugfs_create_dir("nvalue", sr_info->dbg_dir);
>  	if (IS_ERR(nvalue_dir)) {
>  		dev_err(&pdev->dev, "%s: Unable to create debugfs directory"
>  			"for n-values\n", __func__);
> @@ -974,6 +976,8 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  
>  	if (sr_info->autocomp_active)
>  		sr_stop_vddautocomp(sr_info);
> +	if (sr_info->dbg_dir)
> +		debugfs_remove_recursive(sr_info->dbg_dir);
>  
>  	list_del(&sr_info->node);
>  	iounmap(sr_info->base);
