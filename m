From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] omap4: Fix ULPI PHY init for ES1.0 SDP (Re: 4430SDP
 boot failure)
Date: Fri, 14 Jan 2011 09:29:10 -0800
Message-ID: <20110114172910.GH4957@atomide.com>
References: <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
 <20110110185209.GC4957@atomide.com>
 <20110111231611.GX4957@atomide.com>
 <2f1a86cfda277de8d190e5eb9b9ccd77@mail.gmail.com>
 <20110113091546.GA24429@n2100.arm.linux.org.uk>
 <20110113155152.GG4957@atomide.com>
 <20110113164957.GA28040@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:17635 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752276Ab1ANR3a (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 14 Jan 2011 12:29:30 -0500
Content-Disposition: inline
In-Reply-To: <20110113164957.GA28040@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Anand Gadiyar <gadiyar@ti.com>, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Keshava Munegowda <keshava_mgowda@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Felipe Balbi <balbi@ti.com>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 08:49]:
> On Thu, Jan 13, 2011 at 07:51:53AM -0800, Tony Lindgren wrote:
> > * Russell King - ARM Linux <linux@arm.linux.org.uk> [110113 01:15]:
> > > Given the very sorry state of OMAP in mainline at present, I'm surprised
> > > that this kind of stuff is still going on...
> > 
> > At least I boot test the patches I send..
> 
> Which is why OMAP3 and OMAP4 can't be built in mainline because they
> spit out lots of compile errors in the OMAP code...  As they won't
> even compile they couldn't have been boot tested.

Huh? I have fixes queued up for the issues that showed up with
merges with various other trees.

I certainly make sure everything I merge is compile and boot
tested. Sure there are still tons of issues still remaining,
but people are working on those. That's why we have the -rc
releases.

Tony
