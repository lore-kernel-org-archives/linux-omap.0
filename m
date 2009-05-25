From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 07/10] ARM: OMAP2/3: sDMA: Correct
	omap_request_dma_chain()
Date: Mon, 25 May 2009 10:34:00 +0100
Message-ID: <20090525093400.GD28195@n2100.arm.linux.org.uk>
References: <20090519232905.12760.15490.stgit@localhost> <20090519234007.12760.1967.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:34033 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148AbZEYJeJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 25 May 2009 05:34:09 -0400
Content-Disposition: inline
In-Reply-To: <20090519234007.12760.1967.stgit@localhost>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.arm.linux.org.uk, linux-omap@vger.kernel.org, Santosh Shilimkar <santosh.shilimkar@ti.com>

On Tue, May 19, 2009 at 04:40:07PM -0700, Tony Lindgren wrote:
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> 
> Original OMAP DMA chaining design has chain_id as one of the callback
> parameters. Patch 538528de0cb256f65716ab2e9613d9e920f97fe2 broke
> the desing.
> 
> Change the callback to return the logical channel number and not
> chain_id.

This patch does not make a material change.  It merely changes the name
used in a couple function pointer prototype.  This has no impact on the
generated code - iow, it's cosmetic.
