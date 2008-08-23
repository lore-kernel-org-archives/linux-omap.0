From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 07/16] ARM: OMAP2: Add clkdm_get_pwrdm()
Date: Sat, 23 Aug 2008 15:38:57 -0700
Message-ID: <20080823223857.GE4713@atomide.com>
References: <1212804762-18413-1-git-send-email-tony@atomide.com> <1212804762-18413-2-git-send-email-tony@atomide.com> <1212804762-18413-3-git-send-email-tony@atomide.com> <1212804762-18413-4-git-send-email-tony@atomide.com> <1212804762-18413-5-git-send-email-tony@atomide.com> <1212804762-18413-6-git-send-email-tony@atomide.com> <20080819172953.GD17034@flint.arm.linux.org.uk> <20080820073731.GD28862@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:50165 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbYHWWjD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 23 Aug 2008 18:39:03 -0400
Content-Disposition: inline
In-Reply-To: <20080820073731.GD28862@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [080820 00:37]:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [080819 20:30]:
> > On Fri, Jun 06, 2008 at 07:12:33PM -0700, Tony Lindgren wrote:
> > > From: Paul Walmsley <paul@pwsan.com>
> > > 
> > > Add clkdm_get_pwrdm() to the clockdomain code.  It will return a
> > > pointer to the powerdomain struct that the clockdomain is contained
> > > within.  Used by the PM code.
> > > 
> > > Signed-off-by: Paul Walmsley <paul@pwsan.com>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > 
> > This patch should have been merged into the patch creating clockdomain.c
> > before it was sent upstream.  It's clearly a function which was missed
> > out of Paul's original patch.
> > 
> > There's no requirement to ensure that every bit of microscopic history
> > behind the development of a feature is preserved into the mainline
> > kernel tree - it's actually preferred that it isn't.
> > 
> > Another reason for doing so is to cut down on the amount of reviewing
> > that has to be done upstream.  Given the amount of churn in OMAP land,
> > reducing compressing changes _sanely_ should be a priority.
> 
> Yeah I agree.
> 
> > > diff --git a/include/asm-arm/arch-omap/clockdomain.h b/include/asm-arm/arch-omap/clockdomain.h
> > > index d2a4551..e71fee4 100644
> > > --- a/include/asm-arm/arch-omap/clockdomain.h
> > > +++ b/include/asm-arm/arch-omap/clockdomain.h
> > > @@ -94,6 +94,9 @@ struct clockdomain *clkdm_lookup(const char *name);
> > >  int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
> > >  struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
> > >  
> > > +int clkdm_for_each(int (*fn)(struct clockdomain *clkdm));
> > > +struct powerdomain *clkdm_get_pwrdm(struct clockdomain *clkdm);
> > > +
> > 
> > These prototypes are already there, so this isn't required.
> 
> Will fix.

Looks like this one you already have in your devel branch.

Tony
