From: Tony Lindgren <tony@atomide.com>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 13:32:51 -0700
Message-ID: <20080903203250.GU23085@atomide.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <200808311447.20312.david-b@pacbell.net> <20080902221501.GD23085@atomide.com> <20080903075541.GA19980@flint.arm.linux.org.uk> <20080903164007.GP23085@atomide.com> <20080903193421.GC19980@flint.arm.linux.org.uk> <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-bos.mailhop.org ([63.208.196.178]:62068 "EHLO
	mho-01-bos.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbYICUdE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 16:33:04 -0400
Content-Disposition: inline
In-Reply-To: <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>

* Woodruff, Richard <r-woodruff2@ti.com> [080903 12:58]:
> 
> > From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> > owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> > Sent: Wednesday, September 03, 2008 2:34 PM
> <snip>
> > The question is why do we need it?  If the correct physical address
> > is passed, then things should work out just fine anyway, especially
> > if drivers start to use ioremap rather than relying on all these fixed
> > translations.
> 
> Fixed translations do have some benefits.  You can ensure that you are using section or super section descriptors to cover large areas.  This does result in better TLB usage.  Along with freeing up TLB entries you also generally avoid TLB misses on IO calls which touch a variety of internal spaces as part of the IRQ sequence.
> 
> With in a family of chips like 2420/22/23 or 3410/20/30/40 the internal space is mapped the same.

I guess there's no advantage of using ioremap if the area is
already mapped. For drivers that are shared across multiple
archs or buses it makes sense.

> Frankly I've never been convinced that a multi OMAP1/2/3 image makes much sense apart forcing better code structure and being kind of cool.  Each chip has very different performance targets and is really better built with an optimized tool chain (ARMv5, ARMv6, ARMv7).  Doing multi-boots with in the same architecture family seems really good but across seems less so.

It definitely makes sense from distro and maintenance point of view. If
we did not work towards multi-omap we would already have the same code
duplicated many times over.

Tony
