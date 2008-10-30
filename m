From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC 0/21 Continue phasing out legacy GPIO calls
Date: Thu, 30 Oct 2008 10:26:23 -0700
Message-ID: <20081030172622.GT13227@atomide.com>
References: <1225280189-6559-1-git-send-email-jarkko.nikula@nokia.com> <20081029160056.GD20456@atomide.com> <200810291649.09137.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:54268 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755717AbYJ3R0b (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 30 Oct 2008 13:26:31 -0400
Content-Disposition: inline
In-Reply-To: <200810291649.09137.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Jarkko Nikula <jarkko.nikula@nokia.com>, linux-omap@vger.kernel.org

* David Brownell <david-b@pacbell.net> [081029 16:49]:
> On Wednesday 29 October 2008, Tony Lindgren wrote:
> > Let's do the clean-up patches in two phases, one series that
> > applies against the mainline kernel, then additional patches for
> > linux-omap. Otherwise we'll never get out of this merge hell.
> 
> I'll refresh my patches that way then.  Most of the stuff
> remaining sits inside arch/arm anyway.

Thanks, that's a bit extra work, but unless we do that in a distributed
way, I'll end up having to spend tons of time reworking the patches.

> > BTW, we should try to do the same for anything that we can already
> > patch in the mainline kernel.
> 
> Right.  We'll count on you to help us do that right.  Part
> of the problem will be coping with the ARM tree merge rules,
> especially for changes that touch mainline drivers too...

Yeah, I'll queue up what we can for Russell in smaller patch
sets. All the new code will then get queued up in Russell's omap-all
branch for mainline, and it will sit there potentially quite
a long time, but gets to mainline every merge window.

Tony
