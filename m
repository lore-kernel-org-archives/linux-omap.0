From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 23/62] ARM: omap1: fix building without 32K_TIMER
Date: Wed, 19 Mar 2014 13:34:31 -0700
Message-ID: <20140319203431.GA8333@atomide.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-24-git-send-email-arnd@arndb.de>
 <20140319195913.GA4271@saruman.home>
 <20140319200100.GB4271@saruman.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:50733 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754478AbaCSUek (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Mar 2014 16:34:40 -0400
Content-Disposition: inline
In-Reply-To: <20140319200100.GB4271@saruman.home>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Felipe Balbi <balbi@ti.com> [140319 13:06]:
> On Wed, Mar 19, 2014 at 02:59:13PM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > On Wed, Mar 19, 2014 at 08:29:20PM +0100, Arnd Bergmann wrote:
> > > If we enable CONFIG_OMAP_MPU_TIMER and CONFIG_OMAP_DM_TIMER but
> > > not CONFIG_OMAP_32K_TIMER on OMAP1, we currently get this build error:
> > > 
> > > mach-omap1/pm.c: In function 'omap1_pm_idle':
> > > mach-omap1/pm.c:123:9: error: 'enable_dyn_sleep' undeclared (first use in this function)
> > >   while (enable_dyn_sleep) {
> > >          ^
> > > mach-omap1/pm.c:123:9: note: each undeclared identifier is reported only once for each function it appears in
> > > 
> > > This attempts to fix the #ifdef logic to deal with all combinations
> > > of timers.
> > > 
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > Cc: linux-omap@vger.kernel.org
> > > Cc: Tony Lindgren <tony@atomide.com>
> > 
> > I had sent a fix for months and months ago, what happened to it ?
> 
> Here
> 
> http://marc.info/?l=linux-omap&m=138963632408031&w=2
> 
> Tony, did you forget to send a pull request ?

Hmm yes weird, can't see it in my omap-for-v3.14/fixes branch.

I must have gotten interrupted while applying and then probably
ran git reset --hard before committing.

Arnd, maybe pick up Felipe's earlier patch instead?

Acked-by: Tony Lindgren <tony@atomide.com>
