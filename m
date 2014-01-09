From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH v2 2/3] ARM: OMAP2+: Add support to parse optional clk
 info from DT
Date: Thu, 9 Jan 2014 09:19:38 -0600
Message-ID: <52CEBE0A.60007@ti.com>
References: <1386848309-14076-1-git-send-email-rnayak@ti.com>
 <1386848309-14076-3-git-send-email-rnayak@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386848309-14076-3-git-send-email-rnayak@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Rajendra Nayak <rnayak@ti.com>, linux-omap@vger.kernel.org, tony@atomide.com, paul@pwsan.com
Cc: mark.rutland@arm.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, bcousson@baylibre.com
List-Id: linux-omap@vger.kernel.org

On 12/12/2013 05:38 AM, Rajendra Nayak wrote:
> With clocks for OMAP moving to DT, its now possible to pass all optional clock
> data for each device from DT instead of having it in hwmod.
> 
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> ---
>  arch/arm/mach-omap2/omap_hwmod.c |   65 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 63 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
> index f22bbbb..271634f 100644
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
> @@ -807,6 +807,64 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>  	return ret;
>  }
>  
> +static const char **_parse_opt_clks_dt(struct omap_hwmod *oh,
> +				       struct device_node *np,
> +				       int *opt_clks_cnt)
> +{
> +	int i, clks_cnt;
> +	const char *clk_name;
> +	const char **opt_clk_names;
> +
> +	clks_cnt = of_property_count_strings(np, "clock-names");
> +	if (!clks_cnt)
> +		return NULL;
> +
> +	opt_clk_names = kzalloc(sizeof(char *)*clks_cnt, GFP_KERNEL);
> +	if (!opt_clk_names)
> +		return NULL;
> +
> +	for (i = 0; i < clks_cnt; i++) {
> +		of_property_read_string_index(np, "clock-names", i, &clk_name);
> +		if (!strcmp(clk_name, "fck"))
> +			continue;
> +		opt_clks_cnt++;
> +		opt_clk_names[i] = clk_name;

This assumes that any clock-names entry which does not match "fck" is
an optional clock that should be controlled by hwmod -> this is not
always the case and in cases such as gpio or mmc, the optional
debounce clock is actually prefered to be controlled by the driver.

we wont have a way around that.

> +	}
> +	return opt_clk_names;
> +}
> +
> +static int _init_opt_clks_dt(struct omap_hwmod *oh, struct device_node *np)
> +{
> +	struct clk *c;
> +	int i, opt_clks_cnt = 0;
> +	int ret = 0;
> +	const char **opt_clk_names;
> +
> +	opt_clk_names = _parse_opt_clks_dt(oh, np, &opt_clks_cnt);
> +	if (!opt_clk_names)
> +		return -EINVAL;
> +
> +	oh->opt_clks = kzalloc(sizeof(struct omap_hwmod_opt_clk *)
> +			       * opt_clks_cnt, GFP_KERNEL);
> +	if (!oh->opt_clks)
> +		return -ENOMEM;
> +
> +	oh->opt_clks_cnt = opt_clks_cnt;
> +
> +	for (i = 0; i < oh->opt_clks_cnt; i++) {
> +		c = of_clk_get_by_name(np, opt_clk_names[i]);
> +		if (IS_ERR(c)) {
> +			pr_warn("omap_hwmod: %s: cannot clk_get opt_clk %s\n",
> +				oh->name, opt_clk_names[i]);
> +			ret = -EINVAL;
> +		}
> +		oh->opt_clks[i]._clk = c;
> +		oh->opt_clks[i].role = opt_clk_names[i];
> +		clk_prepare(oh->opt_clks[i]._clk);
> +	}
> +	return ret;
> +}
> +
>  /**
>   * _init_opt_clk - get a struct clk * for the the hwmod's optional clocks
>   * @oh: struct omap_hwmod *
> @@ -814,13 +872,16 @@ static int _init_interface_clks(struct omap_hwmod *oh)
>   * Called from _init_clocks().  Populates the @oh omap_hwmod_opt_clk
>   * clock pointers.  Returns 0 on success or -EINVAL on error.
>   */
> -static int _init_opt_clks(struct omap_hwmod *oh)
> +static int _init_opt_clks(struct omap_hwmod *oh, struct device_node *np)
>  {
>  	struct omap_hwmod_opt_clk *oc;
>  	struct clk *c;
>  	int i;
>  	int ret = 0;
>  
> +	if (of_get_property(np, "clocks", NULL))
> +		return _init_opt_clks_dt(oh, np);
> +
>  	for (i = oh->opt_clks_cnt, oc = oh->opt_clks; i > 0; i--, oc++) {
>  		c = clk_get(NULL, oc->clk);
>  		if (IS_ERR(c)) {
> @@ -1590,7 +1651,7 @@ static int _init_clocks(struct omap_hwmod *oh, void *data,
>  
>  	ret |= _init_main_clk(oh, np);
>  	ret |= _init_interface_clks(oh);
> -	ret |= _init_opt_clks(oh);
> +	ret |= _init_opt_clks(oh, np);
>  
>  	if (!ret)
>  		oh->_state = _HWMOD_STATE_CLKS_INITED;
> 


-- 
Regards,
Nishanth Menon
