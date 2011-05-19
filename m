From: Kevin Hilman <khilman@ti.com>
Subject: Re: [PM-WIP_CPUFREQ][PATCH 1/6 v2] OMAP2+: cpufreq: free up table on exit
Date: Thu, 19 May 2011 12:26:51 +0200
Message-ID: <87liy39eac.fsf@ti.com>
References: <1305704266-17623-2-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog107.obsmtp.com ([74.125.149.197]:52705 "EHLO
	na3sys009aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752177Ab1ESKrp (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 May 2011 06:47:45 -0400
Received: by wwi18 with SMTP id 18so5494187wwi.4
        for <linux-omap@vger.kernel.org>; Thu, 19 May 2011 03:47:42 -0700 (PDT)
In-Reply-To: <1305704266-17623-2-git-send-email-nm@ti.com> (Nishanth Menon's
	message of "Wed, 18 May 2011 02:37:41 -0500")
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap <linux-omap@vger.kernel.org>

Nishanth Menon <nm@ti.com> writes:

> freq_table allocated by opp_init_cpufreq_table in omap_cpu_init
> needs to be freed in omap_cpu_exit.

Actually it needs to be freed by a corresponding OPP layer function.

IOW, what happens if the OPP core code switches from using kmalloc to
static tables, or something else?    The cleanup should be done by the
same layer that does the init/alloc.

Kevin

> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  arch/arm/mach-omap2/omap2plus-cpufreq.c |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/omap2plus-cpufreq.c b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> index d53ce23..e38ebb8 100644
> --- a/arch/arm/mach-omap2/omap2plus-cpufreq.c
> +++ b/arch/arm/mach-omap2/omap2plus-cpufreq.c
> @@ -26,6 +26,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/opp.h>
> +#include <linux/slab.h>
>  #include <linux/cpu.h>
>  
>  #include <asm/system.h>
> @@ -216,6 +217,8 @@ static int __cpuinit omap_cpu_init(struct cpufreq_policy *policy)
>  static int omap_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	clk_exit_cpufreq_table(&freq_table);
> +	kfree(freq_table);
> +	freq_table = NULL;
>  	clk_put(mpu_clk);
>  	return 0;
>  }
