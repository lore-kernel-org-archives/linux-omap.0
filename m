From: Dave Martin <dave.martin@linaro.org>
Subject: Re: Latest build results - errors/warnings - lots of them
Date: Tue, 30 Apr 2013 12:43:11 +0100
Message-ID: <20130430114229.GA2439@linaro.org>
References: <20130430081739.GP14496@n2100.arm.linux.org.uk>
 <201304301304.20650.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ee0-f41.google.com ([74.125.83.41]:34065 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759520Ab3D3LnY (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 30 Apr 2013 07:43:24 -0400
Received: by mail-ee0-f41.google.com with SMTP id c50so199388eek.14
        for <linux-omap@vger.kernel.org>; Tue, 30 Apr 2013 04:43:22 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201304301304.20650.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Nicolas Pitre <nico@fluxnic.net>

On Tue, Apr 30, 2013 at 01:04:20PM +0200, Arnd Bergmann wrote:
> On Tuesday 30 April 2013, Russell King - ARM Linux wrote:
> > Latest nightly build of 3.9+my for-next+arm-soc's for-next results in a
> > great load of new warnings and errors.  arch/arm/common/mcpm_head.S,
> > arch/arm/common/mcpm_platsmp.c, arch/arm/common/vlock.S are the biggest
> > source of errors.

[...]
 
> >arch/arm/common/mcpm_head.S:39: Error: selected processor does not support ARM mode `ubfx r9,r0,#0,#8'
> >arch/arm/common/mcpm_head.S:40: Error: selected processor does not support ARM mode `ubfx r10,r0,#8,#8'
> >arch/arm/common/mcpm_head.S:100: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:115: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:127: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:131: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:138: Error: selected processor does not support ARM mode `dsb'
> >arch/arm/common/mcpm_head.S:152: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:161: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/mcpm_head.S:175: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:62: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:72: Error: selected processor does not support ARM mode `dsb'
> >arch/arm/common/vlock.S:89: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:95: Error: selected processor does not support ARM mode `dsb'
> >arch/arm/common/vlock.S:102: Error: selected processor does not support ARM mode `dmb'
> >arch/arm/common/vlock.S:105: Error: selected processor does not support ARM mode `dsb'
> 
> Right, the problem here is that the code was never tested with an ARMv6+ARMv7 config.
> We can either fix it up by adding
> 
> 	.arch	armv7-a
> 
> in the assembly files, or by doing the same in the Makefile:
> 
> AFLAGS_vlock.S += -march=armv7-a
> AFLAGS_mcpm_head.S += -march=armv7-a


Hmmm, this code was tested with ARCH_MULTIPLATFORM, but it looks like
no v6 boards were configured in when testing that...


Assuming people are OK with the Makefile route, here's a patch for that,
build-tested with a v6+v7 ARCH_MULTIPLATFORM config.

Cheers
---Dave


>From 193f254689beaa1612d29bcc5ba004a933b37d95 Mon Sep 17 00:00:00 2001
From: Dave Martin <dave.martin@linaro.org>
Date: Tue, 30 Apr 2013 12:25:04 +0100
Subject: [PATCH 1/3] ARM: mcpm: Add explicit AFLAGS to support v6/v7
 multiplatform kernels

The full mcpm layer is not likely to be relevant to v6 based platforms,
so a multiplatform kernel won't use that code if booted on v6 hardware.

This patch modifies the AFLAGS for affected mcpm .S files to specify
armv7-a explicitly for that code.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
 arch/arm/common/Makefile |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/common/Makefile b/arch/arm/common/Makefile
index 546a932..d65a0a8 100644
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@ -12,6 +12,8 @@ obj-$(CONFIG_SHARP_SCOOP)	+= scoop.o
 obj-$(CONFIG_PCI_HOST_ITE8152)  += it8152.o
 obj-$(CONFIG_ARM_TIMER_SP804)	+= timer-sp.o
 obj-$(CONFIG_MCPM)		+= mcpm_head.o mcpm_entry.o mcpm_platsmp.o vlock.o
+AFLAGS_mcpm_head.o		:= -march=armv7-a
+AFLAGS_vlock.o			:= -march=armv7-a
 CFLAGS_REMOVE_mcpm_entry.o	= -pg
 obj-$(CONFIG_FIQ_GLUE)		+= fiq_glue.o fiq_glue_setup.o
 obj-$(CONFIG_FIQ_DEBUGGER)	+= fiq_debugger.o
-- 
1.7.9.5

