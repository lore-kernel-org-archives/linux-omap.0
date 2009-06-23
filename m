From: "Hemanth V" <hemanthv@ti.com>
Subject: [RESEND][PATCH 1/2] McSPI Slave and DMA,FIFO support
Date: Tue, 23 Jun 2009 19:24:00 +0530 (IST)
Message-ID: <42142.10.24.255.18.1245765240.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33780 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752314AbZFWN7H (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 23 Jun 2009 09:59:07 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: spi-devel-general@lists.sourceforge.net, dbrownell@users.sourceforge.net

This patch adds support for McSPI slave and FIFO. DMA and FIFO
could be enabled together for better throughput. Platform config
parameters have been added to enable these features on any particular
McSPI controller.

FIFO can be enabled by defining fifo_depth parameter. fifo_depth needs
to be a multiple of buffer size that is used for read/write.

These features are useful when you have high throughput devices
like WLAN or Modem connected over SPI.

Signed-off-by: Hemanth V <hemanthv@ti.com>
 arch/arm/mach-omap2/devices.c           |    5 +++++
 arch/arm/plat-omap/include/mach/mcspi.h |   16 ++++++++++++++++
 2 files changed, 21 insertions(+)

---
Index: linux-omap-2.6/arch/arm/mach-omap2/devices.c
===================================================================
--- linux-omap-2.6.orig/arch/arm/mach-omap2/devices.c	2009-06-18
15:22:39.000000000 +0530
+++ linux-omap-2.6/arch/arm/mach-omap2/devices.c	2009-06-23 16:45:51.000000000
+0530
@@ -259,6 +259,7 @@

 static struct omap2_mcspi_platform_config omap2_mcspi1_config = {
 	.num_cs		= 4,
+	.force_cs_mode	= 1,
 };

 static struct resource omap2_mcspi1_resources[] = {
@@ -281,6 +282,10 @@

 static struct omap2_mcspi_platform_config omap2_mcspi2_config = {
 	.num_cs		= 2,
+	.mode		= OMAP2_MCSPI_MASTER,
+	.dma_mode	= 1,
+	.force_cs_mode	= 0,
+	.fifo_depth	= 0,
 };

 static struct resource omap2_mcspi2_resources[] = {
Index: linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h
===================================================================
--- linux-omap-2.6.orig/arch/arm/plat-omap/include/mach/mcspi.h	2009-06-18
15:22:39.000000000 +0530
+++ linux-omap-2.6/arch/arm/plat-omap/include/mach/mcspi.h	2009-06-23
16:45:51.000000000 +0530
@@ -1,8 +1,24 @@
 #ifndef _OMAP2_MCSPI_H
 #define _OMAP2_MCSPI_H

+#define OMAP2_MCSPI_MASTER		0
+#define OMAP2_MCSPI_SLAVE		1
+
 struct omap2_mcspi_platform_config {
 	unsigned short	num_cs;
+
+	/* SPI is master or slave */
+	unsigned short	mode;
+
+	/* Use only DMA for data transfers */
+	unsigned short	dma_mode;
+
+	/* Force chip select mode */
+	unsigned short	force_cs_mode;
+
+	/* FIFO depth in bytes, max value 64 */
+	unsigned short fifo_depth;
+
 };

 struct omap2_mcspi_device_config {


