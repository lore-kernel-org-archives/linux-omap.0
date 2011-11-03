From: Tony Lindgren <tony@atomide.com>
Subject: [RFC] omap build warnings gone in fixes branch
Date: Thu, 3 Nov 2011 10:44:35 -0700
Message-ID: <20111103174434.GS31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:31379 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756168Ab1KCRoh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 3 Nov 2011 13:44:37 -0400
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org

Hi all,

So what we have in the current fixes branch does not produce
any compiler warnings for omap1_defconfig or omap2plus_defconfig.
Let's plan on keeping it that way.

I'll be test compiling all the new patches with the following
patch applied, and I suggest anybody queueing patches touching
arch/arm/*omap*/ code will do the same.

Looks some makefiles have -Werror flags in them, but
I don't think we want to enable this by default because of
different compiler versions emitting different warnings.

If we wanted to enable it by default, we should test it with
a range of compilers. And I could see a bunch of warnings
popping up, for example, if we start compiling for 64-bit at
some point.

Cheers,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Thu, 3 Nov 2011 10:12:40 -0700
Subject: [RFC] ARM: OMAP: Set -Werror flags for arch/arm/*omap*/Makefile

With the remaining build warnings finally gone, let's keep
things that way. Please use this patch to test build new
patches so the new code won't add warnings.

We probably don't want to enable this by default as the
warnings may depend on compiler version.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/Makefile
+++ b/arch/arm/mach-omap1/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-y := -Werror
+
 # Common support
 obj-y := io.o id.o sram.o time.o irq.o mux.o flash.o serial.o devices.o dma.o
 obj-y += clock.o clock_data.o opp_data.o reset.o pm_bus.o timer.o
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+ccflags-y := -Werror
+
 # Common support
 obj-y := id.o io.o control.o mux.o devices.o serial.o gpmc.o timer.o pm.o \
 	 common.o gpio.o dma.o wd_timer.o
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -2,6 +2,8 @@
 # Makefile for the linux kernel.
 #
 
+flags-y := -Werror
+
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o \
 	 usb.o fb.o io.o counter_32k.o
