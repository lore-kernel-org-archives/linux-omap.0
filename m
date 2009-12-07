From: Cory Maccarrone <darkstar6262@gmail.com>
Subject: [PATCH 3/3] [OMAP] Add OMAP 7xx pin muxes for SPI
Date: Sun,  6 Dec 2009 20:48:19 -0800
Message-ID: <1260161299-17656-4-git-send-email-darkstar6262@gmail.com>
References: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:58904 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934534AbZLGEtm (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Dec 2009 23:49:42 -0500
Received: by mail-pw0-f42.google.com with SMTP id 9so690286pwj.21
        for <linux-omap@vger.kernel.org>; Sun, 06 Dec 2009 20:49:49 -0800 (PST)
In-Reply-To: <1260161299-17656-1-git-send-email-darkstar6262@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net, linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>

This change adds pin mux configuration for SPI100k on
omap7xx platforms.

Signed-off-by: Cory Maccarrone <darkstar6262@gmail.com>
---
 arch/arm/mach-omap1/mux.c             |    8 ++++++++
 arch/arm/plat-omap/include/plat/mux.h |    8 ++++++++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap1/mux.c b/arch/arm/mach-omap1/mux.c
index 07212cc..8434137 100644
--- a/arch/arm/mach-omap1/mux.c
+++ b/arch/arm/mach-omap1/mux.c
@@ -62,6 +62,14 @@ MUX_CFG_7XX("MMC_7XX_DAT0",        2,   17,    0,   16,   1, 0)
 /* I2C interface */
 MUX_CFG_7XX("I2C_7XX_SCL",         5,    1,    0,    0,   1, 0)
 MUX_CFG_7XX("I2C_7XX_SDA",         5,    5,    0,    0,   1, 0)
+
+/* SPI pins */
+MUX_CFG_7XX("SPI_7XX_1",           6,    5,    4,    4,   1, 0)
+MUX_CFG_7XX("SPI_7XX_2",           6,    9,    4,    8,   1, 0)
+MUX_CFG_7XX("SPI_7XX_3",           6,   13,    4,   12,   1, 0)
+MUX_CFG_7XX("SPI_7XX_4",           6,   17,    4,   16,   1, 0)
+MUX_CFG_7XX("SPI_7XX_5",           8,   25,    0,   24,   0, 0)
+MUX_CFG_7XX("SPI_7XX_6",           9,    5,    0,    4,   0, 0)
 };
 #define OMAP7XX_PINS_SZ		ARRAY_SIZE(omap7xx_pins)
 #else
diff --git a/arch/arm/plat-omap/include/plat/mux.h b/arch/arm/plat-omap/include/plat/mux.h
index 8f069cc..692c90e 100644
--- a/arch/arm/plat-omap/include/plat/mux.h
+++ b/arch/arm/plat-omap/include/plat/mux.h
@@ -183,6 +183,14 @@ enum omap7xx_index {
 	/* I2C */
 	I2C_7XX_SCL,
 	I2C_7XX_SDA,
+
+	/* SPI */
+	SPI_7XX_1,
+	SPI_7XX_2,
+	SPI_7XX_3,
+	SPI_7XX_4,
+	SPI_7XX_5,
+	SPI_7XX_6,
 };
 
 enum omap1xxx_index {
-- 
1.6.3.3

