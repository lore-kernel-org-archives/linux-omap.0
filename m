From: Tony Lindgren <tony@atomide.com>
Subject: Re: 4430SDP boot failure
Date: Mon, 10 Jan 2011 10:52:09 -0800
Message-ID: <20110110185209.GC4957@atomide.com>
References: <20110106170805.GE1198@n2100.arm.linux.org.uk>
 <20110106180030.GA8249@n2100.arm.linux.org.uk>
 <20110106182023.GV7771@atomide.com>
 <20110106203238.GH1198@n2100.arm.linux.org.uk>
 <20110106204053.GA7771@atomide.com>
 <20110107161230.GR1198@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:25211 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754008Ab1AJSwV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 10 Jan 2011 13:52:21 -0500
Content-Disposition: inline
In-Reply-To: <20110107161230.GR1198@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110107 08:12]:
> On Thu, Jan 06, 2011 at 12:40:54PM -0800, Tony Lindgren wrote:
> > Anyways, I can debug the DEBUG_LL booting issue further if the patch
> > I posted does not help.
> 
> This is what I ended up with earlier today to make the debug code work
> both in the decompressor and in the kernel - once I had it working I
> haven't bothered putting any more effort into it.

Hmm I have DEBUG_LL working fine (execept not for the uncompress code).

Looks like the only issue I have with my 4430 es1.0 blaze board is
that it won't boot reliably unless I disable l2x0_init.

Have you guys seen this issue?

Of course there are all kinds of omap4 warnings there, but after
disabling l2x0_init I was able to run apt-get dist-upgrade on my
board. This is with what I have queued up in omap-fixes.

Regards,

Tony
