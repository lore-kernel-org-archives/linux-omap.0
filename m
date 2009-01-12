From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Mon, 12 Jan 2009 12:46:12 +0200
Message-ID: <20090112104611.GB9373@atomide.com>
References: <1225975475-9300-1-git-send-email-stanley.miao@windriver.com> <1226065961.24669.8.camel@localhost> <20090108133356.GI27566@atomide.com> <1231756958.24932.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:64415 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752120AbZALKqP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 Jan 2009 05:46:15 -0500
Content-Disposition: inline
In-Reply-To: <1231756958.24932.4.camel@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "stanley.miao" <stanley.miao@windriver.com>
Cc: linux-omap@vger.kernel.org

* stanley.miao <stanley.miao@windriver.com> [090112 12:34]:
> On Thu, 2009-01-08 at 15:33 +0200, Tony Lindgren wrote:
> > * stanley.miao <stanley.miao@windriver.com> [081107 15:47]:
> > > This solution keeps the virtual clock in place and enable the child
> > > clocks before enable the virtual clock. So, any comments ?
> > 
> > What if we just removed the custom clock and had a struct **clk
> > in struct omap_mcbsp that contains the clocks for each instance?
> 
> It works. This is what I did in my first patch. 

OK, sorry for all this going back and forth.. We still don't
have a good long term solution on how to handle different clocks..

> The difference is I add two struct *clk in struct omap_mcbsp.
> 
> struct omap_mcbsp {
> @@ -365,7 +366,8 @@ struct omap_mcbsp {
>         /* Protect the field .free, while checking if the mcbsp is in
> use */
>         spinlock_t lock;
>         struct omap_mcbsp_platform_data *pdata;
> -       struct clk *clk;
> +       struct clk *ick;
> +       struct clk *fck;
> 
> 
> If one struct **clk is better, I will resend the patch later.

Sounds like we should just apply your original patch, then figure
out a good long term approacth.

Can you please repost your first version of the patch?

Regards,

Tony
