From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 16:19:26 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036545FC27@dlee02.ent.ti.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
 <200808311447.20312.david-b@pacbell.net>
 <20080902221501.GD23085@atomide.com>
 <20080903075541.GA19980@flint.arm.linux.org.uk>
 <20080903164007.GP23085@atomide.com> <20080903193421.GC19980@flint.arm
 <20080903203000.GH19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:34648 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752000AbYICVTw convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:19:52 -0400
In-Reply-To: <20080903203000.GH19980@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>


> From: Russell King - ARM Linux [mailto:linux@arm.linux.org.uk]
> Sent: Wednesday, September 03, 2008 3:30 PM

<snip>

> On Wed, Sep 03, 2008 at 02:58:10PM -0500, Woodruff, Richard wrote:
> > Fixed translations do have some benefits.  You can ensure that you are
> > using section or super section descriptors to cover large areas.  This
> > does result in better TLB usage.  Along with freeing up TLB entries
> you
> > also generally avoid TLB misses on IO calls which touch a variety of
> > internal spaces as part of the IRQ sequence.
>
> These are valid points, and you can arrange for ioremap to give you the
> same effect.  That way, you end up using _standard_ Linux interfaces
> which everyone understands and still having your cake.

Is there some example in current code which does this?  I recall ioremap's only using 4k and not combining.

Also, fixed maps are a lot easier to debug.

> > Each chip has very different performance targets and is really better
> > built with an optimized tool chain (ARMv5, ARMv6, ARMv7).  Doing
> > multi-boots with in the same architecture family seems really good
> > but across seems less so.
>
> This thread isn't about multi-boots across differnet architecture;
> please take that discussion elsewhere - it's off topic.

No but it is a consideration in how fix up is done.

Regards,
Richard W.

