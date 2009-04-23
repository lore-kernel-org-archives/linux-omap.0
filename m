From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH 1/7] OMAP24xx/25xx clock: init osc_ck, sys_ck internal
 lists early
Date: Thu, 23 Apr 2009 02:32:25 -0600 (MDT)
Message-ID: <alpine.DEB.2.00.0904230221190.6400@utopia.booyaka.com>
References: <20090414182039.22344.49790.stgit@localhost.localdomain> <20090414182324.22344.71159.stgit@localhost.localdomain> <alpine.DEB.2.00.0904141229580.32081@utopia.booyaka.com> <20090421195421.GB29943@n2100.arm.linux.org.uk>
 <alpine.DEB.2.00.0904222000240.24299@utopia.booyaka.com> <20090423075337.GA20250@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:45749 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752456AbZDWIc0 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 23 Apr 2009 04:32:26 -0400
In-Reply-To: <20090423075337.GA20250@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

Hello Russell,

On Thu, 23 Apr 2009, Russell King - ARM Linux wrote:

> On Wed, Apr 22, 2009 at 08:01:29PM -0600, Paul Walmsley wrote:
> > The patch also renames clk_init_one() to clk_preinit() to
> > distinguish its function from clk_init() and the individual struct clk
> > init functions.
> 
> That's rather unnecessary.  'clk_init_one' is already unique.  In the
> long run, it's clk_init that needs to go.

Even if clk_init() were to disappear, the struct clk .init function 
pointer would still be present.  clk->init() performs a very different 
kind of initialization than clk_init_one().

> >  Incorporates review comments from Russell King
> > <linux@arm.linux.org.uk>.
> 
> Please don't add this email address to git commit comments.  Thanks.

Updated in the git branch to rmk+kernel.


- Paul
