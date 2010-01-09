From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Sat, 9 Jan 2010 09:28:41 -0800
Message-ID: <20100109172841.GF2879@atomide.com>
References: <20100108180912.GC6831@atomide.com>
 <alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
 <20100108182236.GE6831@atomide.com>
 <alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
 <20100108222715.GC2879@atomide.com>
 <alpine.LFD.2.00.1001081430210.7821@localhost.localdomain>
 <20100108225023.GD2879@atomide.com>
 <20100109134731.a1bca240.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:57780 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754755Ab0AIR2t (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 9 Jan 2010 12:28:49 -0500
Content-Disposition: inline
In-Reply-To: <20100109134731.a1bca240.sfr@canb.auug.org.au>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Stephen Rothwell <sfr@canb.auug.org.au> [100108 18:45]:
> Hi Tony,
> 
> On Fri, 8 Jan 2010 14:50:23 -0800 Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hmm, sounds like it might make sense to check for that in Stephen's
> > for-next tree then. Added Stephen to the loop, let's see if what he
> > thinks.
> 
> I can certainly add hooks to my tree if someone can suggest what should
> be in them (I didn't get enough context here ...).  That way I could send
> the tree maintainer a warning email letting them know something is
> fishy ...

Just trying to warn about unconfigured environment for GIT_AUTHOR_EMAIL
and GIT_COMMITTER_EMAIL that makes commits show from user@hostname.(none).
There are quite a few of them, but looks like none after v2.6.33-rc1.

So I guess the test would be to do a pull into for-next, then do a
git log of the pull to see if there were any unconfigured email
addresses. Then notify the maintainers if there were .(none) type
email addresses.

The git commands to test for these would be something like this:

ORIG=$(git log --pretty=format:"%H" -n1)
git pull whatevever
...
git log --pretty=format:"Bad author: %H %ae" --author=".(none)" $ORIG..HEAD
git log --pretty=format:"Bad committer: %H %ce" --committer=".(none)" $ORIG..HEAD

> Of course, this only helps those who don't mind rebasing their trees,
> right?  The non-rebasing tree maintainers should do these checks
> themselves.  Maybe we could propogate a suggested (or mandatory) set of
> hooks?

Right, this won't catch all of them, and might be too late in many
cases to fix the issue. But just letting the maintainers know about
issues might be enough to fix the problem.

Regards,

Tony

