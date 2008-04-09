From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 5/17] ARM: OMAP2: Change 24xx to use new register access
Date: Wed, 9 Apr 2008 21:54:33 +0000
Message-ID: <20080409215433.GQ31071@atomide.com>
References: <1205848935-12078-1-git-send-email-tony@atomide.com> <1205848935-12078-2-git-send-email-tony@atomide.com> <1205848935-12078-3-git-send-email-tony@atomide.com> <1205848935-12078-4-git-send-email-tony@atomide.com> <1205848935-12078-5-git-send-email-tony@atomide.com> <1205848935-12078-6-git-send-email-tony@atomide.com> <20080407164856.GG5306@flint.arm.linux.org.uk> <20080409205713.GM31071@atomide.com> <20080409212203.GA31636@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-bos.mailhop.org ([63.208.196.179]:55018 "EHLO
	mho-02-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752490AbYDIVyu (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Apr 2008 17:54:50 -0400
Content-Disposition: inline
In-Reply-To: <20080409212203.GA31636@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080409 21:22]:
> On Wed, Apr 09, 2008 at 08:57:13PM +0000, Tony Lindgren wrote:
> > Here's how it now looks:
> 
> Not quite.  The point I was trying to make is:
> 
> > @@ -302,15 +288,17 @@
> >  	int eth_cs;
> >  	unsigned long cs_mem_base;
> >  	unsigned int muxed, rate;
> > -	struct clk *l3ck;
> > +	struct clk *gpmc_fck;
> >  
> >  	eth_cs	= H4_SMC91X_CS;
> >  
> > -	l3ck = clk_get(NULL, "core_l3_ck");
> > -	if (IS_ERR(l3ck))
> > -		rate = 100000000;
> > -	else
> > -		rate = clk_get_rate(l3ck);
> > +	gpmc_fck = clk_get(NULL, "gpmc_fck");	/* Always on ENABLE_ON_INIT */
> > +	if (IS_ERR(gpmc_fck)) {
> > +		WARN_ON(1);
> > +		return;
> > +	}
> > +
> 
> that there should be a call to clk_enable() here - if even if it's
> apparantly "always on".  (If it's always enabled then the call won't
> do any harm anyway - it just serves to ensure that the API conditions
> are followed.)

OK, I'll clk_enable() before clk_get_rate() and then clk_disable() to
make usecounts happy as rate is only needed for setting GPMC timings:

@@ -302,15 +288,19 @@
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
+	clk_enable(gpmc_fck);
+	rate = clk_get_rate(gpmc_fck);
+	clk_disable(gpmc_fck);
 
 	if (is_gpmc_muxed())
 		muxed = 0x200;

Regards,

Tony
