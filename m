From: Quentin Perret <qperret@google.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Tue, 21 Jan 2020 10:08:54 +0000
Message-ID: <20200121100854.GB157387@google.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <17b77e0c-9455-0479-d37b-c57717c784c7@arm.com>
 <20200120152804.GB164543@google.com>
 <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <453034e5-f7b9-20f7-4e26-5d0d7164edd1@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lukasz Luba <lukasz.luba@arm.com>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.
List-Id: linux-omap@vger.kernel.org

On Monday 20 Jan 2020 at 16:20:49 (+0000), Lukasz Luba wrote:
> On 1/20/20 3:28 PM, Quentin Perret wrote:
> > Agreed, this looks a bit confusing. It should be trivial to make
> > em_dev_get() (or whatever we end up calling it) work for CPUs too,
> > though. And we could always have a em_cpu_get(int cpu) API that is a
> > basically a wrapper around em_dev_get() for convenience.
> 
> The problem not only here is that we have a CPU index 'int cpu'
> and if we ask for device like:
> 
> struct device *dev = get_cpu_device(cpu);
> 
> It might be not the same device that was used during the
> registration, when we had i.e. 4 CPUs for the same policy:
>
> int cpu_id = cpumask_first(policy->cpus);
> struct device *cpu_dev = get_cpu_device(cpu_id);
> em_register_perf_domain(cpu_dev, nr_opp, &em_cb);
> 
> That's why the em_cpu_get() is different than em_get_pd(), mainly by:
> if (cpumask_test_cpu(cpu, em_span_cpus(em_pd)))
> 
> It won't be simple wrapper, let me think how it could be handled
> differently than it is now.

Right so I suppose the easiest solution would be to do the opposite of
my first suggestion. That is, make em_get_pd() call em_cpu_get() if the
device is a CPU device, or proceed to the PD list iteration for other
devices. And em_cpu_get() can remain as you originally suggested (that
is, iterate over the PDs and test the mask).

That should ensure em_get_pd() always works, em_cpu_get() is still there
handy for the scheduler and such, and the two EM lookup functions (for
CPUs or for devices) are kept cleanly separated.

Thoughts ?

Thanks,
Quentin
