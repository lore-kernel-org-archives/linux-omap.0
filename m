From: Tony Lindgren <tony@atomide.com>
Subject: Re: PRCM_CLKSRC_CTRL bits set incorrectly in omap2_en_osc_ck
Date: Fri, 25 Apr 2008 10:44:02 -0700
Message-ID: <20080425174402.GA7671@atomide.com>
References: <20080425015654.GA7122@ubuntu-workstation> <alpine.DEB.1.00.0804250159350.14755@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:63757 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760077AbYDYRoF (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 25 Apr 2008 13:44:05 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0804250159350.14755@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Seth Forshee <seth.forshee@gmail.com>, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [080425 01:07]:
> Hi Seth,
> 
> On Thu, 24 Apr 2008, Seth Forshee wrote:
> 
> > On my OMAP2430 board I was seeing the contents of DRAM become corrupted
> > shortly after the kernel started.  I tracked this down to
> > omap2_enable_osc_ck().  I think this function is intended to only clear
> > the bits in OMAP_AUTOEXTCLKMODE_MASK, but it has the side-effect of
> > setting all of the other bits in the register.  This includes setting
> > some fields to reserved values.
> > 
> > I'm not 100% sure whether the problem is with omap2_enable_osc_ck() or
> > prm_rmw_reg_bits() (maybe this should be masking off any bits not set in
> > mask), but based on what I see elsewhere I think that
> > omap2_enable_osc_ck() is to blame.  If this is the case, the patch below
> > fixes the problem.
> > 
> > ----------
> > From: Seth Forshee <seth.forshee@gmail.com>
> > Subject: [PATCH] ARM: OMAP2: Set PRCM_CLKSRC_CTRL correctly in omap2_enable_osc_ck
> > 
> > This patch fixes an incorrect use of prm_rmw_reg_bits() in
> > omap2_enable_osc_ck() which is changing bits in PRCM_CLKSRC_CTRL
> > that are unrelated to the function it is performing.
> > 
> > Signed-off-by: Seth Forshee <seth.forshee@gmail.com>
> 
> Indeed, you have found a bug - thanks for the patch!

Pushing today.

Tony


> Acked-by: Paul Walmsley <paul@pwsan.com>
> 
> > ---
> >  arch/arm/mach-omap2/clock24xx.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> > 
> > diff --git a/arch/arm/mach-omap2/clock24xx.c b/arch/arm/mach-omap2/clock24xx.c
> > index 9b7fd15..e7968e7 100644
> > --- a/arch/arm/mach-omap2/clock24xx.c
> > +++ b/arch/arm/mach-omap2/clock24xx.c
> > @@ -78,7 +78,7 @@ static u32 omap2_get_dpll_rate_24xx(struct clk *tclk)
> >  static int omap2_enable_osc_ck(struct clk *clk)
> >  {
> >  
> > -	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, ~OMAP_AUTOEXTCLKMODE_MASK,
> > +	prm_rmw_reg_bits(OMAP_AUTOEXTCLKMODE_MASK, 0,
> >  			 OMAP24XX_PRCM_CLKSRC_CTRL);
> >  
> >  	return 0;
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> 
> - Paul
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
