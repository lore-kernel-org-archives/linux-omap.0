From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 10/16] ARM: omap: fix section mismatch warning for
 omap_secondary_startup()
Date: Wed, 8 Feb 2012 10:48:32 -0800
Message-ID: <20120208184832.GJ29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAY2-0006HR-Dh@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64551 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757226Ab2BHSsd (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:48:33 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAY2-0006HR-Dh@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:08]:
> WARNING: vmlinux.o(.text+0x1c664): Section mismatch in reference from the function omap_secondary_startup() to the function .cpuinit.text:secondary_startup()
> The function omap_secondary_startup() references
> the function __cpuinit secondary_startup().
> This is often because omap_secondary_startup lacks a __cpuinit
> annotation or the annotation of secondary_startup is wrong.
> 
> Unfortunately, fixing this causes a new warning which is harder to
> solve:
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x5328): Section mismatch in reference from the function omap4_hotplug_cpu() to the function .cpuinit.text:omap_secondary_startup()
> The function omap4_hotplug_cpu() references
> the function __cpuinit omap_secondary_startup().
> This is often because omap4_hotplug_cpu lacks a __cpuinit
> annotation or the annotation of omap_secondary_startup is wrong.
> 
> because omap4_hotplug_cpu() is used by power management code as well,
> which may not end up using omap_secondary_startup().
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Acked-by: Tony Lindgren <tony@atomide.com>
