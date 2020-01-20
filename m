From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH 1/4] PM / EM: and devices to Energy Model
Date: Mon, 20 Jan 2020 19:27:26 +0100
Message-ID: <8332c4ac-2a7d-1e2d-76e9-7c979a666257@arm.com>
References: <20200116152032.11301-1-lukasz.luba@arm.com>
 <20200116152032.11301-2-lukasz.luba@arm.com>
 <20200117105437.GA211774@google.com>
 <40587d98-0e8d-cbac-dbf5-d26501d47a8c@arm.com>
 <20200120150918.GA164543@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200120150918.GA164543@google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Perret <qperret@google.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-imx@nxp.com, Morten.Rasmussen@arm.com, Chris.Redpath@arm.com, ionela.voinescu@arm.com, javi.merino@arm.com, cw00.choi@samsung.com, b.zolnierkie@samsung.com, rjw@rjwysocki.net, sudeep.holla@arm.com, viresh.kumar@linaro.org, nm@ti.com, sboyd@kernel.org, rui.zhang@intel.com, amit.kucheria@verdurent.com, daniel.lezcano@linaro.org, mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, vincent.guittot@linaro.org, rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

On 20/01/2020 16:09, Quentin Perret wrote:
> Hey Lukasz,
> 
> On Monday 20 Jan 2020 at 14:52:07 (+0000), Lukasz Luba wrote:
>> On 1/17/20 10:54 AM, Quentin Perret wrote:
>>> Suggested alternative: have two registration functions like so:
>>>
>>> 	int em_register_dev_pd(struct device *dev, unsigned int nr_states,
>>> 			       struct em_data_callback *cb);
>>> 	int em_register_cpu_pd(cpumask_t *span, unsigned int nr_states,
>>> 			       struct em_data_callback *cb);
>>
>> Interesting, in the internal review Dietmar asked me to remove these two
>> functions. I had the same idea, which would simplify a bit the
>> registration and it does not need to check the dev->bus if it is CPU.
>>
>> Unfortunately, we would need also two function in drivers/opp/of.c:
>> dev_pm_opp_of_register_cpu_em(policy->cpus);
>> and
>> dev_pm_opp_of_register_dev_em(dev);
>>
>> Thus, I have created only one registration function, which you can see
>> in this patch set.
> 
> Right, I can see how having a unified API would be appealing, but the
> OPP dependency is a nono, so we'll need to work around one way or
> another.
> 
> FWIW, I don't think having separate APIs for CPUs and other devices is
> that bad given that we already have entirely different frameworks to
> drive their respective frequencies. And the _cpu variants are basically
> just wrappers around the _dev ones, so not too bad either IMO :).

It's true that we need the policy->cpus cpumask only for cpu devices and
we have it available when we call em_register_perf_domain()
[scmi-cpufreq.c driver] or the OPP wrapper dev_pm_opp_of_register_em()
[e.g. cpufreq-dt.c driver].

And we shouldn't make EM code dependent on OPP.

But can't we add 'struct cpumask *mask' as an additional argument to
both which can be set to NULL for (devfreq) devices?

We can check in em_register_perf_domain() that we got a valid cpumask
for a cpu device and ignore it for (devfreq) devices.
