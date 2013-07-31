From: Tero Kristo <t-kristo@ti.com>
Subject: Re: [PATCHv4 04/33] CLK: omap: move part of the machine specific
 clock header contents to driver
Date: Wed, 31 Jul 2013 12:59:42 +0300
Message-ID: <51F8E00E.7070506@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-5-git-send-email-t-kristo@ti.com> <51F8045C.6020603@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <51F8045C.6020603@ti.com>
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

On 07/30/2013 09:22 PM, Nishanth Menon wrote:
> this patch should be 3/33 to allow dpll.c to build.
>
> On 07/23/2013 02:19 AM, Tero Kristo wrote:
>> Some of the clock.h contents are needed by the new OMAP clock driver,
>> including dpll_data and clk_hw_omap. Thus, move these to the generic
>> omap header file which can be accessed by the driver.
>>
> Looking at the change, I wonder what the rules are for the movement?
> commit message was not clear.

This is kind of a merge of almost everything that is needed by clock 
drivers at some point. I can move the changes along to the patches that 
actually need the exports for clarity and to keep compilation clean.

>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> ---
>>   arch/arm/mach-omap2/clock.h |  151
>> +----------------------------------------
>>   include/linux/clk/omap.h    |  157
>> ++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 157 insertions(+), 151 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/clock.h b/arch/arm/mach-omap2/clock.h
>> index 7aa32cd..d1a3125 100644
>> --- a/arch/arm/mach-omap2/clock.h
>> +++ b/arch/arm/mach-omap2/clock.h
>> @@ -21,6 +21,7 @@
>>
>>   #include <linux/clkdev.h>
>>   #include <linux/clk-provider.h>
>> +#include <linux/clk/omap.h>
>>
>>   struct omap_clk {
>>       u16                cpu;
>> @@ -178,83 +179,6 @@ struct clksel {
>>       const struct clksel_rate *rates;
>>   };
>>
>> -/**
>> - * struct dpll_data - DPLL registers and integration data
>> - * @mult_div1_reg: register containing the DPLL M and N bitfields
>> - * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
>> - * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
>> - * @clk_bypass: struct clk pointer to the clock's bypass clock input
>> - * @clk_ref: struct clk pointer to the clock's reference clock input
>> - * @control_reg: register containing the DPLL mode bitfield
>> - * @enable_mask: mask of the DPLL mode bitfield in @control_reg
>> - * @last_rounded_rate: cache of the last rate result of
>> omap2_dpll_round_rate()
>> - * @last_rounded_m: cache of the last M result of
>> omap2_dpll_round_rate()
>> - * @last_rounded_m4xen: cache of the last M4X result of
>> - *            omap4_dpll_regm4xen_round_rate()
>> - * @last_rounded_lpmode: cache of the last lpmode result of
>> - *             omap4_dpll_lpmode_recalc()
>> - * @max_multiplier: maximum valid non-bypass multiplier value (actual)
>> - * @last_rounded_n: cache of the last N result of
>> omap2_dpll_round_rate()
>> - * @min_divider: minimum valid non-bypass divider value (actual)
>> - * @max_divider: maximum valid non-bypass divider value (actual)
>> - * @modes: possible values of @enable_mask
>> - * @autoidle_reg: register containing the DPLL autoidle mode bitfield
>> - * @idlest_reg: register containing the DPLL idle status bitfield
>> - * @autoidle_mask: mask of the DPLL autoidle mode bitfield in
>> @autoidle_reg
>> - * @freqsel_mask: mask of the DPLL jitter correction bitfield in
>> @control_reg
>> - * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
>> - * @lpmode_mask: mask of the DPLL low-power mode bitfield in
>> @control_reg
>> - * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
>> - * @auto_recal_bit: bitshift of the driftguard enable bit in
>> @control_reg
>> - * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for
>> recalibration IRQs
>> - * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for
>> recalibration IRQs
>> - * @flags: DPLL type/features (see below)
>> - *
>> - * Possible values for @flags:
>> - * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
>> - *
>> - * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
>> - *
>> - * XXX Some DPLLs have multiple bypass inputs, so it's not technically
>> - * correct to only have one @clk_bypass pointer.
>> - *
>> - * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
>> - * @last_rounded_n) should be separated from the runtime-fixed fields
>> - * and placed into a different structure, so that the runtime-fixed data
>> - * can be placed into read-only space.
>> - */
>> -struct dpll_data {
>> -    void __iomem        *mult_div1_reg;
>> -    u32            mult_mask;
>> -    u32            div1_mask;
>> -    struct clk        *clk_bypass;
>> -    struct clk        *clk_ref;
>> -    void __iomem        *control_reg;
>> -    u32            enable_mask;
>> -    unsigned long        last_rounded_rate;
>> -    u16            last_rounded_m;
>> -    u8            last_rounded_m4xen;
>> -    u8            last_rounded_lpmode;
>> -    u16            max_multiplier;
>> -    u8            last_rounded_n;
>> -    u8            min_divider;
>> -    u16            max_divider;
>> -    u8            modes;
>> -    void __iomem        *autoidle_reg;
>> -    void __iomem        *idlest_reg;
>> -    u32            autoidle_mask;
>> -    u32            freqsel_mask;
>> -    u32            idlest_mask;
>> -    u32            dco_mask;
>> -    u32            sddiv_mask;
>> -    u32            lpmode_mask;
>> -    u32            m4xen_mask;
>> -    u8            auto_recal_bit;
>> -    u8            recal_en_bit;
>> -    u8            recal_st_bit;
>> -    u8            flags;
>> -};
>> -
>>   /*
>>    * struct clk.flags possibilities
>>    *
>> @@ -274,56 +198,6 @@ struct dpll_data {
>>   #define INVERT_ENABLE        (1 << 4)    /* 0 enables, 1 disables */
>>   #define CLOCK_CLKOUTX2        (1 << 5)
>>
>> -/**
>> - * struct clk_hw_omap - OMAP struct clk
>> - * @node: list_head connecting this clock into the full clock list
>> - * @enable_reg: register to write to enable the clock (see @enable_bit)
>> - * @enable_bit: bitshift to write to enable/disable the clock (see
>> @enable_reg)
>> - * @flags: see "struct clk.flags possibilities" above
>> - * @clksel_reg: for clksel clks, register va containing src/divisor
>> select
>> - * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
>> - * @clksel: for clksel clks, pointer to struct clksel for this clock
>> - * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
>> - * @clkdm_name: clockdomain name that this clock is contained in
>> - * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name
>> at runtime
>> - * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
>> - * @src_offset: bitshift for source selection bitfield (OMAP1 only)
>> - *
>> - * XXX @rate_offset, @src_offset should probably be removed and OMAP1
>> - * clock code converted to use clksel.
>> - *
>> - */
>> -
>> -struct clk_hw_omap_ops;
>> -
>> -struct clk_hw_omap {
>> -    struct clk_hw        hw;
>> -    struct list_head    node;
>> -    unsigned long        fixed_rate;
>> -    u8            fixed_div;
>> -    void __iomem        *enable_reg;
>> -    u8            enable_bit;
>> -    u8            flags;
>> -    void __iomem        *clksel_reg;
>> -    u32            clksel_mask;
>> -    const struct clksel    *clksel;
>> -    struct dpll_data    *dpll_data;
>> -    const char        *clkdm_name;
>> -    struct clockdomain    *clkdm;
>> -    const struct clk_hw_omap_ops    *ops;
>> -};
>> -
>> -struct clk_hw_omap_ops {
>> -    void            (*find_idlest)(struct clk_hw_omap *oclk,
>> -                    void __iomem **idlest_reg,
>> -                    u8 *idlest_bit, u8 *idlest_val);
>> -    void            (*find_companion)(struct clk_hw_omap *oclk,
>> -                    void __iomem **other_reg,
>> -                    u8 *other_bit);
>> -    void            (*allow_idle)(struct clk_hw_omap *oclk);
>> -    void            (*deny_idle)(struct clk_hw_omap *oclk);
>> -};
>> -
>>   unsigned long omap_fixed_divisor_recalc(struct clk_hw *hw,
>>                       unsigned long parent_rate);
>>
>> @@ -356,28 +230,13 @@ unsigned long omap_fixed_divisor_recalc(struct
>> clk_hw *hw,
>>   /* DPLL Type and DCO Selection Flags */
>>   #define DPLL_J_TYPE        0x1
>>
>> -long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>> -            unsigned long *parent_rate);
>> -unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long
>> parent_rate);
>> -int omap3_noncore_dpll_enable(struct clk_hw *hw);
>> -void omap3_noncore_dpll_disable(struct clk_hw *hw);
>> -int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>> -                unsigned long parent_rate);
>
> Why are these being moved to generic?

These are used from the dpll.c by the ops.

>
>>   u32 omap3_dpll_autoidle_read(struct clk_hw_omap *clk);
>>   void omap3_dpll_allow_idle(struct clk_hw_omap *clk);
>>   void omap3_dpll_deny_idle(struct clk_hw_omap *clk);
>
>> -unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
>> -                    unsigned long parent_rate);
> why move this?

Same, anyway, I'll cover the rest of similar comments by moving them 
along with the patch that actually needs the export.


>
>>   int omap4_dpllmx_gatectrl_read(struct clk_hw_omap *clk);
>>   void omap4_dpllmx_allow_gatectrl(struct clk_hw_omap *clk);
>>   void omap4_dpllmx_deny_gatectrl(struct clk_hw_omap *clk);
>> -unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
>> -                unsigned long parent_rate);
>> -long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
>> -                    unsigned long target_rate,
>> -                    unsigned long *parent_rate);
> same here.
>
>>
>> -void omap2_init_clk_clkdm(struct clk_hw *clk);
> same question again.
>
>>   void __init omap2_clk_disable_clkdm_control(void);
>>
>>   /* clkt_clksel.c public functions */
>> @@ -396,7 +255,6 @@ int omap2_clksel_set_parent(struct clk_hw *hw, u8
>> field_val);
>>   extern void omap2_clkt_iclk_allow_idle(struct clk_hw_omap *clk);
>>   extern void omap2_clkt_iclk_deny_idle(struct clk_hw_omap *clk);
>>
>> -u8 omap2_init_dpll_parent(struct clk_hw *hw);
> why move this?
>
>>   unsigned long omap2_get_dpll_rate(struct clk_hw_omap *clk);
>>
>>   int omap2_dflt_clk_enable(struct clk_hw *hw);
>> @@ -408,9 +266,7 @@ void omap2_clk_dflt_find_companion(struct
>> clk_hw_omap *clk,
>>   void omap2_clk_dflt_find_idlest(struct clk_hw_omap *clk,
>>                   void __iomem **idlest_reg,
>>                   u8 *idlest_bit, u8 *idlest_val);
>> -void omap2_init_clk_hw_omap_clocks(struct clk *clk);
> why move this?
>
>>   int omap2_clk_enable_autoidle_all(void);
>> -int omap2_clk_disable_autoidle_all(void);
> why move this?
>
>>   void omap2_clk_enable_init_clocks(const char **clk_names, u8
>> num_clocks);
>>   int omap2_clk_switch_mpurate_at_boot(const char *mpurate_ck_name);
>>   void omap2_clk_print_new_rates(const char *hfclkin_ck_name,
>> @@ -431,10 +287,8 @@ extern const struct clksel_rate gfx_l3_rates[];
>>   extern const struct clksel_rate dsp_ick_rates[];
>>   extern struct clk dummy_ck;
>>
>> -extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
> is this needed to be moved?
>
>>   extern const struct clk_hw_omap_ops clkhwops_iclk_wait;
>>   extern const struct clk_hw_omap_ops clkhwops_wait;
>> -extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
> is this needed to be moved?
>
>>   extern const struct clk_hw_omap_ops clkhwops_iclk;
>>   extern const struct clk_hw_omap_ops clkhwops_omap3430es2_ssi_wait;
>>   extern const struct clk_hw_omap_ops clkhwops_omap3430es2_iclk_ssi_wait;
>> @@ -460,8 +314,5 @@ extern const struct clksel_rate div31_1to31_rates[];
>>
>>   extern int am33xx_clk_init(void);
>>
>> -extern int omap2_clkops_enable_clkdm(struct clk_hw *hw);
>> -extern void omap2_clkops_disable_clkdm(struct clk_hw *hw);
>> -
>
>
>>   extern void omap_clocks_register(struct omap_clk *oclks, int cnt);
>>   #endif
>> diff --git a/include/linux/clk/omap.h b/include/linux/clk/omap.h
>> index 647f02f..cba892a 100644
>> --- a/include/linux/clk/omap.h
>> +++ b/include/linux/clk/omap.h
>> @@ -19,6 +19,161 @@
>>   #ifndef __LINUX_CLK_OMAP_H_
>>   #define __LINUX_CLK_OMAP_H_
>>
>> -int __init dt_omap_clk_init(void);
>> +/**
>> + * struct dpll_data - DPLL registers and integration data
>> + * @mult_div1_reg: register containing the DPLL M and N bitfields
>> + * @mult_mask: mask of the DPLL M bitfield in @mult_div1_reg
>> + * @div1_mask: mask of the DPLL N bitfield in @mult_div1_reg
>> + * @clk_bypass: struct clk pointer to the clock's bypass clock input
>> + * @clk_ref: struct clk pointer to the clock's reference clock input
>> + * @control_reg: register containing the DPLL mode bitfield
>> + * @enable_mask: mask of the DPLL mode bitfield in @control_reg
>> + * @last_rounded_rate: cache of the last rate result of
>> omap2_dpll_round_rate()
>> + * @last_rounded_m: cache of the last M result of
>> omap2_dpll_round_rate()
>> + * @last_rounded_m4xen: cache of the last M4X result of
>> + *                     omap4_dpll_regm4xen_round_rate()
>> + * @last_rounded_lpmode: cache of the last lpmode result of
>> + *                      omap4_dpll_lpmode_recalc()
>> + * @max_multiplier: maximum valid non-bypass multiplier value (actual)
>> + * @last_rounded_n: cache of the last N result of
>> omap2_dpll_round_rate()
>> + * @min_divider: minimum valid non-bypass divider value (actual)
>> + * @max_divider: maximum valid non-bypass divider value (actual)
>> + * @modes: possible values of @enable_mask
>> + * @autoidle_reg: register containing the DPLL autoidle mode bitfield
>> + * @idlest_reg: register containing the DPLL idle status bitfield
>> + * @autoidle_mask: mask of the DPLL autoidle mode bitfield in
>> @autoidle_reg
>> + * @freqsel_mask: mask of the DPLL jitter correction bitfield in
>> @control_reg
>> + * @idlest_mask: mask of the DPLL idle status bitfield in @idlest_reg
>> + * @lpmode_mask: mask of the DPLL low-power mode bitfield in
>> @control_reg
>> + * @m4xen_mask: mask of the DPLL M4X multiplier bitfield in @control_reg
>> + * @auto_recal_bit: bitshift of the driftguard enable bit in
>> @control_reg
>> + * @recal_en_bit: bitshift of the PRM_IRQENABLE_* bit for
>> recalibration IRQs
>> + * @recal_st_bit: bitshift of the PRM_IRQSTATUS_* bit for
>> recalibration IRQs
>> + * @flags: DPLL type/features (see below)
>> + *
>> + * Possible values for @flags:
>> + * DPLL_J_TYPE: "J-type DPLL" (only some 36xx, 4xxx DPLLs)
> but the flag is in arch/arm/mach-omap2/clock.h ?

I'll look at this and probably move the flag also.

>
>> + *
>> + * @freqsel_mask is only used on the OMAP34xx family and AM35xx.
>> + *
>> + * XXX Some DPLLs have multiple bypass inputs, so it's not technically
>> + * correct to only have one @clk_bypass pointer.
>> + *
>> + * XXX The runtime-variable fields (@last_rounded_rate, @last_rounded_m,
>> + * @last_rounded_n) should be separated from the runtime-fixed fields
>> + * and placed into a different structure, so that the runtime-fixed data
>> + * can be placed into read-only space.
>> + */
>> +struct dpll_data {
>
> is it necessary to export this? usage is limited to dpll.c and could be
> made private to it alone, no?

No, unfortunately dpll_data is used both by the dpll.c and the support 
code under mach-omap2. This is some sort of intermediate solution, so 
get DT clocks working first, then move the support code also under 
drivers/clk/omap.

>
>> +    void __iomem        *mult_div1_reg;
>> +    u32            mult_mask;
>> +    u32            div1_mask;
>> +    struct clk        *clk_bypass;
>> +    struct clk        *clk_ref;
>> +    void __iomem        *control_reg;
>> +    u32            enable_mask;
>> +    unsigned long        last_rounded_rate;
>> +    u16            last_rounded_m;
>> +    u8            last_rounded_m4xen;
>> +    u8            last_rounded_lpmode;
>> +    u16            max_multiplier;
>> +    u8            last_rounded_n;
>> +    u8            min_divider;
>> +    u16            max_divider;
>> +    u8            modes;
>> +    void __iomem        *autoidle_reg;
>> +    void __iomem        *idlest_reg;
>> +    u32            autoidle_mask;
>> +    u32            freqsel_mask;
>> +    u32            idlest_mask;
>> +    u32            dco_mask;
>
> not part of kernel documentation above.
>
>> +    u32            sddiv_mask;
>
> not part of kernel documentation above.

Copy paste from the corresponding mach-omap2 file, I need to double 
check what these parameters actually do.

>
>
>> +    u32            lpmode_mask;
>> +    u32            m4xen_mask;
>> +    u8            auto_recal_bit;
>> +    u8            recal_en_bit;
>> +    u8            recal_st_bit;
>> +    u8            flags;
>> +};
>> +
>> +/**
>> + * struct clk_hw_omap - OMAP struct clk
>> + * @node: list_head connecting this clock into the full clock list
>> + * @enable_reg: register to write to enable the clock (see @enable_bit)
>> + * @enable_bit: bitshift to write to enable/disable the clock (see
>> @enable_reg)
>> + * @flags: see "struct clk.flags possibilities" above
>> + * @clksel_reg: for clksel clks, register va containing src/divisor
>> select
>> + * @clksel_mask: bitmask in @clksel_reg for the src/divisor selector
>> + * @clksel: for clksel clks, pointer to struct clksel for this clock
>> + * @dpll_data: for DPLLs, pointer to struct dpll_data for this clock
>> + * @clkdm_name: clockdomain name that this clock is contained in
>> + * @clkdm: pointer to struct clockdomain, resolved from @clkdm_name
>> at runtime
>> + * @rate_offset: bitshift for rate selection bitfield (OMAP1 only)
>> + * @src_offset: bitshift for source selection bitfield (OMAP1 only)
>> + *
>> + * XXX @rate_offset, @src_offset should probably be removed and OMAP1
>> + * clock code converted to use clksel.
> Do you need to carry these forward? they already disappeared from the
> struct below.

Hmm, I'll check this.

>
>> + *
>> + */
>> +
>> +struct clk_hw_omap_ops;
> you need to keep the kernel documentation next to the struct which it is
> documenting, by introducing clk_hw_omap_ops forward declaration, we
> introduced the following kernel-doc error:
>
> Error(include/linux/clk/omap.h:119): Cannot parse struct or union!

Copy pasted problem it seems, I'll fix it.

>
>> +
>> +struct clk_hw_omap {
>> +    struct clk_hw        hw;
> not documented.
>
>> +    struct list_head    node;
>> +    unsigned long        fixed_rate;
> not documented.
>
>> +    u8            fixed_div;
> not documented.

I'll fix these.

>
>> +    void __iomem        *enable_reg;
>> +    u8            enable_bit;
>> +    u8            flags;
>> +    void __iomem        *clksel_reg;
>> +    u32            clksel_mask;
>> +    const struct clksel    *clksel;
>> +    struct dpll_data    *dpll_data;
>> +    const char        *clkdm_name;
>> +    struct clockdomain    *clkdm;
>> +    const struct clk_hw_omap_ops    *ops;
>> +};
>> +
>> +struct clk_hw_omap_ops {
>> +    void            (*find_idlest)(struct clk_hw_omap *oclk,
>> +                    void __iomem **idlest_reg,
>> +                    u8 *idlest_bit, u8 *idlest_val);
>> +    void            (*find_companion)(struct clk_hw_omap *oclk,
>> +                    void __iomem **other_reg,
>> +                    u8 *other_bit);
>> +    void            (*allow_idle)(struct clk_hw_omap *oclk);
>> +    void            (*deny_idle)(struct clk_hw_omap *oclk);
>> +};
>
> will be nice to have kernel documentation for these.

Okay.

>
>> +
>> +void omap2_init_clk_hw_omap_clocks(struct clk *clk);
>> +int omap3_noncore_dpll_enable(struct clk_hw *hw);
>> +void omap3_noncore_dpll_disable(struct clk_hw *hw);
>> +int omap3_noncore_dpll_set_rate(struct clk_hw *hw, unsigned long rate,
>> +                unsigned long parent_rate);
>> +unsigned long omap4_dpll_regm4xen_recalc(struct clk_hw *hw,
>> +                unsigned long parent_rate);
>> +long omap4_dpll_regm4xen_round_rate(struct clk_hw *hw,
>> +                    unsigned long target_rate,
>> +                    unsigned long *parent_rate);
>> +u8 omap2_init_dpll_parent(struct clk_hw *hw);
>> +unsigned long omap3_dpll_recalc(struct clk_hw *hw, unsigned long
>> parent_rate);
>> +long omap2_dpll_round_rate(struct clk_hw *hw, unsigned long target_rate,
>> +            unsigned long *parent_rate);
>> +void omap2_init_clk_clkdm(struct clk_hw *clk);
>> +unsigned long omap3_clkoutx2_recalc(struct clk_hw *hw,
>> +                    unsigned long parent_rate);
>> +
>> +int omap2_clkops_enable_clkdm(struct clk_hw *hw);
>> +void omap2_clkops_disable_clkdm(struct clk_hw *hw);
>> +
>> +int omap2_clk_disable_autoidle_all(void);
> ^^ all the above, not clear why we are moving them out enmasse.

Will split out the moves.


>
>> +
>> +extern const struct clk_hw_omap_ops clkhwops_omap3_dpll;
>> +extern const struct clk_hw_omap_ops clkhwops_omap4_dpllmx;
> why do we need to export these out?

Ditto. But these are used by the dpll.c code.

>
>> +
>> +/* DT functions */
>> +int dt_omap_clk_init(void);
> in this change, we removed __init -> which should have been done in the
> patch that introduced it in the first place.
>
>> +void of_omap4_dpll_setup(struct device_node *node);
> we should not be needing this.

I think we do.

>
>>
>>   #endif
>>
>
> at this point, we have a dependency between drivers/clk/omap/dpll.c and
> arch/arm/mach-omap2/ -> a possible suggestion will be to move required
> data structures first and operations as required.

My plan is to move the data structs + code later once the initial 
support is in. Otherwise this excercise is going to take much more time 
to get anything up and running.

Also, you can't even move some of the support code / structs, as they 
are still needed by the code under mach-omap2 (clock data for other 
platforms for example.)

-Tero
