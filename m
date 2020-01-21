From: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Tue, 21 Jan 2020 09:31:58 +0000
Message-ID: <20200121093158.GA154455@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
 <20200120150918.GA164543@google.com>
 <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
 <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b02da0ed-9e0b-36db-9813-daa334cbf2ba@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.
List-Id: linux-omap@vger.kernel.org

On Monday 20 Jan 2020 at 18:38:41 (+0000), Lukasz Luba wrote:
> I think we could avoid this additional argument 'cpumask'. I have
> checked the cpufreq_cpu_get function, which should do be good for this:
> 
> ---------->8-------------------------
> static int _get_sharing_cpus(struct device *cpu_dev, struct cpumask *span)
> {
>         struct cpufreq_policy *policy;
> 
>         policy = cpufreq_cpu_get(cpu_dev->id);
>         if (policy) {
>                 cpumask_copy(span, policy->cpus);

That should be with 'policy->related_cpus', but yes if the policy
cpumasks have been populated this approach is OK I think.

>                 cpufreq_cpu_put(policy);
>                 return 0;
>         } else {
>                 return -EINVAL;
>         }
> }
> --------------------------8<-------------------------------

Thanks,
Quentin
