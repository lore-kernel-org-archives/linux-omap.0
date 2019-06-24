From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/6] thermal/drivers/cpu_cooling: Unregister with the
 policy
Date: Mon, 24 Jun 2019 11:33:34 +0530
Message-ID: <20190624060334.kak2mjuou4napi4x@vireshk-i7>
References: <20190621132302.30414-1-daniel.lezcano@linaro.org>
 <20190621132302.30414-2-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190621132302.30414-2-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: edubezval@gmail.com, linux-kernel@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, "open list:TI BANDGAP AND THERMAL DRIVER" <linux-omap@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On 21-06-19, 15:22, Daniel Lezcano wrote:
> Currently the function cpufreq_cooling_register() returns a cooling
> device pointer which is used back as a pointer to call the function
> cpufreq_cooling_unregister(). Even if it is correct, it would make
> sense to not leak the structure inside a cpufreq driver and keep the
> code thermal code self-encapsulate. Moreover, that forces to add an
> extra variable in each driver using this function.
> 
> Instead of passing the cooling device to unregister, pass the policy.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>  drivers/cpufreq/arm_big_little.c               |  2 +-
>  drivers/cpufreq/cpufreq.c                      |  2 +-
>  drivers/thermal/cpu_cooling.c                  | 18 ++++++++++--------
>  drivers/thermal/imx_thermal.c                  |  4 ++--
>  .../thermal/ti-soc-thermal/ti-thermal-common.c |  2 +-
>  include/linux/cpu_cooling.h                    |  6 +++---
>  6 files changed, 18 insertions(+), 16 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
