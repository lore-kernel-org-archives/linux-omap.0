From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: Git pull request for omap patches for merge window after 2.6.30
Date: Thu, 28 May 2009 14:29:01 +0100
Message-ID: <20090528132901.GC19297@n2100.arm.linux.org.uk>
References: <20090527234056.GJ6267@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:42801 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755706AbZE1N3N (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 09:29:13 -0400
Content-Disposition: inline
In-Reply-To: <20090527234056.GJ6267@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

On Wed, May 27, 2009 at 04:40:57PM -0700, Tony Lindgren wrote:
> Assuming you have had a chance to look at all the patches posted,
> please pull them from the request below. Will refresh the patches
> as needed if you have more comments.

To be honest, I don't know where I am with any of the OMAP stuff; there's
soo many emails flying about recently that I've really not been able to
keep enough state in my head to be able to know what's what (especially
with this new device tree thread which has exploded to 100+ emails in
about 12 hours.)

If you ask me which patches I'd looked at over the last couple of weeks,
or even just last Monday, I really couldn't tell you.

I'll try to work out what I've already looked at and what's remaining
sometime later today.

It might have been better had I merged the stuff piecemeal into an omap
branch, that way I'd know that everything in there was stuff I'd looked
at - and you'd know what was outstanding (because it wouldn't have been
merged.)

> I've merged all the omap patches, except Santosh' omap4 SMP
> set, and Paul's second clock updates. This should remove any
> dependencies for Santosh' SMP series.

There's a little more work to do on the SMP stuff before I'd be happy,
and the best way to merge that will be directly into my tree - it will
depend on the SMP branch there anyway.
