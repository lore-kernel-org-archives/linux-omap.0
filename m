From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 4/4] omap: cpu: Power tracking support for cgroup cpuacct
Date: Wed, 19 May 2010 08:11:03 -0500
Message-ID: <4BF3E367.5080906@ti.com>
References: <1274232620-23003-1-git-send-email-mike@android.com> <1274232620-23003-5-git-send-email-mike@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1274232620-23003-5-git-send-email-mike@android.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Chan <mike@android.com>
Cc: "khilman@deeprootsystems.com" <khilman@deeprootsystems.com>, "menage@google.com" <menage@google.com>, "balbir@in.ibm.com" <balbir@in.ibm.com>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Mike Chan had written, on 05/18/2010 08:30 PM, the following:
> Specify new power field in struct omap_opp, which is
> power exported in milliWatt.
> 
> power_usage function gives power consumed in milliWatt seconds
> 
> Signed-off-by: Mike Chan <mike@android.com>
> ---
>  arch/arm/plat-omap/cpu-omap.c             |   23 ++++++++++++++++++++++-
>  arch/arm/plat-omap/include/plat/omap-pm.h |    1 +
>  2 files changed, 23 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-omap/cpu-omap.c b/arch/arm/plat-omap/cpu-omap.c
> index d27234d..1381539 100644
> --- a/arch/arm/plat-omap/cpu-omap.c
> +++ b/arch/arm/plat-omap/cpu-omap.c
> @@ -22,6 +22,7 @@
>  #include <linux/clk.h>
>  #include <linux/io.h>
>  #include <linux/cpuacct.h>
> +#include <linux/math64.h>
>  
>  #include <mach/hardware.h>
>  #include <plat/clock.h>
> @@ -218,10 +219,30 @@ static void omap_cpuacct_freq_show(void *cpuacct_data, struct cgroup_map_cb *cb)
>  	}
>  }
>  
> +
> +/* Returns power (in milliWatt seconds) for cgroup */
> +static u64 omap_cpuacct_power_usage(void *cpuacct_data)
> +{
> +	int i;
> +	u64 *cpuacct_freq = cpuacct_data;
> +	u64 totalpower = 0;
> +
> +	/* mpu_opps table starts at 1 */
> +	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++)
> +		totalpower += cpuacct_freq[i] * mpu_opps[i + 1].power;
> +
> +	/* milliwatt seconds */
> +	totalpower = div64_u64(totalpower, NSEC_PER_SEC);
> +
> +	return totalpower;
> +}
> +
> +
>  static struct cpuacct_cpufreq_calls omap_cpuacct_cpufreq = {
>  	.init = omap_cpuacct_freq_init,
>  	.charge = omap_cpuacct_freq_charge,
> -	.show = omap_cpuacct_freq_show,
> +	.cpufreq_show = omap_cpuacct_freq_show,
> +	.power_usage = omap_cpuacct_power_usage,
>  };
>  
>  static int __init omap_cpuacct_init(void)
> diff --git a/arch/arm/plat-omap/include/plat/omap-pm.h b/arch/arm/plat-omap/include/plat/omap-pm.h
> index 3ee41d7..8f2db6f 100644
> --- a/arch/arm/plat-omap/include/plat/omap-pm.h
> +++ b/arch/arm/plat-omap/include/plat/omap-pm.h
> @@ -31,6 +31,7 @@ struct omap_opp {
>  	unsigned long rate;
>  	u8 opp_id;
>  	u16 min_vdd;
> +	unsigned long power; /* power consumed running at OPP in milliWatts */

this conflicts with the OPP layer implementation. this structure will 
disappear for good.

>  };
>  
>  extern struct omap_opp *mpu_opps;


-- 
Regards,
Nishanth Menon
