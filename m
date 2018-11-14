From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v4] cpufreq: ti-cpufreq: Only register platform_device
 when supported
Date: Wed, 14 Nov 2018 09:32:42 +0530
Message-ID: <20181114040242.wfpvazl62g6phy3o@vireshk-i7>
References: <20181113193040.15181-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181113193040.15181-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Dave Gerlach <d-gerlach@ti.com>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Keerthy J <j-keerthy@ti.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, Tero Kristo <t-kristo@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 13-11-18, 13:30, Dave Gerlach wrote:
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
> v3->v4: Use platform_device_register_data rather than
> 	platform_device_register_resndata as we are only passing data.
> 
> 	v3: https://patchwork.kernel.org/patch/10681161/
> 
>  drivers/cpufreq/ti-cpufreq.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ti-cpufreq.c b/drivers/cpufreq/ti-cpufreq.c
> index 3f0e2a14895a..22b53bf26817 100644
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
> +	match = dev_get_platdata(&pdev->dev);
>  	if (!match)
>  		return -ENODEV;
>  
> @@ -290,7 +299,14 @@ static int ti_cpufreq_probe(struct platform_device *pdev)
>  
>  static int ti_cpufreq_init(void)
>  {
> -	platform_device_register_simple("ti-cpufreq", -1, NULL, 0);
> +	const struct of_device_id *match;
> +
> +	/* Check to ensure we are on a compatible platform */
> +	match = ti_cpufreq_match_node();
> +	if (match)
> +		platform_device_register_data(NULL, "ti-cpufreq", -1, match,
> +					      sizeof(*match));
> +
>  	return 0;
>  }
>  module_init(ti_cpufreq_init);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
