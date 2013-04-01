From: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Mon, 1 Apr 2013 14:04:49 +0300
Message-ID: <515969D1.1090805@ti.com>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com> <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com> <20130328212739.13785.44736@quantum> <20130328223513.GA19470@kahuna>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:57908 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759372Ab3DALEx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 1 Apr 2013 07:04:53 -0400
In-Reply-To: <20130328223513.GA19470@kahuna>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Nishanth Menon <nm@ti.com>
Cc: Mike Turquette <mturquette@linaro.org>, Tero Kristo <t-kristo@ti.com>, =?ISO-8859-1?Q?Beno=EEt_Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org

Hi,

Subject changed to "Re: [*RFC* PATCH 5/6] ARM: OMAP3+: ABB: introduce 
ABB driver"

On 03/29/2013 12:35 AM, Nishanth Menon wrote:
>
> - ti internal list which got into the git send-email by error. 
> Apologies on the bounces which might have resulted... On 
> 14:27-20130328, Mike Turquette wrote:
>>
>> Quoting Andrii Tseglytskyi (2013-03-28 10:16:07)
>>> From: "Andrii.Tseglytskyi"<andrii.tseglytskyi@ti.com>
> Ownership of ABB driver patch probably still belongs to Mike as the 
> original
> author of the code and working out all the details to entitle ABB on OMAP
> platforms

Agreed with Mike to keep mine ownership of patch series, and mention 
that Mike is an author of idea and architecture of ABB driver.

> [..]
>> You should probably post this as an RFC.  It remains to be seen if using
>> the clk rate-change notifiers will be the mechanism for scaling voltage
>> in The Future.  This patch is helpful for the purposes of that
>> discussion but shouldn't be merged until there is more consensus.
> I agree. + include linux-arm-kernel and lkml in CC on the next *public*
> revision .

Agree.

>
> [..]
>>> +/*
>>> + * struct omap_abb_data - common data for each instance of ABB ldo
>>> + *
>>> + * @opp_sel_mask:      selects Fast/Nominal/Slow OPP for ABB
>>> + * @opp_change_mask:   selects OPP_CHANGE bit value
>>> + * @sr2_wtcnt_value_mask:      LDO settling time for active-mode 
>>> OPP change
>>> + * @sr2en_mask:                        enables/disables ABB
>>> + * @fbb_sel_mask:              selects FBB mode
>>> + * @rbb_sel_mask:              selects RBB mode
>>> + * @settling_time:     IRQ handle used to resolve IRQSTATUS offset 
>>> & masks
>>> + * @clock_cycles:      value needed for LDO setting time calculation
>>> + * @setup_offs:                PRM_LDO_ABB_XXX_SETUP register offset
>>> + * @control_offs:      PRM_LDO_ABB_IVA_CTRL register offset
>> Can you align all of these?
> We should check up on AM and DM series as well - if the bit offsets are
> precisely the same, we could stick with macros instead of having the
> masks and register offsets in a device specific manner.

These offsets are the same for OMAP3/4/5. I see two options here.
1) Use macro to define offsets and continue storing them in "struct 
omap_abb_data"
2) Use macro definitions directly in the driver code and remove 
mentioned fields from "struct omap_abb_data"

> [..]
>>> +/**
>>> + * omap_abb_readl() - reads ABB control memory
>>> + * @abb:       pointer to the abb instance
>>> + * @offs:      offset to read
>>> + *
>>> + * Returns @offs value
>>> + */
>>> +static u32 omap_abb_readl(struct omap_abb *abb, u32 offs)
>>> +{
>>> +       return __raw_readl(abb->control + offs);
>>> +}
>> readl instead of __raw_readl?
> Ack. readl/writel should be used..

Ack. readl/writel to be used.

>>> +/**
>>> + * omap_abb_clock_rate_change() - ABB clock notifier callback
>>> + * @nb:                notifier block
>>> + * @flags:     notifier event type
>>> + * @data:      notifier data, contains clock rates
>>> + *
>>> + * Returns NOTIFY_OK
>>> + */
>>> +static int omap_abb_clock_rate_change(struct notifier_block *nb,
>>> +                                     unsigned long flags, void *data)
>>> +{
>>> +       struct clk_notifier_data *cnd = data;
>>> +       struct omap_abb *abb = container_of(nb, struct omap_abb, 
>>> abb_clk_nb);
>>> +
>>> +       switch (flags) {
>>> +       case PRE_RATE_CHANGE:
>>> +               omap_abb_pre_scale(abb, cnd->old_rate, cnd->new_rate);
>>> +               break;
>>> +       case POST_RATE_CHANGE:
>>> +               omap_abb_post_scale(abb, cnd->old_rate, cnd->new_rate);
>>> +               break;
>>> +       }
>>> +
>>> +       return NOTIFY_OK;
>>> +}
>> How does this synchronize with the VC/VP voltage transition? Ordering
>> is important here and if the clk rate-change notifiers are used for both
>> a VP force update and for an FBB transition there is no guarantee of the
>> ordering.
> I need to dig into this series deeper, but the requirement is as
> follows:
> Actual voltage change may occur with vc/vp - OMAP3,4,5 OR with i2c1- AM
> series or the upcoming DRA SoCs, intent is to model the vc-vp->pmic as
> regulators (some internal patches circulate for this, but not mature 
> enough
> to be send out in a public list yet)
>
> Key however is:
> * if we do as clock notifiers(as this series attempts I believe), we'd 
> get ABB
> settings around clock change boundary.
> Alternative might be to do it around voltage change - we could, in
> theory:
> a) make an omap voltage regulator and provide notifier around the same
> and hook ABB to it. the omap voltage regulator will in turn call the
> appropriate voltage regulator (modelled from a regulator that controls
> an PMIC over i2c1 OR over vc-vp regulator)
> b) make ABB as an regulator by itself?
> c) how might this work if we have DVFS capability in CCF itself[1]? it
> might be better to have it as notifiers to regulator (the pseudo
> omap-voltage regulator perhaps?)
>
> [1] CCF DVFS patches:
> https://patchwork.kernel.org/patch/2195431/
> https://patchwork.kernel.org/patch/2195421/
> https://patchwork.kernel.org/patch/2195451/
> https://patchwork.kernel.org/patch/2195441/
> https://patchwork.kernel.org/patch/2195461/
>

In case if VC/VP use clock notifier to scale voltage, there is no 
guarantee of order.
The only option which I see is to create ABB API and call it from OMAP 
regulator during OPP change.

omap_abb_pre_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);
omap_abb_post_scale(struct omap_abb *abb, u32 old_volt, u32 new_volt);

Mike, do you agree to proceed in this way? Also I need you opinion about 
files placement. Now it is placed in

*drivers/power/avs/abb.c*

And header will be added to
*include/linux/power/abb.h*

Regards,
Andrii

