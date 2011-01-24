From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] ARM: OMAP2: use early init hook
Date: Mon, 24 Jan 2011 12:19:52 -0800
Message-ID: <20110124201952.GD13589@atomide.com>
References: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:51573 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490Ab1AXUUN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 24 Jan 2011 15:20:13 -0500
Content-Disposition: inline
In-Reply-To: <20110123171344.GH30094@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [110123 09:12]:
> Move non-mapping and non-irq initialization code out of .map_io and
> .init_irq respectively into the new init_early hook.

Nice :)
 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> I think I've updated this patch correctly for the new platforms merged
> into mainline.
> 
> Please ensure that new platforms merged after this patch also use the
> new structure, and note that the initializers should be listed in the
> following order:
> 
> 	.fixup
> 	.reserve
> 	.map_io
> 	.init_early
> 	.init_irq
> 	.timer
> 	.init_machine
> 
> This is the order in which they are called, so it helps to make sense
> when reading the board level code if they're arranged in called order.

OK, will do.

Will also add this also into omap-testing. Any other issues that
might remain should be easy to fix.

Acked-by: Tony Lindgren <tony@atomide.com>
