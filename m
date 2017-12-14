From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 1/4] cpufreq: ti-cpufreq: Convert to
 module_platform_driver
Date: Thu, 14 Dec 2017 09:59:46 +0530
Message-ID: <20171214042946.GR3322@vireshk-i7>
References: <20171213203358.20839-1-d-gerlach@ti.com>
 <20171213203358.20839-2-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20171213203358.20839-2-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Rob Herring <robh+dt@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

On 13-12-17, 14:33, Dave Gerlach wrote:
> ti-cpufreq will be responsible for calling dev_pm_opp_set_regulators on
> platforms that require AVS and ABB regulator support so we must be
> able to defer probe if regulators are not yet available, so change
> ti-cpufreq to be a module_platform_driver to allow for probe defer.
> 
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
>  drivers/cpufreq/ti-cpufreq.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 923317f03b4b..b1c230a1e2aa 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -17,6 +17,7 @@
>  #include <linux/cpu.h>
>  #include <linux/io.h>
>  #include <linux/mfd/syscon.h>
> +#include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
> @@ -195,7 +196,7 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>  	{},
>  };
>  
> -static int ti_cpufreq_init(void)
> +static int ti_cpufreq_probe(struct platform_device *pdev)
>  {
>  	u32 version[VERSION_COUNT];
>  	struct device_node *np;
> @@ -269,4 +270,22 @@ static int ti_cpufreq_init(void)
>  
>  	return ret;
>  }
> -device_initcall(ti_cpufreq_init);
> +
> +static int ti_cpufreq_init(void)
> +{
> +	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	return 0;
> +}
> +module_init(ti_cpufreq_init);
> +
> +static struct platform_driver ti_cpufreq_driver = {
> +	.probe = ti_cpufreq_probe,
> +	.driver = {
> +		.name = "ti-cpufreq",
> +	},
> +};
> +module_platform_driver(ti_cpufreq_driver);
> +
> +MODULE_DESCRIPTION("TI CPUFreq/OPP hw-supported driver");
> +MODULE_AUTHOR("Dave Gerlach <d-gerlach@ti.com>");
> +MODULE_LICENSE("GPL v2");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
