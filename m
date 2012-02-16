From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: [PATCH] arch/arm/mach-omap2/: included some headers twice
Date: Thu, 16 Feb 2012 15:45:02 +0100
Message-ID: <1329403502-32494-1-git-send-email-danny.kukawka@bisect.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Danny Kukawka <dkukawka@suse.de>, Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

arch/arm/mach-omap2/: included some headers tiwce:
- arch/arm/mach-omap2/board-ldp.c: 'linux/gpio.h'
- arch/arm/mach-omap2/io.c: 'common.h'
- arch/arm/mach-omap2/omap_hwmod_44xx_data.c: 'plat/i2c.h'

Remove the duplicates.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/arm/mach-omap2/board-ldp.c            |    1 -
 arch/arm/mach-omap2/io.c                   |    1 -
 arch/arm/mach-omap2/omap_hwmod_44xx_data.c |    1 -
 3 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/board-ldp.c b/arch/arm/mach-omap2/board-ldp.c
index 2d2a61f..ac42ebe 100644
--- a/arch/arm/mach-omap2/board-ldp.c
+++ b/arch/arm/mach-omap2/board-ldp.c
@@ -27,7 +27,6 @@
 #include <linux/io.h>
 #include <linux/smsc911x.h>
 #include <linux/mmc/host.h>
-#include <linux/gpio.h>
 
 #include <mach/hardware.h>
 #include <asm/mach-types.h>
diff --git a/arch/arm/mach-omap2/io.c b/arch/arm/mach-omap2/io.c
index eb50c29..9bd07f3 100644
--- a/arch/arm/mach-omap2/io.c
+++ b/arch/arm/mach-omap2/io.c
@@ -43,7 +43,6 @@
 #include "clockdomain.h"
 #include <plat/omap_hwmod.h>
 #include <plat/multi.h>
-#include "common.h"
 
 /*
  * The machine specific code may provide the extra mapping besides the
diff --git a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
index ef0524c..acb561e 100644
--- a/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_44xx_data.c
@@ -28,7 +28,6 @@
 #include <plat/mcspi.h>
 #include <plat/mcbsp.h>
 #include <plat/mmc.h>
-#include <plat/i2c.h>
 #include <plat/dmtimer.h>
 #include <plat/common.h>
 
-- 
1.7.8.3
