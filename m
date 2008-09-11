From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC] Patch for proper Cortex-A8 cache configuration output
Date: Thu, 11 Sep 2008 11:37:29 -0700
Message-ID: <20080911183728.GM21163@atomide.com>
References: <489B24DA.4020008@googlemail.com> <20080808104007.GU24923@atomide.com> <20080910232807.GP21163@atomide.com> <20080911084543.GB26078@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62434 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752472AbYIKShl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 11 Sep 2008 14:37:41 -0400
Content-Disposition: inline
In-Reply-To: <20080911084543.GB26078@flint.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dirk Behme <dirk.behme@googlemail.com>, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [080911 01:46]:
> On Wed, Sep 10, 2008 at 04:28:07PM -0700, Tony Lindgren wrote:
> > I guess Catalin will submit his patch at some point after 2.6.28 opens.
> > I'll apply it l-o tree, and remove the L2 debug info we had in id.c
> > to clean up id.c in the future patches.
> 
> As I've said on the main ARM lists where I've given reasons, I'm against
> extending this stuff, and it is my intention to remove it completely.
> It was only added because it was relatively simple and easy to print the
> information.
> 
> However, with ARMs attitude of breaking configuration register formats
> willy nilly, it's just not worth having the additional complexity to
> try to work out which format we have, and decode that format.
> 
> For all we know, come the next ARM architecture revision, these registers
> will have completely changed their format again.  So much for providing
> software with an easy way to determine the parameters of the core.
> 
> It's just not worth the complexity and effort to try and decode this
> information for no other purpose than a few printk's.

Hmm, people need to see what's enabled though.

For later ARMs, would it make sense to have some arm_l2_init() function
that would get called from mach specific init to set the timings and enable
L2? That function could then dump the cache configuration too.

Tony
