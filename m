From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 15/33] CLK: OMAP: DPLL: add support for DT property
 ti,dpll-no-gate
Date: Tue, 30 Jul 2013 14:18:39 -0500
Message-ID: <51F8118F.3000104@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-16-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374564028-11352-16-git-send-email-t-kristo@ti.com>
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
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/23/2013 02:20 AM, Tero Kristo wrote:
> AM335x has DPLL clocks that should never be attempted to be gated. Adding
> ti,dpll-no-gate property for them handles this situation.
>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   drivers/clk/omap/dpll.c |   10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
> index 66e82be..1d24feada 100644
> --- a/drivers/clk/omap/dpll.c
> +++ b/drivers/clk/omap/dpll.c
> @@ -54,6 +54,13 @@ static const struct clk_ops dpll_x2_ck_ops = {
>   	.recalc_rate	= &omap3_clkoutx2_recalc,
>   };
>
> +static const struct clk_ops dpll_no_gate_ck_ops = {
> +	.recalc_rate	= &omap3_dpll_recalc,
> +	.get_parent	= &omap2_init_dpll_parent,
> +	.round_rate	= &omap2_dpll_round_rate,
> +	.set_rate	= &omap3_noncore_dpll_set_rate,
> +};
> +
>   struct clk *omap_clk_register_dpll(struct device *dev, const char *name,
>   		const char **parent_names, int num_parents, unsigned long flags,
>   		struct dpll_data *dpll_data, const char *clkdm_name,
> @@ -288,6 +295,9 @@ __init void of_omap4_dpll_setup(struct device_node *node)
>   		return;
>   	}
>
> +	if (of_property_read_bool(node, "ti,dpll-no-gate"))
> +		ops = &dpll_no_gate_ck_ops;
> +
>   	of_omap_dpll_setup(node, ops);
>   }
>   EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>
squash this to dpll patch?

-- 
Regards,
Nishanth Menon
