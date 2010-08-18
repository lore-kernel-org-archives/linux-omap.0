From: Keshava Munegowda <keshava_mgowda@ti.com>
Subject: [RFC] [PATCH 1/7] usb: ehci-omap: Add the HSUSB base address
Date: Thu, 19 Aug 2010 05:19:31 +0530
Message-ID: <1282175377-2784-2-git-send-email-keshava_mgowda@ti.com>
References: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:48573 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752774Ab0HSLtB (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Aug 2010 07:49:01 -0400
In-Reply-To: <1282175377-2784-1-git-send-email-keshava_mgowda@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Keshava Munegowda <keshava_mgowda@ti.com>, Anand Gadiyar <gadiyar@ti.com>

Update omap44xx.h with base addresses for USBHOST and USBTLL.
This patch will be replaced with the HWMOD(hardware mode) implementation later.

Signed-off-by: Keshava Munegowda <keshava_mgowda@ti.com>
Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: kernel-omap4-base/arch/arm/plat-omap/include/plat/omap44xx.h
===================================================================
--- kernel-omap4-base.orig/arch/arm/plat-omap/include/plat/omap44xx.h
+++ kernel-omap4-base/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,10 @@
 #define OMAP4_MMU1_BASE			0x55082000
 #define OMAP4_MMU2_BASE			0x4A066000
 
+#define OMAP44XX_USBTLL_BASE		(L4_44XX_BASE + 0x62000)
+#define OMAP44XX_UHH_CONFIG_BASE	(L4_44XX_BASE + 0x64000)
+#define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
+#define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
