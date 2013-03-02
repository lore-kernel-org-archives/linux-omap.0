From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: omap: IORESOURCE_IRQ flags not set when defining a GPIO-IRQ
	from DT
Date: Sat, 2 Mar 2013 00:00:17 +0000
Message-ID: <20130302000017.GD30923@n2100.arm.linux.org.uk>
References: <CAAwP0s3ZzGf+_diZiQ7DSfWj74Sh=E9F+j=4UGnw8meHDR2AZQ@mail.gmail.com> <20130301173001.GC30923@n2100.arm.linux.org.uk> <51312EA1.8000600@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:52657 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448Ab3CBAAy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 1 Mar 2013 19:00:54 -0500
Content-Disposition: inline
In-Reply-To: <51312EA1.8000600@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Jon Hunter <jon-hunter@ti.com>
Cc: Javier Martinez Canillas <martinez.javier@gmail.com>, Stephen Warren <swarren@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, Kevin Hilman <khilman@deeprootsystems.com>, "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On Fri, Mar 01, 2013 at 04:41:37PM -0600, Jon Hunter wrote:
> Thanks for the history. For OMAP I see SMC_IRQ_FLAGS getting defined as
> follows in smc91x.h ...
> 
> #ifndef SMC_IRQ_FLAGS
> #define SMC_IRQ_FLAGS           IRQF_TRIGGER_RISING
> #endif
> 
> And so for OMAP devices using smc91x, it is always being configured as
> rising-edge. So it would be good to move OMAP to use a dynamic
> configuration too.

Yep.  I think that was requested back when I did the work from those
which remained...
