From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP34xx
Date: Sat, 4 Feb 2012 17:25:57 -0800
Message-ID: <20120205012556.GG1426@atomide.com>
References: <20120204185453.GB17309@n2100.arm.linux.org.uk>
 <20120204190109.GL20333@atomide.com>
 <20120204203453.GD17309@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-01-ewr.mailhop.org ([204.13.248.71]:10915 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752846Ab2BEB0A (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 4 Feb 2012 20:26:00 -0500
Content-Disposition: inline
In-Reply-To: <20120204203453.GD17309@n2100.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-omap@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120204 12:03]:
> 
> Another problem (some build errors for OMAP3) do seem to be solved, but
> not the section mismatch warnings.  They're easy to verify before code
> gets pushed anywhere upstream, especially if you're doing one giant OMAP
> build - just enable CONFIG_DEBUG_SECTION_MISMATCH in your build
> configuration.  Refuse patches which introduce section mismatches - at
> least without an explanation backing up why they do.
>
> My OMAP3 and OMAP4 configurations spit out these - I've not even tried
> my OMAP2 configuration yet:

Weird. The warnings you're seeing all seem valid to me, but I'm not seeing
any the section warnings with the following compilers I have:

gcc version 4.3.5 (Debian 4.3.5-4)
gcc version 4.3.3 (Sourcery G++ Lite 2009q1-203)
gcc version 4.6.1 (Sourcery CodeBench Lite 2011.09-70)

I see _different_ warnings if I compile with an older gcc:
gcc version 4.2.1 (CodeSourcery Sourcery G++ Lite 2007q3-51)

Any ideas why that would be?

The only warnings I see are:

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19a4): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19a8): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19ac): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19b0): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x19b4): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: arch/arm/mach-omap2/built-in.o(.text+0x12b70): Section mismatch in reference from the function cm_t35_init_usbh() to the (unknown reference) .init.data:(unknown)
The function cm_t35_init_usbh() references
the (unknown reference) __initdata (unknown).
This is often because cm_t35_init_usbh lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x1c424): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x1c428): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x1c42c): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x1c430): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x1c434): Section mismatch in reference from the function omap_serial_fill_default_pads() to the (unknown reference) .init.data:(unknown)
The function omap_serial_fill_default_pads() references
the (unknown reference) __initdata (unknown).
This is often because omap_serial_fill_default_pads lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

WARNING: vmlinux.o(.text+0x2d5f0): Section mismatch in reference from the function cm_t35_init_usbh() to the (unknown reference) .init.data:(unknown)
The function cm_t35_init_usbh() references
the (unknown reference) __initdata (unknown).
This is often because cm_t35_init_usbh lacks a __initdata 
annotation or the annotation of (unknown) is wrong.

