From: Santosh <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 25/25] OMAP3: CPUidle: Make use of CPU PM notifiers
Date: Fri, 09 Sep 2011 12:47:42 +0530
Message-ID: <4E69BD96.9080002@ti.com>
References: <1315144466-9395-1-git-send-email-santosh.shilimkar@ti.com>	<1315144466-9395-26-git-send-email-santosh.shilimkar@ti.com> <87vct2hq79.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:50741 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756565Ab1IIHRs (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 9 Sep 2011 03:17:48 -0400
Received: by mail-gx0-f171.google.com with SMTP id 22so1008397gxk.2
        for <linux-omap@vger.kernel.org>; Fri, 09 Sep 2011 00:17:47 -0700 (PDT)
In-Reply-To: <87vct2hq79.fsf@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, rnayak@ti.com

On Thursday 08 September 2011 11:27 PM, Kevin Hilman wrote:
>  From 8ad40f8c7f950105b25cc8d2cc35caa50871f86f Mon Sep 17 00:00:00 2001
> From: Kevin Hilman<khilman@ti.com>
> Date: Wed, 7 Sep 2011 12:04:44 -0700
> Subject: [PATCH 1/2] OMAP2/3: PM: trigger CPU PM notifiers in idle and
>   suspend path
>
> Add calls to CPU PM notifier core in the idle and suspend paths
> so any CPU PM notifiers are properly called.
>
> [add more description about the need to trigger notifiers only after
>   next power states are programmed.]
>
> Signed-off-by: Kevin Hilman<khilman@ti.com>
> ---
>   arch/arm/mach-omap2/pm24xx.c |    5 +++++
>   arch/arm/mach-omap2/pm34xx.c |    5 +++++
>   2 files changed, 10 insertions(+), 0 deletions(-)
>

[...]

> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 7255d9b..b167c7f 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -29,6 +29,7 @@
>   #include<linux/delay.h>
>   #include<linux/slab.h>
>   #include<linux/console.h>
> +#include<linux/cpu_pm.h>
>   #include<trace/events/power.h>
>
>   #include<asm/suspend.h>
> @@ -386,6 +387,8 @@ void omap_sram_idle(void)
>   			if (!console_trylock())
>   				goto console_still_active;
>
> +	cpu_pm_enter();
> +
I don't think you should blindly call CPU_PM notifiers.
This should called if the MPU targeted state is OFF.
With blind notifiers, CPU context like VFP or GIC or L2
will be saved and restored even if CPU/CPU cluster is
not entering into low power. This is highly un-optimal for
CPUIDLE and defeats the purpose of adding different
CPU PM events.

Looking at your UART driver notfier usage, you might need
add new events instead of using the CPU and CPU cluster
events.

Even though on OMAP UART is idles as part of CPU, it's still
an independent PD.

E.g just to make a point,
MPU is programmed to INACTIVE and let say PER PD is programmed
to OFF.
 From MPU point of view the CPU_PM notifier change need not be called 
because, it's doesn't loose any context, but UART notifier needs to
be executed since UART context must be saved.

Regards
Santosh



