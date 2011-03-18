From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL] omap changes for v2.6.39 merge window
Date: Fri, 18 Mar 2011 16:43:18 -0700
Message-ID: <20110318234318.GC18583@atomide.com>
References: <20110317183048.GW7258@atomide.com>
 <AANLkTik_Y1uMfVTVVEdPFG0sjW2uYpeeUMKfymho3sd+@mail.gmail.com>
 <20110318070935.GC3555@atomide.com>
 <AANLkTin-dwhmFjF=g90tMvGMS1hv-cod9WrQiaLfYygS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:21197 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757563Ab1CRXnX (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 18 Mar 2011 19:43:23 -0400
Content-Disposition: inline
In-Reply-To: <AANLkTin-dwhmFjF=g90tMvGMS1hv-cod9WrQiaLfYygS@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ohad Ben-Cohen <ohad@wizery.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Ohad Ben-Cohen <ohad@wizery.com> [110318 01:04]:
> On Fri, Mar 18, 2011 at 9:09 AM, Tony Lindgren <tony@atomide.com> wrote:
> > * Linus Torvalds <torvalds@linux-foundation.org> [110317 20:00]:
> >> Make platforms that need it "select" it or something. It looks like
> >> nobody but an OMAP4 could _possibly_ ever want to answer 'y' to that
> >> question, SO DON'T ASK IT!
> >
> > No problem, let's make it depends on OMAP4.
> 
> From d086e8f994b9272f8c999af0a4d32d870749c77a Mon Sep 17 00:00:00 2001
> From: Ohad Ben-Cohen <ohad@wizery.com>
> Date: Fri, 18 Mar 2011 10:01:11 +0200
> Subject: [PATCH] hwspinlock: depend on OMAP4
> 
> Currently only OMAP4 supports hwspinlocks, so don't bother asking
> anyone else.
> 
> Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>

Thanks I'll queue this.

Regards,

Tony
