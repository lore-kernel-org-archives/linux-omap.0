From: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Fri, 17 Jan 2020 10:54:37 +0000
Message-ID: <20200117105437.GA211774@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200116152032.11301-2-lukasz.luba@arm.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: lukasz.luba@arm.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Dietmar.Eggemann@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.
List-Id: linux-omap@vger.kernel.org

Hey Lukasz,

Still reading through this, but with small changes, this looks pretty
good to me.

On Thursday 16 Jan 2020 at 15:20:29 (+0000), lukasz.luba@arm.com wrote:
> +int em_register_perf_domain(struct device *dev, unsigned int nr_states,
> +			struct em_data_callback *cb)
>  {
>  	unsigned long cap, prev_cap = 0;
>  	struct em_perf_domain *pd;
> -	int cpu, ret = 0;
> +	struct em_device *em_dev;
> +	cpumask_t *span = NULL;
> +	int cpu, ret;
>  
> -	if (!span || !nr_states || !cb)
> +	if (!dev || !nr_states || !cb || !cb->active_power)

Nit: you check !cb->active_power in em_create_pd() too I think, so only
one of the two is needed.

>  		return -EINVAL;
>  
> -	/*
> -	 * Use a mutex to serialize the registration of performance domains and
> -	 * let the driver-defined callback functions sleep.
> -	 */
>  	mutex_lock(&em_pd_mutex);
>  
> -	for_each_cpu(cpu, span) {
> -		/* Make sure we don't register again an existing domain. */
> -		if (READ_ONCE(per_cpu(em_data, cpu))) {
> +	if (_is_cpu_device(dev)) {
> +		span = kzalloc(cpumask_size(), GFP_KERNEL);
> +		if (!span) {
> +			mutex_unlock(&em_pd_mutex);
> +			return -ENOMEM;
> +		}
> +
> +		ret = dev_pm_opp_get_sharing_cpus(dev, span);
> +		if (ret)
> +			goto free_cpumask;

That I think should be changed. This creates some dependency on PM_OPP
for the EM framework. And in fact, the reason we came up with PM_EM was
precisely to not depend on PM_OPP which was deemed too Arm-specific.

Suggested alternative: have two registration functions like so:

	int em_register_dev_pd(struct device *dev, unsigned int nr_states,
			       struct em_data_callback *cb);
	int em_register_cpu_pd(cpumask_t *span, unsigned int nr_states,
			       struct em_data_callback *cb);

where em_register_cpu_pd() does the CPU-specific work and then calls
em_register_dev_pd() (instead of having that big if (_is_cpu_device(dev))
as you currently have). Would that work ?

Another possibility would be to query CPUFreq instead of PM_OPP to get
the mask, but I'd need to look again at the driver registration path in
CPUFreq to see if the policy masks have been populated when we enter
PM_EM ... I am not sure if this is the case, but it's worth having a
look too.

Thanks,
Quentin
