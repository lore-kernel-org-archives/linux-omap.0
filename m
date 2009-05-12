From: "Syed Rafiuddin" <rafiuddin.syed@ti.com>
Subject: [PATCH] I2C:Moving Register Defines to Header File
Date: Tue, 12 May 2009 18:39:45 +0530 (IST)
Message-ID: <52671.192.168.10.89.1242133785.squirrel@dbdmail.itg.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49760 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750712AbZELNJu (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 May 2009 09:09:50 -0400
Received: from dlep36.itg.ti.com ([157.170.170.91])
	by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id n4CD9kj4015183
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 08:09:51 -0500
Received: from webmail.ti.com (localhost [127.0.0.1])
	by dlep36.itg.ti.com (8.13.8/8.13.8) with ESMTP id n4CD9iE0021976
	for <linux-omap@vger.kernel.org>; Tue, 12 May 2009 08:09:45 -0500 (CDT)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org

This patch creates i2c-omap.h header and moves register and bit definition
macros to it from i2c-omap.c

Signed-off-by: Syed Rafiuddin <rafiuddin.syed@ti.com>
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 drivers/i2c/busses/i2c-omap.c |  120 ----------------------------------
 drivers/i2c/busses/i2c-omap.h |  145 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 146 insertions(+), 119 deletions(-)

Index: linux-2.6/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-2.6.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-2.6/drivers/i2c/busses/i2c-omap.c
@@ -37,125 +37,7 @@
 #include <linux/platform_device.h>
 #include <linux/clk.h>
 #include <linux/io.h>
-
-/* I2C controller revisions */
-#define OMAP_I2C_REV_2			0x20
-
-/* I2C controller revisions present on specific hardware */
-#define OMAP_I2C_REV_ON_2430		0x36
-#define OMAP_I2C_REV_ON_3430		0x3C
-
-/* timeout waiting for the controller to respond */
-#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
-
-#define OMAP_I2C_REV_REG		0x00
-#define OMAP_I2C_IE_REG			0x04
-#define OMAP_I2C_STAT_REG		0x08
-#define OMAP_I2C_IV_REG			0x0c
-/* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
-#define OMAP_I2C_WE_REG			0x0c
-#define OMAP_I2C_SYSS_REG		0x10
-#define OMAP_I2C_BUF_REG		0x14
-#define OMAP_I2C_CNT_REG		0x18
-#define OMAP_I2C_DATA_REG		0x1c
-#define OMAP_I2C_SYSC_REG		0x20
-#define OMAP_I2C_CON_REG		0x24
-#define OMAP_I2C_OA_REG			0x28
-#define OMAP_I2C_SA_REG			0x2c
-#define OMAP_I2C_PSC_REG		0x30
-#define OMAP_I2C_SCLL_REG		0x34
-#define OMAP_I2C_SCLH_REG		0x38
-#define OMAP_I2C_SYSTEST_REG		0x3c
-#define OMAP_I2C_BUFSTAT_REG		0x40
-
-/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
-#define OMAP_I2C_IE_XDR		(1 << 14)	/* TX Buffer drain int enable */
-#define OMAP_I2C_IE_RDR		(1 << 13)	/* RX Buffer drain int enable */
-#define OMAP_I2C_IE_XRDY	(1 << 4)	/* TX data ready int enable */
-#define OMAP_I2C_IE_RRDY	(1 << 3)	/* RX data ready int enable */
-#define OMAP_I2C_IE_ARDY	(1 << 2)	/* Access ready int enable */
-#define OMAP_I2C_IE_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_IE_AL		(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C Status Register (OMAP_I2C_STAT): */
-#define OMAP_I2C_STAT_XDR	(1 << 14)	/* TX Buffer draining */
-#define OMAP_I2C_STAT_RDR	(1 << 13)	/* RX Buffer draining */
-#define OMAP_I2C_STAT_BB	(1 << 12)	/* Bus busy */
-#define OMAP_I2C_STAT_ROVR	(1 << 11)	/* Receive overrun */
-#define OMAP_I2C_STAT_XUDF	(1 << 10)	/* Transmit underflow */
-#define OMAP_I2C_STAT_AAS	(1 << 9)	/* Address as slave */
-#define OMAP_I2C_STAT_AD0	(1 << 8)	/* Address zero */
-#define OMAP_I2C_STAT_XRDY	(1 << 4)	/* Transmit data ready */
-#define OMAP_I2C_STAT_RRDY	(1 << 3)	/* Receive data ready */
-#define OMAP_I2C_STAT_ARDY	(1 << 2)	/* Register access ready */
-#define OMAP_I2C_STAT_NACK	(1 << 1)	/* No ack interrupt enable */
-#define OMAP_I2C_STAT_AL	(1 << 0)	/* Arbitration lost int ena */
-
-/* I2C WE wakeup enable register */
-#define OMAP_I2C_WE_XDR_WE	(1 << 14)	/* TX drain wakup */
-#define OMAP_I2C_WE_RDR_WE	(1 << 13)	/* RX drain wakeup */
-#define OMAP_I2C_WE_AAS_WE	(1 << 9)	/* Address as slave wakeup*/
-#define OMAP_I2C_WE_BF_WE	(1 << 8)	/* Bus free wakeup */
-#define OMAP_I2C_WE_STC_WE	(1 << 6)	/* Start condition wakeup */
-#define OMAP_I2C_WE_GC_WE	(1 << 5)	/* General call wakeup */
-#define OMAP_I2C_WE_DRDY_WE	(1 << 3)	/* TX/RX data ready wakeup */
-#define OMAP_I2C_WE_ARDY_WE	(1 << 2)	/* Reg access ready wakeup */
-#define OMAP_I2C_WE_NACK_WE	(1 << 1)	/* No acknowledgment wakeup */
-#define OMAP_I2C_WE_AL_WE	(1 << 0)	/* Arbitration lost wakeup */
-
-#define OMAP_I2C_WE_ALL		(OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
-				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
-				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
-				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
-				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
-
-/* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
-#define OMAP_I2C_BUF_RDMA_EN	(1 << 15)	/* RX DMA channel enable */
-#define OMAP_I2C_BUF_RXFIF_CLR	(1 << 14)	/* RX FIFO Clear */
-#define OMAP_I2C_BUF_XDMA_EN	(1 << 7)	/* TX DMA channel enable */
-#define OMAP_I2C_BUF_TXFIF_CLR	(1 << 6)	/* TX FIFO Clear */
-
-/* I2C Configuration Register (OMAP_I2C_CON): */
-#define OMAP_I2C_CON_EN		(1 << 15)	/* I2C module enable */
-#define OMAP_I2C_CON_BE		(1 << 14)	/* Big endian mode */
-#define OMAP_I2C_CON_OPMODE_HS	(1 << 12)	/* High Speed support */
-#define OMAP_I2C_CON_STB	(1 << 11)	/* Start byte mode (master) */
-#define OMAP_I2C_CON_MST	(1 << 10)	/* Master/slave mode */
-#define OMAP_I2C_CON_TRX	(1 << 9)	/* TX/RX mode (master only) */
-#define OMAP_I2C_CON_XA		(1 << 8)	/* Expand address */
-#define OMAP_I2C_CON_RM		(1 << 2)	/* Repeat mode (master only) */
-#define OMAP_I2C_CON_STP	(1 << 1)	/* Stop cond (master only) */
-#define OMAP_I2C_CON_STT	(1 << 0)	/* Start condition (master) */
-
-/* I2C SCL time value when Master */
-#define OMAP_I2C_SCLL_HSSCLL	8
-#define OMAP_I2C_SCLH_HSSCLH	8
-
-/* I2C System Test Register (OMAP_I2C_SYSTEST): */
-#ifdef DEBUG
-#define OMAP_I2C_SYSTEST_ST_EN		(1 << 15)	/* System test enable */
-#define OMAP_I2C_SYSTEST_FREE		(1 << 14)	/* Free running mode */
-#define OMAP_I2C_SYSTEST_TMODE_MASK	(3 << 12)	/* Test mode select */
-#define OMAP_I2C_SYSTEST_TMODE_SHIFT	(12)		/* Test mode select */
-#define OMAP_I2C_SYSTEST_SCL_I		(1 << 3)	/* SCL line sense in */
-#define OMAP_I2C_SYSTEST_SCL_O		(1 << 2)	/* SCL line drive out */
-#define OMAP_I2C_SYSTEST_SDA_I		(1 << 1)	/* SDA line sense in */
-#define OMAP_I2C_SYSTEST_SDA_O		(1 << 0)	/* SDA line drive out */
-#endif
-
-/* OCP_SYSSTATUS bit definitions */
-#define SYSS_RESETDONE_MASK		(1 << 0)
-
-/* OCP_SYSCONFIG bit definitions */
-#define SYSC_CLOCKACTIVITY_MASK		(0x3 << 8)
-#define SYSC_SIDLEMODE_MASK		(0x3 << 3)
-#define SYSC_ENAWAKEUP_MASK		(1 << 2)
-#define SYSC_SOFTRESET_MASK		(1 << 1)
-#define SYSC_AUTOIDLE_MASK		(1 << 0)
-
-#define SYSC_IDLEMODE_SMART		0x2
-#define SYSC_CLOCKACTIVITY_FCLK		0x2
-
+#include "i2c-omap.h"

 struct omap_i2c_dev {
 	struct device		*dev;
Index: linux-2.6/drivers/i2c/busses/i2c-omap.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/drivers/i2c/busses/i2c-omap.h	2009-05-12 18:01:21.000000000 +0530
@@ -0,0 +1,145 @@
+/*
+ * drivers/i2c/busses/i2c-omap.h
+ *
+ * Defines for I2C
+ *
+ * Copyright (C) 2009 Texas Instruments.
+ * Author: Syed Rafiuddin
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ *
+ */
+#ifndef __ASM_ARCH_I2C_OMAP_H
+#define __ASM_ARCH_I2C_OMAP_H
+
+/* I2C controller revisions */
+#define OMAP_I2C_REV_2                  0x20
+
+/* I2C controller revisions present on specific hardware */
+#define OMAP_I2C_REV_ON_2430            0x36
+#define OMAP_I2C_REV_ON_3430            0x3C
+
+/* timeout waiting for the controller to respond */
+#define OMAP_I2C_TIMEOUT (msecs_to_jiffies(1000))
+
+#define OMAP_I2C_REV_REG                0x00
+#define OMAP_I2C_IE_REG                 0x04
+#define OMAP_I2C_STAT_REG               0x08
+#define OMAP_I2C_IV_REG                 0x0c
+/* For OMAP3 I2C_IV has changed to I2C_WE (wakeup enable) */
+#define OMAP_I2C_WE_REG                 0x0c
+#define OMAP_I2C_SYSS_REG               0x10
+#define OMAP_I2C_BUF_REG                0x14
+#define OMAP_I2C_CNT_REG                0x18
+#define OMAP_I2C_DATA_REG               0x1c
+#define OMAP_I2C_SYSC_REG               0x20
+#define OMAP_I2C_CON_REG                0x24
+#define OMAP_I2C_OA_REG                 0x28
+#define OMAP_I2C_SA_REG                 0x2c
+#define OMAP_I2C_PSC_REG                0x30
+#define OMAP_I2C_SCLL_REG               0x34
+#define OMAP_I2C_SCLH_REG               0x38
+#define OMAP_I2C_SYSTEST_REG            0x3c
+#define OMAP_I2C_BUFSTAT_REG            0x40
+
+/* I2C Interrupt Enable Register (OMAP_I2C_IE): */
+#define OMAP_I2C_IE_XDR         (1 << 14)       /* TX Buffer drain int enable */
+#define OMAP_I2C_IE_RDR         (1 << 13)       /* RX Buffer drain int enable */
+#define OMAP_I2C_IE_XRDY        (1 << 4)        /* TX data ready int enable */
+#define OMAP_I2C_IE_RRDY        (1 << 3)        /* RX data ready int enable */
+#define OMAP_I2C_IE_ARDY        (1 << 2)        /* Access ready int enable */
+#define OMAP_I2C_IE_NACK        (1 << 1)        /* No ack interrupt enable */
+#define OMAP_I2C_IE_AL          (1 << 0)        /* Arbitration lost int ena */
+
+/* I2C Status Register (OMAP_I2C_STAT): */
+#define OMAP_I2C_STAT_XDR       (1 << 14)       /* TX Buffer draining */
+#define OMAP_I2C_STAT_RDR       (1 << 13)       /* RX Buffer draining */
+#define OMAP_I2C_STAT_BB        (1 << 12)       /* Bus busy */
+#define OMAP_I2C_STAT_ROVR      (1 << 11)       /* Receive overrun */
+#define OMAP_I2C_STAT_XUDF      (1 << 10)       /* Transmit underflow */
+#define OMAP_I2C_STAT_AAS       (1 << 9)        /* Address as slave */
+#define OMAP_I2C_STAT_AD0       (1 << 8)        /* Address zero */
+#define OMAP_I2C_STAT_XRDY      (1 << 4)        /* Transmit data ready */
+#define OMAP_I2C_STAT_RRDY      (1 << 3)        /* Receive data ready */
+#define OMAP_I2C_STAT_ARDY      (1 << 2)        /* Register access ready */
+#define OMAP_I2C_STAT_NACK      (1 << 1)        /* No ack interrupt enable */
+#define OMAP_I2C_STAT_AL        (1 << 0)        /* Arbitration lost int ena */
+
+/* I2C WE wakeup enable register */
+#define OMAP_I2C_WE_XDR_WE      (1 << 14)       /* TX drain wakup */
+#define OMAP_I2C_WE_RDR_WE      (1 << 13)       /* RX drain wakeup */
+#define OMAP_I2C_WE_AAS_WE      (1 << 9)        /* Address as slave wakeup*/
+#define OMAP_I2C_WE_BF_WE       (1 << 8)        /* Bus free wakeup */
+#define OMAP_I2C_WE_STC_WE      (1 << 6)        /* Start condition wakeup */
+#define OMAP_I2C_WE_GC_WE       (1 << 5)        /* General call wakeup */
+#define OMAP_I2C_WE_DRDY_WE     (1 << 3)        /* TX/RX data ready wakeup */
+#define OMAP_I2C_WE_ARDY_WE     (1 << 2)        /* Reg access ready wakeup */
+#define OMAP_I2C_WE_NACK_WE     (1 << 1)        /* No acknowledgment wakeup */
+#define OMAP_I2C_WE_AL_WE       (1 << 0)        /* Arbitration lost wakeup */
+
+#define OMAP_I2C_WE_ALL         (OMAP_I2C_WE_XDR_WE | OMAP_I2C_WE_RDR_WE | \
+				OMAP_I2C_WE_AAS_WE | OMAP_I2C_WE_BF_WE | \
+				OMAP_I2C_WE_STC_WE | OMAP_I2C_WE_GC_WE | \
+				OMAP_I2C_WE_DRDY_WE | OMAP_I2C_WE_ARDY_WE | \
+				OMAP_I2C_WE_NACK_WE | OMAP_I2C_WE_AL_WE)
+
+/* I2C Buffer Configuration Register (OMAP_I2C_BUF): */
+#define OMAP_I2C_BUF_RDMA_EN    (1 << 15)       /* RX DMA channel enable */
+#define OMAP_I2C_BUF_RXFIF_CLR  (1 << 14)       /* RX FIFO Clear */
+#define OMAP_I2C_BUF_XDMA_EN    (1 << 7)        /* TX DMA channel enable */
+#define OMAP_I2C_BUF_TXFIF_CLR  (1 << 6)        /* TX FIFO Clear */
+
+/* I2C Configuration Register (OMAP_I2C_CON): */
+#define OMAP_I2C_CON_EN         (1 << 15)       /* I2C module enable */
+#define OMAP_I2C_CON_BE         (1 << 14)       /* Big endian mode */
+#define OMAP_I2C_CON_OPMODE_HS  (1 << 12)       /* High Speed support */
+#define OMAP_I2C_CON_STB        (1 << 11)       /* Start byte mode (master) */
+#define OMAP_I2C_CON_MST        (1 << 10)       /* Master/slave mode */
+#define OMAP_I2C_CON_TRX        (1 << 9)        /* TX/RX mode (master only) */
+#define OMAP_I2C_CON_XA         (1 << 8)        /* Expand address */
+#define OMAP_I2C_CON_RM         (1 << 2)        /* Repeat mode (master only) */
+#define OMAP_I2C_CON_STP        (1 << 1)        /* Stop cond (master only) */
+#define OMAP_I2C_CON_STT        (1 << 0)        /* Start condition (master) */
+
+/* I2C SCL time value when Master */
+#define OMAP_I2C_SCLL_HSSCLL    8
+#define OMAP_I2C_SCLH_HSSCLH    8
+
+/* I2C System Test Register (OMAP_I2C_SYSTEST): */
+#ifdef DEBUG
+#define OMAP_I2C_SYSTEST_ST_EN          (1 << 15)       /* System test enable */
+#define OMAP_I2C_SYSTEST_FREE           (1 << 14)       /* Free running mode */
+#define OMAP_I2C_SYSTEST_TMODE_MASK     (3 << 12)       /* Test mode select */
+#define OMAP_I2C_SYSTEST_TMODE_SHIFT    (12)            /* Test mode select */
+#define OMAP_I2C_SYSTEST_SCL_I          (1 << 3)        /* SCL line sense in */
+#define OMAP_I2C_SYSTEST_SCL_O          (1 << 2)        /* SCL line drive out */
+#define OMAP_I2C_SYSTEST_SDA_I          (1 << 1)        /* SDA line sense in */
+#define OMAP_I2C_SYSTEST_SDA_O          (1 << 0)        /* SDA line drive out */
+#endif
+
+/* OCP_SYSSTATUS bit definitions */
+#define SYSS_RESETDONE_MASK             (1 << 0)
+
+/* OCP_SYSCONFIG bit definitions */
+#define SYSC_CLOCKACTIVITY_MASK         (0x3 << 8)
+#define SYSC_SIDLEMODE_MASK             (0x3 << 3)
+#define SYSC_ENAWAKEUP_MASK             (1 << 2)
+#define SYSC_SOFTRESET_MASK             (1 << 1)
+#define SYSC_AUTOIDLE_MASK              (1 << 0)
+
+#define SYSC_IDLEMODE_SMART             0x2
+#define SYSC_CLOCKACTIVITY_FCLK         0x2
+
+#endif


