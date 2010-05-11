From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/6] OMAP3: GPIO: Only enable WAKEUPEN for edge
 detection GPIOs
Date: Tue, 11 May 2010 16:53:17 -0700
Message-ID: <20100511235317.GQ13931@atomide.com>
References: <1272929177-22685-1-git-send-email-khilman@deeprootsystems.com>
 <1272929177-22685-3-git-send-email-khilman@deeprootsystems.com>
 <20100510211105.GI16460@atomide.com>
 <87vdaufr92.fsf@deeprootsystems.com>
 <20100511225734.GK13931@atomide.com>
 <87fx1yrpdh.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:61910 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab0EKXxR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 11 May 2010 19:53:17 -0400
Content-Disposition: inline
In-Reply-To: <87fx1yrpdh.fsf@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Kevin Hilman <khilman@deeprootsystems.com>
Cc: linux-omap@vger.kernel.org

* Kevin Hilman <khilman@deeprootsystems.com> [100511 16:22]:
> -cqwang address which is bouncing
> 
> Tony Lindgren <tony@atomide.com> writes:
> 
> > * Kevin Hilman <khilman@deeprootsystems.com> [100511 07:22]:
> >
> > OK, let's plan on merging these then. Want me to pick these,
> > or pull from some branch?
> 
> You can pull from the gpio-2.6.35 branch in my tree.

OK
 
> > Looks like they also need to be posted to LAKML too, and we
> > should get them into linux-omap master for some testing.
> 
> Oops, meant to cc l-a-k.  Will repost with l-a-k in Cc.

Will merge them into linux-omap master branch today, then
will wait a few days for any comments on LAKML, then pull
them into omap-for-linus.

Regards,

Tony
