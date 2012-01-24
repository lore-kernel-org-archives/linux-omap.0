From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: ARM/ARM-SoC plans for v3.4 merge window
Date: Tue, 24 Jan 2012 11:27:45 +0000
Message-ID: <20120124112745.GT16726@n2100.arm.linux.org.uk>
References: <20120123114902.GY1068@n2100.arm.linux.org.uk> <20120124095009.GS16726@n2100.arm.linux.org.uk> <20120124105645.GE19798@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:46232 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750713Ab2AXL2G (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 24 Jan 2012 06:28:06 -0500
Content-Disposition: inline
In-Reply-To: <20120124105645.GE19798@mudshark.cambridge.arm.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>

On Tue, Jan 24, 2012 at 10:56:45AM +0000, Will Deacon wrote:
> Hi Russell,
> 
> On Tue, Jan 24, 2012 at 09:50:09AM +0000, Russell King - ARM Linux wrote:
> > Right, although it's out there - but I'd like to get the AMBA changes
> > into it which are already conflicting the Samsung development.  So I'm
> > going to hold off officially asking for people to include the baseline
> > until this evening.  At that point, I will shut down my 'amba' branch
> > and transfer that over; that means I won't be accepting any further
> > acks etc for that work.
> > 
> > If you haven't acked changes in the amba branch (eg, to Versatile,
> > Realview etc) then it'll soon be too late...
> 
> I took a look at your amba branch, but all I can see in there is:
> 
> 6cfa627 ARM: 7079/1: spi: Fix builderror in spi-pl022.c
> 1c3be36 PM: add runtime PM support to MMCI
> 92b97f0 PM: add runtime PM support to core Primecell driver
> 
> which don't seem to touch Versatile or Realview. Am I looking in the wrong
> place?

Erm, I don't think you're looking at the right branch - especially as
all the commits start "ARM: amba:".  They were sent out to the mailing
list on 20th Jan as a set of 31 patches (latest first):

ARM: amba: samsung: use common amba device initializers
ARM: amba: spear: use common amba device initializers
ARM: amba: nomadik: use common amba device initializers
ARM: amba: u300: use common amba device initializers
ARM: amba: lpc32xx: use common amba device initializers
ARM: amba: netx: use common amba device initializers
ARM: amba: bcmring: use common amba device initializers
ARM: amba: ep93xx: use common amba device initializers
ARM: amba: omap2: use common amba device initializers
ARM: amba: integrator: use common amba device initializers
ARM: amba: realview: get rid of private platform amba_device initializer
ARM: amba: versatile: get rid of private platform amba_device initializer
ARM: amba: vexpress: get rid of private platform amba_device initializer
ARM: amba: provide common initializers for static amba devices
ARM: amba: make use of -1 IRQs warn
ARM: amba: u300: get rid of NO_IRQ initializers
ARM: amba: spear: get rid of NO_IRQ initializers
ARM: amba: netx: get rid of NO_IRQ initializers
ARM: amba: nomadik: get rid of NO_IRQ initializers
ARM: amba: mxs: get rid of NO_IRQ initializers
ARM: amba: lpc32xx: get rid of NO_IRQ initializers
ARM: amba: integrator/realview/versatile/vexpress: get rid of NO_IRQ initializers
ARM: amba: samsung: get rid of NO_IRQ initializers
ARM: amba: get rid of NO_IRQ initializers
ARM: amba: ux500: get rid of NO_IRQ
ARM: amba: make irq 0 invalid
ARM: amba: mxs: convert to use amba_device_alloc
ARM: amba: integrator: convert to use amba_device_alloc
ARM: amba: ux500: convert to use amba_device_alloc
ARM: amba: of: convert to use amba_device_alloc
ARM: amba: add amba_device allocation/add/put functions
