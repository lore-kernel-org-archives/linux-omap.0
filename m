From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 3/3] ARM: AM335x: Fix warning in timer.c
Date: Wed, 28 Nov 2012 11:58:57 +0530
Message-ID: <50B5AF29.4020306@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42463 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751031Ab2K1G2r (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 28 Nov 2012 01:28:47 -0500
In-Reply-To: <1354068915-3378-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Igor Grinberg <grinberg@compulab.co.il>

On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
> When compiling the kernel with configuration options ...
>
>   # CONFIG_ARCH_OMAP2 is not set
>   # CONFIG_ARCH_OMAP3 is not set
>   # CONFIG_ARCH_OMAP4 is not set
>   # CONFIG_SOC_OMAP5 is not set
>   CONFIG_SOC_AM33XX=3Dy
>
>   ... the following build warning is seen.
>
>    CC      arch/arm/mach-omap2/timer.o
>    arch/arm/mach-omap2/timer.c:395:19: warning: =E2=80=98omap2_sync32=
k_clocksource_init=E2=80=99
>    	defined but not used [-Wunused-function]
>
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remo=
ve
> CONFIG_OMAP_32K_TIMER) where the omap2_sync32k_clocksource_init() is =
no
> longer referenced by the timer initialisation function for the AM335x
> device as it has no 32k-sync timer.
>
> Fix this by only including the omap2_sync32k_clocksource_init() funct=
ion
> if either OMAP2, OMAP3, OMAP4 or OMAP5 devices are enabled.
>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>   arch/arm/mach-omap2/timer.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.=
c
> index eb96712..085c7e7 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -386,6 +386,8 @@ static u32 notrace dmtimer_read_sched_clock(void)
>   	return 0;
>   }
>
> +#if defined(CONFIG_ARCH_OMAP2) || defined(CONFIG_ARCH_OMAP3) || \
> +	defined(CONFIG_ARCH_OMAP4) || defined(CONFIG_SOC_OMAP5)
#ifndef CONFIG_SOC_AM33XX ?

#ifdef things are really ugly and needs constant patching and
hence something like CONFIG_HAS_32K kind of feature flags are
better. But that will undo certain part of f80b3b
(ARM: OMAP2+: timer: remove  CONFIG_OMAP_32K_TIMER).

Regards
santosh




--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
