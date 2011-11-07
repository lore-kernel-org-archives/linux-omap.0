From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: OMAP CRAP: The Continuing Story Of Brokenness
Date: Mon, 7 Nov 2011 17:46:45 +0000
Message-ID: <20111107174645.GE15294@n2100.arm.linux.org.uk>
References: <20111106121829.GB15294@n2100.arm.linux.org.uk> <20111107172600.GS31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:45969 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933149Ab1KGRq4 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 7 Nov 2011 12:46:56 -0500
Content-Disposition: inline
In-Reply-To: <20111107172600.GS31337@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>, Chris Ball <cjb@laptop.org>, Felipe Balbi <balbi@ti.com>

On Mon, Nov 07, 2011 at 09:26:00AM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111106 03:44]:
> > Yet again I find that I'm having to email about crap on OMAP3.
> > 
> > I'm getting really fed up with OMAP stuff which keeps breaking in
> > idiotic ways - and the way there's fatal build errors at EVERY merge
> > window.  The OMAP workflow is totally broken.  Something MUST change
> > in the way the OMAP community works to stop the continual breakage
> > at every single bloody merge window.
> 
> Hmm he following fixes are queued elsewhere and now merged:
> 
> omap_hsmmc: fix missing parenthesis in pr_info
> PM / OPP: Fix build when CONFIG_PM_OPP is not set 
> net: Add back alignment for size for __alloc_skb
> 
> Or have you seen some other build errors?
> 
> FYI, now all the compile warnings are finally gone with what
> I have in fixes branch.

It was the errors in the "ARM: OMAP: Fix build for OMAP3 only builds"
thread.

However, rebuilding today gives brand new breakage - for my OMAP4430SDP
config.  This seems to be because more linux/module.h includes have been
deleted from include/linux/*.h includes.

arch/arm/plat-omap/dmtimer.c:184: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:184: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:184: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:215: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:215: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:215: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:228: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:228: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:228: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:234: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:234: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:234: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:240: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:240: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:240: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:248: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:248: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:248: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:294: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:294: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:294: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:302: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:302: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:302: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:316: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:316: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:316: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:344: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:344: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:344: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:361: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:361: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:361: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:380: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:380: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:380: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:406: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:406: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:406: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:443: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:443: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:443: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:468: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:468: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:468: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:494: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:494: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:494: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:517: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:517: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:517: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:534: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:534: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:534: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:549: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:549: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:549: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:561: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:561: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:561: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:572: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:572: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:572: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:587: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:587: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:587: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:604: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:604: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL'
arch/arm/plat-omap/dmtimer.c:604: warning: parameter names (without types) in function declaration
arch/arm/plat-omap/dmtimer.c:746: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:746: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:746: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/arm/plat-omap/dmtimer.c:746: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:747: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:747: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:747: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/arm/plat-omap/dmtimer.c:747: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:748: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:748: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:748: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
arch/arm/plat-omap/dmtimer.c:748: warning: function declaration isn't a prototype
arch/arm/plat-omap/dmtimer.c:749: error: expected declaration specifiers or '...' before string constant
arch/arm/plat-omap/dmtimer.c:749: warning: data definition has no type or storage class
arch/arm/plat-omap/dmtimer.c:749: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/plat-omap/dmtimer.c:749: warning: function declaration isn't a prototype
arch/arm/mach-omap2/omap_l3_noc.c:250: error: 'THIS_MODULE' undeclared here (not in a function)
arch/arm/mach-omap2/usb-musb.c:64: warning: 'usb_musb_mux_init' defined but not used

In addition, for OMAP3430 LDP:

arch/arm/plat-omap/omap_device.c:1055: warning: data definition has no type or storage class
arch/arm/plat-omap/omap_device.c:1055: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
arch/arm/plat-omap/omap_device.c:1055: warning: parameter names (without types) in function declaration
arch/arm/mach-omap2/mailbox.c:417: error: expected declaration specifiers or '...' before string constant
arch/arm/mach-omap2/mailbox.c:417: warning: data definition has no type or storage class
arch/arm/mach-omap2/mailbox.c:417: warning: type defaults to 'int' in declaration of 'MODULE_LICENSE'
arch/arm/mach-omap2/mailbox.c:417: warning: function declaration isn't a prototype
arch/arm/mach-omap2/mailbox.c:418: error: expected declaration specifiers or '...' before string constant
arch/arm/mach-omap2/mailbox.c:418: warning: data definition has no type or storage class
arch/arm/mach-omap2/mailbox.c:418: warning: type defaults to 'int' in declaration of 'MODULE_DESCRIPTION'
arch/arm/mach-omap2/mailbox.c:418: warning: function declaration isn't a prototype
arch/arm/mach-omap2/mailbox.c:419: error: expected declaration specifiers or '...' before string constant
arch/arm/mach-omap2/mailbox.c:419: warning: data definition has no type or storage class
arch/arm/mach-omap2/mailbox.c:419: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/mach-omap2/mailbox.c:419: warning: function declaration isn't a prototype
arch/arm/mach-omap2/mailbox.c:420: error: expected declaration specifiers or '...' before string constant
arch/arm/mach-omap2/mailbox.c:420: warning: data definition has no type or storage class
arch/arm/mach-omap2/mailbox.c:420: warning: type defaults to 'int' in declaration of 'MODULE_AUTHOR'
arch/arm/mach-omap2/mailbox.c:420: warning: function declaration isn't a prototype
arch/arm/mach-omap2/mailbox.c:421: error: expected declaration specifiers or '...' before string constant
arch/arm/mach-omap2/mailbox.c:421: warning: data definition has no type or storage class
arch/arm/mach-omap2/mailbox.c:421: warning: type defaults to 'int' in declaration of 'MODULE_ALIAS'
arch/arm/mach-omap2/mailbox.c:421: warning: function declaration isn't a prototype
drivers/video/omap/dispc.c:276: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:276: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:276: warning: parameter names (without types) in function declaration
drivers/video/omap/dispc.c:286: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:286: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:286: warning: parameter names (without types) in function declaration
drivers/video/omap/dispc.c:320: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:320: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:320: warning: parameter names (without types) in function declaration
drivers/video/omap/dispc.c:328: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:328: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:328: warning: parameter names (without types) in function declaration
drivers/video/omap/dispc.c:863: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:863: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:863: warning: parameter names (without types) in function declaration
drivers/video/omap/dispc.c:883: warning: data definition has no type or storage class
drivers/video/omap/dispc.c:883: warning: type defaults to 'int' in declaration of 'EXPORT_SYMBOL'
drivers/video/omap/dispc.c:883: warning: parameter names (without types) in function declaration

It might be an idea to do this:

grep -rl EXPORT_SYMBOL arch/arm/*omap* | xargs grep -L linux/export.h

and for any OMAP drivers as well.  This gives:

arch/arm/mach-omap1/id.c
arch/arm/mach-omap1/lcd_dma.c
arch/arm/mach-omap1/io.c
arch/arm/mach-omap1/ams-delta-fiq.c
arch/arm/mach-omap2/gpmc.c
arch/arm/mach-omap2/id.c
arch/arm/mach-omap2/io.c
arch/arm/plat-omap/ocpi.c
arch/arm/plat-omap/mcbsp.c
arch/arm/plat-omap/omap_device.c
arch/arm/plat-omap/mux.c
arch/arm/plat-omap/devices.c
arch/arm/plat-omap/io.c
arch/arm/plat-omap/dma.c
arch/arm/plat-omap/dmtimer.c
arch/arm/plat-omap/mailbox.c

which probably should all be fixed before any more of these errors
spring up.
