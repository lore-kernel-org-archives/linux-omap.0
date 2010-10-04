From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH 2/4] perf: add OMAP support for the new power events
Date: Mon, 4 Oct 2010 21:45:46 +0200
Message-ID: <201010042145.48838.trenn@suse.de>
References: <1286205661-24448-1-git-send-email-jean.pihet@newoldbits.com> <1286205661-24448-3-git-send-email-jean.pihet@newoldbits.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <1286205661-24448-3-git-send-email-jean.pihet@newoldbits.com>
Content-Disposition: inline
Sender: linux-trace-users-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: linux-trace-users@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-perf-users@vger.kernel.org, mingo@elte.hu, arjan@linux.intel.com, rjw@sisk.pl, linux-omap@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Kevin Hilman <khilman@deeprootsystems.com>, Steven Rostedt <rostedt@goodmis.org>, Frank Eigler <fche@redhat.com>, mathieu.desnoyers@efficios.com, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Monday 04 October 2010 05:20:59 pm Jean Pihet wrote:
> The patch adds the new power management trace points for
> the OMAP architecture.
>
> The trace points are for cpuidle, cpufreq (DVFS), the clocks
> changes (enable, disable, set_rate) and the power domains
> transitions.
...
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index 6d3d333..19d5a6c 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -21,6 +21,7 @@
>  #include <linux/err.h>
>  #include <linux/clk.h>
>  #include <linux/io.h>
> +#include <trace/events/power.h>
>
>  #include <mach/hardware.h>
>  #include <plat/clock.h>
> @@ -95,6 +96,7 @@ static int omap_target(struct cpufreq_policy *policy,
>  	printk(KERN_DEBUG "cpufreq-omap: transition: %u --> %u\n",
>  	       freqs.old, freqs.new);
>  #endif
> +	trace_processor_frequency(freqs.new, freqs.cpu);
>  	ret = clk_set_rate(mpu_clk, freqs.new * 1000);
>  	cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);

This one is not needed, frequency power events are all fired in
drivers/cpufreq/cpufreq.c
for cpufreq drivers:
static struct cpufreq_driver omap_driver = {
        .target         = omap_target,
}
