From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/1] OMAP: omap_device: only override _noirq methods, not normal suspend/resume
Date: Thu, 1 Sep 2011 18:00:55 +0200
Message-ID: <201109011800.55516.arnd@arndb.de>
References: <1314229437-31836-1-git-send-email-khilman@ti.com> <1314229437-31836-2-git-send-email-khilman@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:62342 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932566Ab1IAQBB (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Sep 2011 12:01:01 -0400
In-Reply-To: <1314229437-31836-2-git-send-email-khilman@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Hilman <khilman@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org

On Thursday 25 August 2011, Kevin Hilman wrote:
> --- a/arch/arm/plat-omap/omap_device.c
> +++ b/arch/arm/plat-omap/omap_device.c
> @@ -622,7 +622,8 @@ static struct dev_pm_domain omap_device_pm_domain = {
>                 SET_RUNTIME_PM_OPS(_od_runtime_suspend, _od_runtime_resume,
>                                    _od_runtime_idle)
>                 USE_PLATFORM_PM_SLEEP_OPS
> -               SET_SYSTEM_SLEEP_PM_OPS(_od_suspend_noirq, _od_resume_noirq)
> +               .suspend_noirq = _od_suspend_noirq,
> +               .resume_noirq = _od_resume_noirq,
>         }
>  };

This breaks if CONFIG_SUSPEND is not set and the _od_suspend_noirq/_od_resume_noirq
functions are not defined.

	Arnd
