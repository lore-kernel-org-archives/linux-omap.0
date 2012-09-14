From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] ARM: OMAP: SmartReflex: fix error path in init function
Date: Fri, 14 Sep 2012 12:18:31 +0200
Message-ID: <CAORVsuVQeNXPkfk9uUg-yMF-KkoWc=sBfffcs99VT+jT+YeWOg@mail.gmail.com>
References: <1347617694-367-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:64658 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753822Ab2INKSd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Fri, 14 Sep 2012 06:18:33 -0400
Received: by lagy9 with SMTP id y9so2603641lag.19
        for <linux-omap@vger.kernel.org>; Fri, 14 Sep 2012 03:18:31 -0700 (PDT)
In-Reply-To: <1347617694-367-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: J Keerthy <j-keerthy@ti.com>, Jean Pihet <j-pihet@ti.com>

Hi!

On Fri, Sep 14, 2012 at 12:14 PM,  <jean.pihet@newoldbits.com> wrote:
> From: Jean Pihet <j-pihet@ti.com>
>
> Fix the error handling path in omap_sr_probe to correctly
> de-allocate resources in case of problems.

Please note that this patch applies on top of 'ARM: OMAP: SmartReflex:
pass device dependent data via platform data' [1].

[1] http://marc.info/?l=linux-omap&m=134761557609931&w=2

Regards,
Jean

>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  drivers/power/avs/smartreflex.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/power/avs/smartreflex.c b/drivers/power/avs/smartreflex.c
> index 734493d..a802f4c 100644
> --- a/drivers/power/avs/smartreflex.c
> +++ b/drivers/power/avs/smartreflex.c
> @@ -911,7 +911,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>         if (!sr_info->base) {
>                 dev_err(&pdev->dev, "%s: ioremap fail\n", __func__);
>                 ret = -ENOMEM;
> -               goto err_release_region;
> +               goto err_free_name;
>         }
>
>         if (irq)
> @@ -949,7 +949,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>                 dev_err(&pdev->dev, "%s: Unable to create debugfs directory\n",
>                         __func__);
>                 ret = PTR_ERR(sr_info->dbg_dir);
> -               goto err_free_name;
> +               goto err_debugfs;
>         }
>
>         (void) debugfs_create_file("autocomp", S_IRUGO | S_IWUSR,
> @@ -993,11 +993,11 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>
>  err_debugfs:
>         debugfs_remove_recursive(sr_info->dbg_dir);
> -err_free_name:
> -       kfree(sr_info->name);
>  err_iounmap:
>         list_del(&sr_info->node);
>         iounmap(sr_info->base);
> +err_free_name:
> +       kfree(sr_info->name);
>  err_release_region:
>         release_mem_region(mem->start, resource_size(mem));
>  err_free_devinfo:
> --
> 1.7.7.6
>
