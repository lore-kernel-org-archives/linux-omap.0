From: David Brownell <david-b@pacbell.net>
Subject: Re: FOR COMMENT: void __iomem * and similar casts are Bad News
Date: Wed, 3 Sep 2008 14:35:52 -0700
Message-ID: <200809031435.52620.david-b@pacbell.net>
References: <20080827220821.GE7227@flint.arm.linux.org.uk> <20080903203720.GV23085@atomide.com> <20080903210412.GJ19980@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp123.sbc.mail.sp1.yahoo.com ([69.147.64.96]:34958 "HELO
	smtp123.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1752359AbYICVf4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Sep 2008 17:35:56 -0400
In-Reply-To: <20080903210412.GJ19980@flint.arm.linux.org.uk>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Tony Lindgren <tony@atomide.com>, Eduardo Valentin <edubezval@gmail.com>, linux-omap@vger.kernel.org

On Wednesday 03 September 2008, Russell King - ARM Linux wrote:
> - virtual addresses are pointer like.
> - physical addresses are integer like.
> 
> So, if it's a physical address, it should be stored in an integer type
> large enough to contain it, and that means something like u32, or
> unsigned long.

And to complete the puzzle:  in the absense of IOMMU technologies
what's the difference between a "physical address" and a dma_addr_t?
(DMA addreses being integer-like.)

I would have expected omap_dma_set_{dest,src}_params() to accept a
dma_addr_t instead of a "physical address", on general principles.
And for those address types to be effectively the same, although it
would be allowed (albeit annoying) to have some trivial mapping
between the two (XOR some value etc).

- Dave

