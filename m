From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Fri, 8 Jan 2010 10:22:37 -0800
Message-ID: <20100108182236.GE6831@atomide.com>
References: <20100108180912.GC6831@atomide.com>
 <alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51170 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646Ab0AHSWm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 13:22:42 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux@atomide.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [100108 10:18]:
> 
> 
> On Fri, 8 Jan 2010, Tony Lindgren wrote:
> > 
> > Please pull omap fixes from:
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap-2.6.git omap-fixes-for-linus
> 
> No.
> 
> I don't know what the *** people have been doing in that tree, but it 
> looks like the _same_ branch was merged twice after rebasing:
> 
> 	Merge branch 'for_2_6_33_rc_a' of git://git.pwsan.com/linux-2.6 into omap-fixes-2.6.33-rc3
> 	Merge branch 'for_2.6.33rc_b' of git://git.pwsan.com/linux-2.6 into omap-fixes-for-linus
> 
> This is why we don't rebase public trees, and I refuse to pull crap like 
> that. You need to teach the people you work with to not rebase, and the 
> only way I can say "stop" is by simply not pulling the crap.
> 
> There are other problems with that branch too - the "committer" 
> information is pure sh*t. It says "paul <paul@twilight.(none)>", so quite 
> frankly, somebody hasn't even read the very first chapter of just about 
> every single git documentation that is out there.
> 
> And now that I noticed, I see that the crap-for-brains committer info has 
> been going on for a long time, and I just hadn't looked closely enough 
> before. I didn't look closely enough to see if the rebase problem had also 
> happened before.

Yeah sorry, noticed the duplicate mess too. Will look into it.

Regards,

Tony
