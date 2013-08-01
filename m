From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCHv4 03/33] CLK: OMAP4: Add DPLL clock support
Date: Thu, 1 Aug 2013 09:00:08 -0500
Message-ID: <51FA69E8.8000000@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-4-git-send-email-t-kristo@ti.com> <51F7E883.7000000@ti.com>
 <51F8DCF8.2040309@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F8DCF8.2040309@ti.com>
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

On 07/31/2013 04:46 AM, Tero Kristo wrote:
> On 07/30/2013 07:23 PM, Nishanth Menon wrote:
>> This patch probably was submitted in the wrong sequence - fails build
>> and few other issues below.
>
> Yeah, I'll double check the build sequence for these.
>
>>
>> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>>> The OMAP clock driver now supports DPLL clock type. This patch also
>>> adds support for DT DPLL nodes.
>>
>> Then why is $subject specific to OMAP4? is that because of
>> of_omap4_dpll_setup?
>
> The driver only supports omap4 dpll type at this point, omap3 dplls
> require some modifications on top of this, and are provided later in the
> series.

ok.

>
>>
>>>
>>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>>> ---
>>>   drivers/clk/omap/Makefile |    2 +-
>>>   drivers/clk/omap/clk.c    |    1 +
>>>   drivers/clk/omap/dpll.c   |  295
>>> +++++++++++++++++++++++++++++++++++++++++++++
>>
>> Device Tree Binding documentation?
>
> Didn't bother writing those yet as I haven't received too much feedback
> whether this approach is acceptable or not.

Documentation helps simplify the understanding of expected usage - this 
is useful to review approach as well :)

>>> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
>>> index 4bf1929..1dafdaa 100644
>>> --- a/drivers/clk/omap/clk.c
>>> +++ b/drivers/clk/omap/clk.c
>>> @@ -28,6 +28,7 @@ static const struct of_device_id clk_match[] = {
>>>           .data = of_fixed_factor_clk_setup, },
>>>       {.compatible = "divider-clock", .data = of_divider_clk_setup, },
>>>       {.compatible = "gate-clock", .data = of_gate_clk_setup, },
>>> +    {.compatible = "ti,omap4-dpll-clock", .data =
>>> of_omap4_dpll_setup, },
>>>       {},
>>>   };
>> you would not need this if you did just of_clk_init(NULL); ?
>
> Why not? And I think we still need to do this.

CLK_OF_DECLARE will take care of having all required clks registered 
of_clk_init(NULL); will pick up from that list.

that will remove all extra exports, and make clk.c redundant.
[...]

>
>>
>>> +#include <linux/clk/omap.h>
>>
>> why?
>
> Need dpll_data definition for example.
OK - without the ordering of patches, it was not obvious. structures aside,

We should move the functions to this file instead and empty out 
mach-omap2 gradually, omap_dpll.h should be exported and used by 
mach-omap2, rather than the other way around.

>>> +
>>> +struct clk *omap_clk_register_dpll(struct device *dev, const char
>>> *name,
>>> +        const char **parent_names, int num_parents, unsigned long
>>> flags,
>>> +        struct dpll_data *dpll_data, const char *clkdm_name,
>>> +        const struct clk_ops *ops)
>>
>> why should this be public?
>
> Currently does not need to be, but someone could in theory build up
> cclockXxxx_data.c file and use these calls from there. Kind of legacy
> support, see some of the basic clk types. I guess I can add static to
> this, and remove some of the params along.
>

thanks. we should keep unneeded stuff in static unless a specific 
provable need really arises.

>>
>> I am assuming you do not do parameter check as you expect clk_register
>> to do the same?
>
> True, so I'll change the above function to static.
>
>>
>>> +
>>> +    /* allocate the divider */
>>> +    clk_hw = kzalloc(sizeof(struct clk_hw_omap), GFP_KERNEL);
>> checkpatch complained:
>> CHECK: Prefer kzalloc(sizeof(*clk_hw)...) over kzalloc(sizeof(struct
>> clk_hw_omap)...)
>
> Hmm, I didn't get this with checkpatch. Some special option/version you
> use? I still see both types of sizeof used in the kernel.
use checkpatch with --strict option

>
>>
>> or given we have dev, devm_kzalloc?
>
> Actually we don't have dev, check how this is called from below.

ok.

>
>>> +    if (!clk_hw) {
>>> +        pr_err("%s: could not allocate clk_hw_omap\n", __func__);
>>> +        return ERR_PTR(-ENOMEM);
>>> +    }
>>> +
>>> +    clk_hw->dpll_data = dpll_data;
>>> +    clk_hw->ops = &clkhwops_omap3_dpll;
>>> +    clk_hw->clkdm_name = clkdm_name;
>>> +    clk_hw->hw.init = &init;
>>> +
>>> +    init.name = name;
>>> +    init.ops = ops;
>>> +    init.flags = flags;
>>> +    init.parent_names = parent_names;
>>> +    init.num_parents = num_parents;
>>> +
>>> +    /* register the clock */
>>> +    clk = clk_register(dev, &clk_hw->hw);
>>> +
>>> +    if (IS_ERR(clk))
>>> +        kfree(clk_hw);
>>> +    else
>>> +        omap2_init_clk_hw_omap_clocks(clk);
>> what if init fails? and it is in mach-omap2 at this point in time?
>
> Yea, this just calls the autoidle init part under mach-omap2.

we should make this independent of mach-omap2. calls should be made to 
here if needed from mach-omap2 instead of the other way around. OR the 
required code should be moved over here.

>
>>
>>> +
>>> +    return clk;
>>> +}
>>
<snip>
>>
>>> +
>>> +    if (of_property_read_bool(node, "ti,dpll-j-type")) {
>>> +        dd->sddiv_mask = 0xff000000;
>>> +        mult_mask = 0xfff << 8;
>>> +        div1_mask = 0xff;
>>> +        max_multiplier = 4095;
>>> +        max_divider = 256;
>>> +    }
>>> +
>>> +    if (of_property_read_bool(node, "ti,dpll-regm4xen")) {
>> I think we need bindings to understand this better.
>
> Or documentation you mean?

yes. Documentation/devicetree/bindings/....

>
>>
>>> +        dd->m4xen_mask = 0x800;
>>> +        dd->lpmode_mask = 1 << 10;
>>> +    }
>>> +
>>> +    dd->mult_mask = mult_mask;
>>> +    dd->div1_mask = div1_mask;
>>> +    dd->max_multiplier = max_multiplier;
>>> +    dd->max_divider = max_divider;
>>> +    dd->min_divider = min_divider;
>>> +
>>> +    clk = omap_clk_register_dpll(NULL, clk_name, parent_names,
>>> +                num_parents, dpll_flags, dd,
>>> +                clkdm_name, ops);
>>> +
>>> +    if (!IS_ERR(clk))
>>> +        of_clk_add_provider(node, of_clk_src_simple_get, clk);
>> error check?
>
> This is not done with other drivers either. Would require clk_unregister
> use to cleanup the above register call which is currently unavailable. I
> could add an error trace for this though.

you can definitely ensure this driver is clean :)

>>
>>> +    kfree(dd);
>>> +    return;
>>> +}
>>> +
>>> +static void __init of_omap_dpll_x2_setup(struct device_node *node)
>>> +{
>>> +    struct clk *clk;
>>> +    const char *clk_name = node->name;
>>> +    void __iomem *reg;
>>> +    const char *parent_name;
>>> +
>>> +    of_property_read_string(node, "clock-output-names", &clk_name);
>>> +
>>> +    parent_name = of_clk_get_parent_name(node, 0);
>>> +
>>> +    reg = of_iomap(node, 0);
>>
>> if dts has errors, should we not verify mandatory parameters?
>
> You mean checking the validity of this pointer? It seems of_iomap does
> something strange when it fails, e.g. when passed a 0x0 from DT. You can
> see what I do in a later patch for adding am335x support for DPLLs.

in general, helping dts writers know of invalid/out of range parameters 
with a log message helps ensure those are fixed either on development or 
at some point - it aids debug instead of others having to scratch heads 
wondering what happened.

if mandatory parameters are verifable at setup and decided as bad, 
refusing to register is good idea especially with logs, they tend to get 
fixed rather faster - than an error that pops up when a specific DPLL is 
used at a later point in time.

just my 2 cents.
[..]

>>> +}
>>> +EXPORT_SYMBOL_GPL(of_omap4_dpll_setup);
>>
>> you can drop the export if you use of_clk_init(NULL);
>
> Hmm no?
>
> Actually dug this further, I think the init setup is slightly wrong at
> the moment, we should not do CLK_OF_DECLARE at all within the omap
> specific clock drivers, but instead just use the match table from clk.c.
> I'll change it like so.
>
>>
>>> +CLK_OF_DECLARE(omap4_dpll_clock, "ti,omap4-dpll-clock",
>>> of_omap4_dpll_setup);
>
> So, for example this should be removed. We don't want to support this
> clock type on non-omap platforms just to avoid problems.

As discussed offline, doing the other way around and doing what all 
other platforms do (which is CLK_OF_DECLARE) is a better idea to ensure 
standard APIs are carried forward and not spin off OMAP as a "special 
platform" - at least I dont seem to see any good reasoning for it yet.



-- 
Regards,
Nishanth Menon
