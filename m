From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH V2 3/4] ARM: AM335x: Fix warning in timer.c
Date: Thu, 29 Nov 2012 10:45:58 +0530
Message-ID: <50B6EF8E.70803@ti.com>
References: <1354140300-16825-1-git-send-email-jon-hunter@ti.com> <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:38218 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750922Ab2K2FPt (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 29 Nov 2012 00:15:49 -0500
In-Reply-To: <1354140300-16825-4-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Igor Grinberg <grinberg@compulab.co.il>

On Thursday 29 November 2012 03:34 AM, Jon Hunter wrote:
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
> Fix this by adding the "__maybe_unused" compiler directive to the
> omap2_sync32k_clocksource_init() function to indicate that this funct=
ion
> may be used for certain configurations.
>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
