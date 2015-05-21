From: Tony Lindgren <tony@atomide.com>
Subject: Re: [GIT PULL 2/2] omap1 sparse irq support for v4.2
Date: Thu, 21 May 2015 11:36:30 -0700
Message-ID: <20150521183629.GT10274@atomide.com>
References: <80194352.chs4cqVdmg@wuerfel>
 <20150521145840.GQ10274@atomide.com>
 <2613552.WPU8qB3AF6@wuerfel>
 <20150521154957.GR10274@atomide.com>
 <20150521165413.GS10274@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:52870 "EHLO muru.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286AbbEUSgc (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 21 May 2015 14:36:32 -0400
Content-Disposition: inline
In-Reply-To: <20150521165413.GS10274@atomide.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, arm@kernel.org, linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [150521 09:55]:
> * Tony Lindgren <tony@atomide.com> [150521 08:52]:
> > * Arnd Bergmann <arnd@arndb.de> [150521 08:41]:
> > > On Thursday 21 May 2015 07:58:41 Tony Lindgren wrote:
> > > > * Arnd Bergmann <arnd@arndb.de> [150521 05:13]:
> > > > > On Wednesday 20 May 2015 15:36:05 Tony Lindgren wrote:
> > > > > > Add support for CONFIG_SPARSE_IRQ for omap1. This takes us a bit closer
> > > > > > to making omap1 support multiarch. After this series we still need to
> > > > > > make omap1 use the common clock framework and fix up the drivers to not
> > > > > > rely on includes from mach and plat directories.
> > > > > > 
> > > > > > Note that this branch depends on a GPIO driver fix in v4.1-rc3
> > > > > > d2d05c65c40e ("gpio: omap: Fix regression for MPUIO interrupts").
> > > > > > 
> > > > > 
> > > > > I'm getting lots of build errors in linux-next, which I think are
> > > > > caused by this series.
> > > > 
> > > > Hmm is this with make randconfig?
> > > 
> > > Yes, all sorts of randconfig builds hit different parts here
> > > 
> > > > What's the Kconfig option enabling these errors?
> > > 
> > > From what I can tell, this is simply a result of enabling
> > > CONFIG_SPARSE_IRQ, which results in linux/irq.h no longer
> > > implicitly including  mach/hardware.h through mach/irqs.h.
> > 
> > Hmm not seeing that here, well at least not with what I've
> > tried so far.
> >  
> > > You should be able to see these errors by just enabling
> > > the respective drivers. The errors manifest as a long list
> > > of undefined symbols like
> > > 
> > > /git/arm-soc/arch/arm/mach-omap1/io.c:33:28: error: 'OMAP1_IO_OFFSET' undeclared here (not in a function)
> > > /git/arm-soc/arch/arm/mach-omap1/io.c:43:14: error: 'OMAP7XX_DSP_BASE' undeclared here (not in a function)
> > > /git/arm-soc/arch/arm/mach-omap1/serial.c:114:33: note: each undeclared identifier is reported only once for each function it appears in
> > > /git/arm-soc/arch/arm/mach-omap1/pm.c:217:23: error: 'ULPD_SOFT_DISABLE_REQ_REG' undeclared (first use in this function)
> > > /git/arm-soc/drivers/video/fbdev/omap/sossi.c:608:17: error: 'MOD_CONF_CTRL_1' undeclared (first use in this function)
> > > 
> > > Then again, it is possible that I only see the errors because of
> > > an interaction with another patch from my randconfig fixes
> > > series.
> > 
> > I think there's something like that going on.. Maybe you're
> > now enabling multiarch for omap1 in your branch?
> 
> OK got it triggered here too with randconfig builds now.
> This seems to be related to not selecting some omap1 SoCs or
> boards. I'll try to do a minimal fix for it today.
> 
> It seems the include changes you posted would be better done
> by replacing the the dependencies to mach/irqs.h where possible
> rather than adding more includes?

OK figured it out. We now rely on an indirect include selected
with ARCH_OMAP15XX. Here's what I suggest as a fix for this
issue, obviously the real fix is to fix the legacy drivers to not 
#include <mach/*.h>.

Regards,

Tony

8< --------------------
From: Tony Lindgren <tony@atomide.com>
Date: Thu, 21 May 2015 11:01:29 -0700
Subject: [PATCH] ARM: OMAP1: Fix randconfig builds if ARCH_OMAP15XX not
 selected

With the omap1 SPARSE_IRQ changes mach/irqs.h is no longer
automatically included. Turns out now we rely on ARCH_OMAP15XX
including hardware.h from memory.h, so without ARCH_OMAP15XX
we get build failures.

As we have legacy drivers still relying on these indirect
includes, let's not add more mach includes to the drivers.
Those have to be removed anyways for multiplatform support.

Let's fix up mach-omap1 to include soc.h where cpu_is_omap
checks are done, and common.h for board-*.c files.

But let's keep the indirect memory.h include for now to avoid
unnecessary churn in the drivers.

Signed-off-by: Tony Lindgren <tony@atomide.com>

--- a/arch/arm/mach-omap1/board-h3-mmc.c
+++ b/arch/arm/mach-omap1/board-h3-mmc.c
@@ -16,6 +16,7 @@
 
 #include <linux/i2c/tps65010.h>
 
+#include "common.h"
 #include "board-h3.h"
 #include "mmc.h"
 
--- a/arch/arm/mach-omap1/common.h
+++ b/arch/arm/mach-omap1/common.h
@@ -36,6 +36,8 @@
 
 #include <mach/irqs.h>
 
+#include "soc.h"
+
 #if defined(CONFIG_ARCH_OMAP730) || defined(CONFIG_ARCH_OMAP850)
 void omap7xx_map_io(void);
 #else
--- a/arch/arm/mach-omap1/gpio16xx.c
+++ b/arch/arm/mach-omap1/gpio16xx.c
@@ -21,6 +21,8 @@
 
 #include <mach/irqs.h>
 
+#include "soc.h"
+
 #define OMAP1610_GPIO1_BASE		0xfffbe400
 #define OMAP1610_GPIO2_BASE		0xfffbec00
 #define OMAP1610_GPIO3_BASE		0xfffbb400
--- a/arch/arm/mach-omap1/gpio7xx.c
+++ b/arch/arm/mach-omap1/gpio7xx.c
@@ -21,6 +21,8 @@
 
 #include <mach/irqs.h>
 
+#include "soc.h"
+
 #define OMAP7XX_GPIO1_BASE		0xfffbc000
 #define OMAP7XX_GPIO2_BASE		0xfffbc800
 #define OMAP7XX_GPIO3_BASE		0xfffbd000
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -5,6 +5,9 @@
 #ifndef __ASM_ARCH_MEMORY_H
 #define __ASM_ARCH_MEMORY_H
 
+/* REVISIT: omap1 legacy drivers still rely on this */
+#include <mach/soc.h>
+
 /*
  * Bus address is physical address, except for OMAP-1510 Local Bus.
  * OMAP-1510 bus address is translated into a Local Bus address if the
@@ -14,7 +17,6 @@
  * because of the strncmp().
  */
 #if defined(CONFIG_ARCH_OMAP15XX) && !defined(__ASSEMBLER__)
-#include <mach/soc.h>
 
 /*
  * OMAP-1510 Local Bus address offset
--- a/arch/arm/mach-omap1/pm.c
+++ b/arch/arm/mach-omap1/pm.c
@@ -62,6 +62,7 @@
 #include "iomap.h"
 #include "clock.h"
 #include "pm.h"
+#include "soc.h"
 #include "sram.h"
 
 static unsigned int arm_sleep_save[ARM_SLEEP_SAVE_SIZE];
--- a/arch/arm/mach-omap1/serial.c
+++ b/arch/arm/mach-omap1/serial.c
@@ -25,6 +25,7 @@
 #include <mach/mux.h>
 
 #include "pm.h"
+#include "soc.h"
 
 static struct clk * uart1_ck;
 static struct clk * uart2_ck;
