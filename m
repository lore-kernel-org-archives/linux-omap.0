From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 13/16] ARM: omap: fix section mismatch warnings in
 mux.c caused by hsmmc.c
Date: Wed, 8 Feb 2012 10:50:38 -0800
Message-ID: <20120208185038.GM29796@atomide.com>
References: <20120208163546.GA15849@n2100.arm.linux.org.uk>
 <E1RvAZ0-0006He-RC@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:10166 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757097Ab2BHSun (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 8 Feb 2012 13:50:43 -0500
Content-Disposition: inline
In-Reply-To: <E1RvAZ0-0006He-RC@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120208 08:09]:
> The previous commit causes new section mismatch warnings:
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb30): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_gpio()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_gpio().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_gpio is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb4c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_gpio()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_gpio().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_gpio is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb60): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb6c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb78): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb90): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdb9c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdba8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbc0): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbcc): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbd8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdbf8): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc04): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc10): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc28): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc34): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc40): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc58): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc64): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc70): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> WARNING: arch/arm/mach-omap2/built-in.o(.text+0xdc7c): Section mismatch in reference from the function omap_init_hsmmc() to the function .init.text:omap_mux_init_signal()
> The function omap_init_hsmmc() references
> the function __init omap_mux_init_signal().
> This is often because omap_init_hsmmc lacks a __init
> annotation or the annotation of omap_mux_init_signal is wrong.
> 
> Again, as for omap2_hsmmc_init(), these functions are callable at
> runtime via the gpio-twl4030.c driver, and so these can't be marked
> __init.

These too will be back to __init for v3.4 when the mux stuff
is separated from omap2_hsmmc_init(). For -rc:

Acked-by: Tony Lindgren <tony@atomide.com>
