From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH C 06/13] OMAP3 clock: DPLLs should enter bypass if new rate is sys_ck
Date: Thu, 29 Jan 2009 12:39:36 +0000
Message-ID: <20090129123936.GA16644@n2100.arm.linux.org.uk>
References: <20090128190724.12092.22239.stgit@localhost.localdomain> <20090128190823.12092.2638.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37804 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117AbZA2Mjx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 07:39:53 -0500
Content-Disposition: inline
In-Reply-To: <20090128190823.12092.2638.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:08:26PM -0700, Paul Walmsley wrote:
> This patch causes a DPLL to enter bypass when it is instructed to set
> its rate to that of its bypass clock.  Previously this was only possible
> after setting the DPLL rate, then disabling and re-enabling it.

The more I think about this, especially with reference to patch D1, the
more I'm convinced this is not entirely the right approach.

Patch D1 introduces the necessary mechanics to make clk_get_parent()
work.  If you use this on a PLL clock, and the PLL is in bypass mode,
it returns the non-bypass clock.

Now, I suspect that your first thought to resolving that would be to
add some complexity to clk_get_parent().  I advise against that.
Instead, arrange for clk->parent to _always_ point at the correct
parent clock, whether the PLL is in bypass mode or not.

In other words, encapsulate all the PLL mechanics localized inside
the PLL handling code and don't let them leak outside that code.
