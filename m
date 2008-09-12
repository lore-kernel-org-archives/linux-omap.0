From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] OMAP3 clock: remove extra init from csi2_96m_fck
Date: Fri, 12 Sep 2008 10:33:18 -0700
Message-ID: <20080912173317.GB10675@atomide.com>
References: <20080910234736.GS21163@atomide.com> <A24693684029E5489D1D202277BE894411CCEEC5@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64638 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753293AbYILRdV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 12 Sep 2008 13:33:21 -0400
Content-Disposition: inline
In-Reply-To: <A24693684029E5489D1D202277BE894411CCEEC5@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Aguirre Rodriguez, Sergio Alberto" <saaguirre@ti.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

* Aguirre Rodriguez, Sergio Alberto <saaguirre@ti.com> [080912 09:30]:
> Isn't this patch meant to be pushed after "Update powerdomains and clockdomains" series from Paul?
> 
> I don't see that yet.

Sorry, will push that series today.

Tony

> 
> Regards,
> Sergio
> 
> -----Original Message-----
> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-owner@vger.kernel.org] On Behalf Of Tony Lindgren
> Sent: Wednesday, September 10, 2008 6:48 PM
> To: Paul Walmsley
> Cc: linux-omap@vger.kernel.org
> Subject: Re: [PATCH] OMAP3 clock: remove extra init from csi2_96m_fck
> 
> * Paul Walmsley <paul@pwsan.com> [080909 09:59]:
> > 
> > csi2_96m_fck no longer should attempt to init its clockdomain pointer; the 
> > clock framework now does this by default.  Applies on top of the "Update 
> > powerdomains and clockdomains" series sent earlier.
> > 
> > Verified on 3430SDP ES2.
> 
> Pushing today.
> 
> Tony
> 
> > 
> > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > ---
> >  arch/arm/mach-omap2/clock34xx.h |    1 -
> >  1 files changed, 0 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock34xx.h b/arch/arm/mach-omap2/clock34xx.h
> > index 65568c3..56ae83f 100644
> > --- a/arch/arm/mach-omap2/clock34xx.h
> > +++ b/arch/arm/mach-omap2/clock34xx.h
> > @@ -2298,7 +2298,6 @@ static struct clk cam_ick = {
> >  static struct clk csi2_96m_fck = {
> >  	.name		= "csi2_96m_fck",
> >  	.parent		= &core_96m_fck,
> > -	.init		= &omap2_init_clk_clkdm,
> >  	.enable_reg	= _OMAP34XX_CM_REGADDR(OMAP3430_CAM_MOD, CM_FCLKEN),
> >  	.enable_bit	= OMAP3430_EN_CSI2_SHIFT,
> >  	.flags		= CLOCK_IN_OMAP343X,
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
