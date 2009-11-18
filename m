From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH] OMAP: Exporting functions doing common register access
Date: Wed, 18 Nov 2009 12:30:33 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0911181220560.9248@utopia.booyaka.com>
References: <1258384836-24854-1-git-send-email-anuj.aggarwal@ti.com> <alpine.DEB.2.00.0911161408260.29213@utopia.booyaka.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A8C8EC2@dbde02.ent.ti.com> <5A47E75E594F054BAF48C5E4FC4B92AB030A9CA8F7@dbde02.ent.ti.com>
 <alpine.DEB.2.00.0911180324350.25515@utopia.booyaka.com> <20091118163314.d0325283.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:43625 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758083AbZKRTa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 18 Nov 2009 14:30:27 -0500
In-Reply-To: <20091118163314.d0325283.jhnikula@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: "Aggarwal, Anuj" <anuj.aggarwal@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>

Hi Jarkko,

On Wed, 18 Nov 2009, Jarkko Nikula wrote:

> On Wed, 18 Nov 2009 03:40:40 -0700 (MST)
> Paul Walmsley <paul@pwsan.com> wrote:
> 
> > In the interim, I would suggest that you remove the the clock source and 
> > receiver source change functions from omap-mcbsp.c, split them into OMAP1 
> > and OMAP2/3 variants, and place them into arch/arm/mach-omap*/mcbsp.c.  
> > Expand struct omap_mcbsp_ops to add function pointers to those functions.  
> > Call those from soc/omap-mcbsp.c via mcbsp->pdata->ops. That way you won't 
> > need those exports.
> > 
> Paul: What's your opinnion, would it be possible or would it be wise to
> handle these McBSP clock route setups with the clock framework instead?
> 
> Functions omap_mcbsp_dai_set_clks_src and omap_mcbsp_dai_set_rcvr_src
> are basically just setting up the input clock for McBSP SRG or McBSP1
> receiver.

Sure.  There already should be some support for it in clock34xx.h, but I 
doubt anyone's tested it:

static struct clk mcbsp1_fck = {
        .name           = "mcbsp_fck",
        .ops            = &clkops_omap2_dflt_wait,
        .id             = 1,
        .init           = &omap2_init_clksel_parent,
        .enable_reg     = OMAP_CM_REGADDR(CORE_MOD, CM_FCLKEN1),
        .enable_bit     = OMAP3430_EN_MCBSP1_SHIFT,
        .clksel_reg     = OMAP343X_CTRL_REGADDR(OMAP2_CONTROL_DEVCONF0),
        .clksel_mask    = OMAP2_MCBSP1_CLKS_MASK,
        .clksel         = mcbsp_15_clksel,
        .clkdm_name     = "core_l4_clkdm",
        .recalc         = &omap2_clksel_recalc,
};

etc.  Some similar entries would need to be added to the clock24xx.h file.

> > I don't understand how this code compiled on OMAP1 in any case, since it 
> > doesn't have a System Control Module.
> > 
> OMAP1 can include control.h as well :-)

Yeah, I guess it is this stuff in control.h that makes it work:

#define omap_ctrl_base_get()            0
#define omap_ctrl_readb(x)              0
#define omap_ctrl_readw(x)              0
#define omap_ctrl_readl(x)              0
#define omap_ctrl_writeb(x, y)          WARN_ON(1)
#define omap_ctrl_writew(x, y)          WARN_ON(1)
#define omap_ctrl_writel(x, y)          WARN_ON(1)

Would be nice to get rid of that at some point.


- Paul
