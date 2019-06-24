From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Mon, 24 Jun 2019 15:09:37 +0530
Message-ID: <20190624093937.hmfzfm2s46hfhvhm@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
 <20190624060334.kak2mjuou4napi4x@vireshk-i7>
 <3f324189-aa1e-ae78-1d69-61e00c5d033a@linaro.org>
 <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
 <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 24-06-19, 09:45, Daniel Lezcano wrote:
> Actually I'm asking your opinion :)
> 
> The structure in drivers/thermal/imx_thermal.c
> 
> struct imx_thermal_data {
>         struct cpufreq_policy *policy; <<<< in the thermal data ?!
> 	[ ... ]
> };
> 
> And then:
> 
> #ifdef CONFIG_CPU_FREQ
> /*
>  * Create cooling device in case no #cooling-cells property is available in
>  * CPU node
>  */
> static int imx_thermal_register_legacy_cooling(struct imx_thermal_data
> *data)
> {
>         struct device_node *np;
>         int ret;
> 
>         data->policy = cpufreq_cpu_get(0);
>         if (!data->policy) {
>                 pr_debug("%s: CPUFreq policy not found\n", __func__);
>                 return -EPROBE_DEFER;
>         }
> 
>         np = of_get_cpu_node(data->policy->cpu, NULL);
> 
>         if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
>                 data->cdev = cpufreq_cooling_register(data->policy);
>                 if (IS_ERR(data->cdev)) {
>                         ret = PTR_ERR(data->cdev);
>                         cpufreq_cpu_put(data->policy);
>                         return ret;
>                 }
>         }
> 
>         return 0;
> }
> 
> [ ... ]
> 
> Shouldn't this be move in the drivers/cpufreq/<whatever driver> ?

Sure, we have platform specific drivers where this can be moved :)

-- 
viresh
