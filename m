From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH 5/6] ARM: OMAP3+: ABB: introduce ABB driver
Date: Thu, 28 Mar 2013 17:35:13 -0500
Message-ID: <20130328223513.GA19470@kahuna>
References: <1364490968-13613-1-git-send-email-andrii.tseglytskyi@ti.com>
 <1364490968-13613-5-git-send-email-andrii.tseglytskyi@ti.com>
 <20130328212739.13785.44736@quantum>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:45061 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607Ab3C1WfO (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 28 Mar 2013 18:35:14 -0400
Content-Disposition: inline
In-Reply-To: <20130328212739.13785.44736@quantum>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Mike Turquette <mturquette@linaro.org>
Cc: Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>, Tero Kristo <t-kristo@ti.com>, =?iso-8859-1?Q?Beno=EEt?= Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org

- ti internal list which got into the git send-email by error. Apologies
on the bounces which might have resulted...

On 14:27-20130328, Mike Turquette wrote:
> Quoting Andrii Tseglytskyi (2013-03-28 10:16:07)
> > From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>
Ownership of ABB driver patch probably still belongs to Mike as the original
author of the code and working out all the details to entitle ABB on OMAP
platforms :)
> > 
[..]
> You should probably post this as an RFC.  It remains to be seen if using
> the clk rate-change notifiers will be the mechanism for scaling voltage
> in The Future.  This patch is helpful for the purposes of that
> discussion but shouldn't be merged until there is more consensus.
I agree. + include linux-arm-kernel and lkml in CC on the next *public*
revision :).

[..]
> 
> > +/*
> > + * struct omap_abb_data - common data for each instance of ABB ldo
> > + *
> > + * @opp_sel_mask:      selects Fast/Nominal/Slow OPP for ABB
> > + * @opp_change_mask:   selects OPP_CHANGE bit value
> > + * @sr2_wtcnt_value_mask:      LDO settling time for active-mode OPP change
> > + * @sr2en_mask:                        enables/disables ABB
> > + * @fbb_sel_mask:              selects FBB mode
> > + * @rbb_sel_mask:              selects RBB mode
> > + * @settling_time:     IRQ handle used to resolve IRQSTATUS offset & masks
> > + * @clock_cycles:      value needed for LDO setting time calculation
> > + * @setup_offs:                PRM_LDO_ABB_XXX_SETUP register offset
> > + * @control_offs:      PRM_LDO_ABB_IVA_CTRL register offset
> 
> Can you align all of these?
We should check up on AM and DM series as well - if the bit offsets are
precisely the same, we could stick with macros instead of having the
masks and register offsets in a device specific manner.

[..]
> > +/**
> > + * omap_abb_readl() - reads ABB control memory
> > + * @abb:       pointer to the abb instance
> > + * @offs:      offset to read
> > + *
> > + * Returns @offs value
> > + */
> > +static u32 omap_abb_readl(struct omap_abb *abb, u32 offs)
> > +{
> > +       return __raw_readl(abb->control + offs);
> > +}
> 
> readl instead of __raw_readl?
Ack. readl/writel should be used..

> > +/**
> > + * omap_abb_clock_rate_change() - ABB clock notifier callback
> > + * @nb:                notifier block
> > + * @flags:     notifier event type
> > + * @data:      notifier data, contains clock rates
> > + *
> > + * Returns NOTIFY_OK
> > + */
> > +static int omap_abb_clock_rate_change(struct notifier_block *nb,
> > +                                     unsigned long flags, void *data)
> > +{
> > +       struct clk_notifier_data *cnd = data;
> > +       struct omap_abb *abb = container_of(nb, struct omap_abb, abb_clk_nb);
> > +
> > +       switch (flags) {
> > +       case PRE_RATE_CHANGE:
> > +               omap_abb_pre_scale(abb, cnd->old_rate, cnd->new_rate);
> > +               break;
> > +       case POST_RATE_CHANGE:
> > +               omap_abb_post_scale(abb, cnd->old_rate, cnd->new_rate);
> > +               break;
> > +       }
> > +
> > +       return NOTIFY_OK;
> > +}
> 
> How does this synchronize with the VC/VP voltage transition?  Ordering
> is important here and if the clk rate-change notifiers are used for both
> a VP force update and for an FBB transition there is no guarantee of the
> ordering.
I need to dig into this series deeper, but the requirement is as
follows:
Actual voltage change may occur with vc/vp - OMAP3,4,5 OR with i2c1- AM
series or the upcoming DRA SoCs, intent is to model the vc-vp->pmic as
regulators (some internal patches circulate for this, but not mature enough
to be send out in a public list yet)

Key however is:
* if we do as clock notifiers(as this series attempts I believe), we'd get ABB
settings around clock change boundary.
Alternative might be to do it around voltage change - we could, in
theory:
a) make an omap voltage regulator and provide notifier around the same
and hook ABB to it. the omap voltage regulator will in turn call the
appropriate voltage regulator (modelled from a regulator that controls
an PMIC over i2c1 OR over vc-vp regulator)
b) make ABB as an regulator by itself?
c) how might this work if we have DVFS capability in CCF itself[1]? it
might be better to have it as notifiers to regulator (the pseudo
omap-voltage regulator perhaps?)

[1] CCF DVFS patches:
https://patchwork.kernel.org/patch/2195431/
https://patchwork.kernel.org/patch/2195421/
https://patchwork.kernel.org/patch/2195451/
https://patchwork.kernel.org/patch/2195441/
https://patchwork.kernel.org/patch/2195461/

-- 
Regards,
Nishanth Menon
