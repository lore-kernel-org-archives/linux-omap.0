From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Fri, 8 Jan 2010 14:27:15 -0800
Message-ID: <20100108222715.GC2879@atomide.com>
References: <20100108180912.GC6831@atomide.com>
 <alpine.LFD.2.00.1001081014090.7821@localhost.localdomain>
 <20100108182236.GE6831@atomide.com>
 <alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:52958 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab0AHW1U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 17:27:20 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Paul Walmsley <paul@pwsan.com> [100108 14:03]:
> Hello Linus, Tony,
> 
> On Fri, 8 Jan 2010, Tony Lindgren wrote:
> 
> > * Linus Torvalds <torvalds@linux-foundation.org> [100108 10:18]:
> > > 
> > > There are other problems with that branch too - the "committer" 
> > > information is pure sh*t. It says "paul <paul@twilight.(none)>", so quite 
> > > frankly, somebody hasn't even read the very first chapter of just about 
> > > every single git documentation that is out there.
> > > 
> > > And now that I noticed, I see that the crap-for-brains committer info has 
> > > been going on for a long time, and I just hadn't looked closely enough 
> > > before. I didn't look closely enough to see if the rebase problem had also 
> > > happened before.
> 
> Sorry - I seem to be the crap-for-brains committer.  Will fix -

Here's a check for unconfigured GIT_AUTHOR_EMAIL and GIT_COMMITTER_EMAIL:

$ git log --pretty=oneline --author=".(none)" --committer=".(none)" v2.6.33-rc1..

If it returns results, something is wrong.

Should we have some check like this in place for all pulls?

Regards,

Tony
