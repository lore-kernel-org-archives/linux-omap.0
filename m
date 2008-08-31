From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap: update omap README
Date: Sun, 31 Aug 2008 14:52:49 +0100
Message-ID: <20080831135249.GA29378@flint.arm.linux.org.uk>
References: <20080830193330.GA9887@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37952 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756620AbYHaNxL (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 31 Aug 2008 09:53:11 -0400
Content-Disposition: inline
In-Reply-To: <20080830193330.GA9887@frodo>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Felipe Balbi <me@felipebalbi.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>

On Sat, Aug 30, 2008 at 10:33:35PM +0300, Felipe Balbi wrote:
>  4. General guidelines to write clean and OMAP Linux compatible code
>  -------------------------------------------------------------------
>  
> +- For register access use the __raw_{read,write}[bwl]() functions. At the
> +moment, see first example in arch/arm/plat-omap/include/mach/hardware.h.

(looking at mainline) which example?

> +#define OMAP_ID_REG  0xfffed400
> +#define DPLL_CTL_REG 0xfffecf00

This is unclear; it looks to me like it's trying to suggest that:

	__raw_readl(OMAP_ID_REG)

is somehow valid.  It isn't; you're passing a physical address to a
function which takes a virtual address - I'm cooking a patch which will
make __raw_readl() and friends only accept void __iomem pointers.

The correct way is to do something like:

	__raw_readl(IO_ADDRESS(OMAP_ID_REG))

where IO_ADDRESS is some function which translates the physical address
to a virtual address _and_ casts to a void __iomem pointer.

See my recent patch which fixes most of the virtual vs physical address
confusion that's present in the omap kernel (which was sent for comment
but got completely ignored.)
