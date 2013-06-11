From: Florian Vaussard <florian.vaussard@epfl.ch>
Subject: [PATCH 1/3] ARM: dts: Add headers with constants for MTD partitions
Date: Tue, 11 Jun 2013 16:48:56 +0200
Message-ID: <1370962138-9631-2-git-send-email-florian.vaussard@epfl.ch>
References: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp4.epfl.ch ([128.178.224.219]:42743 "HELO smtp4.epfl.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752000Ab3FKOtM (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 11 Jun 2013 10:49:12 -0400
In-Reply-To: <1370962138-9631-1-git-send-email-florian.vaussard@epfl.ch>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Benoit Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Anil Kumar <anilk4.v@gmail.com>, linux-omap@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, Florian Vaussard <florian.vaussard@epfl.ch>

These constants can be used to easily declare MTD partitions inside
DTS.

The constants MTDPART_OFS_* are purposely not included. Indeed,
parse_ofpart_partitions() is expecting u64, but a DT cell is u32.
Negative constants, as defined by MTDPART_OFS_*, would be wrongly
interpreted by parse_ofpart_partitions(). Two cells should be
used to correctly encode the negative constants, but this breaks
current usage.

Signed-off-by: Florian Vaussard <florian.vaussard@epfl.ch>
---
 include/dt-bindings/mtd/partitions.h |   12 ++++++++
 include/dt-bindings/sizes.h          |   52 ++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+), 0 deletions(-)
 create mode 100644 include/dt-bindings/mtd/partitions.h
 create mode 100644 include/dt-bindings/sizes.h

diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/mtd/partitions.h
new file mode 100644
index 0000000..7dfa676
--- /dev/null
+++ b/include/dt-bindings/mtd/partitions.h
@@ -0,0 +1,12 @@
+/*
+ * This header provides constants used with MTD partitions.
+ */
+
+#ifndef _DT_BINDINGS_MTD_PARTITIONS_H
+#define _DT_BINDINGS_MTD_PARTITIONS_H
+
+/* Partition size */
+#define MTDPART_SIZ_FULL	0
+
+#endif
+
diff --git a/include/dt-bindings/sizes.h b/include/dt-bindings/sizes.h
new file mode 100644
index 0000000..995f2de
--- /dev/null
+++ b/include/dt-bindings/sizes.h
@@ -0,0 +1,52 @@
+/*
+ * This header provides size constants.
+ *
+ * Original version:
+ *   include/linux/sizes.h
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _DT_BINDINGS_SIZES_H
+#define _DT_BINDINGS_SIZES_H
+
+#define SZ_1				0x00000001
+#define SZ_2				0x00000002
+#define SZ_4				0x00000004
+#define SZ_8				0x00000008
+#define SZ_16				0x00000010
+#define SZ_32				0x00000020
+#define SZ_64				0x00000040
+#define SZ_128				0x00000080
+#define SZ_256				0x00000100
+#define SZ_512				0x00000200
+
+#define SZ_1K				0x00000400
+#define SZ_2K				0x00000800
+#define SZ_4K				0x00001000
+#define SZ_8K				0x00002000
+#define SZ_16K				0x00004000
+#define SZ_32K				0x00008000
+#define SZ_64K				0x00010000
+#define SZ_128K				0x00020000
+#define SZ_256K				0x00040000
+#define SZ_512K				0x00080000
+
+#define SZ_1M				0x00100000
+#define SZ_2M				0x00200000
+#define SZ_4M				0x00400000
+#define SZ_8M				0x00800000
+#define SZ_16M				0x01000000
+#define SZ_32M				0x02000000
+#define SZ_64M				0x04000000
+#define SZ_128M				0x08000000
+#define SZ_256M				0x10000000
+#define SZ_512M				0x20000000
+
+#define SZ_1G				0x40000000
+#define SZ_2G				0x80000000
+
+#endif
+
-- 
1.7.5.4

