From: "stanley.miao" <stanley.miao@windriver.com>
Subject: Re: [PATCH v2] OMAP: Fix McBSP spin_lock deadlock.
Date: Wed, 14 Jan 2009 09:39:05 +0800
Message-ID: <1231897145.29324.31.camel@localhost>
References: <1225975475-9300-1-git-send-email-stanley.miao@windriver.com>
	 <1226065961.24669.8.camel@localhost> <20090108133356.GI27566@atomide.com>
	 <1231756958.24932.4.camel@localhost>  <20090112104611.GB9373@atomide.com>
Reply-To: stanley.miao@windriver.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail.windriver.com ([147.11.1.11]:49394 "EHLO mail.wrs.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752606AbZANBad (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 13 Jan 2009 20:30:33 -0500
In-Reply-To: <20090112104611.GB9373@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org

On Mon, 2009-01-12 at 12:46 +0200, Tony Lindgren wrote:
> * stanley.miao <stanley.miao@windriver.com> [090112 12:34]:
> > On Thu, 2009-01-08 at 15:33 +0200, Tony Lindgren wrote:
> > > * stanley.miao <stanley.miao@windriver.com> [081107 15:47]:
> > > > This solution keeps the virtual clock in place and enable the child
> > > > clocks before enable the virtual clock. So, any comments ?
> > > 
> > > What if we just removed the custom clock and had a struct **clk
> > > in struct omap_mcbsp that contains the clocks for each instance?
> > 
> > It works. This is what I did in my first patch. 
> 
> OK, sorry for all this going back and forth..

It's OK. In order to make the code better, it is worth a little more
job.

>  We still don't
> have a good long term solution on how to handle different clocks..
> 
<snip>
> 
> Sounds like we should just apply your original patch, then figure
> out a good long term approacth.
> 
> Can you please repost your first version of the patch?

I will post the patch V3.

Stanley.

> 
> Regards,
> 
> Tony
