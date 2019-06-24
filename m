From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 2/2] thermal/drivers/cpu_cooling: Unregister with the policy
Date: Tue, 25 Jun 2019 00:08:24 +0200
Message-ID: <CAJZ5v0hMGMETyJyLxCKxiGOojAhmJ+Crioj7Gw_2wA+YUAS9QQ@mail.gmail.com>
References: <20190624131715.1857-1-daniel.lezcano@linaro.org> <20190624131715.1857-2-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190624131715.1857-2-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Eduardo Valentin <edubezval@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Keerthy <j-keerthy@ti.com>, "open list:CPU FREQUENCY DRIVERS - ARM BIG LITTLE" <linux-pm@vger.kernel.org>, "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list:TI BANDG
List-Id: linux-omap@vger.kernel.org

) On Mon, Jun 24, 2019 at 3:17 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Currently the function cpufreq_cooling_register() returns a cooling
> device pointer which is used back as a pointer to call the function
> cpufreq_cooling_unregister(). Even if it is correct, it would make
> sense to not leak the structure inside a cpufreq driver and keep the
> code thermal code self-encapsulate. Moreover, that forces to add an
> extra variable in each driver using this function.

[cut]

> @@ -667,9 +667,9 @@ static int imx_thermal_register_legacy_cooling(struct imx_thermal_data *data)
>         np = of_get_cpu_node(data->policy->cpu, NULL);
>
>         if (!np || !of_find_property(np, "#cooling-cells", NULL)) {
> -               data->cdev = cpufreq_cooling_register(data->policy);
> -               if (IS_ERR(data->cdev)) {
> -                       ret = PTR_ERR(data->cdev);
> +               cdev = cpufreq_cooling_register(data->policy);

It looks like after the changes in this patch the only reason for
returning (struct thermal_cooling_device *) from
cpufreq_cooling_register() is error checking, but it would be much
more straightforward to return int for this purpose.

Moreover, that would prevent the callers of it from doing incorrect
things with the returned pointers (like using it to unregister the
cooling device).

> +               if (IS_ERR(cdev)) {
> +                       ret = PTR_ERR(cdev);
>                         cpufreq_cpu_put(data->policy);
>                         return ret;
>                 }
