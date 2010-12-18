From: Paul Walmsley <paul@pwsan.com>
Subject: Re: [PATCH v2 4/9] OMAP2430: hwmod data: add system DMA
Date: Sat, 18 Dec 2010 02:42:16 -0700 (MST)
Message-ID: <alpine.DEB.2.00.1012180241140.16875@utopia.booyaka.com>
References: <1292600388-13094-1-git-send-email-manjugk@ti.com> <1292600388-13094-5-git-send-email-manjugk@ti.com> <alpine.DEB.2.00.1012180203380.16875@utopia.booyaka.com> <20101218093741.GC3047@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:34693 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528Ab0LRJmV (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 18 Dec 2010 04:42:21 -0500
In-Reply-To: <20101218093741.GC3047@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: "G, Manjunath Kondaiah" <manjugk@ti.com>, b-cousson@ti.com, tony@atomide.com, khilman@deeprootsystems.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Sat, 18 Dec 2010, Russell King - ARM Linux wrote:

> I'm confused.  I thought the whole point of hwmod was that the data for
> it was generated from a TI database of how the chip is actually setup.
> 
> However, from all the patching which seems to be going on, it looks to
> me like that's not the case - and if that's true, hwmod was mis-sold.
> It's just moved the problem rather than solving anything.
> 
> What's going on?

OMAP4 and beyond data is being generated from the TI hardware database.  
However, apparently that is not possible with the OMAP2 and OMAP3 data.


- Paul
