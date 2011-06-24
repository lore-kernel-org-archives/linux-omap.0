From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCHv2] omap2+: pm: cpufreq: Fix loops_per_jiffy calculation
Date: Fri, 24 Jun 2011 15:01:42 +0100
Message-ID: <20110624140142.GM9449@n2100.arm.linux.org.uk>
References: <1308923618-5333-1-git-send-email-premi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1308923618-5333-1-git-send-email-premi@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sanjeev Premi <premi@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Jun 24, 2011 at 07:23:38PM +0530, Sanjeev Premi wrote:
> @@ -97,12 +97,8 @@ static int omap_target(struct cpufreq_policy *policy,
>  		return ret;
> 
>  	/* Notify transitions */
> -	if (is_smp()) {
> -		for_each_cpu(i, policy->cpus) {
> -			freqs.cpu = i;
> -			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
> -		}
> -	} else {
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
>  		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
>  	}
> 

Ok.

> @@ -114,13 +110,20 @@ static int omap_target(struct cpufreq_policy *policy,
> 
>  	freqs.new = omap_getspeed(policy->cpu);
> 
> +#ifdef CONFIG_SMP
> +	/* Adjust jiffies before transition */
> +	for_each_cpu(i, policy->cpus) {
> +		unsigned long lpj = per_cpu(cpu_data, i).loops_per_jiffy;
> +
> +		per_cpu(cpu_data, i).loops_per_jiffy = cpufreq_scale(lpj,
> +							freqs.old,
> +							freqs.new);
> +	}
> +#endif
> +

You didn't listen to what I told you.  It'll be quicker for me to write
this patch myself if you send me the *original* file.

>  	/* Notify transitions */
> -	if (is_smp()) {
> -		for_each_cpu(i, policy->cpus) {
> -			freqs.cpu = i;
> -			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
> -		}
> -	} else {
> +	for_each_cpu(i, policy->cpus) {
> +		freqs.cpu = i;
>  		cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
>  	}

Ok.
