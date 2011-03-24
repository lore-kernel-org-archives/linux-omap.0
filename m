From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/6] arm: mach-omap2: smartreflex: fix sr_late_init() error path in probe
Date: Thu, 24 Mar 2011 10:18:49 -0700
Message-ID: <87fwqczbba.fsf@ti.com>
References: <1300984535-10530-1-git-send-email-aaro.koskinen@nokia.com>
	<1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:40540 "EHLO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751564Ab1CXRSw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 24 Mar 2011 13:18:52 -0400
Received: by pwi14 with SMTP id 14so49528pwi.21
        for <linux-omap@vger.kernel.org>; Thu, 24 Mar 2011 10:18:51 -0700 (PDT)
In-Reply-To: <1300984535-10530-2-git-send-email-aaro.koskinen@nokia.com> (Aaro
	Koskinen's message of "Thu, 24 Mar 2011 18:35:31 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Aaro Koskinen <aaro.koskinen@nokia.com> writes:

> sr_late_init() will take care of freeing the resources.
>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>

Thanks,

As I've already got some other SR related stuff queued up for 2.6.39,
I'll queue patches 2-6 for the 2.6.39-rc fixes cycle.

Tony can take patch 1 as he see's fit.

Also, I renamed the subject/shortlog to use 'OMAP2+: smartreflex: ..."
instead of 'arm: mach-omap2'.

Kevin

> ---
>  arch/arm/mach-omap2/smartreflex.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/smartreflex.c
> index 8f674c9..6dfc8db 100644
> --- a/arch/arm/mach-omap2/smartreflex.c
> +++ b/arch/arm/mach-omap2/smartreflex.c
> @@ -883,7 +883,7 @@ static int __init omap_sr_probe(struct platform_device *pdev)
>  		ret = sr_late_init(sr_info);
>  		if (ret) {
>  			pr_warning("%s: Error in SR late init\n", __func__);
> -			goto err_release_region;
> +			return ret;
>  		}
>  	}
