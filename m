From: Tony Lindgren <tony@atomide.com>
Subject: Re: OMAP totally fucked?
Date: Sat, 3 Mar 2012 13:05:21 -0800
Message-ID: <20120303210521.GE10293@atomide.com>
References: <20120303154650.GA16132@n2100.arm.linux.org.uk>
 <20120303180428.GA10293@atomide.com>
 <201203031829.06992.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-02-ewr.mailhop.org ([204.13.248.72]:36446 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752434Ab2CCVF1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 3 Mar 2012 16:05:27 -0500
Content-Disposition: inline
In-Reply-To: <201203031829.06992.arnd@arndb.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, Peter Ujfalusi <peter.ujfalusi@ti.com>, linux-omap@vger.kernel.org, Olof Johansson <olof@lixom.net>

* Arnd Bergmann <arnd@arndb.de> [120303 09:57]:
> On Saturday 03 March 2012, Tony Lindgren wrote:
> > Well 85631d2 builds fine, looks like now some more includes of
> > plat/hardware.h are now needed.Have not yet tracked down which
> > commit triggers the build errors. Eventually those should become
> > local headers too..
> 
> I've tried building arm-soc/for-next and rmk/for-next, they are both
> fine, just merging the two gives me the same build errors that Russell
> saw.
> 
> Adding plat/hardware.h in all files that break solves the problems,
> aside from the iommu dependency for rpmsg for which Ohad has provided
> a fix already that I should pull.

Here's a patch for you to the cleanup branch to fix the hardware.h
build errors.

Regards,

Tony


From: Tony Lindgren <tony@atomide.com>
Date: Sat, 3 Mar 2012 09:47:45 -0800
Subject: [PATCH] ARM: OMAP2+: Fix build error after merge

Commit 9890ce44 (ARM: get rid of asm/irq.h in asm/prom.h)
removed include of asm/irq.h in asm/prom.h. This commit
together with recent omap cleanup to remove io.h causes
build breakage:

arrch/arm/mach-omap2/control.c: In function 'omap3_ctrl_write_boot_mode':
arch/arm/mach-omap2/control.c:238: error:
'OMAP343X_CTRL_BASE' undeclared (first use in this function)
...

Fix this by including hardware.h directly where needed
instead of relying on asm/irq.h in asm/prom.h.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Tony Lindgren <tony@atomide.com>

diff --git a/arch/arm/mach-omap2/cm2xxx_3xxx.c b/arch/arm/mach-omap2/cm2xxx_3xxx.c
index c79ed63..389f9f8 100644
--- a/arch/arm/mach-omap2/cm2xxx_3xxx.c
+++ b/arch/arm/mach-omap2/cm2xxx_3xxx.c
@@ -18,6 +18,8 @@
 #include <linux/err.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
+
 #include "iomap.h"
 #include "common.h"
 #include "cm.h"
diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 93419de..1549c11 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -17,6 +17,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/board.h>
 #include <plat/mux.h>
 #include <plat/clock.h>
diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/control.c
index 2fd5fd1..08e674b 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/sdrc.h>
 
 #include "iomap.h"
diff --git a/arch/arm/mach-omap2/sdrc2xxx.c b/arch/arm/mach-omap2/sdrc2xxx.c
index 2c329a6..1133bb2 100644
--- a/arch/arm/mach-omap2/sdrc2xxx.c
+++ b/arch/arm/mach-omap2/sdrc2xxx.c
@@ -24,6 +24,7 @@
 #include <linux/clk.h>
 #include <linux/io.h>
 
+#include <plat/hardware.h>
 #include <plat/clock.h>
 #include <plat/sram.h>
 #include <plat/sdrc.h>
