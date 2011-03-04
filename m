From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH] omap3: Initialize iva only if available
Date: Fri, 04 Mar 2011 07:35:28 -0800
Message-ID: <87d3m6lwzj.fsf@ti.com>
References: <1298640440-4527-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:57797 "EHLO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759144Ab1CDPfc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 4 Mar 2011 10:35:32 -0500
Received: by mail-gy0-f171.google.com with SMTP id 12so1085144gyd.16
        for <linux-omap@vger.kernel.org>; Fri, 04 Mar 2011 07:35:31 -0800 (PST)
In-Reply-To: <1298640440-4527-1-git-send-email-premi@ti.com> (Sanjeev Premi's
	message of "Fri, 25 Feb 2011 18:57:20 +0530")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org

Sanjeev Premi <premi@ti.com> writes:

> IVA device is not present in many OMAP3 variants.
>
> This patch ensures that initialization is tied to
> the presence of IVA on the device.
>
> Signed-off-by: Sanjeev Premi <premi@ti.com>

Thanks, queuing for 2.6.39 (branch: for_2.6.39/pm-misc)

Kevin

> ---
>  arch/arm/mach-omap2/pm.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm.c b/arch/arm/mach-omap2/pm.c
> index d5a102c..6e4eb7f 100644
> --- a/arch/arm/mach-omap2/pm.c
> +++ b/arch/arm/mach-omap2/pm.c
> @@ -83,7 +83,9 @@ static int _init_omap_device(char *name, struct device **new_dev)
>  static void omap2_init_processor_devices(void)
>  {
>  	_init_omap_device("mpu", &mpu_dev);
> -	_init_omap_device("iva", &iva_dev);
> +	if (omap3_has_iva())
> +		_init_omap_device("iva", &iva_dev);
> +
>  	if (cpu_is_omap44xx()) {
>  		_init_omap_device("l3_main_1", &l3_dev);
>  		_init_omap_device("dsp", &dsp_dev);
