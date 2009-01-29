From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 08/14] OMAP clock: move rate recalc, propagation code up to plat-omap/clock.c
Date: Thu, 29 Jan 2009 17:41:53 +0000
Message-ID: <20090129174153.GH18233@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192748.29333.5856.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46055 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754042AbZA2RmH (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 12:42:07 -0500
Content-Disposition: inline
In-Reply-To: <20090128192748.29333.5856.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:27:51PM -0700, Paul Walmsley wrote:
> Previously the individual clock recalculation functions handled their
> own rate recalculation.  This can be handled in the clk_set_rate(),
> clk_set_parent(), and recalculate_root_clocks() functions in
> plat-omap/clock.c.  Removes duplicate code and clarifies the role of the
> recalc functions.

I must say that this commit looks very much like a combination of
my commits from November:

[ARM] omap: move clock propagation into core omap clock code
[ARM] omap: remove unnecessary calls to propagate_rate()
[ARM] omap: move propagate_rate() calls into generic omap clock code

which do basically the same thing a little more efficiently, and an
additional patch from you to call ->recalc after set_rate or
reparenting a clock.

So I think I can drop everything from this apart from the additional
recalc calls, and the removal of those omap2_dpllcore_recalc() calls.

Please confirm my suspicions.
