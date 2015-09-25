From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 1/2] Trace: PM: promote event 'power_domain_target' to
 generic power domains.
Date: Fri, 25 Sep 2015 10:05:32 -0400
Message-ID: <20150925100532.7cf5bde7@gandalf.local.home>
References: <1443187345-14834-1-git-send-email-mtitinger+renesas@baylibre.com>
	<1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1443187345-14834-2-git-send-email-mtitinger+renesas@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
To: Marc Titinger <mtitinger@baylibre.com>
Cc: khilman@kernel.org, rjw@rjwysocki.net, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Fri, 25 Sep 2015 15:22:24 +0200
Marc Titinger <mtitinger@baylibre.com> wrote:

> From: Marc Titinger <mtitinger@baylibre.com>
> 
> - change arg3 to a state name string: we got the current CPU rom the trace
> backend already. This also prepares for multiple/named states in the power
> domain, consistent with idle-states. states in the domain may match given
> CPU states in this case, we will trace them by their name, and potentially
> use arg2 as a link to their index for the cpuidle driver.
> 
> - tested with Juno DP
> 
> <idle>-0     [000]    42.395510: power_domain_target:  a53_pd index=0 'cluster-sleep-0'
> <idle>-0     [000]    42.395528: cpu_idle:             state=4294967295 cpu_id=0
> <idle>-0     [000]    42.395668: cpu_idle:             state=2 cpu_id=0
> 
> - compiled for Omap2+
> 
> Signed-off-by: Marc Titinger <mtitinger@baylibre.com>
> ---
>  drivers/base/power/domain.c  |  9 +++++++++
>  include/trace/events/power.h | 29 +++++++++++++++--------------
>  2 files changed, 24 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 59ccd92..b9e2a37 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -21,6 +21,10 @@
>  #include <linux/export.h>
>  #include <linux/sort.h>
>  
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +#include <trace/events/power.h>
> +#endif

Are the events in events/power.h only available when PM_ADVANCED_DEBUG
is enabled? If so, this should probably be encapsulated in that header
file, with an "#else" that makes all the trace_power_*() calls into
static inlined nops. Then you can get rid of the ugly #ifdef in this
file.


> +
>  #define GENPD_RETRY_MAX_MS	250		/* Approximate */
>  
>  #define GENPD_DEV_CALLBACK(genpd, type, callback, dev)		\
> @@ -328,6 +332,11 @@ static int __pm_genpd_poweron(struct generic_pm_domain *genpd)
>  
>   out:
>  	genpd->status = GPD_STATE_ACTIVE;
> +
> +#ifdef CONFIG_PM_ADVANCED_DEBUG
> +	trace_power_domain_target(genpd->name, genpd->state_idx,
> +				genpd->states[genpd->state_idx].name);
> +#endif
>  	return 0;
>  
>   err:
> diff --git a/include/trace/events/power.h b/include/trace/events/power.h
> index 284244e..8f93be6 100644
> --- a/include/trace/events/power.h
> +++ b/include/trace/events/power.h
> @@ -237,9 +237,9 @@ DECLARE_EVENT_CLASS(clock,
>  	TP_ARGS(name, state, cpu_id),
>  
>  	TP_STRUCT__entry(
> -		__string(       name,           name            )
> -		__field(        u64,            state           )
> -		__field(        u64,            cpu_id          )
> +		__string(name, name)
> +		__field(u64, state)
> +		__field(u64, cpu_id)

Note, the standard formatting for the tracepoints is with the spaces.
Igonre checkpatch for that, tracepoints don't follow it.

-- Steve

>  	),
>  
>  	TP_fast_assign(
> @@ -278,31 +278,32 @@ DEFINE_EVENT(clock, clock_set_rate,
>   */
>  DECLARE_EVENT_CLASS(power_domain,

