From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Mon, 24 Jun 2019 09:45:40 +0200
Message-ID: <d31f65c8-53df-ae59-5f6f-211c0ddcff3f@linaro.org>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
 <20190624060334.kak2mjuou4napi4x@vireshk-i7>
 <3f324189-aa1e-ae78-1d69-61e00c5d033a@linaro.org>
 <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624073747.hf7jd6ulkmebbxtm@vireshk-i7>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 24/06/2019 09:37, Viresh Kumar wrote:
> On 24-06-19, 09:30, Daniel Lezcano wrote:
>> On 24/06/2019 08:03, Viresh Kumar wrote:
>>> On 21-06-19, 15:22, Daniel Lezcano wrote:
>>>> Currently the function cpufreq_cooling_register() returns a cooling
>>>> device pointer which is used back as a pointer to call the function
>>>> cpufreq_cooling_unregister(). Even if it is correct, it would make
>>>> sense to not leak the structure inside a cpufreq driver and keep the
>>>> code thermal code self-encapsulate. Moreover, that forces to add an
>>>> extra variable in each driver using this function.
>>>>
>>>> Instead of passing the cooling device to unregister, pass the policy.
>>>>
>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>> ---
>>>>  drivers/cpufreq/arm_big_little.c               |  2 +-
>>>>  drivers/cpufreq/cpufreq.c                      |  2 +-
>>>>  drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
>>>>  drivers/thermal/imx_thermal.c                  |  4 ++--
>>>>  .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
>>>>  include/linux/cpu_cooling.h                    |  6 +++---
>>>>  6 files changed, 18 insertions(+), 16 deletions(-)
>>>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> Just a side note, does it make sense to have the function called from
>> imx_thermal.c and ti-thermal-common.c? Sounds like also a leakage from
>> cpufreq to thermal drivers, no?
> 
> I am not sure what you are proposing here :)

Actually I'm asking your opinion :)

The structure in drivers/thermal/imx_thermal.c

struct imx_thermal_data {
        struct cpufreq_policy *policy; <<<< in the thermal data ?!
	[ ... ]
};

And then:

#ifdef CONFIG_CPU_FREQ
/*
 * Create cooling device in case no #cooling-cells property is available in
 * CPU node
 */
static int imx_thermal_register_legacy_cooling(struct imx_thermal_data
*data)
{
        struct device_node *np;
        int ret;

        data->policy = cpufreq_cpu_get(0);
        if (!data->policy) {
                pr_debug("%s: CPUFreq policy not found\n", __func__);
                return -EPROBE_DEFER;
        }

        np = of_get_cpu_node(data->policy->cpu, NULL);

        if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
                data->cdev = cpufreq_cooling_register(data->policy);
                if (IS_ERR(data->cdev)) {
                        ret = PTR_ERR(data->cdev);
                        cpufreq_cpu_put(data->policy);
                        return ret;
                }
        }

        return 0;
}

[ ... ]

Shouldn't this be move in the drivers/cpufreq/<whatever driver> ?

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
