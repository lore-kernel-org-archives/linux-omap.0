From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 10/23] mfd: omap-usb-tll: Add OMAP5 revision and HSIC support
Date: Tue, 4 Dec 2012 16:13:03 +0200
Message-ID: <1354630396-24545-11-git-send-email-rogerq@ti.com>
References: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42352 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754230Ab2LDONo (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 4 Dec 2012 09:13:44 -0500
In-Reply-To: <1354630396-24545-1-git-send-email-rogerq@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: balbi@ti.com
Cc: keshava_mgowda@ti.com, sshtylyov@mvista.com, bjorn@mork.no, rogerq@ti.com, linux-usb@vger.kernel.org, linux-omap@vger.kernel.org

The TLL module on OMAP5 has 3 channels.
HSIC mode requires the TLL channel to be in Transparent UTMI mode.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 drivers/mfd/omap-usb-tll.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
index 7b4afd0..ecc6a62 100644
--- a/drivers/mfd/omap-usb-tll.c
+++ b/drivers/mfd/omap-usb-tll.c
@@ -54,10 +54,13 @@
 
 #define	OMAP_TLL_CHANNEL_CONF(num)			(0x040 + 0x004 * num)
 #define OMAP_TLL_CHANNEL_CONF_FSLSMODE_SHIFT		24
+#define OMAP_TLL_CHANNEL_CONF_DRVVBUS			(1 << 16)
+#define OMAP_TLL_CHANNEL_CONF_CHRGVBUS			(1 << 15)
 #define	OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF		(1 << 11)
 #define	OMAP_TLL_CHANNEL_CONF_ULPI_ULPIAUTOIDLE		(1 << 10)
 #define	OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE		(1 << 9)
 #define	OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE		(1 << 8)
+#define OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI	(2 << 1)
 #define OMAP_TLL_CHANNEL_CONF_CHANMODE_FSLS		(1 << 1)
 #define	OMAP_TLL_CHANNEL_CONF_CHANEN			(1 << 0)
 
@@ -92,6 +95,7 @@
 #define OMAP_USBTLL_REV1		0x00000015	/* OMAP3 */
 #define OMAP_USBTLL_REV2		0x00000018	/* OMAP 3630 */
 #define OMAP_USBTLL_REV3		0x00000004	/* OMAP4 */
+#define OMAP_USBTLL_REV4		0x00000006	/* OMAP5 */
 
 #define is_ehci_tll_mode(x)	(x == OMAP_EHCI_PORT_MODE_TLL)
 
@@ -242,6 +246,7 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 	ver =  usbtll_read(base, OMAP_USBTLL_REVISION);
 	switch (ver) {
 	case OMAP_USBTLL_REV1:
+	case OMAP_USBTLL_REV4:
 		tll->nch = OMAP_TLL_CHANNEL_COUNT;
 		break;
 	case OMAP_USBTLL_REV2:
@@ -310,6 +315,15 @@ static int __devinit usbtll_omap_probe(struct platform_device *pdev)
 				reg &= ~(OMAP_TLL_CHANNEL_CONF_UTMIAUTOIDLE
 					| OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF
 					| OMAP_TLL_CHANNEL_CONF_ULPIDDRMODE);
+			} else if (pdata->port_mode[i] ==
+					OMAP_EHCI_PORT_MODE_HSIC) {
+				/*
+				 * HSIC Mode requires UTMI port configurations
+				 */
+				reg |= OMAP_TLL_CHANNEL_CONF_DRVVBUS
+				 | OMAP_TLL_CHANNEL_CONF_CHRGVBUS
+				 | OMAP_TLL_CHANNEL_CONF_MODE_TRANSPARENT_UTMI
+				 | OMAP_TLL_CHANNEL_CONF_ULPINOBITSTUFF;
 			} else {
 				continue;
 			}
-- 
1.7.4.1

