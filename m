From: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>
Subject: RE: [PATCH] OMAP: Exporting functions doing common register access
Date: Thu, 7 Jan 2010 19:39:59 +0530
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB031E0A39D8@dbde02.ent.ti.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com>
 <alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com>
 <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com>
 <20091118163314.d0325283.jhnikula@gmail.com>
 <alpine.DEB.2.00.0911181220560.9248@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:38237 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752040Ab0AGOKN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 7 Jan 2010 09:10:13 -0500
In-Reply-To: <alpine.DEB.2.00.0911181220560.9248@utopia.booyaka.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>, Jarkko Nikula <jhnikula@gmail.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Lohithakshan, Ranjith" <ranjithl@ti.com>

> > > In the interim, I would suggest that you remove the the clock source
> and
> > > receiver source change functions from omap-mcbsp.c, split them into
> OMAP1
> > > and OMAP2/3 variants, and place them into arch/arm/mach-omap*/mcbsp.c.
> > > Expand struct omap_mcbsp_ops to add function pointers to those
> functions.
> > > Call those from soc/omap-mcbsp.c via mcbsp->pdata->ops. That way you
> won't
> > > need those exports.
> > >
> > Paul: What's your opinnion, would it be possible or would it be wise to
> > handle these McBSP clock route setups with the clock framework instead?
> >
> > Functions omap_mcbsp_dai_set_clks_src and omap_mcbsp_dai_set_rcvr_src
> > are basically just setting up the input clock for McBSP SRG or McBSP1
> > receiver.
> 
> Sure.  There already should be some support for it in clock34xx.h, but I
> doubt anyone's tested it:
> 
> static struct clk mcbsp1_fck = {
>         .name           = "mcbsp_fck",
>         .ops            = &clkops_omap2_dflt_wait,
>         .id             = 1,
>         .init           = &omap2_init_clksel_parent,
>         .enable_reg     = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
>         .enable_bit     = OMAP3430_EN_MCBSP1_SHIFT,
>         .clksel_reg     = OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
>         .clksel_mask    = OMAP2_MCBSP1_CLKS_MASK,
>         .clksel         = mcbsp_15_clksel,
>         .clkdm_name     = "core_l4_clkdm",
>         .recalc         = &omap2_clksel_recalc,
> };
> 
> etc.  Some similar entries would need to be added to the clock24xx.h file.
[Aggarwal, Anuj] One problem which I found in trying the above discussed 
approach is that I am not able to get mcbsp clock handles in omap-mcbsp.c 
file. To call clk_set_parent() with the new parent clock as "mcbsp_clks" 
(in case of an external clock), I need the mcbsp_fck clock handle. But this
handle is not shared with the omap_mcbsp_dai[].

What should be the right method of getting this handle in 
omap_mcbsp_dai_set_dai_sysclk(), in case I understood the concept properly.
Basically, we want to get rid of the low level stuff in this function 
and instead use standard clock framework APIs?
