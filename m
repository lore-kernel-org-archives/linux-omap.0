From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 16:40:39 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036545FC7D@dlee02.ent.ti.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
 <20080903193421.GC19980@flint.arm.linux.org.uk>
 <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
 <200809031418.44929.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:60303 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbYICVlI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:41:08 -0400
In-Reply-To: <200809031418.44929.david-b@pacbell.net>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>


> From: David Brownell [mailto:david-b@pacbell.net]
<snip>
> On Wednesday 03 September 2008, Woodruff, Richard wrote:
> > Fixed translations do have some benefits.  You can ensure that you
> > are using section or super section descriptors to cover large areas.
> > This does result in better TLB usage.  Along with freeing up TLB
> > entries you also generally avoid TLB misses on IO calls which
> > touch a variety of internal spaces as part of the IRQ sequence.
>
> ... which is exactly why some linux/arch/... code makes sure ioremap()
> can return fixed mappings instead of always requiring dynamic ones.

That does sound like a nice consistent way to do it.  Which implementation of this would you recommend looking at?  Do any ARMs you know of do it today?

> True enough, but that decision can be in the hands of whoever
> builds a kernel.  If you want to deploy an A8-optimized system,
> the kernel will be only one part of the equation.

As long as the option exists to make the optimized build, yours is a pretty reasonable stance.

Practically, I wonder about user communities you are trying to support.  If there are tons of active users at each generation then it seems to make sense to cater to them all.  If generations are quick flashes then coupling seems less compelling.

Regards,
Richard W.

