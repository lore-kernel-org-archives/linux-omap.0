From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V3 2/3] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Wed, 26 Jun 2019 12:07:16 +0530
Message-ID: <20190626063716.cechnzsb75q5lclr@vireshk-i7>
References: <20190625113244.18146-1-daniel.lezcano@linaro.org>
 <20190625113244.18146-2-daniel.lezcano@linaro.org>
 <20190626025831.jmyzyypxr6ezpbtu@vireshk-i7>
 <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <da1d2603-e30a-d877-54c3-1fad218f9d57@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@rjwysocki.net, edubezval@gmail.com, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 26-06-19, 08:02, Daniel Lezcano wrote:
> On 26/06/2019 04:58, Viresh Kumar wrote:
> > On 25-06-19, 13:32, Daniel Lezcano wrote:
> >> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> >> index aee024e42618..f07454249fbc 100644
> >> --- a/drivers/cpufreq/cpufreq.c
> >> +++ b/drivers/cpufreq/cpufreq.c
> >> @@ -1379,8 +1379,8 @@ static int cpufreq_online(unsigned int cpu)
> >>  		cpufreq_driver->ready(policy);
> >>  
> >>  	if (cpufreq_thermal_control_enabled(cpufreq_driver))
> >> -		policy->cdev = of_cpufreq_cooling_register(policy);
> >> -
> >> +		of_cpufreq_cooling_register(policy);
> >> +	
> > 
> > We don't need any error checking here anymore ?
> 
> There was no error checking initially. This comment and the others below
> are for an additional patch IMO, not a change in this one.

right, but ...

> >> -void cpufreq_cooling_unregister(struct thermal_cooling_device *cdev)
> >> +void cpufreq_cooling_unregister(struct cpufreq_policy *policy)
> >>  {
> >>  	struct cpufreq_cooling_device *cpufreq_cdev;
> >>  	bool last;
> >>  
> >> -	if (!cdev)
> >> -		return;

we used to return without any errors from here. Now we will have
problems if regsitering fails for some reason.

-- 
viresh
