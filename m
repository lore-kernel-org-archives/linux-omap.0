From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 2/4] OMAP: McSPI: Convert bit shifted values into BIT format
Date: Thu, 25 Jun 2009 14:34:04 -0700
Message-ID: <1245965646-20070-3-git-send-email-khilman@deeprootsystems.com>
References: <1245965646-20070-1-git-send-email-khilman@deeprootsystems.com>
 <1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ew0-f210.google.com ([209.85.219.210]:58244 "EHLO
	mail-ew0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbZFYVeR (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 25 Jun 2009 17:34:17 -0400
Received: by mail-ew0-f210.google.com with SMTP id 6so2748369ewy.37
        for <linux-omap@vger.kernel.org>; Thu, 25 Jun 2009 14:34:20 -0700 (PDT)
In-Reply-To: <1245965646-20070-2-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Jouni Hogander <jouni.hogander@nokia.com>, Tony Lindgren <tony@atomide.com>

From: Jouni Hogander <jouni.hogander@nokia.com>

Convert bit shifted values into BIT format

Signed-off-by: Jouni Hogander <jouni.hogander@nokia.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/spi/omap2_mcspi.c |   50 ++++++++++++++++++++++----------------------
 1 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
index 2b64091..0016078 100644
--- a/drivers/spi/omap2_mcspi.c
+++ b/drivers/spi/omap2_mcspi.c
@@ -59,40 +59,40 @@
 
 /* per-register bitmasks: */
 
-#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	(2 << 3)
-#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	(1 << 2)
-#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	(1 << 0)
-#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	(1 << 1)
+#define OMAP2_MCSPI_SYSCONFIG_SMARTIDLE	BIT(4)
+#define OMAP2_MCSPI_SYSCONFIG_ENAWAKEUP	BIT(2)
+#define OMAP2_MCSPI_SYSCONFIG_AUTOIDLE	BIT(0)
+#define OMAP2_MCSPI_SYSCONFIG_SOFTRESET	BIT(1)
 
-#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	(1 << 0)
+#define OMAP2_MCSPI_SYSSTATUS_RESETDONE	BIT(0)
 
-#define OMAP2_MCSPI_MODULCTRL_SINGLE	(1 << 0)
-#define OMAP2_MCSPI_MODULCTRL_MS	(1 << 2)
-#define OMAP2_MCSPI_MODULCTRL_STEST	(1 << 3)
+#define OMAP2_MCSPI_MODULCTRL_SINGLE	BIT(0)
+#define OMAP2_MCSPI_MODULCTRL_MS	BIT(2)
+#define OMAP2_MCSPI_MODULCTRL_STEST	BIT(3)
 
-#define OMAP2_MCSPI_CHCONF_PHA		(1 << 0)
-#define OMAP2_MCSPI_CHCONF_POL		(1 << 1)
+#define OMAP2_MCSPI_CHCONF_PHA		BIT(0)
+#define OMAP2_MCSPI_CHCONF_POL		BIT(1)
 #define OMAP2_MCSPI_CHCONF_CLKD_MASK	(0x0f << 2)
-#define OMAP2_MCSPI_CHCONF_EPOL		(1 << 6)
+#define OMAP2_MCSPI_CHCONF_EPOL		BIT(6)
 #define OMAP2_MCSPI_CHCONF_WL_MASK	(0x1f << 7)
-#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	(0x01 << 12)
-#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	(0x02 << 12)
+#define OMAP2_MCSPI_CHCONF_TRM_RX_ONLY	BIT(12)
+#define OMAP2_MCSPI_CHCONF_TRM_TX_ONLY	BIT(13)
 #define OMAP2_MCSPI_CHCONF_TRM_MASK	(0x03 << 12)
-#define OMAP2_MCSPI_CHCONF_DMAW		(1 << 14)
-#define OMAP2_MCSPI_CHCONF_DMAR		(1 << 15)
-#define OMAP2_MCSPI_CHCONF_DPE0		(1 << 16)
-#define OMAP2_MCSPI_CHCONF_DPE1		(1 << 17)
-#define OMAP2_MCSPI_CHCONF_IS		(1 << 18)
-#define OMAP2_MCSPI_CHCONF_TURBO	(1 << 19)
-#define OMAP2_MCSPI_CHCONF_FORCE	(1 << 20)
+#define OMAP2_MCSPI_CHCONF_DMAW		BIT(14)
+#define OMAP2_MCSPI_CHCONF_DMAR		BIT(15)
+#define OMAP2_MCSPI_CHCONF_DPE0		BIT(16)
+#define OMAP2_MCSPI_CHCONF_DPE1		BIT(17)
+#define OMAP2_MCSPI_CHCONF_IS		BIT(18)
+#define OMAP2_MCSPI_CHCONF_TURBO	BIT(19)
+#define OMAP2_MCSPI_CHCONF_FORCE	BIT(20)
 
-#define OMAP2_MCSPI_CHSTAT_RXS		(1 << 0)
-#define OMAP2_MCSPI_CHSTAT_TXS		(1 << 1)
-#define OMAP2_MCSPI_CHSTAT_EOT		(1 << 2)
+#define OMAP2_MCSPI_CHSTAT_RXS		BIT(0)
+#define OMAP2_MCSPI_CHSTAT_TXS		BIT(1)
+#define OMAP2_MCSPI_CHSTAT_EOT		BIT(2)
 
-#define OMAP2_MCSPI_CHCTRL_EN		(1 << 0)
+#define OMAP2_MCSPI_CHCTRL_EN		BIT(0)
 
-#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	(1 << 0)
+#define OMAP2_MCSPI_WAKEUPENABLE_WKEN	BIT(0)
 
 /* We have 2 DMA channels per CS, one for RX and one for TX */
 struct omap2_mcspi_dma {
-- 
1.6.3.2

