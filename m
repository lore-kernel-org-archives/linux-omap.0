From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 05/33] CLK: omap: add DT duplicate clock registration
 mechanism
Date: Wed, 31 Jul 2013 13:07:49 +0300
Message-ID: <51F8E1F5.20706@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com> <1374564028-11352-6-git-send-email-t-kristo@ti.com> <51F808A8.6000503@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:50913 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751903Ab3GaKIU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 31 Jul 2013 06:08:20 -0400
In-Reply-To: <51F808A8.6000503@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: linux-omap@vger.kernel.org, paul@pwsan.com, khilman@linaro.org, tony@atomide.com, mturquette@linaro.org, rnayak@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

On 07/30/2013 09:40 PM, Nishanth Menon wrote:
> On 07/23/2013 02:20 AM, Tero Kristo wrote:
>> Some devices require their clocks to be available with a specific
>> dev-id con-id mapping. With DT, the clocks can be found by default
>> only with their name, or alternatively through the device node of
>> the consumer. With drivers, that don't support DT fully yet, add
>> mechanism to register specific clock names.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>
> with this, should it not be enough to add clocks=<&phandle>

Don't know, I am not an expert on DT. :)

>
> I am not sure I understand what specific drivers should need to carry
> this "old hack" forward. More importantly, why is it preferable to carry
> the hack forward rather than fixing the drivers.

At least the GP timer seems to need this, and I don't want to touch / 
verify all the potential drivers touched by this so it is easier to 
provide a (semi) temporary tweak.

>
>
>> ---
>>   drivers/clk/omap/clk.c   |   39 +++++++++++++++++++++++++++++++++++++++
>>   include/linux/clk/omap.h |   17 +++++++++++++++++
>>   2 files changed, 56 insertions(+)
>>
>> diff --git a/drivers/clk/omap/clk.c b/drivers/clk/omap/clk.c
>> index 1dafdaa..cd31a81 100644
>> --- a/drivers/clk/omap/clk.c
>> +++ b/drivers/clk/omap/clk.c
>> @@ -32,6 +32,45 @@ static const struct of_device_id clk_match[] = {
>>       {},
>>   };
>>
>> + /**
>> + * omap_dt_clocks_register - register DT duplicate clocks during boot
>> + * @oclks: list of clocks to register
>> + * @cnt: number of clocks
>> + *
>> + * Register duplicate or non-standard DT clock entries during boot. By
>> + * default, DT clocks are found based on their node name. If any
>> + * additional con-id / dev-id -> clock mapping is required, use this
>> + * function to list these.
>> + */
>> +void __init omap_dt_clocks_register(struct omap_dt_clk oclks[], int cnt)
>
> Cant we use a NULL terminated array? then we dont need to pass cnt.

Yea can.

>
>> +{
>> +    struct omap_dt_clk *c;
>> +    struct device_node *n;
>> +    struct clk *clk;
>> +    struct of_phandle_args clkspec;
>> +
>> +    for (c = oclks; c < oclks + cnt; c++) {
>> +        n = of_find_node_by_name(NULL, c->node_name);
>> +
>> +        if (!n) {
>> +            pr_err("%s: %s not found!\n", __func__, c->node_name);
>> +            continue;
>> +        }
>> +
>> +        clkspec.np = n;
>> +
>> +        clk = of_clk_get_from_provider(&clkspec);
>> +
>> +        if (!clk) {
>> +            pr_err("%s: %s has no clock!\n", __func__,
>> +                c->node_name);
>> +            continue;
>> +        }
>> +        c->lk.clk = clk;
>> +        clkdev_add(&c->lk);
>
> why not clk_add_alias ?

Hmm yea, that might work also now that I made patch #1.

>
>> +    }
>> +}
>> +
>>   /* FIXME - need to initialize early; skip real driver registration &
>> probe */
>>   int __init dt_omap_clk_init(void)
>>   {
>> diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
>> index cba892a..c39e775 100644
>> --- a/include/linux/clk/omap.h
>> +++ b/include/linux/clk/omap.h
>> @@ -19,6 +19,8 @@
>>   #ifndef __LINUX_CLK_OMAP_H_
>>   #define __LINUX_CLK_OMAP_H_
>>
>> +#include <linux/clkdev.h>
>> +
>>   /**
>>    * struct dpll_data - DPLL registers and integration data
>>    * @mult_div1_reg: register containing the DPLL M and N bitfields
>> @@ -146,6 +148,20 @@ struct clk_hw_omap_ops {
>>       void            (*deny_idle)(struct clk_hw_omap *oclk);
>>   };
>>
>> +struct omap_dt_clk {
>> +    struct clk_lookup        lk;
>> +    const char            *node_name;
>> +};
>> +
>
> documentation missing.

Yea, will add.

>
>> +#define DT_CLK(dev, con, name)        \
>> +    {                \
>> +        .lk = {            \
>> +            .dev_id = dev,    \
>> +            .con_id = con,    \
>> +        },            \
>> +        .node_name = name,    \
>> +    }
>> +
>>   void omap2_init_clk_hw_omap_clocks(struct clk *clk);
>>   int omap3_noncore_dpll_enable(struct clk_hw *hw);
>>   void omap3_noncore_dpll_disable(struct clk_hw *hw);
>> @@ -174,6 +190,7 @@ extern const struct clk_hw_omap_ops
>> clkhwops_omap4_dpllmx;
>>
>>   /* DT functions */
>>   int dt_omap_clk_init(void);
>> +extern void omap_dt_clocks_register(struct omap_dt_clk *oclks, int cnt);
>
> do you need the extern?

I guess not.

>
>>   void of_omap4_dpll_setup(struct device_node *node);
>>
>>   #endif
>>
>
>

