From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 09/29] ARM: OMAP2+: Make am35xx.h local
Date: Wed, 19 Sep 2012 14:05:59 -0700
Message-ID: <20120919210558.28074.81754.stgit@muffinssi>
References: <20120919205732.28074.43697.stgit@muffinssi>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mho-04-ewr.mailhop.org ([204.13.248.74]:43003 "EHLO
	mho-02-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751929Ab2ISVGA (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:06:00 -0400
In-Reply-To: <20120919205732.28074.43697.stgit@muffinssi>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-omap@vger.kernel.org

This can be local to mach-omap2.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/am35xx-emac.c          |    2 +-
 arch/arm/mach-omap2/am35xx.h               |    0 
 arch/arm/mach-omap2/board-am3517evm.c      |    2 +-
 arch/arm/mach-omap2/board-cm-t3517.c       |    2 +-
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    2 +-
 arch/arm/mach-omap2/usb-musb.c             |    2 +-
 6 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap2/{include/mach/am35xx.h => am35xx.h} (100%)

diff --git a/arch/arm/mach-omap2/am35xx-emac.c b/arch/arm/mach-omap2/am35xx-emac.c
index 2c90ac6..d0c54c5 100644
--- a/arch/arm/mach-omap2/am35xx-emac.c
+++ b/arch/arm/mach-omap2/am35xx-emac.c
@@ -19,7 +19,7 @@
 #include <linux/davinci_emac.h>
 #include <asm/system.h>
 #include <plat/omap_device.h>
-#include <mach/am35xx.h>
+#include "am35xx.h"
 #include "control.h"
 #include "am35xx-emac.h"
 
diff --git a/arch/arm/mach-omap2/include/mach/am35xx.h b/arch/arm/mach-omap2/am35xx.h
similarity index 100%
rename from arch/arm/mach-omap2/include/mach/am35xx.h
rename to arch/arm/mach-omap2/am35xx.h
diff --git a/arch/arm/mach-omap2/board-am3517evm.c b/arch/arm/mach-omap2/board-am3517evm.c
index 6e80d78..e162897 100644
--- a/arch/arm/mach-omap2/board-am3517evm.c
+++ b/arch/arm/mach-omap2/board-am3517evm.c
@@ -27,7 +27,7 @@
 #include <linux/mmc/host.h>
 #include <linux/platform_data/gpio-omap.h>
 
-#include <mach/am35xx.h>
+#include "am35xx.h"
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
diff --git a/arch/arm/mach-omap2/board-cm-t3517.c b/arch/arm/mach-omap2/board-cm-t3517.c
index 27a5450..a749990 100644
--- a/arch/arm/mach-omap2/board-cm-t3517.c
+++ b/arch/arm/mach-omap2/board-cm-t3517.c
@@ -43,7 +43,7 @@
 #include <plat/nand.h>
 #include <plat/gpmc.h>
 
-#include <mach/am35xx.h>
+#include "am35xx.h"
 
 #include "mux.h"
 #include "control.h"
diff --git a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
index 8fec2ce..61486f2 100644
--- a/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
+++ b/arch/arm/mach-omap2/omap_hwmod_3xxx_data.c
@@ -28,7 +28,7 @@
 #include <plat/mcspi.h>
 #include <plat/dmtimer.h>
 
-#include <mach/am35xx.h>
+#include "am35xx.h"
 
 #include "soc.h"
 #include "omap_hwmod_common_data.h"
diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
index 0a592f4..51da21c 100644
--- a/arch/arm/mach-omap2/usb-musb.c
+++ b/arch/arm/mach-omap2/usb-musb.c
@@ -28,7 +28,7 @@
 #include <plat/usb.h>
 #include <plat/omap_device.h>
 
-#include <mach/am35xx.h>
+#include "am35xx.h"
 
 #include "mux.h"
 

