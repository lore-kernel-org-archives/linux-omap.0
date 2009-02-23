From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 13/23] usb: host: ehci: remove ehci-omap.h
Date: Mon, 23 Feb 2009 20:52:41 +0200
Message-ID: <1235415171-17376-14-git-send-email-me@felipebalbi.com>
References: <1235415171-17376-1-git-send-email-me@felipebalbi.com>
 <1235415171-17376-2-git-send-email-me@felipebalbi.com>
 <1235415171-17376-3-git-send-email-me@felipebalbi.com>
 <1235415171-17376-4-git-send-email-me@felipebalbi.com>
 <1235415171-17376-5-git-send-email-me@felipebalbi.com>
 <1235415171-17376-6-git-send-email-me@felipebalbi.com>
 <1235415171-17376-7-git-send-email-me@felipebalbi.com>
 <1235415171-17376-8-git-send-email-me@felipebalbi.com>
 <1235415171-17376-9-git-send-email-me@felipebalbi.com>
 <1235415171-17376-10-git-send-email-me@felipebalbi.com>
 <1235415171-17376-11-git-send-email-me@felipebalbi.com>
 <1235415171-17376-12-git-send-email-me@felipebalbi.com>
 <1235415171-17376-13-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42813 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755048AbZBWS6g (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:58:36 -0500
In-Reply-To: <1235415171-17376-13-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Syed Mohammed Khasim <x0khasim@ti.com>, Felipe Balbi <me@felipebalbi.com>

That header is only used by ehci-omap.c for register
definitions and indirectly include some other headers.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |  100 +++++++++++++++++++++++++++++++++-
 drivers/usb/host/ehci-omap.h |  125 ------------------------------------------
 2 files changed, 99 insertions(+), 126 deletions(-)
 delete mode 100644 drivers/usb/host/ehci-omap.h

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 7f37b5f..2bdc978 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -29,7 +29,105 @@
 #include <linux/clk.h>
 #include <linux/gpio.h>
 
-#include "ehci-omap.h"
+/* FIXME remove platform-specific code */
+#include <mach/hardware.h>
+#include "../../../arch/arm/mach-omap2/cm.h"
+#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
+
+/*
+ * OMAP USBHOST Register addresses: PHYSICAL ADDRESSES
+ *	Use omap_readl()/omap_writel() functions
+ */
+
+/* USBHOST: TLL, UUH, OHCI, EHCI */
+#define	OMAP_USBHOST_BASE	(L4_34XX_BASE + 0x60000)
+
+/* TLL Register Set */
+#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
+#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
+#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
+	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
+	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
+	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT	2
+	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT	1
+	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE_SHIFT	0
+#define	OMAP_USBTLL_SYSSTATUS	(OMAP_USBHOST_TLL_BASE + 0x14)
+	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT	0
+#define	OMAP_USBTLL_IRQSTATUS	(OMAP_USBHOST_TLL_BASE + 0x18)
+#define	OMAP_USBTLL_IRQENABLE	(OMAP_USBHOST_TLL_BASE + 0x1C)
+
+#define	OMAP_TLL_SHARED_CONF	(OMAP_USBHOST_TLL_BASE + 0x30)
+	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT	6
+	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT	5
+	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT	2
+	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ_SHIFT		1
+	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT		0
+
+#define	OMAP_TLL_CHANNEL_CONF(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x040 + 0x004 * num))
+	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT	11
+	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE_SHIFT	10
+	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT	9
+	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT		8
+	#define	OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT		0
+
+#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x804 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x807 + 0x100 * num))
+#define	OMAP_TLL_ULPI_OTG_CTRL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x80A + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_EN_RISE(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x80D + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_EN_FALL(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x810 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_STATUS(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x813 + 0x100 * num))
+#define	OMAP_TLL_ULPI_INT_LATCH(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x814 + 0x100 * num))
+#define	OMAP_TLL_ULPI_DEBUG(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x815 + 0x100 * num))
+#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)\
+			(OMAP_USBHOST_TLL_BASE + (0x816 + 0x100 * num))
+
+#define OMAP_TLL_CHANNEL_COUNT		3
+	#define OMAP_TLL_CHANNEL_1_EN_MASK	1
+	#define OMAP_TLL_CHANNEL_2_EN_MASK	2
+	#define OMAP_TLL_CHANNEL_3_EN_MASK	4
+
+/* UHH Register Set */
+#define	OMAP_USBHOST_UHH_BASE	(OMAP_USBHOST_BASE + 0x4000)
+#define	OMAP_UHH_REVISION	(OMAP_USBHOST_UHH_BASE + 0x00)
+#define	OMAP_UHH_SYSCONFIG	(OMAP_USBHOST_UHH_BASE + 0x10)
+	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT	12
+	#define	OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT	8
+	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT	3
+	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT	2
+	#define	OMAP_UHH_SYSCONFIG_SOFTRESET_SHIFT	1
+	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT	0
+
+#define	OMAP_UHH_SYSSTATUS	(OMAP_USBHOST_UHH_BASE + 0x14)
+#define	OMAP_UHH_HOSTCONFIG	(OMAP_USBHOST_UHH_BASE + 0x40)
+	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT	0
+	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT	2
+	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT	3
+	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT	4
+	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT	5
+
+#define	OMAP_UHH_DEBUG_CSR	(OMAP_USBHOST_UHH_BASE + 0x44)
+
+/* EHCI Register Set */
+#define	OMAP_USBHOST_EHCI_BASE	(OMAP_USBHOST_BASE + 0x4800)
+#define	EHCI_INSNREG05_ULPI		(OMAP_USBHOST_EHCI_BASE + 0xA4)
+	#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT	31
+	#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT	24
+	#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT		22
+	#define	EHCI_INSNREG05_ULPI_REGADD_SHIFT	16
+	#define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT	8
+	#define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT	0
+
+/* OHCI Register Set */
+#define	OMAP_USBHOST_OHCI_BASE	(OMAP_USBHOST_BASE + 0x4400)
 
 #ifdef CONFIG_OMAP_EHCI_PHY_MODE
 /* EHCI connected to External PHY */
diff --git a/drivers/usb/host/ehci-omap.h b/drivers/usb/host/ehci-omap.h
deleted file mode 100644
index 9e4378f..0000000
--- a/drivers/usb/host/ehci-omap.h
+++ /dev/null
@@ -1,125 +0,0 @@
-/*
- * ehci-omap.h - register definitions for USBHOST in OMAP 34xx
- *
- * Copyright (C) 2007-2008 Texas Instruments, Inc.
- * 	Author: Vikram Pandita <vikram.pandita@ti.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
- *
- */
-
-#ifndef __EHCI_OMAP_H
-#define __EHCI_OMAP_H
-
-#include <mach/hardware.h>
-#include "../../../arch/arm/mach-omap2/cm.h"
-#include "../../../arch/arm/mach-omap2/cm-regbits-34xx.h"
-
-/*
- * OMAP USBHOST Register addresses: PHYSICAL ADDRESSES
- * 	Use omap_readl()/omap_writel() functions
- */
-
-/* USBHOST: TLL, UUH, OHCI, EHCI */
-#define	OMAP_USBHOST_BASE	(L4_34XX_BASE + 0x60000)
-
-/* TLL Register Set */
-#define	OMAP_USBHOST_TLL_BASE	(OMAP_USBHOST_BASE + 0x2000)
-#define	OMAP_USBTLL_REVISION	(OMAP_USBHOST_TLL_BASE + 0x00)
-#define	OMAP_USBTLL_SYSCONFIG	(OMAP_USBHOST_TLL_BASE + 0x10)
-	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY_SHIFT	8
-	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE_SHIFT	3
-	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP_SHIFT	2
-	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET_SHIFT	1
-	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE_SHIFT	0
-#define	OMAP_USBTLL_SYSSTATUS	(OMAP_USBHOST_TLL_BASE + 0x14)
-	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE_SHIFT	0
-#define	OMAP_USBTLL_IRQSTATUS	(OMAP_USBHOST_TLL_BASE + 0x18)
-#define	OMAP_USBTLL_IRQENABLE	(OMAP_USBHOST_TLL_BASE + 0x1C)
-
-#define	OMAP_TLL_SHARED_CONF	(OMAP_USBHOST_TLL_BASE + 0x30)
-	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN_SHFT	6
-	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN_SHIFT	5
-	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION_SHIFT	2
-	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ_SHIFT		1
-	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON_SHIFT		0
-
-#define	OMAP_TLL_CHANNEL_CONF(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x040 + 0x004 * num))
-	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF_SHIFT	11
-	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE_SHIFT	10
-	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE_SHIFT	9
-	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE_SHIFT		8
-	#define	OMAP_TLL_CHANNEL_CONF_CHANEN_SHIFT		0
-
-#define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x804 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x807 + 0x100 * num))
-#define	OMAP_TLL_ULPI_OTG_CTRL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x80A + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_EN_RISE(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x80D + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_EN_FALL(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x810 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_STATUS(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x813 + 0x100 * num))
-#define	OMAP_TLL_ULPI_INT_LATCH(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x814 + 0x100 * num))
-#define	OMAP_TLL_ULPI_DEBUG(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x815 + 0x100 * num))
-#define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)\
-			(OMAP_USBHOST_TLL_BASE + (0x816 + 0x100 * num))
-
-#define OMAP_TLL_CHANNEL_COUNT		3
-	#define OMAP_TLL_CHANNEL_1_EN_MASK	1
-	#define OMAP_TLL_CHANNEL_2_EN_MASK	2
-	#define OMAP_TLL_CHANNEL_3_EN_MASK	4
-
-/* UHH Register Set */
-#define	OMAP_USBHOST_UHH_BASE	(OMAP_USBHOST_BASE + 0x4000)
-#define	OMAP_UHH_REVISION	(OMAP_USBHOST_UHH_BASE + 0x00)
-#define	OMAP_UHH_SYSCONFIG	(OMAP_USBHOST_UHH_BASE + 0x10)
-	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE_SHIFT	12
-	#define	OMAP_UHH_SYSCONFIG_CACTIVITY_SHIFT	8
-	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE_SHIFT	3
-	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP_SHIFT	2
-	#define	OMAP_UHH_SYSCONFIG_SOFTRESET_SHIFT	1
-	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE_SHIFT	0
-
-#define	OMAP_UHH_SYSSTATUS	(OMAP_USBHOST_UHH_BASE + 0x14)
-#define	OMAP_UHH_HOSTCONFIG	(OMAP_USBHOST_UHH_BASE + 0x40)
-	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS_SHIFT	0
-	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN_SHIFT	2
-	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN_SHIFT	3
-	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN_SHIFT	4
-	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN_SHIFT	5
-
-#define	OMAP_UHH_DEBUG_CSR	(OMAP_USBHOST_UHH_BASE + 0x44)
-
-/* EHCI Register Set */
-#define	OMAP_USBHOST_EHCI_BASE	(OMAP_USBHOST_BASE + 0x4800)
-#define	EHCI_INSNREG05_ULPI		(OMAP_USBHOST_EHCI_BASE + 0xA4)
-	#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT	31
-	#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT	24
-	#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT		22
-	#define	EHCI_INSNREG05_ULPI_REGADD_SHIFT	16
-	#define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT	8
-	#define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT	0
-
-/* OHCI Register Set */
-#define	OMAP_USBHOST_OHCI_BASE	(OMAP_USBHOST_BASE + 0x4400)
-
-#endif/* __EHCI_OMAP_H*/
-- 
1.6.1.3

