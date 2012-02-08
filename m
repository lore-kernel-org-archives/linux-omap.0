From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 12/16] ARM: omap: fix section mismatch warning for
 sdp3430_twl_gpio_setup()
Date: Wed, 8 Feb 2012 10:49:31 -0800
Message-ID: <20120208184930.GL29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAYg-0006Ha-Mf@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:63939 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757245Ab2BHStc (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:49:32 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAYg-0006Ha-Mf@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:08]:
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xd0f0): Section mismatch in reference from the function sdp3430_twl_gpio_setup() to the function .init.text:omap2_hsmmc_init()
> The function sdp3430_twl_gpio_setup() references
> the function __init omap2_hsmmc_init().
> This is often because sdp3430_twl_gpio_setup lacks a __init
> annotation or the annotation of omap2_hsmmc_init is wrong.
> 
> sdp3430_twl_gpio_setup() is called via platform data from the
> gpio-twl4030 module, which can be inserted and removed at runtime.
> This makes sdp3430_twl_gpio_setup() callable at runtime, and prevents
> it being marked with an __init annotation.
> 
> As it calls omap2_hsmmc_init() unconditionally, the only resolution to
> this warning is to remove the __init markings from omap2_hsmmc_init()
> and its called functions.  This addresses the functions in hsmmc.c.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

We'll try to sort this out also properly for v3.4, meanwhile:

Acked-by: Tony Lindgren <tony@atomide.com>
