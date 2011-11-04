From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH v8 16/24] gpio/omap: use pm-runtime framework
Date: Fri, 04 Nov 2011 10:13:29 -0700
Message-ID: <87lirvbykm.fsf@ti.com>
References: <1317803593-12259-1-git-send-email-tarun.kanti@ti.com>
	<1317803593-12259-17-git-send-email-tarun.kanti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:47734 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751219Ab1KDRNj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Nov 2011 13:13:39 -0400
Received: by mail-qw0-f41.google.com with SMTP id c11so2889675qad.0
        for <linux-omap@vger.kernel.org>; Fri, 04 Nov 2011 10:13:38 -0700 (PDT)
In-Reply-To: <1317803593-12259-17-git-send-email-tarun.kanti@ti.com> (Tarun
	Kanti DebBarma's message of "Wed, 5 Oct 2011 14:03:05 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tarun Kanti DebBarma <tarun.kanti@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Charulatha V <charu@ti.com>

Tarun Kanti DebBarma <tarun.kanti@ti.com> writes:

> Call runtime pm APIs pm_runtime_get_sync() and pm_runtime_put_sync()
> for enabling/disabling clocks appropriately. Remove syscore_ops and
> instead use SET_RUNTIME_PM_OPS macro.
>
> Signed-off-by: Charulatha V <charu@ti.com>
> Signed-off-by: Tarun Kanti DebBarma <tarun.kanti@ti.com>
> Reviewed-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> ---
>  arch/arm/mach-omap2/gpio.c |    2 -
>  drivers/gpio/gpio-omap.c   |   67 +++++++++++++++++++++++++++++---------------
>  2 files changed, 44 insertions(+), 25 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/gpio.c b/arch/arm/mach-omap2/gpio.c
> index 5ae1cf3..a992802 100644
> --- a/arch/arm/mach-omap2/gpio.c
> +++ b/arch/arm/mach-omap2/gpio.c
> @@ -146,8 +146,6 @@ static int omap2_gpio_dev_init(struct omap_hwmod *oh, void *unused)
>  		return PTR_ERR(od);
>  	}
>  
> -	omap_device_disable_idle_on_suspend(od);
> -

No description in the changelog about this change.  (Yes, I understand
why it's removed, but it needs to be described in the changelog so when
I forget, I'll have a way to remember.)

Kevin
