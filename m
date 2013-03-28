From: Mike Turquette <mturquette@linaro.org>
Subject: Re: [PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Thu, 28 Mar 2013 14:27:39 -0700
Message-ID: <20130328212739.13785.44736@quantum>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:61248 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753471Ab3C1V1q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 Mar 2013 17:27:46 -0400
Received: by mail-da0-f46.google.com with SMTP id y19so4633225dan.5
        for <linux-omap@vger.kernel.org>; Thu, 28 Mar 2013 14:27:46 -0700 (PDT)
In-Reply-To: <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-patch-review@list.ti.com
Cc: Nishanth Menon <nm@ti.com>, Tero Kristo <t-kristo@ti.com>, "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>, =?utf-8?q?Beno=C3=AEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

Quoting Andrii Tseglytskyi (2013-03-28 10:16:07)
> From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
> 
> This patch introduces the Adaptive Body-Bias LDO driver,
> which handles LDOs voltage during OPP change routine.
> It follows general principles of ABB implementation
> in kernel 3.4.
> 
> Some new features are added:
> 
> 1) ABB driver uses clock notifier framework to scale LDO.
> To make this working it handles it's own OPP table.
> OPP table has the following format in device tree:
> 
> operating-points = <
>                /* kHz   ABB (0 - Bypass, 1 - FBB, 2 - RBB) */
>                499200           0
>                1099800          1
>                1500000          1
>                1699200          1
> >;
> 
> Generic API is used for OPP table parsing - of_init_opp_table()
> 
> 2) ABB driver doesn't have any public interfaces. It follows
> Voltage/Frequency changes, using only notification mechanism.
> 
> 3) ABB driver uses PRM_IRQSTATUS register to check tranxdone status.
> This register is shared with VP.

Hi Andrii,

You should probably post this as an RFC.  It remains to be seen if using
the clk rate-change notifiers will be the mechanism for scaling voltage
in The Future.  This patch is helpful for the purposes of that
discussion but shouldn't be merged until there is more consensus.

Some comments below.

<snip>

> +/*
> + * struct omap_abb_data - common data for each instance of ABB ldo
> + *
> + * @opp_sel_mask:      selects Fast/Nominal/Slow OPP for ABB
> + * @opp_change_mask:   selects OPP_CHANGE bit value
> + * @sr2_wtcnt_value_mask:      LDO settling time for active-mode OPP change
> + * @sr2en_mask:                        enables/disables ABB
> + * @fbb_sel_mask:              selects FBB mode
> + * @rbb_sel_mask:              selects RBB mode
> + * @settling_time:     IRQ handle used to resolve IRQSTATUS offset & masks
> + * @clock_cycles:      value needed for LDO setting time calculation
> + * @setup_offs:                PRM_LDO_ABB_XXX_SETUP register offset
> + * @control_offs:      PRM_LDO_ABB_IVA_CTRL register offset

Can you align all of these?

> + */
> +struct omap_abb_data {
> +       u32 opp_sel_mask;
> +       u32 opp_change_mask;
> +       u32 sr2_wtcnt_value_mask;
> +       u32 sr2en_mask;
> +       u32 fbb_sel_mask;
> +       u32 rbb_sel_mask;
> +       unsigned long settling_time;
> +       unsigned long clock_cycles;
> +       u8 setup_offs;
> +       u8 control_offs;
> +};
> +
> +/*
> + * struct omap_abb - ABB ldo instance
> + *
> + * @control:   memory mapped ABB registers
> + * @txdone:    memory mapped IRQSTATUS register
> + * @dev:       device, for which ABB is created
> + * @txdone_mask:       ABB mode change done bit
> + * @opp_sel:           current ABB status - Fast/Nominal/Slow
> + * @notify_clk:                clock, which rate changes are handled by ABB
> + * @data:              common data
> + * @abb_clk_nb:                clock rate change notifier block
> + */
> +struct omap_abb {
> +       void __iomem    *control;
> +       void __iomem    *txdone;
> +       struct device   *dev;
> +       u32             txdone_mask;
> +       u32             opp_sel;
> +       struct clk      *notify_clk;
> +       struct omap_abb_data    data;
> +       struct notifier_block abb_clk_nb;
> +};
> +

Ditto.

> +static const struct omap_abb_data __initdata omap36xx_abb_data = {
> +       .opp_sel_mask           = (3 << 0), /* OMAP3630_OPP_SEL_MASK */
> +       .opp_change_mask        = (1 << 2), /* OMAP3630_OPP_CHANGE_MASK */
> +       .sr2en_mask             = (1 << 0), /* OMAP3630_SR2EN_MASK */
> +       .fbb_sel_mask           = (1 << 2), /* OMAP3630_ACTIVE_FBB_SEL_MASK */
> +       .sr2_wtcnt_value_mask = (0xff << 8), /* OMAP3630_SR2_WTCNT_VALUE_MASK */
> +       .setup_offs             = 0,
> +       .control_offs           = 0x4,
> +       .settling_time          = 30,
> +       .clock_cycles           = 8,
> +};
> +
> +static const struct omap_abb_data __initdata omap4_abb_data = {
> +       .opp_sel_mask           = (0x3 << 0), /* OMAP4430_OPP_SEL_MASK */
> +       .opp_change_mask        = (1 << 2), /* OMAP4430_OPP_CHANGE_MASK */
> +       .sr2en_mask             = (1 << 0), /* OMAP4430_SR2EN_MASK */
> +       .fbb_sel_mask           = (1 << 2), /* OMAP4430_ACTIVE_FBB_SEL_MASK */
> +       .rbb_sel_mask           = (1 << 1), /* OMAP4430_ACTIVE_RBB_SEL_MASK */
> +       .sr2_wtcnt_value_mask = (0xff << 8), /* OMAP4430_SR2_WTCNT_VALUE_MASK */
> +       .setup_offs             = 0,
> +       .control_offs           = 0x4,
> +       .settling_time          = 50,
> +       .clock_cycles           = 16,
> +};

Any reason to hard code those values and then put the TRM bitfield name
in a comment?  Probably better to #define these values using those
bitfield names.

Also please be consistent about "0x" in your numeric values.  Mixing it
in randomly (such as 0x3 and 0x4 above) is weird.

> +
> +static const struct omap_abb_data __initdata omap5_abb_data = {
> +       .opp_sel_mask           = (0x3 << 0), /* OMAP54XX_OPP_SEL_MASK */
> +       .opp_change_mask        = (1 << 2), /* OMAP54XX_OPP_CHANGE_MASK */
> +       .sr2en_mask             = (1 << 0), /* OMAP54XX_SR2EN_MASK */
> +       .fbb_sel_mask           = (1 << 2), /* OMAP54XX_ACTIVE_FBB_SEL_MASK */
> +       .rbb_sel_mask           = (1 << 1), /* OMAP54XX_ACTIVE_RBB_SEL_MASK */
> +       .sr2_wtcnt_value_mask = (0xff << 8), /* OMAP54XX_SR2_WTCNT_VALUE_MASK */
> +       .setup_offs             = 0,
> +       .control_offs           = 0x4,
> +       .settling_time          = 50,
> +       .clock_cycles           = 16,
> +};
> +
> +/**
> + * omap_abb_readl() - reads ABB control memory
> + * @abb:       pointer to the abb instance
> + * @offs:      offset to read
> + *
> + * Returns @offs value
> + */
> +static u32 omap_abb_readl(struct omap_abb *abb, u32 offs)
> +{
> +       return __raw_readl(abb->control + offs);
> +}

readl instead of __raw_readl?

> +
> +/**
> + * omap_abb_rmw() - modifies ABB control memory
> + * @abb:       pointer to the abb instance
> + * @mask:      mask to modify
> + * @bits:      bits to store
> + * @offs:      offset to modify
> + */
> +static void omap_abb_rmw(struct omap_abb *abb, u32 mask, u32 bits, u32 offs)
> +{
> +       u32 val;
> +
> +       val = __raw_readl(abb->control + offs);
> +       val &= ~mask;
> +       val |= bits;
> +       __raw_writel(val, abb->control + offs);

writel instead of __raw_writel?

<snip>

> +/**
> + * omap_abb_pre_scale() - ABB transition pre-frequency scale callback
> + * @abb:       pointer to the ABB instance
> + * @old_rate:  old notifier clock rate
> + * @new_rate:  new notifier clock rate
> + *
> + * Changes the ABB ldo mode prior to scaling the frequency.
> + * Returns 0 on success, otherwise an error code.
> + */
> +static int omap_abb_pre_scale(struct omap_abb *abb,
> +                             unsigned long old_rate,
> +                             unsigned long new_rate)
> +{
> +       struct opp *opp;
> +
> +       /* bail if the sequence is wrong */
> +       if (new_rate >= old_rate)
> +               return 0;
> +
> +       rcu_read_lock();
> +       opp = opp_find_freq_exact(abb->dev, new_rate, true);
> +       rcu_read_unlock();
> +
> +       if (IS_ERR(opp)) {
> +               dev_err(abb->dev, "%s: can't find OPP for Freq (%lu)",
> +                       __func__, new_rate);
> +               return -EINVAL;
> +       }
> +
> +       return omap_abb_set_opp(abb, opp_get_voltage(opp));
> +}
> +
> +/**
> + * omap_abb_post_scale() - ABB transition post-frequency scale callback
> + * @abb:       pointer to the ABB instance
> + * @old_rate:  old notifier clock rate
> + * @new_rate:  new notifier clock rate
> + *
> + * Changes the ABB ldo mode prior to scaling the frequency.
> + * Returns 0 on success, otherwise an error code.
> + */
> +static int omap_abb_post_scale(struct omap_abb *abb,
> +                              unsigned long old_rate,
> +                              unsigned long new_rate)
> +{
> +       struct opp *opp;
> +
> +       /* bail if the sequence is wrong */
> +       if (new_rate <= old_rate)
> +               return 0;
> +
> +       rcu_read_lock();
> +       opp = opp_find_freq_exact(abb->dev, new_rate, true);
> +       rcu_read_unlock();
> +
> +       if (IS_ERR(opp)) {
> +               dev_err(abb->dev, "%s: can't find OPP for Freq (%lu)",
> +                       __func__, new_rate);
> +               return -EINVAL;
> +       }
> +
> +       return omap_abb_set_opp(abb, opp_get_voltage(opp));
> +}
> +
> +/**
> + * omap_abb_clock_rate_change() - ABB clock notifier callback
> + * @nb:                notifier block
> + * @flags:     notifier event type
> + * @data:      notifier data, contains clock rates
> + *
> + * Returns NOTIFY_OK
> + */
> +static int omap_abb_clock_rate_change(struct notifier_block *nb,
> +                                     unsigned long flags, void *data)
> +{
> +       struct clk_notifier_data *cnd = data;
> +       struct omap_abb *abb = container_of(nb, struct omap_abb, abb_clk_nb);
> +
> +       switch (flags) {
> +       case PRE_RATE_CHANGE:
> +               omap_abb_pre_scale(abb, cnd->old_rate, cnd->new_rate);
> +               break;
> +       case POST_RATE_CHANGE:
> +               omap_abb_post_scale(abb, cnd->old_rate, cnd->new_rate);
> +               break;
> +       }
> +
> +       return NOTIFY_OK;
> +}

How does this synchronize with the VC/VP voltage transition?  Ordering
is important here and if the clk rate-change notifiers are used for both
a VP force update and for an FBB transition there is no guarantee of the
ordering.

Regards,
Mike
