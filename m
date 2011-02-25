From: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 03/10] arm: omap2: usb: rename usb-ehci.c to usb-host.c
Date: Sat, 26 Feb 2011 04:36:31 +0530
Message-ID: <1298675198-14214-4-git-send-email-keshava_mgowda@ti.com>
References: <1298675198-14214-1-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-2-git-send-email-keshava_mgowda@ti.com>
 <1298675198-14214-3-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1298675198-14214-3-git-send-email-keshava_mgowda-l0cyMroinI0@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Keshava Munegowda <keshava_mgowda-l0cyMroinI0@public.gmane.org>, balbi-l0cyMroinI0@public.gmane.org, gadiyar-l0cyMroinI0@public.gmane.org, p-basak2-l0cyMroinI0@public.gmane.org
List-Id: linux-omap@vger.kernel.org

From: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>

We already have both EHCI and OHCI there, so let's
rename to be sure everybody will understand the entire
USB HOST functionality is setup on this file.

Signed-off-by: Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
---
 arch/arm/mach-omap2/Makefile                   |    2 +-
 arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} |    8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)
 rename arch/arm/mach-omap2/{usb-ehci.c => usb-host.c} (98%)

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index 1c0c2b0..64dc417 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -229,7 +229,7 @@ usbfs-$(CONFIG_ARCH_OMAP_OTG)		:= usb-fs.o
 obj-y					+= $(usbfs-m) $(usbfs-y)
 obj-y					+= usb-musb.o
 obj-$(CONFIG_MACH_OMAP2_TUSB6010)	+= usb-tusb6010.o
-obj-y					+= usb-ehci.o
+obj-y					+= usb-host.o
 
 onenand-$(CONFIG_MTD_ONENAND_OMAP2)	:= gpmc-onenand.o
 obj-y					+= $(onenand-m) $(onenand-y)
diff --git a/arch/arm/mach-omap2/usb-ehci.c b/arch/arm/mach-omap2/usb-host.c
similarity index 98%
rename from arch/arm/mach-omap2/usb-ehci.c
rename to arch/arm/mach-omap2/usb-host.c
index 2c74fa1..45f9b80 100644
--- a/arch/arm/mach-omap2/usb-ehci.c
+++ b/arch/arm/mach-omap2/usb-host.c
@@ -1,14 +1,14 @@
 /*
- * linux/arch/arm/mach-omap2/usb-ehci.c
+ * usb-host.c - OMAP USB Host
  *
  * This file will contain the board specific details for the
- * Synopsys EHCI host controller on OMAP3430
+ * Synopsys EHCI/OHCI host controller on OMAP3430 and onwards
  *
- * Copyright (C) 2007 Texas Instruments
+ * Copyright (C) 2007-2011 Texas Instruments
  * Author: Vikram Pandita <vikram.pandita-l0cyMroinI0@public.gmane.org>
  *
  * Generalization by:
- * Felipe Balbi <felipe.balbi-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>
+ * Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
