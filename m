From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH E 11/14] OMAP clock: track child clocks
Date: Mon, 9 Feb 2009 14:11:56 +0000
Message-ID: <20090209141156.GB16626@n2100.arm.linux.org.uk>
References: <20090128192551.29333.82943.stgit@localhost.localdomain> <20090128192756.29333.41541.stgit@localhost.localdomain> <20090129151401.GC18233@n2100.arm.linux.org.uk> <20090129220608.GJ18233@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:49862 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754253AbZBIOML (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 9 Feb 2009 09:12:11 -0500
Content-Disposition: inline
In-Reply-To: <20090129220608.GJ18233@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>

On Thu, Jan 29, 2009 at 10:06:08PM +0000, Russell King - ARM Linux wrote:
> @@ -780,7 +780,7 @@ int omap2_clk_set_parent(struct clk *clk, struct clk *new_parent)
>  	if (clk->usecount > 0)
>  		_omap2_clk_enable(clk);
>  
> -	clk->parent = new_parent;
> +	clk_reparent(clk, new_parent);

While looking at the DPLL patches, I've realised that omap2_clk_set_parent()
is buggy, as are any other places which reparent the clock (thankfully
the only other place is in the initialisation code where it doesn't
matter.)

Consider what happens when a clock is enabled - we walk up the tree
enabling all parents.  If we then change the clock's parent, and
then disable the child, we will again walk up the tree, but since
we've reparented it, it will be a different clock tree.  The result
is that the ancestors clock usage counts, and therefore their enable
status, will end up getting screwed up.

So, this has revealed a logical bug here.  We need to walk the
parent tree before and after the switch to ensure that things stay
sane.

This brings up a question: what we currently do here is:

- disable the child
- program clksel
- enable the child
- change child->parent

If we add in the parent handling, there are two possibilities:

- disable the child
- enable the new parent tree
- program clksel
- change child->parent
- disable the old parent tree
- enable the child

OR

- disable the child and the old parent tree
- program clksel
- change child->parent
- enable the new parent tree and the child

(note those 'and's have implied ordering).

Is there anything which dictates one approach over the other?
Obviously the latter approach results in something smaller and
cleaner, but might not be technically correct.
