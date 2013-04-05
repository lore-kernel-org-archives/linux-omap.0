From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] omap2+: Remove useless Makefile line
Date: Fri, 05 Apr 2013 12:12:29 +0200
Message-ID: <1365156749.1830.60.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Commit f41caddbe73f52a42f529d668ce47b4d693fd2c0 ("omap2+: Use Kconfig
symbol in Makefile instead of obj-y") reorganized this Makefile. But,
for some reason, it also added references to CONFIG_MACH_ENCORE and
board-omap3encore.o. But there's no Kconfig symbol MACH_ENCORE and
there's no file board-omap3encore.c. This line can safely be removed.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
 arch/arm/mach-omap2/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index b068b7f..3d0697c 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -229,7 +229,6 @@ obj-$(CONFIG_MACH_DEVKIT8000)     	+= board-devkit8000.o
 obj-$(CONFIG_MACH_OMAP_LDP)		+= board-ldp.o
 obj-$(CONFIG_MACH_OMAP3530_LV_SOM)      += board-omap3logic.o
 obj-$(CONFIG_MACH_OMAP3_TORPEDO)        += board-omap3logic.o
-obj-$(CONFIG_MACH_ENCORE)		+= board-omap3encore.o
 obj-$(CONFIG_MACH_OVERO)		+= board-overo.o
 obj-$(CONFIG_MACH_OMAP3EVM)		+= board-omap3evm.o
 obj-$(CONFIG_MACH_OMAP3_PANDORA)	+= board-omap3pandora.o
-- 
1.7.11.7
