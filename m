From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/9] ARM: OMAP: Fix McBSP spin_lock deadlock
Date: Wed, 28 Jan 2009 13:28:55 -0800
Message-ID: <20090128212854.GV32148@atomide.com>
References: <20090128181931.21007.73744.stgit@localhost> <20090128182422.21007.97536.stgit@localhost> <20090128192705.GG23301@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:61099 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433AbZA1V3F (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 28 Jan 2009 16:29:05 -0500
Content-Disposition: inline
In-Reply-To: <20090128192705.GG23301@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, "Stanley.Miao" <stanley.miao@windriver.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090128 11:27]:
> On Wed, Jan 28, 2009 at 10:24:22AM -0800, Tony Lindgren wrote:
> > From: Stanley.Miao <stanley.miao@windriver.com>
> > 
> > A spin_lock deadlock will occur when omap_mcbsp_request() is invoked.
> > 
> > omap_mcbsp_request()
> > \- clk_enable(mcbsp->clk)         [takes and holds clockfw_lock]
> >     \- omap2_clk_enable()
> >        \- _omap2_clk_enable()
> >            \- omap_mcbsp_clk_enable()
> >               \- clk_enable(child clock)   [tries for clockfw_lock again]
> > 
> > mcbsp_clk is a virtual clock and it comprises several child clocks. when
> > enable mcbsp_clk in omap_mcbsp_request(), the enable function of mcbsp_clk
> > will enable its child clocks, then the deadlock occurs.
> 
> I'm debating about this.  On one hand, it looks like this has been like
> this for approaching six months, so what's a few more months to wait
> for the clkdev stuff.

Yeah that's why we've been going back and forth with this on the
linux-omap list.

> On the other hand, we probably need this fix.  The question is, are there
> real problems being caused by this, or is this patch just the result of
> code analysis?  And can these problems be produced with mainline (iow,
> do we have enough other code merged to expose this)?

AFAIK it happens in the mainline with CONFIG_PREMEPT and ASoC.

Tony
