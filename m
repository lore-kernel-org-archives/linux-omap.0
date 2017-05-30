From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCHv3b 5/5] ARM: OMAP2+: hwmod: populate clkctrl clocks for
 hwmods if available
Date: Tue, 30 May 2017 11:15:17 -0700
Message-ID: <20170530181516.GB3730@atomide.com>
References: <1496155669-1677-1-git-send-email-t-kristo@ti.com>
 <1496155669-1677-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1496155669-1677-6-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

* Tero Kristo <t-kristo@ti.com> [170530 07:52]:
> If clkctrl clocks are available on a device, populate these automatically
> to replace hwmod main_clk info. First, the patch parses all "ti,clkctrl"
> compatible nodes and maps these against existing clockdomain data. Once
> done, individual hwmod init routines can search for a clkctrl clock
> handle based on the clockdomain info and the created mapping.
...
> --- a/arch/arm/mach-omap2/omap_hwmod.c
> +++ b/arch/arm/mach-omap2/omap_hwmod.c
>  /**
>   * _init_main_clk - get a struct clk * for the the hwmod's main functional clk
>   * @oh: struct omap_hwmod *
> + * @np: device node mapped to this hwmod
>   *
>   * Called from _init_clocks().  Populates the @oh _clk (main
>   * functional clock pointer) if a clock matching the hwmod name is found,
>   * or a main_clk is present.  Returns 0 on success or -EINVAL on error.
>   */
> -static int _init_main_clk(struct omap_hwmod *oh)
> +static int _init_main_clk(struct omap_hwmod *oh, struct device_node *np)
>  {
>  	int ret = 0;
> -	char name[MOD_CLK_MAX_NAME_LEN];
> -	struct clk *clk;
> -	static const char modck[] = "_mod_ck";
> +	struct clk *clk = NULL;
>  
> -	if (strlen(oh->name) >= MOD_CLK_MAX_NAME_LEN - strlen(modck))
> -		pr_warn("%s: warning: cropping name for %s\n", __func__,
> -			oh->name);
> -
> -	strlcpy(name, oh->name, MOD_CLK_MAX_NAME_LEN - strlen(modck));
> -	strlcat(name, modck, MOD_CLK_MAX_NAME_LEN);
> +	if (np) {
> +		clk = _lookup_clkctrl_clk(oh, np);
> +
> +		if (!IS_ERR_OR_NULL(clk)) {
> +			pr_debug("%s: mapped main_clk %s for %s\n", __func__,
> +				 __clk_get_name(clk), oh->name);
> +			oh->main_clk = __clk_get_name(clk);
> +			oh->_clk = clk;
> +			soc_ops.disable_direct_prcm(oh);
> +		}
> +	}

Shouldn't we just parse all "ti,clkctrl" matches to
a list, then match against that list?

Again I'm worried that the "struct device_node *np"
here won't really map to struct omap_hwmod but to one of
the child devices. Or what is the np here?

Regards,

Tony
