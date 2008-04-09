From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/17] ARM: OMAP2: Change 24xx to use new register access
Date: Wed, 9 Apr 2008 20:57:13 +0000
Message-ID: <20080409205713.GM31071@atomide.com>
References: <1205848935-12078-1-git-send-email-tony@atomide.com> <1205848935-12078-2-git-send-email-tony@atomide.com> <1205848935-12078-3-git-send-email-tony@atomide.com> <1205848935-12078-4-git-send-email-tony@atomide.com> <1205848935-12078-5-git-send-email-tony@atomide.com> <1205848935-12078-6-git-send-email-tony@atomide.com> <20080407164856.GG5306@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:52820 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYDIU5T (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 16:57:19 -0400
Content-Disposition: inline
In-Reply-To: <20080407164856.GG5306@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080407 16:49]:
> On Tue, Mar 18, 2008 at 04:02:03PM +0200, Tony Lindgren wrote:
> > From: Paul Walmsley <paul@pwsan.com>
> > 
> > This patch changes 24xx to use new register access, except for clock
> > framework. Clock framework register access will get updates in the
> > next patch.
> 
> Hmm...
> 
> > @@ -187,13 +189,40 @@ static inline void __init apollon_init_smc91x(void)
> >  {
> >  	unsigned long base;
> >  
> > +	unsigned int rate;
> > +	struct clk *l3ck;
> > +	int eth_cs;
> > +
> > +	l3ck = clk_get(NULL, "core_l3_ck");
> > +	if (IS_ERR(l3ck))
> > +		rate = 100000000;
> > +	else
> > +		rate = clk_get_rate(l3ck);
> 
> Now read:
> 
> /**
>  * clk_get_rate - obtain the current clock rate (in Hz) for a clock source.
>  *                This is only valid once the clock source has been enabled.
>  * @clk: clock source
>  */
> unsigned long clk_get_rate(struct clk *clk);
> 
> And now tell me what's wrong with the above code.
> 
> > +	int eth_cs;
> > +	unsigned long cs_mem_base;
> > +	unsigned int muxed, rate;
> > +	struct clk *l3ck;
> > +
> > +	eth_cs	= H4_SMC91X_CS;
> > +
> > +	l3ck = clk_get(NULL, "core_l3_ck");
> > +	if (IS_ERR(l3ck))
> > +		rate = 100000000;
> > +	else
> > +		rate = clk_get_rate(l3ck);
> 
> Ditto.

This has been fixed with following changes:

- Use gpmc_fck instead of core_l3_ck as core_l3_ck is not the right
  clock to use (although the rates are the same as it's the parent).

- Mark gpmc_fck with ENABLE_ON_INIT so it's always on and autoidled

- Remove fixed rate setting on clk_get() error, it's not needed

Here's how it now looks:

@@ -302,15 +288,17 @@
 	int eth_cs;
 	unsigned long cs_mem_base;
 	unsigned int muxed, rate;
-	struct clk *l3ck;
+	struct clk *gpmc_fck;
 
 	eth_cs	= H4_SMC91X_CS;
 
-	l3ck = clk_get(NULL, "core_l3_ck");
-	if (IS_ERR(l3ck))
-		rate = 100000000;
-	else
-		rate = clk_get_rate(l3ck);
+	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
+	if (IS_ERR(gpmc_fck)) {
+		WARN_ON(1);
+		return;
+	}
+
+	rate = clk_get_rate(gpmc_fck);
 
 	if (is_gpmc_muxed())
 		muxed = 0x200;

Will repost the whole series.

Tony
