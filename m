From: <sshahrom@micron.com>
Subject: [PATCH 3/4] [MTD] NAND : Resubmitting support for 2K page nand
Date: Wed, 19 Sep 2007 14:27:45 -0700
Message-ID: <809D758398CC1F49AA8E493528AD4A27014DF6D2@ntxsjombx02.micron.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org


Hi,
Continuing with rest of patch series on linux.omap.com

Signed-off-by: Shahrom Sharif-Kashani <sshahrom <at> micron.com>


:000000 100644 0000000... 2a8edcf... A	include/asm-arm/arch-omap/nand.h

diff --git a/include/asm-arm/arch-omap/nand.h =
b/include/asm-arm/arch-omap/nand.h
new file mode 100644
index 0000000..2a8edcf
--- /dev/null
+++ b/include/asm-arm/arch-omap/nand.h
@@ -0,0 +1,89 @@
+/*
+ * include/asm-arm/arch-omap/nand.h
+ *
+ * Copyright (C) 2006 Micron Technology Inc.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/mtd/partitions.h>
+
+struct omap_nand_platform_data {
+	int			cs;
+	int			gpio_irq;
+	struct mtd_partition	*parts;
+	int			nr_parts;
+	int                     (*nand_setup)(void __iomem *);
+	int			dma_channel;
+	void __iomem            *gpmc_cs_baseaddr;
+	void __iomem            *gpmc_baseaddr;
+};
+
+#define NAND_Ecc_P1e		(1 << 0)
+#define NAND_Ecc_P2e		(1 << 1)
+#define NAND_Ecc_P4e		(1 << 2)
+#define NAND_Ecc_P8e		(1 << 3)
+#define NAND_Ecc_P16e		(1 << 4)
+#define NAND_Ecc_P32e		(1 << 5)
+#define NAND_Ecc_P64e		(1 << 6)
+#define NAND_Ecc_P128e		(1 << 7)
+#define NAND_Ecc_P256e		(1 << 8)
+#define NAND_Ecc_P512e		(1 << 9)
+#define NAND_Ecc_P1024e		(1 << 10)
+#define NAND_Ecc_P2048e		(1 << 11)
+
+#define NAND_Ecc_P1o		(1 << 16)
+#define NAND_Ecc_P2o		(1 << 17)
+#define NAND_Ecc_P4o		(1 << 18)
+#define NAND_Ecc_P8o		(1 << 19)
+#define NAND_Ecc_P16o		(1 << 20)
+#define NAND_Ecc_P32o		(1 << 21)
+#define NAND_Ecc_P64o		(1 << 22)
+#define NAND_Ecc_P128o		(1 << 23)
+#define NAND_Ecc_P256o		(1 << 24)
+#define NAND_Ecc_P512o		(1 << 25)
+#define NAND_Ecc_P1024o		(1 << 26)
+#define NAND_Ecc_P2048o		(1 << 27)
+
+#define TF(value)	(value ? 1 : 0)
+
+#define P2048e(a)	(TF(a & NAND_Ecc_P2048e)	<< 0)
+#define P2048o(a)	(TF(a & NAND_Ecc_P2048o)	<< 1)
+#define P1e(a)		(TF(a & NAND_Ecc_P1e)		<< 2)
+#define P1o(a)		(TF(a & NAND_Ecc_P1o)		<< 3)
+#define P2e(a)		(TF(a & NAND_Ecc_P2e)		<< 4)
+#define P2o(a)		(TF(a & NAND_Ecc_P2o)		<< 5)
+#define P4e(a)		(TF(a & NAND_Ecc_P4e)		<< 6)
+#define P4o(a)		(TF(a & NAND_Ecc_P4o)		<< 7)
+
+#define P8e(a)		(TF(a & NAND_Ecc_P8e)		<< 0)
+#define P8o(a)		(TF(a & NAND_Ecc_P8o)		<< 1)
+#define P16e(a)		(TF(a & NAND_Ecc_P16e)		<< 2)
+#define P16o(a)		(TF(a & NAND_Ecc_P16o)		<< 3)
+#define P32e(a)		(TF(a & NAND_Ecc_P32e)		<< 4)
+#define P32o(a)		(TF(a & NAND_Ecc_P32o)		<< 5)
+#define P64e(a)		(TF(a & NAND_Ecc_P64e)		<< 6)
+#define P64o(a)		(TF(a & NAND_Ecc_P64o)		<< 7)
+
+#define P128e(a)	(TF(a & NAND_Ecc_P128e)		<< 0)
+#define P128o(a)	(TF(a & NAND_Ecc_P128o)		<< 1)
+#define P256e(a)	(TF(a & NAND_Ecc_P256e)		<< 2)
+#define P256o(a)	(TF(a & NAND_Ecc_P256o)		<< 3)
+#define P512e(a)	(TF(a & NAND_Ecc_P512e)		<< 4)
+#define P512o(a)	(TF(a & NAND_Ecc_P512o)		<< 5)
+#define P1024e(a)	(TF(a & NAND_Ecc_P1024e)	<< 6)
+#define P1024o(a)	(TF(a & NAND_Ecc_P1024o)	<< 7)
+
+#define P8e_s(a)	(TF(a & NAND_Ecc_P8e)		<< 0)
+#define P8o_s(a)	(TF(a & NAND_Ecc_P8o)		<< 1)
+#define P16e_s(a)	(TF(a & NAND_Ecc_P16e)		<< 2)
+#define P16o_s(a)	(TF(a & NAND_Ecc_P16o)		<< 3)
+#define P1e_s(a)	(TF(a & NAND_Ecc_P1e)		<< 4)
+#define P1o_s(a)	(TF(a & NAND_Ecc_P1o)		<< 5)
+#define P2e_s(a)	(TF(a & NAND_Ecc_P2e)		<< 6)
+#define P2o_s(a)	(TF(a & NAND_Ecc_P2o)		<< 7)
+
+#define P4e_s(a)	(TF(a & NAND_Ecc_P4e)		<< 0)
+#define P4o_s(a)	(TF(a & NAND_Ecc_P4o)		<< 1)

Signed-off-by: Shahrom Sharif-Kashani < sshahrom@micron.com>
