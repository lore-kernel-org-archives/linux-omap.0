From: Tony Lindgren <tony@atomide.com>
Subject: Re: Git pull request for omap patches for merge window after 2.6.30
Date: Thu, 28 May 2009 08:10:32 -0700
Message-ID: <20090528151031.GA32453@atomide.com>
References: <20090527234056.GJ6267@atomide.com> <20090528132901.GC19297@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:65046 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753010AbZE1PKl (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 28 May 2009 11:10:41 -0400
Content-Disposition: inline
In-Reply-To: <20090528132901.GC19297@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [090528 06:29]:
> On Wed, May 27, 2009 at 04:40:57PM -0700, Tony Lindgren wrote:
> > Assuming you have had a chance to look at all the patches posted,
> > please pull them from the request below. Will refresh the patches
> > as needed if you have more comments.
> 
> To be honest, I don't know where I am with any of the OMAP stuff; there's
> soo many emails flying about recently that I've really not been able to
> keep enough state in my head to be able to know what's what (especially
> with this new device tree thread which has exploded to 100+ emails in
> about 12 hours.)
> 
> If you ask me which patches I'd looked at over the last couple of weeks,
> or even just last Monday, I really couldn't tell you.
> 
> I'll try to work out what I've already looked at and what's remaining
> sometime later today.

OK, thanks. To me it looks like you've looked through everything except
this:

PATCH 0/8] omap3 board updates for merge window after 2.6.30
http://article.gmane.org/gmane.linux.ports.arm.omap/20188
 
> It might have been better had I merged the stuff piecemeal into an omap
> branch, that way I'd know that everything in there was stuff I'd looked
> at - and you'd know what was outstanding (because it wouldn't have been
> merged.)

Hey, just trying to help here to load things on your truck.
If you prefer to make multiple stops with your truck to pick up omap
stuff, that works too :)
 
> > I've merged all the omap patches, except Santosh' omap4 SMP
> > set, and Paul's second clock updates. This should remove any
> > dependencies for Santosh' SMP series.
> 
> There's a little more work to do on the SMP stuff before I'd be happy,
> and the best way to merge that will be directly into my tree - it will
> depend on the SMP branch there anyway.

Yeah that's what I figured. The patches I piled up should be a nice base
for working on the SMP patches.

Regards,

Tony
