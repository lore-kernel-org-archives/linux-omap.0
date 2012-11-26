From: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
Subject: [PATCH] ARM: OMAP: Conditionally compile counter_32k
Date: Mon, 26 Nov 2012 10:28:03 +0100
Message-ID: <1353922083-1094-1-git-send-email-alessio.bogani@elettra.trieste.it>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
List-Id: linux-omap@vger.kernel.org

The 32K timer isn't available on all OMAP devices.

Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.trieste.it>
---
 arch/arm/plat-omap/Makefile |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index 8d88584..b1b321c 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -3,11 +3,13 @@
 #
 
 # Common support
-obj-y := sram.o dma.o fb.o counter_32k.o
+obj-y := sram.o dma.o fb.o
 obj-m :=
 obj-n :=
 obj-  :=
 
+obj-$(CONFIG_OMAP_32K_TIMER) += counter_32k.o
+
 # omap_device support (OMAP2+ only at the moment)
 
 obj-$(CONFIG_OMAP_DM_TIMER) += dmtimer.o
-- 
1.7.9.5
