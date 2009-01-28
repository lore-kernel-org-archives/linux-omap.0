From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 19:27:05 +0000
Message-ID: <20090128192705.GG23301@n2100.arm.linux.org.uk>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182422.21007.97536.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:44989 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359AbZA1T1X (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 14:27:23 -0500
Content-Disposition: inline
In-Reply-To: <20090128182422.21007.97536.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

On Wed, Jan 28, 2009 at 10:24:22AM -0800, Tony Lindgren wrote:
> From: Stanley.Miao <stanley.miao@windriver.com>
> 
> A spin_lock deadlock will occur when omap_mcbsp_request() is invoked.
> 
> omap_mcbsp_request()
> \- clk_enable(mcbsp->clk)         [takes and holds clockfw_lock]
>     \- omap2_clk_enable()
>        \- _omap2_clk_enable()
>            \- omap_mcbsp_clk_enable()
>               \- clk_enable(child clock)   [tries for clockfw_lock again]
> 
> mcbsp_clk is a virtual clock and it comprises several child clocks. when
> enable mcbsp_clk in omap_mcbsp_request(), the enable function of mcbsp_clk
> will enable its child clocks, then the deadlock occurs.

I'm debating about this.  On one hand, it looks like this has been like
this for approaching six months, so what's a few more months to wait
for the clkdev stuff.

On the other hand, we probably need this fix.  The question is, are there
real problems being caused by this, or is this patch just the result of
code analysis?  And can these problems be produced with mainline (iow,
do we have enough other code merged to expose this)?
