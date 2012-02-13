From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Mon, 13 Feb 2012 09:59:06 -0800
Message-ID: <20120213175906.GD1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120212114430.GA18505@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:45364 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757451Ab2BMR7J (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 13 Feb 2012 12:59:09 -0500
Content-Disposition: inline
In-Reply-To: <20120212114430.GA18505@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120212 03:13]:
> Here's another issue which kautobuildv2 just found, as I've now added
> randconfig to the suite of OMAP4430 SDP builds.  Obviously, as it's
> using a different configuration each time, it's going to find different
> issues on each run.
> 
> For this, the seed config has the following extra lines compared with
> allnoconfig:
> 
> CONFIG_ARM_PATCH_PHYS_VIRT=y
> CONFIG_THUMB2_KERNEL=n
> 
> The reason for the last line is that -mauto-it is not supported by my
> toolchain, so if it were to be enabled, it would cause an immediate
> build failure.  The second to late line ensures that we don't end up
> with randconfig having to dream up a value for CONFIG_PHYS_OFFSET,
> which it can't do.
> 
> The seed configs can now be viewed or downloaded from the build site.
> 8<========
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> ARM: OMAP: fix missing __devexit_p() annotations
> 
> Missing __devexit_p() annotations in driver structures for remove functions
> marked with __devexit is waiting for build errors to happen, such as:
> 
> `omap_system_dma_remove' referenced in section `.data' of arch/arm/plat-omap/built-in.o: defined in discarded section `.devexit.text' of arch/arm/plat-omap/built-in.o
> 
> Add the necessary annotation, and as a result of audit, fix others which
> are also missing in arch/arm/*omap*.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
