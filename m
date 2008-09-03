From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 21:30:01 +0100
Message-ID: <20080903203000.GH19980@flint.arm.linux.org.uk>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com> <20080903075541.GA19980@flint.arm.linux.org.uk> <20080903164007.GP23085@atomide.com> <20080903193421.GC19980@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:43616 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233AbYICUam (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 16:30:42 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

On Wed, Sep 03, 2008 at 02:58:10PM -0500, Woodruff, Richard wrote:
> Fixed translations do have some benefits.  You can ensure that you are
> using section or super section descriptors to cover large areas.  This
> does result in better TLB usage.  Along with freeing up TLB entries you
> also generally avoid TLB misses on IO calls which touch a variety of
> internal spaces as part of the IRQ sequence.

These are valid points, and you can arrange for ioremap to give you the
same effect.  That way, you end up using _standard_ Linux interfaces
which everyone understands and still having your cake.

> Each chip has very different performance targets and is really better
> built with an optimized tool chain (ARMv5, ARMv6, ARMv7).  Doing
> multi-boots with in the same architecture family seems really good
> but across seems less so.

This thread isn't about multi-boots across differnet architecture;
please take that discussion elsewhere - it's off topic.

This thread is about fixing up the crappy state that the OMAP tree is
in with respect to typechecking of virtual vs physical address spaces
without regressing the current state of the code.

And "regressing the current state of the code" includes not wilfully
undoing the work which Tony has put in place towards his goal, *even*
if you may not agree with it.
