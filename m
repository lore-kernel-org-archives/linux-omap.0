From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PATCH 11/17][V2] ARM: OMAP3: cpuidle - remove cpuidle_params_table
Date: Mon, 09 Apr 2012 16:12:00 -0700
Message-ID: <878vi48pq7.fsf@ti.com>
References: <1333570371-1389-1-git-send-email-daniel.lezcano@linaro.org>
	<1333570371-1389-12-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:53134 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753060Ab2DIXLz (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Apr 2012 19:11:55 -0400
Received: by dadn15 with SMTP id n15so6775811dad.2
        for <linux-omap@vger.kernel.org>; Mon, 09 Apr 2012 16:11:54 -0700 (PDT)
In-Reply-To: <1333570371-1389-12-git-send-email-daniel.lezcano@linaro.org>
	(Daniel Lezcano's message of "Wed, 4 Apr 2012 22:12:45 +0200")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: santosh.shilimkar@ti.com, jean.pihet@newoldbits.com, tony@atomide.com, linux-omap@vger.kernel.org, linaro-dev@lists.linaro.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org

Daniel Lezcano <daniel.lezcano@linaro.org> writes:

> We do not longer need the ''cpuidle_params_table' array as
> we defined the states in the driver and we checked they are
> all valid.
>
> We also remove the structure definition as it is no longer used.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Jean Pihet <j-pihet@ti.com>
> ---
>  arch/arm/mach-omap2/cpuidle34xx.c |   28 +++-------------------------
>  arch/arm/mach-omap2/pm.h          |   12 ------------
>  2 files changed, 3 insertions(+), 37 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpuidle34xx.c
> index 3f46e45..cdf1b8f 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> @@ -38,36 +38,14 @@
>  
>  #ifdef CONFIG_CPU_IDLE
>  
> -/*
> - * The latencies/thresholds for various C states have
> - * to be configured from the respective board files.
> - * These are some default values (which might not provide
> - * the best power savings) used on boards which do not
> - * pass these details from the board file.
> - */
> -static struct cpuidle_params cpuidle_params_table[] = {
> -	/* C1 */
> -	{2 + 2, 5, 1},
> -	/* C2 */
> -	{10 + 10, 30, 1},
> -	/* C3 */
> -	{50 + 50, 300, 1},
> -	/* C4 */
> -	{1500 + 1800, 4000, 1},
> -	/* C5 */
> -	{2500 + 7500, 12000, 1},
> -	/* C6 */
> -	{3000 + 8500, 15000, 1},
> -	/* C7 */
> -	{10000 + 30000, 300000, 1},
> -};
> -#define OMAP3_NUM_STATES ARRAY_SIZE(cpuidle_params_table)
> -
>  /* Mach specific information to be recorded in the C-state driver_data */
>  struct omap3_idle_statedata {
>  	u32 mpu_state;
>  	u32 core_state;
>  };
> +
> +#define OMAP3_NUM_STATES 7
> +

Similar comment as for OMAP4.  You should be able to git rid of this all
together now.

Kevin
