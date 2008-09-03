From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: RE: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 14:58:10 -0500
Message-ID: <13B9B4C6EF24D648824FF11BE8967162036545FAD7@dlee02.ent.ti.com>
References: <20080827220821.GE7227@flint.arm.linux.org.uk>
 <200808311447.20312.david-b@pacbell.net>
 <20080902221501.GD23085@atomide.com>
 <20080903075541.GA19980@flint.arm.linux.org.uk>
 <20080903164007.GP23085@atomide.com>
 <20080903193421.GC19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49787 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752557AbYICT6m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 15:58:42 -0400
In-Reply-To: <20080903193421.GC19980@flint.arm.linux.org.uk>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>
Cc: David Brownell <david-b@pacbell.net>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>


> From: linux-omap-owner@vger.kernel.org [mailto:linux-omap-
> owner@vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Wednesday, September 03, 2008 2:34 PM
<snip>
> The question is why do we need it?  If the correct physical address
> is passed, then things should work out just fine anyway, especially
> if drivers start to use ioremap rather than relying on all these fixed
> translations.

Fixed translations do have some benefits.  You can ensure that you are using section or super section descriptors to cover large areas.  This does result in better TLB usage.  Along with freeing up TLB entries you also generally avoid TLB misses on IO calls which touch a variety of internal spaces as part of the IRQ sequence.

With in a family of chips like 2420/22/23 or 3410/20/30/40 the internal space is mapped the same.

Frankly I've never been convinced that a multi OMAP1/2/3 image makes much sense apart forcing better code structure and being kind of cool.  Each chip has very different performance targets and is really better built with an optimized tool chain (ARMv5, ARMv6, ARMv7).  Doing multi-boots with in the same architecture family seems really good but across seems less so.

Regards,
Richard W.

