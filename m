From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.34-rc5
Date: Tue, 27 Apr 2010 09:12:17 -0700
Message-ID: <20100427161217.GB7225@atomide.com>
References: <20100426190005.GJ7225@atomide.com>
 <alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57052 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610Ab0D0QMQ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 12:12:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [100427 08:28]:
> 
> On Mon, 26 Apr 2010, Tony Lindgren wrote:
> > 
> > Please pull omap fixes from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus
> 
> I pulled it this time, but I'm starting to get really irritated with you.
> 
> These look like real fixes, but quite frankly, by -rc5, that IS NOT 
> ENOUGH. 
> 
> They need to be _regressions_, not just cleanups and fixes for things that 
> have never worked. And this is starting to be a pattern with the omap 
> tree: you're not honoring the merge window properly.
> 
> Just "it's a bug-fix" or "it's deleting unused code" is not enough. The 
> point of the late -rc series is to fix problems from the merge window, not 
> add new changes. I realize that you think that all the new changes are 
> obviously good, but the fact is, bugs happen even in "obvious bug-fixes". 
> 
> And that's why we have the rule about late-rc pulls being about 
> _regressions_ and/or major oopses/security issues. Not just random 
> development that are meant to improve things.

OK point taken. I should have dealt with this earlier. Will only queue
regressions after -rc3 or so.

Regards,

Tony
