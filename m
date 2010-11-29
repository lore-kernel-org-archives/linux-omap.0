From: Anand Gadiyar <gadiyar@ti.com>
Subject: [PATCH v2 1/4] arm: omap4: add USBHOST and related base addresses
Date: Mon, 29 Nov 2010 22:56:09 +0530
Message-ID: <1291051572-24084-2-git-send-email-gadiyar@ti.com>
References: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:41416 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755337Ab0K2R0V (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 29 Nov 2010 12:26:21 -0500
In-Reply-To: <1291051572-24084-1-git-send-email-gadiyar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-usb@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Greg KH <gregkh@suse.de>, Anand Gadiyar <gadiyar@ti.com>

Add base addresses for USBHOST, USBTLL, EHCI and OHCI to
the header file.

This will disappear when the drivers are converted to use
the hwmod database, however this patch is needed until then.

Signed-off-by: Anand Gadiyar <gadiyar@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/plat-omap/include/plat/omap44xx.h |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-omap/include/plat/omap44xx.h b/arch/arm/plat-omap/include/plat/omap44xx.h
index 8b3f12f..ea2b8a6 100644
--- a/arch/arm/plat-omap/include/plat/omap44xx.h
+++ b/arch/arm/plat-omap/include/plat/omap44xx.h
@@ -52,5 +52,10 @@
 #define OMAP4_MMU1_BASE			0x55082000
 #define OMAP4_MMU2_BASE			0x4A066000
 
+#define OMAP44XX_USBTLL_BASE		(L4_44XX_BASE + 0x62000)
+#define OMAP44XX_UHH_CONFIG_BASE	(L4_44XX_BASE + 0x64000)
+#define OMAP44XX_HSUSB_OHCI_BASE	(L4_44XX_BASE + 0x64800)
+#define OMAP44XX_HSUSB_EHCI_BASE	(L4_44XX_BASE + 0x64C00)
+
 #endif /* __ASM_ARCH_OMAP44XX_H */
 
-- 
1.7.0.4

