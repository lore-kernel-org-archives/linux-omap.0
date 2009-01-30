From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH E 08/14] OMAP clock: move rate recalc, propagation code
 up to plat-omap/clock.c
Date: Fri, 30 Jan 2009 01:42:52 -0700 (MST)
Message-ID: <alpine.DEB.2.00.0901300135560.26985@utopia.booyaka.com>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192748.29333.5856.stgit@localhost.localdomain> <20090129174153.GH18233@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:53237 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751376AbZA3Imy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 30 Jan 2009 03:42:54 -0500
In-Reply-To: <20090129174153.GH18233@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

Hello Russell, 

On Thu, 29 Jan 2009, Russell King - ARM Linux wrote:

> On Wed, Jan 28, 2009 at 12:27:51PM -0700, Paul Walmsley wrote:
> > Previously the individual clock recalculation functions handled their
> > own rate recalculation.  This can be handled in the clk_set_rate(),
> > clk_set_parent(), and recalculate_root_clocks() functions in
> > plat-omap/clock.c.  Removes duplicate code and clarifies the role of the
> > recalc functions.
> 
> I must say that this commit looks very much like a combination of
> my commits from November:
> 
> [ARM] omap: move clock propagation into core omap clock code
> [ARM] omap: remove unnecessary calls to propagate_rate()
> [ARM] omap: move propagate_rate() calls into generic omap clock code
> 
> which do basically the same thing a little more efficiently, and an
> additional patch from you to call ->recalc after set_rate or
> reparenting a clock.
> 
> So I think I can drop everything from this apart from the additional
> recalc calls, and the removal of those omap2_dpllcore_recalc() calls.
> 
> Please confirm my suspicions.

I haven't looked closely at your above three patches for this, but plan to 
do so later today.

Regarding provenance, the patches that I sent you were developed 
independently, for clock notifier support.  Ultimately, I have no personal 
attachment as to whose patches for this go in, if all technical aspects 
are equal.


- Paul
