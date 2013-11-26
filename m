From: Alexander Aring <alex.aring@gmail.com>
Subject: Re: [PATCHv10 15/41] CLK: TI: DRA7: Add APLL support
Date: Tue, 26 Nov 2013 09:51:29 +0100
Message-ID: <20131126085128.GA19357@omega>
References: <1385453182-24421-1-git-send-email-t-kristo@ti.com>
 <1385453182-24421-16-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-wi0-f177.google.com ([209.85.212.177]:62531 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751356Ab3KZIvj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 26 Nov 2013 03:51:39 -0500
Content-Disposition: inline
In-Reply-To: <1385453182-24421-16-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tero Kristo <t-kristo@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, J Keerthy <j-keerthy@ti.com>

Hi,

On Tue, Nov 26, 2013 at 10:05:56AM +0200, Tero Kristo wrote:
> From: J Keerthy <j-keerthy@ti.com>
> 
> The patch adds support for DRA7 PCIe APLL. The APLL
> sources the optional functional clocks for PCIe module.
> 
> APLL stands for Analog PLL. This is different when comapred
> with DPLL meaning Digital PLL, the phase detection is done
> using an analog circuit.
> 
> Signed-off-by: J Keerthy <j-keerthy@ti.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/clock/ti/apll.txt          |   31 +++
>  drivers/clk/ti/Makefile                            |    2 +-
>  drivers/clk/ti/apll.c                              |  239 ++++++++++++++++++++
>  3 files changed, 271 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/apll.txt
>  create mode 100644 drivers/clk/ti/apll.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/apll.txt b/Documentation/devicetree/bindings/clock/ti/apll.txt
> new file mode 100644
> index 0000000..7faf5a6
...
> +
> +static int __init of_dra7_apll_setup(struct device_node *node)
> +{
> +	const struct clk_ops *ops;
> +	struct clk *clk;
> +	const char *clk_name = node->name;
> +	int num_parents;
> +	const char **parent_names = NULL;
> +	u8 apll_flags = 0;
> +	struct dpll_data *ad;
> +	u32 idlest_mask = 0x1;
> +	u32 autoidle_mask = 0x3;
> +	int i;
> +	int ret;
> +
> +	ops = &apll_ck_ops;
> +	ad = kzalloc(sizeof(*ad), GFP_KERNEL);
> +	if (!ad)
> +		return -ENOMEM;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	num_parents = of_clk_get_parent_count(node);
> +	if (num_parents < 1) {
> +		pr_err("dra7 apll %s must have parent(s)\n", node->name);
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	parent_names = kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
> +
> +	for (i = 0; i < num_parents; i++)
> +		parent_names[i] = of_clk_get_parent_name(node, i);
> +
> +	ad->clk_ref = of_clk_get(node, 0);
> +	ad->clk_bypass = of_clk_get(node, 1);
> +
> +	if (IS_ERR(ad->clk_ref)) {
> +		pr_debug("ti,clk-ref for %s not found\n", clk_name);
> +		ret = -EAGAIN;
> +		goto cleanup;
> +	}
> +
> +	if (IS_ERR(ad->clk_bypass)) {
> +		pr_debug("ti,clk-bypass for %s not found\n", clk_name);
> +		ret = -EAGAIN;
> +		goto cleanup;
> +	}
> +
> +	ad->control_reg = ti_clk_get_reg_addr(node, 0);
> +	ad->idlest_reg = ti_clk_get_reg_addr(node, 1);
> +
> +	if (!ad->control_reg || !ad->idlest_reg) {
> +		ret = -EINVAL;
> +		goto cleanup;
> +	}
> +
> +	ad->idlest_mask = idlest_mask;
> +	ad->enable_mask = autoidle_mask;
> +
> +	clk = omap_clk_register_apll(NULL, clk_name, parent_names,
> +				num_parents, apll_flags, ad,
> +				NULL, ops);
> +
> +	if (!IS_ERR(clk)) {
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
> +		return 0;
> +	}
> +

Should we not also here do a cleanup for allocated memory?

> +	return PTR_ERR(clk);
> +
> +cleanup:
> +	kfree(parent_names);
> +	kfree(ad);
> +	return ret;
> +}
> +CLK_OF_DECLARE(dra7_apll_clock, "ti,dra7-apll-clock", of_dra7_apll_setup);

- Alex
