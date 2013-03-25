From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH 2/2] cpufreq: drivers: Remove unnecessary assignments
 of policy-> members
Date: Mon, 25 Mar 2013 14:06:17 +0530
Message-ID: <51500C81.7040307@ti.com>
References: <2ece6d9fe8dfb6882a1c83a1cb2404bacc40b22d.1364138740.git.viresh.kumar@linaro.org> <07b96c5b68470001197445fb3d28786ad9acdbe0.1364138740.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <07b96c5b68470001197445fb3d28786ad9acdbe0.1364138740.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: rjw@sisk.pl, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, Sascha Hauer <kernel@pengutronix.de>, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 3/24/2013 8:59 PM, Viresh Kumar wrote:
> Some assignments of policy-> min/max/cur/cpuinfo.min_freq/cpuinfo.max_freq
> aren't required as part of it is done by cpufreq driver or cpufreq core.
> 
> Remove them.
> 
> At some places we merge multiple lines together too.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  Documentation/cpu-freq/cpu-drivers.txt | 5 +++--
>  arch/arm/mach-davinci/cpufreq.c        | 4 ----
>  arch/arm/mach-imx/cpufreq.c            | 3 ---
>  arch/sh/kernel/cpufreq.c               | 9 +++------
>  drivers/cpufreq/cpufreq-nforce2.c      | 6 ++----
>  drivers/cpufreq/omap-cpufreq.c         | 4 +---
>  6 files changed, 9 insertions(+), 22 deletions(-)
> 
> diff --git a/Documentation/cpu-freq/cpu-drivers.txt b/Documentation/cpu-freq/cpu-drivers.txt
> index 72f70b1..c94383f 100644
> --- a/Documentation/cpu-freq/cpu-drivers.txt
> +++ b/Documentation/cpu-freq/cpu-drivers.txt
> @@ -108,8 +108,9 @@ policy->governor		must contain the "default policy" for
>  				cpufreq_driver.target is called with
>  				these values.
>  
> -For setting some of these values, the frequency table helpers might be
> -helpful. See the section 2 for more information on them.
> +For setting some of these values (cpuinfo.min[max]_freq, policy->min[max]), the
> +frequency table helpers might be helpful. See the section 2 for more information
> +on them.
>  
>  SMP systems normally have same clock source for a group of cpus. For these the
>  .init() would be called only once for the first online cpu. Here the .init()
> diff --git a/arch/arm/mach-davinci/cpufreq.c b/arch/arm/mach-davinci/cpufreq.c
> index 8fb0c2a..ff46862 100644
> --- a/arch/arm/mach-davinci/cpufreq.c
> +++ b/arch/arm/mach-davinci/cpufreq.c
> @@ -149,10 +149,6 @@ static int davinci_cpu_init(struct cpufreq_policy *policy)
>  		policy->cpuinfo.max_freq = policy->max;
>  	}
>  
> -	policy->min = policy->cpuinfo.min_freq;
> -	policy->max = policy->cpuinfo.max_freq;
> -	policy->cur = davinci_getspeed(0);

There is a line in the code a little above the ones you deleted that
also sets these same variables. I guess you were relying on that line to
set policy->cur, but that also sets policy->{min, max} which can be
cleaned up.

Thanks,
Sekhar
