From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH] ARM: OMAP3: Fix omapfb's problem on OMAP3430sdp
Date: Mon, 08 Sep 2008 10:27:19 +0800
Message-ID: <1220840839.28777.4.camel@localhost>
References: <1220276228.2680.9.camel@localhost>
	 <c656a4d20809012249p43213688pce54884c24541fcd@mail.gmail.com>
	 <1220336007.19839.6.camel@localhost> <20080902081429.GB6928@frodo>
	 <1220347997.7042.5.camel@localhost>  <20080905171311.GK24202@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:33172 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628AbYIHCZL (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sun, 7 Sep 2008 22:25:11 -0400
In-Reply-To: <20080905171311.GK24202@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

On Fri, 2008-09-05 at 10:13 -0700, Tony Lindgren wrote:
> * stanley.miao <stanley.miao@windriver.com> [080902 02:32]:
> > Thanks. I resolved the style problem. If gpio function needs to be
> > changed, I think it should be in a single patch.
> > 
> > Re-send the patch again.
> > 
> > Fix omapfb's problem on OMAP3430
> > 
> > Signed-off-by: Stanley.Miao <stanley.miao@windriver.com>
> > ---
> >  drivers/video/omap/lcd_2430sdp.c |   17 +++++++++++++++++
> >  1 files changed, 17 insertions(+), 0 deletions(-)
> > 
[...]
> >  
> >  #define t2_out(c, r, v) twl4030_i2c_write_u8(c, r, v)
> >  
> > @@ -77,6 +82,13 @@ static int sdp2430_panel_enable(struct lcd_panel
> > *panel)
> >  	u8 ded_val, ded_reg;
> >  	u8 grp_val, grp_reg;
> >  
> > +	if (is_sil_rev_greater_than(OMAP3430_REV_ES1_0)) {
> > +		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEDICATED,
> > +					TWL4030_VPLL2_DEDICATED);
> > +		t2_out(PM_RECEIVER, ENABLE_VPLL2_DEV_GRP,
> > +					TWL4030_VPLL2_DEV_GRP);
> > +	}
> > +
> >  	if (machine_is_omap_3430sdp()) {
> >  		ded_reg = TWL4030_VAUX3_DEDICATED;
> >  		ded_val = ENABLE_VAUX3_DEDICATED;
> 
> How about putting the is_sel_rev_greater_than test within the
> machine_is_omap3430sdp test?

Good, this will run fewer instructions on 2430sdp.

Stanley.

> 
> Tony

