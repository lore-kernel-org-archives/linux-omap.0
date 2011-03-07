From: Vishwanath Sripathy <vishwanath.bs@ti.com>
Subject: RE: [PATCH 1/1] omap3: Save and restore CM_AUTOIDLE_PLL across off mode
Date: Mon, 7 Mar 2011 15:30:30 +0530
Message-ID: <c9be31ca3dab99320a409e957330506c@mail.gmail.com>
References: <1297353724-11665-1-git-send-email-premi@ti.com>
 <1297353724-11665-2-git-send-email-premi@ti.com> <alpine.DEB.2.00.1103041540540.10981@utopia.booyaka.com>
 <B85A65D85D7EB246BE421B3FB0FBB593024C0E5A55@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:42704 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755517Ab1CGKAc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Mar 2011 05:00:32 -0500
Received: by wya21 with SMTP id 21so5015449wya.21
        for <linux-omap@vger.kernel.org>; Mon, 07 Mar 2011 02:00:29 -0800 (PST)
In-Reply-To: <B85A65D85D7EB246BE421B3FB0FBB593024C0E5A55@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sanjeev Premi <premi@ti.com>, Paul Walmsley <paul@pwsan.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Premi, Sanjeev
> Sent: Monday, March 07, 2011 2:16 PM
> To: Paul Walmsley
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: RE: [PATCH 1/1] omap3: Save and restore CM_AUTOIDLE_PLL
> across off mode
>
> > -----Original Message-----
> > From: Paul Walmsley [mailto:paul@pwsan.com]
> > Sent: Saturday, March 05, 2011 4:16 AM
> > To: Premi, Sanjeev
> > Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> > Subject: Re: [PATCH 1/1] omap3: Save and restore
> CM_AUTOIDLE_PLL across
> > off mode
> >
> > Hello Sanjeev,
> >
> > On Thu, 10 Feb 2011, Sanjeev Premi wrote:
> >
> > > As per commit "bb33cc58", ROM code is expected to restore
> > > context related to CORE domain. As part of this change,
> > > CM_AUTOIDLE_PLL is neither saved nor restored.
> >
> > ... by Linux.
> [sp] Yes.
>
> >
> > > This results in loosing the value of AUTO_PERIPH_DPLL.
> >
> > A few questions:
> >
> > - Is ROM code supposed to restore this register?
> [sp] Going by the description of the commit message I referenced, it
>      It appears to be the case. I am yet to get official confirmation
>      from the ROM code team (usually takes quite long); but all
>      experiments (i put them in patch 0/1) suggest so.
> >
> > - Is there a documented list of which registers/bitfields the ROM code
> > will and won't restore?
> [sp] No that I am aware of; but yes I have already requested for same
>      since this issue was found.
> >
> > - Are the entire contents of the register lost, or just
> AUTO_PERIPH_DPLL?
> [sp] Just AUTO_PERIPH_DPLL.
As per OMAP3630 TRM Section 26.5, register CM_AUTOIDLE_PLL is supposed to
be restored by ROM code. The PM code should only store these registers
before entering off mode. So only thing that needs to be done in this
patch set is to save these registers.

Vishwa



>
> >
> > > The concern of setting the AUTOIDLE flag before the DPLL
> > > is locked seems valid. Hence, the restoration of this
> > > register is delayed until after the context of PER
> > > domain is restored.
> >
> > Could you explain a little more about this?  Is there a hardware
> > limitation where AUTO_PERIPH_DPLL shouldn't be set unless the DPLL
> is
> > locked?
> [sp] This is based on my understanding (and observation) that DPLL may
>      take longer to lock after resume. Now if the clock goes to AUTOIDLE
>      before it is locked; I am not sure what would be the consequences.
> >
> > >
> > > The patch has been verified on OMAP3EVM by checking value
> > > of CM_AUTOIDLE_PLL register across the suspend/resume
> > > sequence (using devmem) with flags sleep_while_idle and
> > > enable_off_mode set to 1.
> > >
> > > Signed-off-by: Sanjeev Premi <premi@ti.com>
> > > ---
>
> [sp]
> [snip]...[snip]
>
> > >
> > > +/**
> > > + * Restore the contents of CM_AUTOIDLE_PLL register.
> > > + *
> > > + * The implementation below restores AUTO_CORE_DPLL as 'good'
> > redundancy.
> >
> > I don't understand this part.  Are the entire contents of the register
> > lost, or just the AUTO_PERIPH_DPLL field?
> >
>
> [sp] As put above, only AUTO_PERIPH_DPLL; but this is based on
> observation
>      not a *real specification*; I chose to set the AUTO_CORE_DPLL bit
as
>      redundancy.
>
> ~sanjeev
>
> > > + */
> > > +static void pll_mod_restore_autoidle(void)
> > > +{
> > > +	u32 ctx = stored_cm_autoidle_pll();
> > > +	u32 val = omap2_cm_read_mod_reg(PLL_MOD, CM_AUTOIDLE);
> > > +
> > > +	if (ctx & OMAP3430_AUTO_CORE_DPLL_MASK)
> > > +		val |= ctx & OMAP3430_AUTO_CORE_DPLL_MASK;
> > > +
> > > +	if (ctx & OMAP3430_AUTO_PERIPH_DPLL_MASK)
> > > +		val |= ctx & OMAP3430_AUTO_PERIPH_DPLL_MASK;
> > > +
> > > +	omap2_cm_write_mod_reg(val, PLL_MOD, CM_AUTOIDLE);
> > > +}
> > > +
> [snip]...[snip]
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
