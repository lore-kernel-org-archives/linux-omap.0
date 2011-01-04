From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 2/3] perf: add OMAP support for the new power events
Date: Tue, 04 Jan 2011 12:03:56 -0600
Message-ID: <4D23610C.1060009@ti.com>
References: <1294136263-24020-1-git-send-email-j-pihet@ti.com> <1294136263-24020-3-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
In-Reply-To: <1294136263-24020-3-git-send-email-j-pihet@ti.com>
Sender: linux-perf-users-owner@vger.kernel.org
To: jean.pihet@newoldbits.com
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, trenn@suse.de, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-perf-users@vger.kernel.org, rjw@sisk.pl, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

jean.pihet@newoldbits.com had written, on 01/04/2011 04:17 AM, the 
following:
[..]
> diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.c
> index 0ec8a04..0ee0b0e 100644
> --- a/arch/arm/mach-omap2/pm34xx.c
> +++ b/arch/arm/mach-omap2/pm34xx.c
> @@ -29,6 +29,7 @@
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/console.h>
> +#include <trace/events/power.h>
>  
>  #include <plat/sram.h>
>  #include <plat/clockdomain.h>
> @@ -506,8 +507,14 @@ static void omap3_pm_idle(void)
>  	if (omap_irq_pending() || need_resched())
>  		goto out;
>  
> +	trace_power_start(POWER_CSTATE, 1, smp_processor_id());
> +	trace_cpu_idle(1, smp_processor_id());
> +
>  	omap_sram_idle();
>  
> +	trace_power_end(smp_processor_id());
> +	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());

Dumb question: it just tells me which C state was attempted - not if 
actually succeeded in hitting it rt? Does'nt this give us a false data?

[..]
> diff --git a/arch/arm/plat-omap/clock.c b/arch/arm/plat-omap/clock.c
> index fc62fb5..7cbb09b 100644
> --- a/arch/arm/plat-omap/clock.c
> +++ b/arch/arm/plat-omap/clock.c
(from an offline discussion on a related topic): Would it also be nice 
to hook on mach-omap2/clock.c points as well to hook on indirect changes?
[..]

-- 
Regards,
Nishanth Menon
