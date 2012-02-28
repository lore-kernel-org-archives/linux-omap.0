From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 04/14] ARM: OMAP3+: SmartReflex: Add a shutdown hook
Date: Tue, 28 Feb 2012 14:40:38 -0800
Message-ID: <87d38yk2e1.fsf@ti.com>
References: <1328723039-15952-1-git-send-email-j-pihet@ti.com>
	<1328723039-15952-5-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog123.obsmtp.com ([74.125.149.149]:50901 "EHLO
	na3sys009aog123.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965907Ab2B1Wkm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Tue, 28 Feb 2012 17:40:42 -0500
Received: by mail-pz0-f46.google.com with SMTP id d14so3042826dae.5
        for <linux-omap@vger.kernel.org>; Tue, 28 Feb 2012 14:40:41 -0800 (PST)
In-Reply-To: <1328723039-15952-5-git-send-email-j-pihet@ti.com> (Jean Pihet's
	message of "Wed, 8 Feb 2012 18:43:49 +0100")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>, nm@ti.com
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, Jean Pihet <j-pihet@ti.com>

Jean Pihet <jean.pihet@newoldbits.com> writes:

> From: Nishanth Menon <nm@ti.com>
>
> SmartReflex fix for erratum ID i724.
>
> Since OMAP's VP and PRM modules do not get reset by warm reset,
> we should ensure that proper shutdown procedure is followed prior
> to allowing the kernel to reboot back up.

prior to reboot?  how?

This patch only ensures a proper shutdown if the kernel goes down
cleanly.

How is this handled on reboot?

Kevin

> Without this patch, Smartreflex module might be left active or
> system might be caught in an indeterminate sequence when reboot
> is triggered, leaving the next reboot behavior to be unpredictable.
>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/smartreflex.c |   24 ++++++++++++++++++++++++
>  1 files changed, 24 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index ec2b0e7..9c39484 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -1055,8 +1055,32 @@ static int __devexit omap_sr_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +static void __devexit omap_sr_shutdown(struct platform_device *pdev)
> +{
> +	struct omap_sr_data *pdata = pdev->dev.platform_data;
> +	struct omap_sr *sr_info;
> +
> +	if (!pdata) {
> +		dev_err(&pdev->dev, "%s: platform data missing\n", __func__);
> +		return;
> +	}
> +
> +	sr_info = _sr_lookup(pdata->voltdm);
> +	if (IS_ERR(sr_info)) {
> +		dev_warn(&pdev->dev, "%s: omap_sr struct not found\n",
> +			__func__);
> +		return;
> +	}
> +
> +	if (sr_info->autocomp_active)
> +		sr_stop_vddautocomp(sr_info);
> +
> +	return;
> +}
> +
>  static struct platform_driver smartreflex_driver = {
>  	.remove         = omap_sr_remove,
> +	.shutdown	= __devexit_p(omap_sr_shutdown),
>  	.driver		= {
>  		.name	= "smartreflex",
>  	},
