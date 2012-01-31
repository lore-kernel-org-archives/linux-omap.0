From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [RFC PATCH 1/2] of: Add generic device tree DMA helpers
Date: Tue, 31 Jan 2012 23:09:28 +0000
Message-ID: <20120131230928.GA8394@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <20120128180602.GC2501@ponder.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37508 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753727Ab2AaXKE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 18:10:04 -0500
Content-Disposition: inline
In-Reply-To: <20120128180602.GC2501@ponder.secretlab.ca>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Grant Likely <grant.likely@secretlab.ca>
Cc: "Cousson, Benoit" <b-cousson@ti.com>, Stephen Warren <swarren@nvidia.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Rob Herring <rob.herring@calxeda.com>, Thomas Abraham <thomas.abraham@linaro.org>, linux-omap <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Sat, Jan 28, 2012 at 11:06:02AM -0700, Grant Likely wrote:
> This makes the assumption that dma specifiers will only ever be 1
> cell.  I think to be generally useful, the full dma specifier needs to
> be either handed to the dma controller to get a cookie or passed back
> to the caller in its entirety.

More to the point, who says that the DMA specifier is even an integer?
When people are using DMA engines, it (probably) isn't an integer at
all.  Several platforms I know of use strings for this.

Some platforms can even select between two or more DMA engines for
handling the same peripheral - I believe Samsung do this depending
on their individual workloads.

However, the opaque DMA engine API for requesting a channel doesn't
lend itself well to DT, as the match data and match function are
entirely left to the individual DMA engine driver and/or platform
itself.

As far as creating another linear number space for DMA stuff, I'd
really suggest against that - you're going to need some additional
code in place to manage that numberspace.  If you at least use a two-
paid cookie, eg 'dma controller phandle + request signal' then that
makes all the stuff we're starting to see with the IRQ subsystem,
IRQ domains etc become completely unnecessary.

I guess what I'm saying is ignore the flat number space, and go
straight to some kind of 'dma domains' solution from the start.
