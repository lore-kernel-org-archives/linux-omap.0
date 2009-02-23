From: Felipe Balbi <me@felipebalbi.com>
Subject: [rft/rfc/patch-v2.6.29-rc5+ 20/23] usb: host: ehci: align defines
Date: Mon, 23 Feb 2009 20:55:32 +0200
Message-ID: <1235415335-17408-21-git-send-email-me@felipebalbi.com>
References: <1235415335-17408-1-git-send-email-me@felipebalbi.com>
 <1235415335-17408-2-git-send-email-me@felipebalbi.com>
 <1235415335-17408-3-git-send-email-me@felipebalbi.com>
 <1235415335-17408-4-git-send-email-me@felipebalbi.com>
 <1235415335-17408-5-git-send-email-me@felipebalbi.com>
 <1235415335-17408-6-git-send-email-me@felipebalbi.com>
 <1235415335-17408-7-git-send-email-me@felipebalbi.com>
 <1235415335-17408-8-git-send-email-me@felipebalbi.com>
 <1235415335-17408-9-git-send-email-me@felipebalbi.com>
 <1235415335-17408-10-git-send-email-me@felipebalbi.com>
 <1235415335-17408-11-git-send-email-me@felipebalbi.com>
 <1235415335-17408-12-git-send-email-me@felipebalbi.com>
 <1235415335-17408-13-git-send-email-me@felipebalbi.com>
 <1235415335-17408-14-git-send-email-me@felipebalbi.com>
 <1235415335-17408-15-git-send-email-me@felipebalbi.com>
 <1235415335-17408-16-git-send-email-me@felipebalbi.com>
 <1235415335-17408-17-git-send-email-me@felipebalbi.com>
 <1235415335-17408-18-git-send-email-me@felipebalbi.com>
 <1235415335-17408-19-git-send-email-me@felipebalbi.com>
 <1235415335-17408-20-git-send-email-me@felipebalbi.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns1.siteground211.com ([209.62.36.12]:42680 "EHLO
	serv01.siteground211.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbZBWS5d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 23 Feb 2009 13:57:33 -0500
In-Reply-To: <1235415335-17408-20-git-send-email-me@felipebalbi.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Steve Sakoman <steve@sakoman.com>, Anand Gadiyar <gadiyar@ti.com>, Felipe Balbi <me@felipebalbi.com>

Just making it better for my bad eyes. Style only, no
functional changes.

Signed-off-by: Felipe Balbi <me@felipebalbi.com>
---
 drivers/usb/host/ehci-omap.c |  114 ++++++++++++++++++++---------------------
 1 files changed, 56 insertions(+), 58 deletions(-)

diff --git a/drivers/usb/host/ehci-omap.c b/drivers/usb/host/ehci-omap.c
index 48ced8f..c2b592f 100644
--- a/drivers/usb/host/ehci-omap.c
+++ b/drivers/usb/host/ehci-omap.c
@@ -43,32 +43,33 @@
  */
 
 /* TLL Register Set */
-#define	OMAP_USBTLL_REVISION	(0x00)
-#define	OMAP_USBTLL_SYSCONFIG	(0x10)
-	#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY		(1 << 8)
-	#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE		(1 << 3)
-	#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP		(1 << 2)
-	#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET		(1 << 1)
-	#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE		(1 << 0)
-#define	OMAP_USBTLL_SYSSTATUS	(0x14)
-	#define	OMAP_USBTLL_SYSSTATUS_RESETDONE		(1 << 0)
-#define	OMAP_USBTLL_IRQSTATUS	(0x18)
-#define	OMAP_USBTLL_IRQENABLE	(0x1C)
-
-#define	OMAP_TLL_SHARED_CONF	(0x30)
-	#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
-	#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
-	#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
-	#define	OMAP_TLL_SHARED_CONF_FCLK_REQ			(1 << 1)
-	#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
-
-#define	OMAP_TLL_CHANNEL_CONF(num)\
-			(0x040 + 0x004 * num)
-	#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
-	#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
-	#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
-	#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
-	#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
+#define	OMAP_USBTLL_REVISION				(0x00)
+#define	OMAP_USBTLL_SYSCONFIG				(0x10)
+#define	OMAP_USBTLL_SYSCONFIG_CACTIVITY			(1 << 8)
+#define	OMAP_USBTLL_SYSCONFIG_SIDLEMODE			(1 << 3)
+#define	OMAP_USBTLL_SYSCONFIG_ENAWAKEUP			(1 << 2)
+#define	OMAP_USBTLL_SYSCONFIG_SOFTRESET			(1 << 1)
+#define	OMAP_USBTLL_SYSCONFIG_AUTOIDLE			(1 << 0)
+
+#define	OMAP_USBTLL_SYSSTATUS				(0x14)
+#define	OMAP_USBTLL_SYSSTATUS_RESETDONE			(1 << 0)
+
+#define	OMAP_USBTLL_IRQSTATUS				(0x18)
+#define	OMAP_USBTLL_IRQENABLE				(0x1C)
+
+#define	OMAP_TLL_SHARED_CONF				(0x30)
+#define	OMAP_TLL_SHARED_CONF_USB_90D_DDR_EN		(1 << 6)
+#define	OMAP_TLL_SHARED_CONF_USB_180D_SDR_EN		(1 << 5)
+#define	OMAP_TLL_SHARED_CONF_USB_DIVRATION		(1 << 2)
+#define	OMAP_TLL_SHARED_CONF_FCLK_REQ			(1 << 1)
+#define	OMAP_TLL_SHARED_CONF_FCLK_IS_ON			(1 << 0)
+
+#define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
+#define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
+#define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
+#define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
+#define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
+#define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
 
 #define	OMAP_TLL_ULPI_FUNCTION_CTRL(num)		(0x804 + 0x100 * num)
 #define	OMAP_TLL_ULPI_INTERFACE_CTRL(num)		(0x807 + 0x100 * num)
@@ -80,42 +81,39 @@
 #define	OMAP_TLL_ULPI_DEBUG(num)			(0x815 + 0x100 * num)
 #define	OMAP_TLL_ULPI_SCRATCH_REGISTER(num)		(0x816 + 0x100 * num)
 
-#define OMAP_TLL_CHANNEL_COUNT		3
-	#define OMAP_TLL_CHANNEL_1_EN_MASK	(1 << 1)
-	#define OMAP_TLL_CHANNEL_2_EN_MASK	(1 << 2)
-	#define OMAP_TLL_CHANNEL_3_EN_MASK	(1 << 4)
+#define OMAP_TLL_CHANNEL_COUNT				3
+#define OMAP_TLL_CHANNEL_1_EN_MASK			(1 << 1)
+#define OMAP_TLL_CHANNEL_2_EN_MASK			(1 << 2)
+#define OMAP_TLL_CHANNEL_3_EN_MASK			(1 << 4)
 
 /* UHH Register Set */
-#define	OMAP_UHH_REVISION	(0x00)
-#define	OMAP_UHH_SYSCONFIG	(0x10)
-	#define	OMAP_UHH_SYSCONFIG_MIDLEMODE	(1 << 12)
-	#define	OMAP_UHH_SYSCONFIG_CACTIVITY	(1 << 8)
-	#define	OMAP_UHH_SYSCONFIG_SIDLEMODE	(1 << 3)
-	#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP	(1 << 2)
-	#define	OMAP_UHH_SYSCONFIG_SOFTRESET	(1 << 1)
-	#define	OMAP_UHH_SYSCONFIG_AUTOIDLE	(1 << 0)
-
-#define	OMAP_UHH_SYSSTATUS	(0x14)
-#define	OMAP_UHH_HOSTCONFIG	(0x40)
-	#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS		(1 << 0)
-	#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN	(1 << 2)
-	#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN	(1 << 3)
-	#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN	(1 << 4)
-	#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN	(1 << 5)
-
-#define	OMAP_UHH_DEBUG_CSR	(0x44)
+#define	OMAP_UHH_REVISION				(0x00)
+#define	OMAP_UHH_SYSCONFIG				(0x10)
+#define	OMAP_UHH_SYSCONFIG_MIDLEMODE			(1 << 12)
+#define	OMAP_UHH_SYSCONFIG_CACTIVITY			(1 << 8)
+#define	OMAP_UHH_SYSCONFIG_SIDLEMODE			(1 << 3)
+#define	OMAP_UHH_SYSCONFIG_ENAWAKEUP			(1 << 2)
+#define	OMAP_UHH_SYSCONFIG_SOFTRESET			(1 << 1)
+#define	OMAP_UHH_SYSCONFIG_AUTOIDLE			(1 << 0)
+
+#define	OMAP_UHH_SYSSTATUS				(0x14)
+#define	OMAP_UHH_HOSTCONFIG				(0x40)
+#define	OMAP_UHH_HOSTCONFIG_ULPI_BYPASS			(1 << 0)
+#define OMAP_UHH_HOSTCONFIG_INCR4_BURST_EN		(1 << 2)
+#define OMAP_UHH_HOSTCONFIG_INCR8_BURST_EN		(1 << 3)
+#define OMAP_UHH_HOSTCONFIG_INCR16_BURST_EN		(1 << 4)
+#define OMAP_UHH_HOSTCONFIG_INCRX_ALIGN_EN		(1 << 5)
+
+#define	OMAP_UHH_DEBUG_CSR				(0x44)
 
 /* EHCI Register Set */
-#define	EHCI_INSNREG05_ULPI		(0xA4)
-	#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT	31
-	#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT	24
-	#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT		22
-	#define	EHCI_INSNREG05_ULPI_REGADD_SHIFT	16
-	#define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT	8
-	#define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT	0
-
-/* OHCI Register Set */
-#define	OMAP_USBHOST_OHCI_BASE	(OMAP_USBHOST_BASE + 0x4400)
+#define	EHCI_INSNREG05_ULPI				(0xA4)
+#define	EHCI_INSNREG05_ULPI_CONTROL_SHIFT		31
+#define	EHCI_INSNREG05_ULPI_PORTSEL_SHIFT		24
+#define	EHCI_INSNREG05_ULPI_OPSEL_SHIFT			22
+#define	EHCI_INSNREG05_ULPI_REGADD_SHIFT		16
+#define	EHCI_INSNREG05_ULPI_EXTREGADD_SHIFT		8
+#define	EHCI_INSNREG05_ULPI_WRDATA_SHIFT		0
 
 /*-------------------------------------------------------------------------*/
 
-- 
1.6.1.3

