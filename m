From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap fixes for v2.6.34-rc5
Date: Tue, 27 Apr 2010 09:58:13 -0700
Message-ID: <20100427165813.GC7225@atomide.com>
References: <20100426190005.GJ7225@atomide.com>
 <alpine.LFD.2.00.1004270831430.3739@i5.linux-foundation.org>
 <20100427161217.GB7225@atomide.com>
 <alpine.LFD.2.00.1004270934220.3739@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:57186 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751828Ab0D0Q6O (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 27 Apr 2010 12:58:14 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004270934220.3739@i5.linux-foundation.org>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

* Linus Torvalds <torvalds@linux-foundation.org> [100427 09:31]:
> 
> 
> On Tue, 27 Apr 2010, Tony Lindgren wrote:
> > 
> > OK point taken. I should have dealt with this earlier. Will only queue
> > regressions after -rc3 or so.
> 
> Note that the "only regressions" is certainly not a hard rule. Anything 
> that would be valid for -stable is obviously always valid: security 
> issues, major oopses etc etc.

Sure.
 
> But the "only regressions" should kind of be the guiding line, and the 
> others are more like "this is so serious that it should go in regardless 
> of anything else".

OK. I guess was using criteria like "this is needed to boot this and that
board in a usable way" and "let's get all the fixes in" criteria, but that
should have been done way earlier.

Regards,

Tony
