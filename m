From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] omap fixes for 2.6.33-rc3
Date: Fri, 8 Jan 2010 14:39:30 -0800 (PST)
Message-ID: <alpine.LFD.2.00.1001081430210.7821@localhost.localdomain>
References: <20100108180912.GC6831@atomide.com> <alpine.LFD.2.00.1001081014090.7821@localhost.localdomain> <20100108182236.GE6831@atomide.com> <alpine.DEB.2.00.1001081502480.19243@utopia.booyaka.com> <20100108222715.GC2879@atomide.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:53487 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754135Ab0AHWkK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jan 2010 17:40:10 -0500
In-Reply-To: <20100108222715.GC2879@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Paul Walmsley <paul@pwsan.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org



On Fri, 8 Jan 2010, Tony Lindgren wrote:
> 
> $ git log --pretty=oneline --author=".(none)" --committer=".(none)" v2.6.33-rc1..

Well, that will catch one particular common case of it, but..

> Should we have some check like this in place for all pulls?

.. it would probably make more sense to warn about it earlier in the 
chain, so that people with bad configurations can fix them. By the time 
somebody pulls, it's pretty late in the game.

Sadly, git doesn't do any real sanity checking, and now it's pretty much 
too late. It takes about a year or two for new git versions to percolate 
out, with things like Debian-stable etc, so making git warn about 
suspicious-looking names is not necessarily going to help (and with 
scripting and importing from other SCM's, it may be wrong to warn in 
general).

It's _fairly_ easy to set up a hook at commit-time to check for random 
thigns, but obviously if the problem is that people haven't configured 
their git setup, then "add a hook" is not going to work. In that sense, 
pull-time may be better, as a way to see it automatically after-the-fact.

Doing a post-merge hook would catch it, and could be used to warn about 
the fact that you merged something odd.

			Linus
