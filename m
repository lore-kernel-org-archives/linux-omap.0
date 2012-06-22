From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC 0/3] Add cyclic DMA support to OMAP DMA engine driver
Date: Fri, 22 Jun 2012 13:30:13 +0100
Message-ID: <20120622123013.GA7586@sirena.org.uk>
References: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:40761 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761885Ab2FVMaR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 22 Jun 2012 08:30:17 -0400
Content-Disposition: inline
In-Reply-To: <20120622085911.GA19026@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Santosh Shilimkar <santosh.shilimkar@ti.com>, Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>, Liam Girdwood <lrg@ti.com>

On Fri, Jun 22, 2012 at 09:59:11AM +0100, Russell King - ARM Linux wrote:

> As v3.5-rc is horribly broken on my OMAP platforms, I've had to back out
> all the sound/soc/omap changes from the last merge window to test this,
> inspite of Peter Ujfalusi maintaining that there is nothing wrong.  I
> can't get working audio support on the OMAP4430SDP any other way.

Do you have any details on what's wrong here?  I've not seen any
upstream reports but there's been precious little upstream work there so
it should be simple to identify which changes caused the breakage and
just drop them.  There's been no public reports...

> I am planning no further work on this until OMAP ASoC support gets fixed;
> due to Peter and my plans this summer, this is likely to be late July/
> August time.

That's sounding like 3.5 is likely to go out work broken audio.
