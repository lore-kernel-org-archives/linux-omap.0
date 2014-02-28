From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 05/12] CLK: TI: APLL: add support for omap2 aplls
Date: Fri, 28 Feb 2014 13:14:59 -0600
Message-ID: <5310E033.3000900@ti.com>
References: <1393579384-23440-1-git-send-email-t-kristo@ti.com>
 <1393579384-23440-6-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1393579384-23440-6-git-send-email-t-kristo@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tero Kristo <t-kristo@ti.com>, linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, mturquette@linaro.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 02/28/2014 03:22 AM, Tero Kristo wrote:
[...]
> +static void __init of_omap2_apll_setup(struct device_node *node)
> +{
> +	struct dpll_data *ad = NULL;
> +	struct clk_hw_omap *clk_hw = NULL;
> +	struct clk_init_data *init = NULL;
> +	struct clk *clk;
> +	const char *parent_name;
> +	u32 val;
> +
> +	ad = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> +	clk_hw = kzalloc(sizeof(*clk_hw), GFP_KERNEL);
> +	init = kzalloc(sizeof(*init), GFP_KERNEL);
> +
> +	if (!ad || !clk_hw || !init)
> +		goto cleanup;
> +
> +	clk_hw->dpll_data = ad;
> +	clk_hw->hw.init = init;
> +	init->ops = &omap2_apll_ops;
> +	init->name = node->name;
> +	clk_hw->ops = &omap2_apll_hwops;
> +
> +	init->num_parents = of_clk_get_parent_count(node);
> +	if (init->num_parents != 1) {
> +		pr_err("%s must have one parent\n", node->name);
> +		goto cleanup;
> +	}
> +
> +	parent_name = of_clk_get_parent_name(node, 0);
> +	init->parent_names = &parent_name;
> +
> +	if (of_property_read_u32(node, "ti,clock-frequency", &val)) {
> +		pr_err("%s missing clock-frequency\n", node->name);
> +		goto cleanup;
> +	}
> +	clk_hw->fixed_rate = val;
> +
> +	if (of_property_read_u32(node, "ti,bit-shift", &val)) {
> +		pr_err("%s missing bit-shift\n", node->name);
> +		goto cleanup;
> +	}
> +
> +	clk_hw->enable_bit = val;
> +	ad->enable_mask = 0x3 << val;
> +	ad->autoidle_mask = 0x3 << val;
> +
> +	if (of_property_read_u32(node, "ti,idlest-shift", &val)) {
> +		pr_err("%s missing idlest-shift\n", node->name);
> +		goto cleanup;
> +	}
> +
> +	ad->idlest_mask = 1 << val;
> +
> +	ad->control_reg = ti_clk_get_reg_addr(node, 0);
> +	ad->autoidle_reg = ti_clk_get_reg_addr(node, 1);
> +	ad->idlest_reg = ti_clk_get_reg_addr(node, 2);
> +
> +	if (!ad->control_reg || !ad->autoidle_reg || !ad->idlest_reg)
> +		goto cleanup;
> +
> +	clk = clk_register(NULL, &clk_hw->hw);
> +	if (!IS_ERR(clk)) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		kfree(init);
> +		return;
> +	}
> +cleanup:
> +	kfree(clk_hw);
> +	kfree(init);
kfree(ad)?

smatch reported (as part of the kernel_patch_verify_report:
+drivers/clk/ti/apll.c:400 of_omap2_apll_setup() warn: possible memory
leak of 'ad'

-- 
Regards,
Nishanth Menon
