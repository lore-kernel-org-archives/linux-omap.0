From: "Madhusudhan Chikkature" <madhu.cr@ti.com>
Subject: [PATCH 1/3] HSMMC driver fix for core ret
Date: Fri, 25 Jul 2008 16:02:19 +0530 (IST)
Message-ID: <39478.192.168.10.88.1216981939.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:40482 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752730AbYGYKc3 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 25 Jul 2008 06:32:29 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: linux-omap@vger.kernel.org

From: Madhusudhan Chikkature<madhu.cr@ti.com>

ARM: OMAP3: HSMMC fix for core ret.

The core ret seem to be prevented by HSMMC CTO errors. This patch provides a
fix for the same.

Signed-off-by: Madhusudhan Chikkature<madhu.cr@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

Index: linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c
===================================================================
--- linux-omap-ti.git-07142008.orig/drivers/mmc/host/omap_hsmmc.c	2008-07-10
14:59:37.000000000 +0530
+++ linux-omap-ti.git-07142008/drivers/mmc/host/omap_hsmmc.c	2008-07-17
15:08:29.000000000 +0530
@@ -84,6 +84,7 @@
 #define STAT_CLEAR		0xFFFFFFFF
 #define INIT_STREAM_CMD		0x00000000
 #define DUAL_VOLT_OCR_BIT	7
+#define SRC			(1 << 25)

 #define OMAP_MMC1_DEVID		1
 #define OMAP_MMC2_DEVID		2
@@ -315,10 +316,16 @@ static irqreturn_t mmc_omap_irq(int irq,
 		if ((status & CMD_TIMEOUT) ||
 			(status & CMD_CRC)) {
 			if (host->cmd) {
-				if (status & CMD_TIMEOUT)
+				if (status & CMD_TIMEOUT) {
+					OMAP_HSMMC_WRITE(host->base, SYSCTL,
+						OMAP_HSMMC_READ(host->base,
+								SYSCTL) | SRC);
+					while (OMAP_HSMMC_READ(host->base,
+								SYSCTL) & SRC) ;
 					host->cmd->error = -ETIMEDOUT;
-				else
+				} else {
 					host->cmd->error = -EILSEQ;
+				}
 				end_cmd = 1;
 			}
 			if (host->data)


