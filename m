From: Rick Bronson <rick@efn.org>
Subject: Re: Fix for dispc's error "omapfb omapfb: irq error status 4020"
Date: Tue, 11 Nov 2008 09:25:31 -0800
Message-ID: <E1Kzwzb-0004z0-Q5@amazonia.comcast.net>
Reply-To: rick@efn.org
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from samwise.efn.org ([12.33.21.33]:50555 "EHLO samwise.efn.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753885AbYKKRZf (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Nov 2008 12:25:35 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: hvaibhav@ti.com, tomi.valkeinen@nokia.com
Cc: linux-omap@vger.kernel.org

Tomi,

  I agree with both of you.  My patch is a bandaid at best.  I spend a
fair amount of time trying to find out what's causing the sync lost
interrupts in the first place, mostly be doing peripheral memory space
comparisons of good/bad boots.  This let to nothing, all of the
registers off the DSS were the same except for the interrupt pending.

  This led me to implementing the "soft reset" mentioned in the OMAP3
pdf.  But this would be a big change and I'm not too familiar with
that code.  Plus I didn't even have a DVI display until yesterday...

  Rick

> I think the correct solution would be to find out why we get sync lost
> errors and fix that. Your patch just hides the problem. 
> 
> However, I agree that it's not good to just keep spamming the error,
> possibly making the board freeze. The new DSS turns the display off
> after 100 error messages. But I don't think just hiding the interrupt
> is a good change.
> 
> [Hiremath, Vaibhav] Yes, it is not a good practice to hide any
> interrupts. But I think even instead of turning of the DSS, you should
> reset the DSS and reconfigure it with default values or preserve the
> state before resetting and configure it again.  I agree to the point
> that, it requires lot of re-architectureing to the current driver. But
> I believe it should be possible with new omap2 version.
> 
