From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 2/3] ARM: OMAP4: Fix build error and warning in timer.c
Date: Wed, 28 Nov 2012 11:17:21 +0530
Message-ID: <50B5A569.4000908@ti.com>
References: <1354068915-3378-1-git-send-email-jon-hunter@ti.com> <1354068915-3378-3-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50831 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751317Ab2K1FrL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Nov 2012 00:47:11 -0500
In-Reply-To: <1354068915-3378-3-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, linux-omap <linux-omap@vger.kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, Igor Grinberg <grinberg@compulab.co.il>

On Wednesday 28 November 2012 07:45 AM, Jon Hunter wrote:
> When compiling the kernel with configuration option CONFIG_ARCH_OMAP4
> enabled and CONFIG_LOCAL_TIMERS disabled, the following build error a=
nd
> warning is seen.
>
>    CC      arch/arm/mach-omap2/timer.o
>    arch/arm/mach-omap2/timer.c: In function =E2=80=98omap4_local_time=
r_init=E2=80=99:
>    arch/arm/mach-omap2/timer.c:630:2: error: implicit declaration of
>    	function =E2=80=98omap4_sync32_timer_init=E2=80=99
> 	[-Werror=3Dimplicit-function-declaration]
>    arch/arm/mach-omap2/timer.c: At top level:
>    arch/arm/mach-omap2/timer.c:607:1: warning: =E2=80=98omap4_sync32k=
_timer_init=E2=80=99
>    	defined but not used [-Wunused-function]
>    cc1: some warnings being treated as errors
>    make[1]: *** [arch/arm/mach-omap2/timer.o] Error 1
>
> This issue was introduced by commit 6f80b3b (ARM: OMAP2+: timer: remo=
ve
> CONFIG_OMAP_32K_TIMER) where the "k" is missing from the "sync32k" in
> the function name "omap4_sync32_timer_init". Therefore, correct this
> typo to resolve the above error and warning.
>
> Cc: Igor Grinberg <grinberg@compulab.co.il>
>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
