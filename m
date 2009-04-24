From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] OMAP24xx/25xx clock: init osc_ck, sys_ck internal
 lists early
Date: Thu, 23 Apr 2009 21:13:10 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904232111290.29285@utopia.booyaka.com>
References: <20090414182039.22344.49790.stgit@localhost.localdomain> <20090414182324.22344.71159.stgit@localhost.localdomain> <alpine.DEB.2.00.0904141229580.32081@utopia.booyaka.com> <20090421195421.GB29943@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0904222000240.24299@utopia.booyaka.com> <20090423075337.GA20250@n2100.arm.linux.org.uk> <alpine.DEB.2.00.0904230221190.6400@utopia.booyaka.com> <20090423180031.GD22457@atomide.com> <20090423222612.GA6095@n2100.arm.linux.org.uk>
 <20090423235527.GM22457@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:40963 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754695AbZDXDNL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 23:13:11 -0400
In-Reply-To: <20090423235527.GM22457@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Thu, 23 Apr 2009, Tony Lindgren wrote:

> * Russell King - ARM Linux <linux@arm.linux.org.uk> [090423 15:26]:
> > On Thu, Apr 23, 2009 at 11:00:31AM -0700, Tony Lindgren wrote:
> > > * Paul Walmsley <paul@pwsan.com> [090423 01:35]:
> > > > Hello Russell,
> > > > 
> > > > On Thu, 23 Apr 2009, Russell King - ARM Linux wrote:
> > > > 
> > > > > On Wed, Apr 22, 2009 at 08:01:29PM -0600, Paul Walmsley wrote:
> > > > > > The patch also renames clk_init_one() to clk_preinit() to
> > > > > > distinguish its function from clk_init() and the individual struct clk
> > > > > > init functions.
> > > > > 
> > > > > That's rather unnecessary.  'clk_init_one' is already unique.  In the
> > > > > long run, it's clk_init that needs to go.
> > > > 
> > > > Even if clk_init() were to disappear, the struct clk .init function 
> > > > pointer would still be present.  clk->init() performs a very different 
> > > > kind of initialization than clk_init_one().
> > > 
> > > I'm OK doing the rename in this fix. The original naming can cause
> > > confusion while reading the code.
> > 
> > Well I'm not, and I want to discuss it some more.  And I'm sending Linus
> > a pull request tonight, so I'm dropping the OMAP stuff from that.
> 
> OK. Paul, can you please separate out the rename part into a separate
> patch so we only have a minimal fix & then repost it here?
> 
> That way we'll get the necessary fixes in and you guys can schedule
> other changes for next merge window.

The omap-clock-fixes branch has been updated to remove the rename.

Not that this should stop the discussion, but at least this should no 
longer prevent these needed fixes from going upstream.


- Paul
