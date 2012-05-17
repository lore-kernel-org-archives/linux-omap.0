From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 2/9] ARM: OMAP2+: Remove unused max number of timers definition
Date: Thu, 17 May 2012 13:07:14 -0700
Message-ID: <87obpmwozx.fsf@ti.com>
References: <1337124927-19992-1-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog134.obsmtp.com ([74.125.149.83]:36179 "EHLO
	na3sys009aog134.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932347Ab2EQUHQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 17 May 2012 16:07:16 -0400
Received: by dano14 with SMTP id o14so3839671dan.39
        for <linux-omap@vger.kernel.org>; Thu, 17 May 2012 13:07:14 -0700 (PDT)
In-Reply-To: <1337124927-19992-1-git-send-email-jon-hunter@ti.com> (Jon
	Hunter's message of "Tue, 15 May 2012 18:35:27 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <b-cousson@ti.com>

Jon Hunter <jon-hunter@ti.com> writes:

> From: Jon Hunter <jon-hunter@ti.com>
>
> The OMAP2+ timer code has a definition for the maximum number of timers that
> OMAP2+ devices have. This defintion is not used anywhere in the code and
> appears to be left over. Furthermore the definition is not accurate for OMAP4
> devices that only have 11 timers available because the 12th timer is reserved
> as a secure timer. Therefore, remove this definition.

changelog nit: the 12th timer is secure on OMAP3 HS devices also.

Kevin

> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap2/timer.c |    3 ---
>  1 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
> index 840929b..c030dfe 100644
> --- a/arch/arm/mach-omap2/timer.c
> +++ b/arch/arm/mach-omap2/timer.c
> @@ -69,9 +69,6 @@
>  #define OMAP3_SECURE_TIMER	1
>  #endif
>  
> -/* MAX_GPTIMER_ID: number of GPTIMERs on the chip */
> -#define MAX_GPTIMER_ID		12
> -
>  static u32 sys_timer_reserved;
>  
>  /* Clockevent code */
