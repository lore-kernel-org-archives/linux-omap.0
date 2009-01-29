From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 11/14] OMAP clock: track child clocks
Date: Thu, 29 Jan 2009 15:14:01 +0000
Message-ID: <20090129151401.GC18233@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192756.29333.41541.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:33258 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754828AbZA2POP (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 29 Jan 2009 10:14:15 -0500
Content-Disposition: inline
In-Reply-To: <20090128192756.29333.41541.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Wed, Jan 28, 2009 at 12:27:59PM -0700, Paul Walmsley wrote:
> The price paid is additional runtime memory consumption - 8 bytes per
> clock and 16 bytes per child clock - roughly 4.5KiB on OMAP3.

For OMAP3, that's 222 struct clks of which 182 are children, and indeed
222 * 8 + 182 * 16 gives about 4.5K.  On OMAP2, it's 140 and 136,
giving 140 * 8 + 136 * 16 = 3.3K.

Moving struct clk_child into struct clk means that its clk and flags
members can be deleted, making it 8 bytes in size - effectively just
the list_head.  We need a list_head for the 'children' as you have it.
So, that works out as 16 bytes per clock.  That gives 3.5K on OMAP3
and 2.2K on OMAP2.

So, by taking that alternative approach, not only do you end up using
less memory, but you also don't have to have the overhead of your
custom memory bookkeeping.

The other change I'd suggest is that you have one function which deals
with setting the parent of a clock:

void clk_reparent(struct clk *child, struct clk *parent)
{
	list_del_init(&child->sibling);
	if (parent)
		list_add(&child->sibling, &parent->children);
	child->parent = parent;

	/* now do the debugfs renaming to reattach the child
	   to the proper parent */
}

which is a lot simpler than your omap_clk_add_child() and omap_clk_del_child().

These should be in the _core_ OMAP clock code, not just in the OMAP2
clock code.  OMAP1 has child clocks as well as OMAP2.
