From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ARM: OMAP: Introduce local common.h files
Date: Fri, 11 Nov 2011 16:17:27 +0000
Message-ID: <20111111161727.GS15294@n2100.arm.linux.org.uk>
References: <20111106135250.GC15294@n2100.arm.linux.org.uk> <20111108004550.GH31337@atomide.com> <20111110201719.GW31337@atomide.com> <20111110202356.GQ15294@n2100.arm.linux.org.uk> <20111110215008.GX31337@atomide.com> <20111110222907.GR15294@n2100.arm.linux.org.uk> <20111110233347.GZ31337@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20111110233347.GZ31337@atomide.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 10, 2011 at 03:33:47PM -0800, Tony Lindgren wrote:
> * Russell King - ARM Linux <linux@arm.linux.org.uk> [111110 13:54]:
> > Thanks, merged that into the series.  The updated OMAP patch updated is
> > below, which has been moved to part 2.  Lastly, the final patch of part
> > 2 has been updated to delete the empty arch_reset(), so OMAP is now
> > entirely free of arch_reset() references.  This leaves a total of 12
> > references left to nobble.
> 
> Great, good to hear.

I've added this to the patch, as these no longer need to include this
header.

diff --git a/arch/arm/mach-omap1/board-voiceblue.c b/arch/arm/mach-omap1/board-voiceblue.c
index fb61434..f83a502d 100644
--- a/arch/arm/mach-omap1/board-voiceblue.c
+++ b/arch/arm/mach-omap1/board-voiceblue.c
@@ -28,7 +28,6 @@
 #include <linux/export.h>
 
 #include <mach/hardware.h>
-#include <mach/system.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap1/reset.c b/arch/arm/mach-omap1/reset.c
index 8b1cc6e..91d199b 100644
--- a/arch/arm/mach-omap1/reset.c
+++ b/arch/arm/mach-omap1/reset.c
@@ -5,7 +5,6 @@
 #include <linux/io.h>
 
 #include <mach/hardware.h>
-#include <mach/system.h>
 #include <plat/prcm.h>
 
 void omap1_restart(char mode, const char *cmd)
diff --git a/arch/arm/mach-omap2/prcm.c b/arch/arm/mach-omap2/prcm.c
index b6c8cb5..626acfa 100644
--- a/arch/arm/mach-omap2/prcm.c
+++ b/arch/arm/mach-omap2/prcm.c
@@ -25,7 +25,6 @@
 #include <linux/delay.h>
 #include <linux/export.h>
 
-#include <mach/system.h>
 #include "common.h"
 #include <plat/prcm.h>
 #include <plat/irqs.h>
