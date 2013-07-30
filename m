From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Tue, 30 Jul 2013 11:23:31 -0500
Message-ID: <51F7E883.7000000@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-4-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1374564028-11352-4-git-send-email-t-kristo@ti.com>
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

This patch probably was submitted in the wrong sequence - fails build =

and few other issues below.

On 07/23/2013 02:19 AM, Tero Kristo wrote:
> The OMAP clock driver now supports DPLL clock type. This patch also
> adds support for DT DPLL nodes.

Then why is $subject specific to OMAP4? is that because of =

of_omap4_dpll_setup?

>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>   drivers/clk/omap/Makefile |    2 +-
>   drivers/clk/omap/clk.c    |    1 +
>   drivers/clk/omap/dpll.c   |  295 ++++++++++++++++++++++++++++++++++++++=
+++++++

Device Tree Binding documentation?

>   3 files changed, 297 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/clk/omap/dpll.c
>
> diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
> index 8195931..4cad480 100644
> --- a/drivers/clk/omap/Makefile
> +++ b/drivers/clk/omap/Makefile
> @@ -1 +1 @@
> -obj-y					+=3D clk.o
> +obj-y					+=3D clk.o dpll.o
> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
> index 4bf1929..1dafdaa 100644
> --- a/drivers/clk/omap/clk.c
> +++ b/drivers/clk/omap/clk.c
> @@ -28,6 +28,7 @@ static const struct of_device_id clk_match[] =3D {
>   		.data =3D of_fixed_factor_clk_setup, },
>   	{.compatible =3D "divider-clock", .data =3D of_divider_clk_setup, },
>   	{.compatible =3D "gate-clock", .data =3D of_gate_clk_setup, },
> +	{.compatible =3D "ti,omap4-dpll-clock", .data =3D of_omap4_dpll_setup, =
},
>   	{},
>   };
you would not need this if you did just of_clk_init(NULL); ?

Further, at this patch, build fails with:
drivers/clk/omap/clk.c:31:55: error: undefined identifier =

'of_omap4_dpll_setup'
drivers/clk/omap/clk.c:31:48: error: =91of_omap4_dpll_setup=92 undeclared =

here (not in a function)

which makes sense since we did not export the function.	=

>
> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
> new file mode 100644
> index 0000000..66e82be
> --- /dev/null
> +++ b/drivers/clk/omap/dpll.c
> @@ -0,0 +1,295 @@
> +/*
> + * OMAP DPLL clock support
> + *
> + * Copyright (C) 2013 Texas Instruments, Inc.
> + *
> + * Tero Kristo <t-kristo@ti.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/clk-provider.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/io.h>
> +#include <linux/err.h>
> +#include <linux/string.h>
> +#include <linux/log2.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
after a quick check, are all these required?

> +#include <linux/clk/omap.h>

why?

> +
> +static const struct clk_ops dpll_m4xen_ck_ops =3D {
> +	.enable		=3D &omap3_noncore_dpll_enable,
> +	.disable	=3D &omap3_noncore_dpll_disable,
> +	.recalc_rate	=3D &omap4_dpll_regm4xen_recalc,
> +	.round_rate	=3D &omap4_dpll_regm4xen_round_rate,
> +	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> +	.get_parent	=3D &omap2_init_dpll_parent,
> +};
> +
> +static const struct clk_ops dpll_core_ck_ops =3D {
> +	.recalc_rate	=3D &omap3_dpll_recalc,
> +	.get_parent	=3D &omap2_init_dpll_parent,
> +};
> +
> +static const struct clk_ops dpll_ck_ops =3D {
> +	.enable		=3D &omap3_noncore_dpll_enable,
> +	.disable	=3D &omap3_noncore_dpll_disable,
> +	.recalc_rate	=3D &omap3_dpll_recalc,
> +	.round_rate	=3D &omap2_dpll_round_rate,
> +	.set_rate	=3D &omap3_noncore_dpll_set_rate,
> +	.get_parent	=3D &omap2_init_dpll_parent,
> +	.init		=3D &omap2_init_clk_clkdm,
> +};
> +
> +static const struct clk_ops dpll_x2_ck_ops =3D {
> +	.recalc_rate	=3D &omap3_clkoutx2_recalc,
> +};

none of these are defined at this stage of the patch, generates a huge =

build error for dpll.c
http://pastebin.com/GJucv1A5
> +
> +struct clk *omap_clk_register_dpll(struct device *dev, const char *name,
> +		const char **parent_names, int num_parents, unsigned long flags,
> +		struct dpll_data *dpll_data, const char *clkdm_name,
> +		const struct clk_ops *ops)

why should this be public?

> +{
> +	struct clk *clk;
> +	struct clk_init_data init;

init =3D { 0 };  just to future proof?

> +	struct clk_hw_omap *clk_hw;

does not exist yet in generic header?

I am assuming you do not do parameter check as you expect clk_register =

to do the same?

> +
> +	/* allocate the divider */
> +	clk_hw =3D kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
checkpatch complained:
CHECK: Prefer kzalloc(sizeof(*clk_hw)...) over kzalloc(sizeof(struct =

clk_hw_omap)...)

or given we have dev, devm_kzalloc?
> +	if (!clk_hw) {
> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	clk_hw->dpll_data =3D dpll_data;
> +	clk_hw->ops =3D &clkhwops_omap3_dpll;
> +	clk_hw->clkdm_name =3D clkdm_name;
> +	clk_hw->hw.init =3D &init;
> +
> +	init.name =3D name;
> +	init.ops =3D ops;
> +	init.flags =3D flags;
> +	init.parent_names =3D parent_names;
> +	init.num_parents =3D num_parents;
> +
> +	/* register the clock */
> +	clk =3D clk_register(dev, &clk_hw->hw);
> +
> +	if (IS_ERR(clk))
> +		kfree(clk_hw);
> +	else
> +		omap2_init_clk_hw_omap_clocks(clk);
what if init fails? and it is in mach-omap2 at this point in time?

> +
> +	return clk;
> +}
> +
> +struct clk *omap_clk_register_dpll_x2(struct device *dev, const char *na=
me,
> +		const char *parent_name, void __iomem *reg,
> +		const struct clk_ops *ops)

same question here as well

> +{
> +	struct clk *clk;
> +	struct clk_init_data init;
> +	struct clk_hw_omap *clk_hw;
> +
> +	if (!parent_name) {
> +		pr_err("%s: dpll_x2 must have parent\n", __func__);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	clk_hw =3D kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
checkpatch complained:
CHECK: Prefer kzalloc(sizeof(*clk_hw)...) over kzalloc(sizeof(struct =

clk_hw_omap)...)

or devm_kzalloc?

> +	if (!clk_hw) {
> +		pr_err("%s: could not allocate clk_hw_omap\n", __func__);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	clk_hw->ops =3D &clkhwops_omap4_dpllmx;
> +	clk_hw->clksel_reg =3D reg;
> +	clk_hw->hw.init =3D &init;
> +
> +	init.name =3D name;
> +	init.ops =3D ops;
> +	init.parent_names =3D &parent_name;
> +	init.num_parents =3D 1;
> +
> +	/* register the clock */
> +	clk =3D clk_register(dev, &clk_hw->hw);
> +
> +	if (IS_ERR(clk))
> +		kfree(clk_hw);
> +	else
> +		omap2_init_clk_hw_omap_clocks(clk);
> +
> +	return clk;
> +}
this vaguely sounds like a replica of omap_clk_register_dpll with =

num_parents and clk_hw->ops different. why not merge the two?

> +
> +#ifdef CONFIG_OF

why not build the entire thing *iff* CONFIG_OF (Makefile/Kconfig dep)? =

that way, we can drop this #ifdef stuff from drivers that dont need to =

have dual support.

> +
> +/**
> + * of_omap_dpll_setup() - Setup function for OMAP DPLL clocks

node and ops not documented.

> + */
> +static void __init of_omap_dpll_setup(struct device_node *node,
> +					const struct clk_ops *ops)
> +{
> +	struct clk *clk;
> +	const char *clk_name =3D node->name;
> +	int num_parents;
> +	const char **parent_names;
> +	const char *clkdm_name =3D NULL;
> +	struct of_phandle_args clkspec;
> +	u8 dpll_flags =3D 0;
> +	struct dpll_data *dd;
> +	u32 idlest_mask =3D 0x1;
> +	u32 enable_mask =3D 0x7;
> +	u32 autoidle_mask =3D 0x7;
> +	u32 mult_mask =3D 0x7ff << 8;
> +	u32 div1_mask =3D 0x7f;
> +	u32 max_multiplier =3D 2047;
> +	u32 max_divider =3D 128;
> +	u32 min_divider =3D 1;
> +	int i;
> +
> +	dd =3D kzalloc(sizeof(struct dpll_data), GFP_KERNEL);
kzalloc sizeof(*dd) ?

> +	if (!dd) {
> +		pr_err("%s: could not allocate dpll_data\n", __func__);
> +		return;
> +	}
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	num_parents =3D of_clk_get_parent_count(node);
> +	if (num_parents < 1) {
> +		pr_err("%s: omap dpll %s must have parent(s)\n",
> +			__func__, node->name);

checkpatch complained:
CHECK: Alignment should match open parenthesis
#212: FILE: drivers/clk/omap/dpll.c:171:
After applying the patch, I think you should make __func__ aligned with =

" and not %

> +		goto cleanup;
> +	}
> +
> +	parent_names =3D kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
> +
> +	for (i =3D 0; i < num_parents; i++)
> +		parent_names[i] =3D of_clk_get_parent_name(node, i);
> +
> +	of_property_read_u32(node, "ti,idlest-mask", &idlest_mask);
> +
> +	of_property_read_u32(node, "ti,enable-mask", &enable_mask);
> +
> +	of_property_read_u32(node, "ti,autoidle-mask", &autoidle_mask);

are these going to be different? or can we catch with compatible flag?

> +
> +	clkspec.np =3D of_parse_phandle(node, "ti,clk-ref", 0);
> +	dd->clk_ref =3D of_clk_get_from_provider(&clkspec);
> +	if (!dd->clk_ref) {
> +		pr_err("%s: ti,clk-ref for %s not found\n", __func__,
> +			clk_name);

CHECK: Alignment should match open parenthesis
#231: FILE: drivers/clk/omap/dpll.c:190:
similar issue here.

> +		goto cleanup;
> +	}
> +
> +	clkspec.np =3D of_parse_phandle(node, "ti,clk-bypass", 0);
> +	dd->clk_bypass =3D of_clk_get_from_provider(&clkspec);
> +	if (!dd->clk_bypass) {
> +		pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
> +			clk_name);

here as well

> +		goto cleanup;
> +	}
> +
> +	of_property_read_string(node, "ti,clkdm-name", &clkdm_name);
> +
> +	dd->control_reg =3D of_iomap(node, 0);
> +	dd->idlest_reg =3D of_iomap(node, 1);
> +	dd->autoidle_reg =3D of_iomap(node, 2);
> +	dd->mult_div1_reg =3D of_iomap(node, 3);

if dts has errors, should we not verify mandatory parameters?

> +
> +	dd->idlest_mask =3D idlest_mask;
> +	dd->enable_mask =3D enable_mask;
> +	dd->autoidle_mask =3D autoidle_mask;
> +
> +	dd->modes =3D 0xa0;

what is 0xa0?

> +
> +	if (of_property_read_bool(node, "ti,dpll-j-type")) {
> +		dd->sddiv_mask =3D 0xff000000;
> +		mult_mask =3D 0xfff << 8;
> +		div1_mask =3D 0xff;
> +		max_multiplier =3D 4095;
> +		max_divider =3D 256;
> +	}
> +
> +	if (of_property_read_bool(node, "ti,dpll-regm4xen")) {
I think we need bindings to understand this better.

> +		dd->m4xen_mask =3D 0x800;
> +		dd->lpmode_mask =3D 1 << 10;
> +	}
> +
> +	dd->mult_mask =3D mult_mask;
> +	dd->div1_mask =3D div1_mask;
> +	dd->max_multiplier =3D max_multiplier;
> +	dd->max_divider =3D max_divider;
> +	dd->min_divider =3D min_divider;
> +
> +	clk =3D omap_clk_register_dpll(NULL, clk_name, parent_names,
> +				num_parents, dpll_flags, dd,
> +				clkdm_name, ops);
> +
> +	if (!IS_ERR(clk))
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
error check?
> +	return;
> +
> +cleanup:

kfree(parent_names) ?

> +	kfree(dd);
> +	return;
> +}
> +
> +static void __init of_omap_dpll_x2_setup(struct device_node *node)
> +{
> +	struct clk *clk;
> +	const char *clk_name =3D node->name;
> +	void __iomem *reg;
> +	const char *parent_name;
> +
> +	of_property_read_string(node, "clock-output-names", &clk_name);
> +
> +	parent_name =3D of_clk_get_parent_name(node, 0);
> +
> +	reg =3D of_iomap(node, 0);

if dts has errors, should we not verify mandatory parameters?

> +
> +	clk =3D omap_clk_register_dpll_x2(NULL, clk_name, parent_name,
> +				reg, &dpll_x2_ck_ops);
> +
> +	if (!IS_ERR(clk))
> +		of_clk_add_provider(node, of_clk_src_simple_get, clk);
error check?

gentle request - in this setup function we dont see a return of error =

value (which makes sense), but more importantly - log saying that node =

was not setup

> +}
> +
> +__init void of_omap3_dpll_setup(struct device_node *node)

^^ void __init? further, you could make this static.

> +{
> +	/* XXX: to be done */
> +}
> +EXPORT_SYMBOL_GPL(of_omap3_dpll_setup);

you can drop the export if you use of_clk_init(NULL);

> +CLK_OF_DECLARE(omap3_dpll_clock, "ti,omap3-dpll-clock", of_omap3_dpll_se=
tup);
> +
> +__init void of_omap4_dpll_setup(struct device_node *node)

^^ void __init? further, you could make this static.

> +{
> +	const struct clk_ops *ops;
> +
> +	ops =3D &dpll_ck_ops;
> +
> +	if (of_property_read_bool(node, "ti,dpll-regm4xen"))
> +		ops =3D &dpll_m4xen_ck_ops;
> +
> +	if (of_property_read_bool(node, "ti,dpll-core"))
> +		ops =3D &dpll_core_ck_ops;
> +
> +	if (of_property_read_bool(node, "ti,dpll-clk-x2")) {
> +		of_omap_dpll_x2_setup(node);
> +		return;
> +	}
> +
> +	of_omap_dpll_setup(node, ops);
> +}
> +EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);

you can drop the export if you use of_clk_init(NULL);

> +CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock", of_omap4_dpll_se=
tup);
> +#endif
>
-- =

Regards,
Nishanth Menon
