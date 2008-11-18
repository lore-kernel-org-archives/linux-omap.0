From: Jouni Hogander <jouni.hogander@nokia.com>
Subject: [PATCH] OMAP: MCSPI: Enable mcspi wake-up
Date: Tue, 18 Nov 2008 15:00:37 +0200
Message-ID: <1227013237-13650-1-git-send-email-jouni.hogander@nokia.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:64599 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752029AbYKRNBN (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 18 Nov 2008 08:01:13 -0500
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx06.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id mAID0xcV025387
	for <linux-omap@vger.kernel.org>; Tue, 18 Nov 2008 15:01:11 +0200
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

Currently mcspi wake-ups are not enabled. This might cause case where
OMAP is not waking up on mcspi events.

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
---
 drivers/spi/omap2_mcspi.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 454a271..4bd330c 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -59,6 +59,8 @@
 
 /* per-register bitmasks: */
 
+#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(0x2 << 3)
+#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(0x1 << 2)
 #define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
 #define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
 
@@ -90,6 +92,7 @@
 
 #define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
 
+#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
@@ -884,8 +887,12 @@ static int __init omap2_mcspi_reset(struct omap2_mcspi *mcspi)
 	} while (!(tmp & OMAP2_MCSPI_SYSSTATUS_RESETDONE));
 
 	mcspi_write_reg(master, OMAP2_MCSPI_SYSCONFIG,
-			/* (3 << 8) | (2 << 3) | */
-			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE);
+			OMAP2_MCSPI_SYSCONFIG_AUTOIDLE |
+			OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP |
+			OMAP2_MCSPI_SYSCONFIG_SMARTIDLE);
+
+	mcspi_write_reg(master, OMAP2_MCSPI_WAKEUPENABLE,
+			OMAP2_MCSPI_WAKEUPENABLE_WKEN);
 
 	omap2_mcspi_set_master_mode(master);
 
-- 
1.6.0.1

