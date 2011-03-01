From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [PATCH 03/10 v2] arm: omap2: usb: rename usb-ehci.c to usb-host.c
Date: Tue,  1 Mar 2011 20:08:15 +0530
Message-ID: <1298990302-30475-4-git-send-email-keshava_mgowda@ti.com>
References: <1298990302-30475-1-git-send-email-keshava_mgowda@ti.com>
 <1298990302-30475-2-git-send-email-keshava_mgowda@ti.com>
 <1298990302-30475-3-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:42404 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051Ab1CAOit (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 1 Mar 2011 09:38:49 -0500
In-Reply-To: <1298990302-30475-3-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, balbi@ti.com, gadiyar@ti.com, p-basak2@ti.com

From: Felipe Balbi <balbi@ti.com>

We already have both EHCI and OHCI there, so let's
rename to be sure everybody will understand the entire
USB HOST functionality is setup on this file.

Signed-off-by: Felipe Balbi <balbi@ti.com>
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
  * Author: Vikram Pandita <vikram.pandita@ti.com>
  *
  * Generalization by:
- * Felipe Balbi <felipe.balbi@nokia.com>
+ * Felipe Balbi <balbi@ti.com>
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
-- 
1.6.0.4

