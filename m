From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 08/16] ARM: omap: fix section mismatch warning in mux.c
Date: Wed, 8 Feb 2012 10:47:39 -0800
Message-ID: <20120208184739.GH29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAXN-0006HJ-RK@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:64004 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757188Ab2BHSry (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:47:54 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAXN-0006HJ-RK@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:07]:
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0x15a4): Section mismatch in reference from the function omap_mux_init_signals() to the function .init.text:omap_mux_init_signal()
> The function omap_mux_init_signals() references
> the function __init omap_mux_init_signal().
> This is often because omap_mux_init_signals lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

I'll separate out the muxing part for v3.4. For the -rc series:

Acked-by: Tony Lindgren <tony@atomide.com>
