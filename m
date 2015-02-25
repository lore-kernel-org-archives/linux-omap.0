From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] ARM: omap-device: add missed callback for suspend-to-disk
Date: Wed, 25 Feb 2015 11:12:06 -0800
Message-ID: <7hr3tdkdq1.fsf@deeprootsystems.com>
References: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:36904 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852AbbBYTMK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 14:12:10 -0500
Received: by pdbfl12 with SMTP id fl12so6969302pdb.4
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 11:12:09 -0800 (PST)
In-Reply-To: <1424873630-6054-1-git-send-email-grygorii.strashko@linaro.org>
	(grygorii strashko's message of "Wed, 25 Feb 2015 16:13:50 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: grygorii.strashko@linaro.org
Cc: Tony Lindgren <tony@atomide.com>, nm@ti.com, sumit.semwal@linaro.org, linux-omap@vger.kernel.org, kishon@ti.com, linux-arm-kernel@lists.infradead.org

<grygorii.strashko@linaro.org> writes:

> From: Grygorii Strashko <Grygorii.Strashko@linaro.org>
>
> Add missed callback needed for supporting suspend-to-disk (hibernation) mode.
>
> Signed-off-by: Grygorii Strashko <Grygorii.Strashko@linaro.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  arch/arm/mach-omap2/omap_device.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/omap_device.c b/arch/arm/mach-omap2/omap_device.c
> index fcd2c9e..345e18e 100644
> --- a/arch/arm/mach-omap2/omap_device.c
> +++ b/arch/arm/mach-omap2/omap_device.c
> @@ -739,6 +739,9 @@ struct dev_pm_domain omap_device_pm_domain = {
>  		USE_PLATFORM_PM_SLEEP_OPS
>  		.suspend_noirq = _od_suspend_noirq,
>  		.resume_noirq = _od_resume_noirq,
> +		.freeze_noirq = _od_suspend_noirq,
> +		.thaw_noirq = _od_resume_noirq,
> +		.restore_noirq = _od_resume_noirq,
>  	}
>  };
