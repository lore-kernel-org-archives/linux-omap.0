From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] of: Add generic device tree DMA helpers
Date: Thu, 15 Mar 2012 19:57:53 +0000
Message-ID: <20120315195753.GA2842@n2100.arm.linux.org.uk>
References: <4F22DEF2.5000807@ti.com> <1331800690-21518-1-git-send-email-nicolas.ferre@atmel.com> <201203150922.06379.arnd@arndb.de> <4F621939.9040906@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:56045 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1031929Ab2COT6c (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 15 Mar 2012 15:58:32 -0400
Content-Disposition: inline
In-Reply-To: <4F621939.9040906@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Nicolas Ferre <nicolas.ferre@atmel.com>, grant.likely@secretlab.ca, rob.herring@calxeda.com, devicetree-discuss@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>, linux-omap@vger.kernel.org, Thierry Reding <thierry.reding@avionic-design.de>

On Thu, Mar 15, 2012 at 05:30:49PM +0100, Cousson, Benoit wrote:
> This was done like IRQ on purpose, because an Interrupt ReQuest line and  
> a DMA Request line are really similar for the HW point of view at IP 
> level.

I'm not sure about that at all levels.  Sure, at hardware level they're
the same, but I think the flat numeric namespace for IRQs has been
proven to be a problem when there's multiple IRQ controllers in the
system.

> I'm not sure what Thierry have done for pwm, but I thing that having the  
> same scheme for reg, irq and dma was what we agreed with Grant during  
> Plumbers.

I really don't like these behind-the-scenes discussions which never then
get followed up in public, and people then start quoting what was "agreed"
as that's the way things must be done.

It's a bit like folk at the recent Linaro Connect apparantly discussing
my machine registry and deciding that it should be shut down.  No one
has yet talked to me about that or even done the curtesy of asking me
what my view is.

As far as I'm concerned for DMA stuff, there is currently no real solution
for a DT representation; TI have asked me to take over the conversion of
OMAP DMA support to the DMA engine API, and I'm not yet convinced that
the existing numbering system is the right solution - especially as
there's several overlapping numberspaces for OMAP DMA numbers which
are SoC specific.
