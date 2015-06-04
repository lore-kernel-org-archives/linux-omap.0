From: Tony Lindgren <tony@atomide.com>
Subject: Re: [RFC/NOT FOR MERGING] HACK: add global/private timers for A9
Date: Thu, 4 Jun 2015 14:46:51 -0700
Message-ID: <20150604214650.GB30984@atomide.com>
References: <1433363565-17725-1-git-send-email-balbi@ti.com>
 <2466648.WjMxjIpAUG@wuerfel>
 <20150603210455.GD6042@saruman.tx.rr.com>
 <20150603212821.GH6042@saruman.tx.rr.com>
 <556F7493.2060602@codeaurora.org>
 <20150603215445.GK6042@saruman.tx.rr.com>
 <55701E93.60303@free.fr>
 <20150604200850.GF5710@saruman.tx.rr.com>
 <5570B5E8.90300@free.fr>
 <20150604203732.GI5710@saruman.tx.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:55959 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751672AbbFDVqx (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Jun 2015 17:46:53 -0400
Content-Disposition: inline
In-Reply-To: <20150604203732.GI5710@saruman.tx.rr.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <balbi@ti.com>
Cc: Mason <slash.tmp@free.fr>, Stephen Boyd <sboyd@codeaurora.org>, Shawn Guo <shawn.guo@linaro.org>, Russell King <linux@arm.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>, Linux OMAP <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>

* Felipe Balbi <balbi@ti.com> [150604 13:41]:
> On Thu, Jun 04, 2015 at 10:32:40PM +0200, Mason wrote:
> > On 04/06/2015 22:08, Felipe Balbi wrote:
> > 
> > > On Thu, Jun 04, 2015 at 11:46:59AM +0200, Mason wrote:
> > >> Also, check /proc/timer_list for a "Broadcast device". If you don't
> > >> define one, the TWD timers are set to periodic mode, with hrtimers
> > >> disabled.
> > > 
> > > Did you manage to turn global timer into Broadcast device ?
> > 
> > Disclaimer: I am a kernel noob, take everything I say with
> > a rock of salt.
> > 
> > As far as I can see, the global timer code doesn't handle
> > frequency changes, whereas the TWD code does.
> 
> All right, but TWD has C3STOP and that prevents it from being used as
> broadcast device.
> 
> Tony Lindgren had the idea of implementing a timer switch during idle
> and that could help us strip the kernel off of C3STOP feature flag. That
> means we might be able to use TWD as broadcast until CPU decides to
> idle, at which point we need to switch to a different timer.

Yeah I'm looking at adding clocksource_pm_enter/exit() to allow also
changing the clocksource to a different one for idle.. Will post some
patches after investigating it a bit further.

Changing the clockevent for idle already works just fine based on
tick_broadcast_enable() + tick_broadcast_enter/exit().

Regards,

Tony
