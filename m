From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCHv5 18/31] CLK: DT: add support for set-rate-parent flag
Date: Tue, 13 Aug 2013 12:25:49 +0100
Message-ID: <20130813112548.GM27165@e106331-lin.cambridge.arm.com>
References: <1375460751-23676-1-git-send-email-t-kristo@ti.com>
 <1375460751-23676-19-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1375460751-23676-19-git-send-email-t-kristo@ti.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, "mturquette@linaro.org" <mturquette@linaro.org>
Cc: "nm@ti.com" <nm@ti.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "paul@pwsan.com" <paul@pwsan.com>, "tony@atomide.com" <tony@atomide.com>, "rnayak@ti.com" <rnayak@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Aug 02, 2013 at 05:25:37PM +0100, Tero Kristo wrote:
> Adding set-rate-parent to clock node now allows a node to forward
> clk_set_rate request to its parent clock.

Why do you need this?

Is this a description of the hardware, or configuration for Linux?
It feels like the latter, which shouldn't really be in DT.

I'm not that familiar with the internals of the clock framework, and
don't understand the implications of this.

If this is necessary, the bindings need to be updated.

Mike, thoughts?

Mark.

> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/clk/clk-divider.c      |    6 +++++-
>  drivers/clk/clk-fixed-factor.c |    6 +++++-
>  drivers/clk/clk-gate.c         |    8 ++++++--
>  drivers/clk/clk-mux.c          |    6 +++++-
>  4 files changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/clk/clk-divider.c b/drivers/clk/clk-divider.c
> index ff24ec2..01d967f 100644
> --- a/drivers/clk/clk-divider.c
> +++ b/drivers/clk/clk-divider.c
> @@ -388,6 +388,7 @@ void of_divider_clk_setup(struct device_node *node)
>  	u32 mask = 0;
>  	u32 shift = 0;
>  	struct clk_div_table *table;
> +	u32 flags = 0;
>  
>  	of_property_read_string(node, "clock-output-names", &clk_name);
>  
> @@ -418,12 +419,15 @@ void of_divider_clk_setup(struct device_node *node)
>  	if (of_property_read_bool(node, "hiword-mask"))
>  		clk_divider_flags |= CLK_DIVIDER_HIWORD_MASK;
>  
> +	if (of_property_read_bool(node, "set-rate-parent"))
> +		flags |= CLK_SET_RATE_PARENT;
> +
>  	table = of_clk_get_div_table(node);
>  	if (IS_ERR(table))
>  		return;
>  
>  	clk = _register_divider(NULL, clk_name,
> -			parent_name, 0,
> +			parent_name, flags,
>  			reg, (u8) shift, mask,
>  			clk_divider_flags, table,
>  			NULL);
> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
> index 9ff7d51..30aa121 100644
> --- a/drivers/clk/clk-fixed-factor.c
> +++ b/drivers/clk/clk-fixed-factor.c
> @@ -107,6 +107,7 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
>  	const char *clk_name = node->name;
>  	const char *parent_name;
>  	u32 div, mult;
> +	u32 flags = 0;
>  
>  	if (of_property_read_u32(node, "clock-div", &div)) {
>  		pr_err("%s Fixed factor clock <%s> must have a clock-div property\n",
> @@ -123,7 +124,10 @@ void __init of_fixed_factor_clk_setup(struct device_node *node)
>  	of_property_read_string(node, "clock-output-names", &clk_name);
>  	parent_name = of_clk_get_parent_name(node, 0);
>  
> -	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, 0,
> +	if (of_property_read_bool(node, "set-rate-parent"))
> +		flags |= CLK_SET_RATE_PARENT;
> +
> +	clk = clk_register_fixed_factor(NULL, clk_name, parent_name, flags,
>  					mult, div);
>  	if (!IS_ERR(clk))
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> diff --git a/drivers/clk/clk-gate.c b/drivers/clk/clk-gate.c
> index cd595ec..0be25b9 100644
> --- a/drivers/clk/clk-gate.c
> +++ b/drivers/clk/clk-gate.c
> @@ -176,6 +176,7 @@ void of_gate_clk_setup(struct device_node *node)
>  	const char *parent_name;
>  	u8 clk_gate_flags = 0;
>  	u32 bit_idx = 0;
> +	u32 flags = 0;
>  
>  	of_property_read_string(node, "clock-output-names", &clk_name);
>  
> @@ -195,8 +196,11 @@ void of_gate_clk_setup(struct device_node *node)
>  	if (of_property_read_bool(node, "hiword-mask"))
>  		clk_gate_flags |= CLK_GATE_HIWORD_MASK;
>  
> -	clk = clk_register_gate(NULL, clk_name, parent_name, 0, reg, (u8) bit_idx,
> -			clk_gate_flags, NULL);
> +	if (of_property_read_bool(node, "set-rate-parent"))
> +		flags |= CLK_SET_RATE_PARENT;
> +
> +	clk = clk_register_gate(NULL, clk_name, parent_name, flags, reg,
> +			(u8) bit_idx, clk_gate_flags, NULL);
>  
>  	if (!IS_ERR(clk))
>  		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> diff --git a/drivers/clk/clk-mux.c b/drivers/clk/clk-mux.c
> index 4751bce..890ddbf 100644
> --- a/drivers/clk/clk-mux.c
> +++ b/drivers/clk/clk-mux.c
> @@ -184,6 +184,7 @@ void of_mux_clk_setup(struct device_node *node)
>  	u8 clk_mux_flags = 0;
>  	u32 mask = 0;
>  	u32 shift = 0;
> +	u32 flags = 0;
>  
>  	of_property_read_string(node, "clock-output-names", &clk_name);
>  
> @@ -219,8 +220,11 @@ void of_mux_clk_setup(struct device_node *node)
>  	if (of_property_read_bool(node, "hiword-mask"))
>  		clk_mux_flags |= CLK_MUX_HIWORD_MASK;
>  
> +	if (of_property_read_bool(node, "set-rate-parent"))
> +		flags |= CLK_SET_RATE_PARENT;
> +
>  	clk = clk_register_mux_table(NULL, clk_name, parent_names, num_parents,
> -			0, reg, (u8) shift, mask, clk_mux_flags,
> +			flags, reg, (u8) shift, mask, clk_mux_flags,
>  			NULL, NULL);
>  
>  	if (!IS_ERR(clk))
> -- 
> 1.7.9.5
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
