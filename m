From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Date: Mon, 3 Sep 2018 12:01:31 +0530
Message-ID: <20180903063131.6wmbl66544svagst@vireshk-i7>
References: <20180823192035.22940-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180823192035.22940-1-d-gerlach@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Keerthy J <j-keerthy@ti.com>
List-Id: linux-omap@vger.kernel.org

On 23-08-18, 14:20, Dave Gerlach wrote:
> Currently the ti-cpufreq driver blindly registers a 'ti-cpufreq' to force
> the driver to probe on any platforms where the driver is built in.
> However, this should only happen on platforms that actually can make use
> of the driver. There is already functionality in place to match the
> SoC compatible so let's factor this out into a separate call and
> make sure we find a match before creating the ti-cpufreq platform device.
> 
> Reviewed-by: Johan Hovold <johan@kernel.org>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v1->v2:
> * Return 'match' directly in ti_cpufreq_match_node.
> * Add Johan's Reviewed-by.
> 
>  drivers/cpufreq/ti-cpufreq.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 3f0e2a14895a..6b025953ddee 100644
> --- a/drivers/cpufreq/ti-cpufreq.c
> +++ b/drivers/cpufreq/ti-cpufreq.c
> @@ -201,19 +201,28 @@ static const struct of_device_id ti_cpufreq_of_match[] = {
>  	{},
>  };
>  
> +static const struct of_device_id *ti_cpufreq_match_node(void)
> +{
> +	struct device_node *np;
> +	const struct of_device_id *match;
> +
> +	np = of_find_node_by_path("/");
> +	match = of_match_node(ti_cpufreq_of_match, np);
> +	of_node_put(np);
> +
> +	return match;
> +}
> +
>  static int ti_cpufreq_probe(struct platform_device *pdev)
>  {
>  	u32 version[VERSION_COUNT];
> -	struct device_node *np;
>  	const struct of_device_id *match;
>  	struct opp_table *ti_opp_table;
>  	struct ti_cpufreq_data *opp_data;
>  	const char * const reg_names[] = {"vdd", "vbb"};
>  	int ret;
>  
> -	np = of_find_node_by_path("/");
> -	match = of_match_node(ti_cpufreq_of_match, np);
> -	of_node_put(np);
> +	match = ti_cpufreq_match_node();
>  	if (!match)
>  		return -ENODEV;
>  
> @@ -290,7 +299,10 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	/* Check to ensure we are on a compatible platform */
> +	if (ti_cpufreq_match_node())
> +		platform_device_register_simple("ti-cpufreq", -1, NULL, 0);

Maybe call platform_device_register_resndata() here instead and pass match->data
to it and then you wouldn't be required to match again in probe ?

-- 
viresh
