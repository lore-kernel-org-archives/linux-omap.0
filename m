From: "Hemanth V" <hemanthv@ti.com>
Subject: PATCH[V2 1/3]: Update Platform files for SPI
Date: Wed, 3 Feb 2010 15:51:45 +0530 (IST)
Message-ID: <9629.10.24.255.17.1265192505.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:39021 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab0BCKVy (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 3 Feb 2010 05:21:54 -0500
References: 
In-Reply-To: 
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Cc: linux-omap@vger.kernel.org, dbrownell@users.sourceforge.net, grant.likely@secretlab.ca

>From ee48142ddc43129a21676dbb56a83e3e7d8063de Mon Sep 17 00:00:00 2001
From: Hemanth V <hemanthv@ti.com>
Date: Fri, 27 Nov 2009 14:22:30 +0530
Subject: [PATCH] Update platform files

This patch updates platform files for
fifo, slave support

Signed-off-by: Hemanth V <hemanthv@ti.com>
---
 arch/arm/mach-omap2/devices.c           |    5 +++++
 arch/arm/plat-omap/include/plat/mcspi.h |   29 ++++++++++++++++++++++++++++- 2
files changed, 33 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/devices.c b/arch/arm/mach-omap2/devices.c
index 733d3dc..79b5396 100644
--- a/arch/arm/mach-omap2/devices.c
+++ b/arch/arm/mach-omap2/devices.c
@@ -282,6 +282,7 @@ static inline void omap_init_sti(void) {}

 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
+	.force_cs_mode	= 1,
 };

 static struct resource omap2_mcspi1_resources[] = {
@@ -304,6 +305,10 @@ static struct platform_device omap2_mcspi1 = {

 static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
 	.num_cs		= 2,
+	.mode		= OMAP2_MCSPI_MASTER,
+	.dma_mode	= 0,
+	.force_cs_mode	= 0,
+	.fifo_depth	= 0,
 };

 static struct resource omap2_mcspi2_resources[] = {
diff --git a/arch/arm/plat-omap/include/plat/mcspi.h
b/arch/arm/plat-omap/include/plat/mcspi.h
index 1254e49..ffda0a1 100644
--- a/arch/arm/plat-omap/include/plat/mcspi.h
+++ b/arch/arm/plat-omap/include/plat/mcspi.h
@@ -1,8 +1,35 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H

+#define OMAP2_MCSPI_MASTER		0
+#define OMAP2_MCSPI_SLAVE		1
+
+/**
+ * struct omap2_mcspi_platform_config - McSPI controller configuration + *
@num_cs: Number of chip selects or channels supported
+ * @mode: SPI is master or slave
+ * @dma_mode: Use only DMA for data transfers
+ * @force_cs_mode: Use force chip select mode or auto chip select mode + *
@fifo_depth: FIFO depth in bytes, max value 64
+ *
+ * @dma_mode when set to 1 uses only dma for data transfers
+ * else the default behaviour is to use PIO mode for transfer
+ * size of 8 bytes or less. This mode is useful when mcspi
+ * is configured as slave
+ *
+ * @force_cs_mode when set to 1 allows continuous transfer of multiple + * spi
words without toggling the chip select line.
+ *
+ * @fifo_depth when set to non zero values enables FIFO. fifo_depth + * should
be set as a multiple of buffer size used for read/write. + */
+
 struct omap2_mcspi_platform_config {
-	unsigned short	num_cs;
+	u8	num_cs;
+	u8	mode;
+	u8	dma_mode;
+	u8	force_cs_mode;
+	unsigned short fifo_depth;
 };

 struct omap2_mcspi_device_config {
-- 
1.5.6.3





