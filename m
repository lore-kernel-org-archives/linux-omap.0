From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Wed, 31 Jul 2013 12:46:32 +0300
Message-ID: <51F8DCF8.2040309@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-4-git-send-email-t-kristo@ti.com> <51F7E883.7000000@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F7E883.7000000@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nishanth Menon <nm@ti.com>
Cc: paul@pwsan.com, khilman@linaro.org, mturquette@linaro.org, tony@atomide.com, devicetree-discuss@lists.ozlabs.org, rnayak@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On 07/30/2013 07:23 PM, Nishanth Menon wrote:
> This patch probably was submitted in the wrong sequence - fails build
> and few other issues below.

Yeah, I'll double check the build sequence for these.

>
> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>> The OMAP clock driver now supports DPLL clock type. This patch also
>> adds support for DT DPLL nodes.
>
> Then why is $subject specific to OMAP4? is that because of
> of_omap4_dpll_setup?

The driver only supports omap4 dpll type at this point, omap3 dplls =

require some modifications on top of this, and are provided later in the =

series.

>
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   drivers/clk/omap/Makefile |    2 +-
>>   drivers/clk/omap/clk.c    |    1 +
>>   drivers/clk/omap/dpll.c   |  295
>> +++++++++++++++++++++++++++++++++++++++++++++
>
> Device Tree Binding documentation?

Didn't bother writing those yet as I haven't received too much feedback =

whether this approach is acceptable or not.

>
>>   3 files changed, 297 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clk/omap/dpll.c
>>
>> diff --git a/drivers/clk/omap/Makefile b/drivers/clk/omap/Makefile
>> index 8195931..4cad480 100644
>> --- a/drivers/clk/omap/Makefile
>> +++ b/drivers/clk/omap/Makefile
>> @@ -1 +1 @@
>> -obj-y                    +=3D clk.o
>> +obj-y                    +=3D clk.o dpll.o
>> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
>> index 4bf1929..1dafdaa 100644
>> --- a/drivers/clk/omap/clk.c
>> +++ b/drivers/clk/omap/clk.c
>> @@ -28,6 +28,7 @@ static const struct of_device_id clk_match[] =3D {
>>           .data =3D of_fixed_factor_clk_setup, },
>>       {.compatible =3D "divider-clock", .data =3D of_divider_clk_setup, =
},
>>       {.compatible =3D "gate-clock", .data =3D of_gate_clk_setup, },
>> +    {.compatible =3D "ti,omap4-dpll-clock", .data =3D
>> of_omap4_dpll_setup, },
>>       {},
>>   };
> you would not need this if you did just of_clk_init(NULL); ?

Why not? And I think we still need to do this.

>
> Further, at this patch, build fails with:
> drivers/clk/omap/clk.c:31:55: error: undefined identifier
> 'of_omap4_dpll_setup'
> drivers/clk/omap/clk.c:31:48: error: =91of_omap4_dpll_setup=92 undeclared
> here (not in a function)
>
> which makes sense since we did not export the function.

Yea seems like wrong ordering of patches, sorry about that. >.<

>>
>> diff --git a/drivers/clk/omap/dpll.c b/drivers/clk/omap/dpll.c
>> new file mode 100644
>> index 0000000..66e82be
>> --- /dev/null
>> +++ b/drivers/clk/omap/dpll.c
>> @@ -0,0 +1,295 @@
>> +/*
>> + * OMAP DPLL clock support
>> + *
>> + * Copyright (C) 2013 Texas Instruments, Inc.
>> + *
>> + * Tero Kristo <t-kristo@ti.com>
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
>> + * kind, whether express or implied; without even the implied warranty
>> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/io.h>
>> +#include <linux/err.h>
>> +#include <linux/string.h>
>> +#include <linux/log2.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
> after a quick check, are all these required?

Seems like some might not be needed, I'll double check this.

>
>> +#include <linux/clk/omap.h>
>
> why?

Need dpll_data definition for example.

>
>> +
>> +static const struct clk_ops dpll_m4xen_ck_ops =3D {
>> +    .enable        =3D &omap3_noncore_dpll_enable,
>> +    .disable    =3D &omap3_noncore_dpll_disable,
>> +    .recalc_rate    =3D &omap4_dpll_regm4xen_recalc,
>> +    .round_rate    =3D &omap4_dpll_regm4xen_round_rate,
>> +    .set_rate    =3D &omap3_noncore_dpll_set_rate,
>> +    .get_parent    =3D &omap2_init_dpll_parent,
>> +};
>> +
>> +static const struct clk_ops dpll_core_ck_ops =3D {
>> +    .recalc_rate    =3D &omap3_dpll_recalc,
>> +    .get_parent    =3D &omap2_init_dpll_parent,
>> +};
>> +
>> +static const struct clk_ops dpll_ck_ops =3D {
>> +    .enable        =3D &omap3_noncore_dpll_enable,
>> +    .disable    =3D &omap3_noncore_dpll_disable,
>> +    .recalc_rate    =3D &omap3_dpll_recalc,
>> +    .round_rate    =3D &omap2_dpll_round_rate,
>> +    .set_rate    =3D &omap3_noncore_dpll_set_rate,
>> +    .get_parent    =3D &omap2_init_dpll_parent,
>> +    .init        =3D &omap2_init_clk_clkdm,
>> +};
>> +
>> +static const struct clk_ops dpll_x2_ck_ops =3D {
>> +    .recalc_rate    =3D &omap3_clkoutx2_recalc,
>> +};
>
> none of these are defined at this stage of the patch, generates a huge
> build error for dpll.c
> http://pastebin.com/GJucv1A5

Yea, wrong ordering, linux/clk/omap.h is not up to date. I'll fix this =

and rest of the similar issues.

>> +
>> +struct clk *omap_clk_register_dpll(struct device *dev, const char *name,
>> +        const char **parent_names, int num_parents, unsigned long flags,
>> +        struct dpll_data *dpll_data, const char *clkdm_name,
>> +        const struct clk_ops *ops)
>
> why should this be public?

Currently does not need to be, but someone could in theory build up =

cclockXxxx_data.c file and use these calls from there. Kind of legacy =

support, see some of the basic clk types. I guess I can add static to =

this, and remove some of the params along.

>
>> +{
>> +    struct clk *clk;
>> +    struct clk_init_data init;
>
> init =3D { 0 };  just to future proof?

Good idea, i'll add this.

>
>> +    struct clk_hw_omap *clk_hw;
>
> does not exist yet in generic header?

Yea.

>
> I am assuming you do not do parameter check as you expect clk_register
> to do the same?

True, so I'll change the above function to static.

>
>> +
>> +    /* allocate the divider */
>> +    clk_hw =3D kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
> checkpatch complained:
> CHECK: Prefer kzalloc(sizeof(*clk_hw)...) over kzalloc(sizeof(struct
> clk_hw_omap)...)

Hmm, I didn't get this with checkpatch. Some special option/version you =

use? I still see both types of sizeof used in the kernel.

>
> or given we have dev, devm_kzalloc?

Actually we don't have dev, check how this is called from below.

>> +    if (!clk_hw) {
>> +        pr_err("%s: could not allocate clk_hw_omap\n", __func__);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    clk_hw->dpll_data =3D dpll_data;
>> +    clk_hw->ops =3D &clkhwops_omap3_dpll;
>> +    clk_hw->clkdm_name =3D clkdm_name;
>> +    clk_hw->hw.init =3D &init;
>> +
>> +    init.name =3D name;
>> +    init.ops =3D ops;
>> +    init.flags =3D flags;
>> +    init.parent_names =3D parent_names;
>> +    init.num_parents =3D num_parents;
>> +
>> +    /* register the clock */
>> +    clk =3D clk_register(dev, &clk_hw->hw);
>> +
>> +    if (IS_ERR(clk))
>> +        kfree(clk_hw);
>> +    else
>> +        omap2_init_clk_hw_omap_clocks(clk);
> what if init fails? and it is in mach-omap2 at this point in time?

Yea, this just calls the autoidle init part under mach-omap2.

>
>> +
>> +    return clk;
>> +}
>> +
>> +struct clk *omap_clk_register_dpll_x2(struct device *dev, const char
>> *name,
>> +        const char *parent_name, void __iomem *reg,
>> +        const struct clk_ops *ops)
>
> same question here as well

Yea, can change to static I think.

>
>> +{
>> +    struct clk *clk;
>> +    struct clk_init_data init;
>> +    struct clk_hw_omap *clk_hw;
>> +
>> +    if (!parent_name) {
>> +        pr_err("%s: dpll_x2 must have parent\n", __func__);
>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>> +    clk_hw =3D kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
> checkpatch complained:
> CHECK: Prefer kzalloc(sizeof(*clk_hw)...) over kzalloc(sizeof(struct
> clk_hw_omap)...)
>
> or devm_kzalloc?

Same as above.

>
>> +    if (!clk_hw) {
>> +        pr_err("%s: could not allocate clk_hw_omap\n", __func__);
>> +        return ERR_PTR(-ENOMEM);
>> +    }
>> +
>> +    clk_hw->ops =3D &clkhwops_omap4_dpllmx;
>> +    clk_hw->clksel_reg =3D reg;
>> +    clk_hw->hw.init =3D &init;
>> +
>> +    init.name =3D name;
>> +    init.ops =3D ops;
>> +    init.parent_names =3D &parent_name;
>> +    init.num_parents =3D 1;
>> +
>> +    /* register the clock */
>> +    clk =3D clk_register(dev, &clk_hw->hw);
>> +
>> +    if (IS_ERR(clk))
>> +        kfree(clk_hw);
>> +    else
>> +        omap2_init_clk_hw_omap_clocks(clk);
>> +
>> +    return clk;
>> +}
> this vaguely sounds like a replica of omap_clk_register_dpll with
> num_parents and clk_hw->ops different. why not merge the two?

Some of the params are different but yes, I'll see if I can merge the two.

>
>> +
>> +#ifdef CONFIG_OF
>
> why not build the entire thing *iff* CONFIG_OF (Makefile/Kconfig dep)?
> that way, we can drop this #ifdef stuff from drivers that dont need to
> have dual support.

Yea, I guess I can do this.

>
>> +
>> +/**
>> + * of_omap_dpll_setup() - Setup function for OMAP DPLL clocks
>
> node and ops not documented.

I'll add some beef here.

>
>> + */
>> +static void __init of_omap_dpll_setup(struct device_node *node,
>> +                    const struct clk_ops *ops)
>> +{
>> +    struct clk *clk;
>> +    const char *clk_name =3D node->name;
>> +    int num_parents;
>> +    const char **parent_names;
>> +    const char *clkdm_name =3D NULL;
>> +    struct of_phandle_args clkspec;
>> +    u8 dpll_flags =3D 0;
>> +    struct dpll_data *dd;
>> +    u32 idlest_mask =3D 0x1;
>> +    u32 enable_mask =3D 0x7;
>> +    u32 autoidle_mask =3D 0x7;
>> +    u32 mult_mask =3D 0x7ff << 8;
>> +    u32 div1_mask =3D 0x7f;
>> +    u32 max_multiplier =3D 2047;
>> +    u32 max_divider =3D 128;
>> +    u32 min_divider =3D 1;
>> +    int i;
>> +
>> +    dd =3D kzalloc(sizeof(struct dpll_data), GFP_KERNEL);
> kzalloc sizeof(*dd) ?

See above.

>
>> +    if (!dd) {
>> +        pr_err("%s: could not allocate dpll_data\n", __func__);
>> +        return;
>> +    }
>> +
>> +    of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +    num_parents =3D of_clk_get_parent_count(node);
>> +    if (num_parents < 1) {
>> +        pr_err("%s: omap dpll %s must have parent(s)\n",
>> +            __func__, node->name);
>
> checkpatch complained:
> CHECK: Alignment should match open parenthesis
> #212: FILE: drivers/clk/omap/dpll.c:171:
> After applying the patch, I think you should make __func__ aligned with
> " and not %

Again, what version of checkpatch you use? Or what flags?

>
>> +        goto cleanup;
>> +    }
>> +
>> +    parent_names =3D kzalloc(sizeof(char *) * num_parents, GFP_KERNEL);
>> +
>> +    for (i =3D 0; i < num_parents; i++)
>> +        parent_names[i] =3D of_clk_get_parent_name(node, i);
>> +
>> +    of_property_read_u32(node, "ti,idlest-mask", &idlest_mask);
>> +
>> +    of_property_read_u32(node, "ti,enable-mask", &enable_mask);
>> +
>> +    of_property_read_u32(node, "ti,autoidle-mask", &autoidle_mask);
>
> are these going to be different? or can we catch with compatible flag?

For example, omap3 dpll4:

dpll4_ck: dpll4_ck@48004d00 {
         ti,autoidle-mask =3D <0x38>;
         ti,idlest-mask =3D <0x2>;
         ti,enable-mask =3D <0x70000>;
};

It seems that currently we can catch all cases with the =

ti,dpll-peripheral flag. I'll modify the code accordingly.


>
>> +
>> +    clkspec.np =3D of_parse_phandle(node, "ti,clk-ref", 0);
>> +    dd->clk_ref =3D of_clk_get_from_provider(&clkspec);
>> +    if (!dd->clk_ref) {
>> +        pr_err("%s: ti,clk-ref for %s not found\n", __func__,
>> +            clk_name);
>
> CHECK: Alignment should match open parenthesis
> #231: FILE: drivers/clk/omap/dpll.c:190:
> similar issue here.
>
>> +        goto cleanup;
>> +    }
>> +
>> +    clkspec.np =3D of_parse_phandle(node, "ti,clk-bypass", 0);
>> +    dd->clk_bypass =3D of_clk_get_from_provider(&clkspec);
>> +    if (!dd->clk_bypass) {
>> +        pr_err("%s: ti,clk-bypass for %s not found\n", __func__,
>> +            clk_name);
>
> here as well
>
>> +        goto cleanup;
>> +    }
>> +
>> +    of_property_read_string(node, "ti,clkdm-name", &clkdm_name);
>> +
>> +    dd->control_reg =3D of_iomap(node, 0);
>> +    dd->idlest_reg =3D of_iomap(node, 1);
>> +    dd->autoidle_reg =3D of_iomap(node, 2);
>> +    dd->mult_div1_reg =3D of_iomap(node, 3);
>
> if dts has errors, should we not verify mandatory parameters?
>
>> +
>> +    dd->idlest_mask =3D idlest_mask;
>> +    dd->enable_mask =3D enable_mask;
>> +    dd->autoidle_mask =3D autoidle_mask;
>> +
>> +    dd->modes =3D 0xa0;
>
> what is 0xa0?

Magic mode. :) I'll copy paste a macro for this.

>
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-j-type")) {
>> +        dd->sddiv_mask =3D 0xff000000;
>> +        mult_mask =3D 0xfff << 8;
>> +        div1_mask =3D 0xff;
>> +        max_multiplier =3D 4095;
>> +        max_divider =3D 256;
>> +    }
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-regm4xen")) {
> I think we need bindings to understand this better.

Or documentation you mean?

>
>> +        dd->m4xen_mask =3D 0x800;
>> +        dd->lpmode_mask =3D 1 << 10;
>> +    }
>> +
>> +    dd->mult_mask =3D mult_mask;
>> +    dd->div1_mask =3D div1_mask;
>> +    dd->max_multiplier =3D max_multiplier;
>> +    dd->max_divider =3D max_divider;
>> +    dd->min_divider =3D min_divider;
>> +
>> +    clk =3D omap_clk_register_dpll(NULL, clk_name, parent_names,
>> +                num_parents, dpll_flags, dd,
>> +                clkdm_name, ops);
>> +
>> +    if (!IS_ERR(clk))
>> +        of_clk_add_provider(node, of_clk_src_simple_get, clk);
> error check?

This is not done with other drivers either. Would require clk_unregister =

use to cleanup the above register call which is currently unavailable. I =

could add an error trace for this though.

>> +    return;
>> +
>> +cleanup:
>
> kfree(parent_names) ?

Hmm yea.

>
>> +    kfree(dd);
>> +    return;
>> +}
>> +
>> +static void __init of_omap_dpll_x2_setup(struct device_node *node)
>> +{
>> +    struct clk *clk;
>> +    const char *clk_name =3D node->name;
>> +    void __iomem *reg;
>> +    const char *parent_name;
>> +
>> +    of_property_read_string(node, "clock-output-names", &clk_name);
>> +
>> +    parent_name =3D of_clk_get_parent_name(node, 0);
>> +
>> +    reg =3D of_iomap(node, 0);
>
> if dts has errors, should we not verify mandatory parameters?

You mean checking the validity of this pointer? It seems of_iomap does =

something strange when it fails, e.g. when passed a 0x0 from DT. You can =

see what I do in a later patch for adding am335x support for DPLLs.

>
>> +
>> +    clk =3D omap_clk_register_dpll_x2(NULL, clk_name, parent_name,
>> +                reg, &dpll_x2_ck_ops);
>> +
>> +    if (!IS_ERR(clk))
>> +        of_clk_add_provider(node, of_clk_src_simple_get, clk);
> error check?
>
> gentle request - in this setup function we dont see a return of error
> value (which makes sense), but more importantly - log saying that node
> was not setup

Yea, I can add error prints.

>
>> +}
>> +
>> +__init void of_omap3_dpll_setup(struct device_node *node)
>
> ^^ void __init? further, you could make this static.

Ok.

>
>> +{
>> +    /* XXX: to be done */
>> +}
>> +EXPORT_SYMBOL_GPL(of_omap3_dpll_setup);
>
> you can drop the export if you use of_clk_init(NULL);

Same comment as earlier.

>
>> +CLK_OF_DECLARE(omap3_dpll_clock, "ti,omap3-dpll-clock",
>> of_omap3_dpll_setup);
>> +
>> +__init void of_omap4_dpll_setup(struct device_node *node)
>
> ^^ void __init? further, you could make this static.

Ok.

>
>> +{
>> +    const struct clk_ops *ops;
>> +
>> +    ops =3D &dpll_ck_ops;
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-regm4xen"))
>> +        ops =3D &dpll_m4xen_ck_ops;
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-core"))
>> +        ops =3D &dpll_core_ck_ops;
>> +
>> +    if (of_property_read_bool(node, "ti,dpll-clk-x2")) {
>> +        of_omap_dpll_x2_setup(node);
>> +        return;
>> +    }
>> +
>> +    of_omap_dpll_setup(node, ops);
>> +}
>> +EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>
> you can drop the export if you use of_clk_init(NULL);

Hmm no?

Actually dug this further, I think the init setup is slightly wrong at =

the moment, we should not do CLK_OF_DECLARE at all within the omap =

specific clock drivers, but instead just use the match table from clk.c. =

I'll change it like so.

>
>> +CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock",
>> of_omap4_dpll_setup);

So, for example this should be removed. We don't want to support this =

clock type on non-omap platforms just to avoid problems.

>> +#endif
>>
