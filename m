From: Jon Hunter <jon-hunter@ti.com>
Subject: Re: [PATCH V2 09/11] ARM: OMAP: Remove timer function pointer for
 context loss counter
Date: Mon, 4 Jun 2012 13:49:33 -0500
Message-ID: <4FCD033D.4030708@ti.com>
References: <1338830555-20469-1-git-send-email-jon-hunter@ti.com> <1338830555-20469-10-git-send-email-jon-hunter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:57273 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503Ab2FDStg (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 4 Jun 2012 14:49:36 -0400
In-Reply-To: <1338830555-20469-10-git-send-email-jon-hunter@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Tarun Kanti DebBarma <tarun.kanti@ti.com>


On 06/04/2012 12:22 PM, Jon Hunter wrote:
> For OMAP2+ devices, a function pointer that returns the number of times a timer
> power domain has lost context is passed to the dmtimer driver. This function
> pointer is only populated for OMAP2+ devices and it is pointing to a platform
> function. Given that this is a platform function, we can simplify the code by
> removing the function pointer and referencing the function directly. We can use
> the OMAP_TIMER_ALWON flag to determine if we need to call this function for
> OMAP1 and OMAP2+ devices.
> 
> The benefit of this change is the we can remove the function pointer from the
> platform data and simplifies the dmtimer migration to device-tree.
> 
> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
> ---
>  arch/arm/mach-omap1/timer.c               |    4 ++--
>  arch/arm/mach-omap2/timer.c               |    3 ---
>  arch/arm/plat-omap/dmtimer.c              |   26 ++++++++++----------------
>  arch/arm/plat-omap/include/plat/dmtimer.h |    4 +---
>  4 files changed, 13 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/arm/mach-omap1/timer.c b/arch/arm/mach-omap1/timer.c
> index b4bf48c..aa81593 100644
> --- a/arch/arm/mach-omap1/timer.c
> +++ b/arch/arm/mach-omap1/timer.c
> @@ -140,8 +140,8 @@ static int __init omap1_dm_timer_init(void)
>  		}
>  
>  		pdata->set_timer_src = omap1_dm_timer_set_src;
> -		pdata->needs_manual_reset = 1;
> -		pdata->timer_capability = OMAP_TIMER_ALWON;
> +		pdata->timer_capability = OMAP_TIMER_ALWON |
> +				OMAP_TIMER_NEEDS_RESET;

Some how I have managed to squash 2 patches together here when rebasing
to 3.5-rc1, ugh! I will re-send this series. Sorry for the noise.

Jon
