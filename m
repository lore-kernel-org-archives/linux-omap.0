From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: OMAP3430: MUSB host and hot-plugging
Date: Thu, 20 Mar 2008 22:48:01 +0200
Message-ID: <20080320204801.GA5457@kedavra.cpe.vivax.com.br>
References: <87d4pqqmj2.fsf@paris.hilman.org> <200803201230.03729.david-b@pacbell.net> <20080320200000.GI4772@kedavra.cpe.vivax.com.br> <200803201325.28818.david-b@pacbell.net>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:41349 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754195AbYCTUp4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 20 Mar 2008 16:45:56 -0400
Content-Disposition: inline
In-Reply-To: <200803201325.28818.david-b@pacbell.net>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: me@felipebalbi.com, Kevin Hilman <khilman@mvista.com>, linux-omap@vger.kernel.org

On Thu, Mar 20, 2008 at 01:25:28PM -0700, David Brownell wrote:
> On Thursday 20 March 2008, Felipe Balbi wrote:
> > Could it be some
> > problem in the ULPI support for omap3 that's preventing musb to wake up
> > and switch to host role ?
> 
> Your theory is as good as mine; I don't have that hardware.
> 
> I was just pointing out that this specific area has always
> been a significant PITA for the MUSB silicon ... I'm not the
> only developer who's ended up losing weeks of time chasing
> (undocumented) bogosity in the area of host-side startup.
> 
> The thing is that making it "switch to host role" is the
> very black magic that regularly misbehaved.  ISTR there was
> a chicken/egg thing going on:  it couldn't know it needed to
> switch to "host role" unless the oddball Mentor "session"
> was already active, but it couldn't be activated unless you
> somehow knew it should be in host role...

Hmm... thanks for the tips Dave, I'll re-check that programmers guide
again tomorrow and try to debug a bit more.

-- 
Best Regards,

Felipe Balbi
me@felipebalbi.com
http://blog.felipebalbi.com
