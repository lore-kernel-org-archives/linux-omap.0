From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/5] clocksource: move omap 32k timer to drivers/clocksource
Date: Tue, 19 Oct 2010 12:22:14 +0300
Message-ID: <1287480136-2046-4-git-send-email-balbi@ti.com>
References: <1287480136-2046-1-git-send-email-balbi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:39046 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758119Ab0JSJWi (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 19 Oct 2010 05:22:38 -0400
In-Reply-To: <1287480136-2046-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Felipe Balbi <balbi@ti.com>

this is a better location for that driver. No
changes to the code otherwise.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/plat-omap/Makefile                        |    2 +-
 drivers/clocksource/Makefile                       |    1 +
 .../clocksource/omap-32k.c                         |    2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)
 rename arch/arm/plat-omap/counter-32k.c => drivers/clocksource/omap-32k.c (98%)

diff --git a/arch/arm/plat-omap/Makefile b/arch/arm/plat-omap/Makefile
index ff57f33..2a15191 100644
--- a/arch/arm/plat-omap/Makefile
+++ b/arch/arm/plat-omap/Makefile
@@ -4,7 +4,7 @@
 
 # Common support
 obj-y := common.o sram.o clock.o devices.o dma.o mux.o gpio.o \
-	 usb.o fb.o io.o counter-32k.o
+	 usb.o fb.o io.o
 obj-m :=
 obj-n :=
 obj-  :=
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index be61ece..ccdbc16 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -1,6 +1,7 @@
 obj-$(CONFIG_ATMEL_TCB_CLKSRC)	+= tcb_clksrc.o
 obj-$(CONFIG_X86_CYCLONE_TIMER)	+= cyclone.o
 obj-$(CONFIG_X86_PM_TIMER)	+= acpi_pm.o
+obj-$(CONFIG_OMAP_32K_TIMER)	+= omap-32k.o
 obj-$(CONFIG_SCx200HR_TIMER)	+= scx200_hrt.o
 obj-$(CONFIG_CS5535_CLOCK_EVENT_SRC)	+= cs5535-clockevt.o
 obj-$(CONFIG_SH_TIMER_CMT)	+= sh_cmt.o
diff --git a/arch/arm/plat-omap/counter-32k.c b/drivers/clocksource/omap-32k.c
similarity index 98%
rename from arch/arm/plat-omap/counter-32k.c
rename to drivers/clocksource/omap-32k.c
index 7bfd67a..5c61510 100644
--- a/arch/arm/plat-omap/counter-32k.c
+++ b/drivers/clocksource/omap-32k.c
@@ -1,5 +1,5 @@
 /*
- * counter-32k.c -- OMAP 32k Sync Timer Clocksource Driver
+ * omap-32k.c -- OMAP 32k Sync Timer Clocksource Driver
  *
  * Copyright (C) 2005-2010 Tony Lindgren <tony@atomide.com>
  * Copyright (C) 2010 Nokia Corporation
-- 
1.7.3.1.120.g38a18

