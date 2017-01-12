From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/3] misc: sram: Split sram data structures into local header
Date: Thu, 12 Jan 2017 14:52:18 -0600
Message-ID: <20170112205220.26325-2-d-gerlach@ti.com>
References: <20170112205220.26325-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170112205220.26325-1-d-gerlach@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>, Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>, Dave Gerlach <d-gerlach@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

In preparation of a coming file split of the sram driver, move the
common data structures into a local header file that can be shared
between files related to the sram driver.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 drivers/misc/sram.c | 30 ++----------------------------
 drivers/misc/sram.h | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 28 deletions(-)
 create mode 100644 drivers/misc/sram.h

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index b33ab8ce47ab..4ef5affd03d7 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -31,35 +31,9 @@
 #include <linux/mfd/syscon.h>
 #include <soc/at91/atmel-secumod.h>
 
-#define SRAM_GRANULARITY	32
-
-struct sram_partition {
-	void __iomem *base;
-
-	struct gen_pool *pool;
-	struct bin_attribute battr;
-	struct mutex lock;
-};
-
-struct sram_dev {
-	struct device *dev;
-	void __iomem *virt_base;
-
-	struct gen_pool *pool;
-	struct clk *clk;
+#include "sram.h"
 
-	struct sram_partition *partition;
-	u32 partitions;
-};
-
-struct sram_reserve {
-	struct list_head list;
-	u32 start;
-	u32 size;
-	bool export;
-	bool pool;
-	const char *label;
-};
+#define SRAM_GRANULARITY	32
 
 static ssize_t sram_read(struct file *filp, struct kobject *kobj,
 			 struct bin_attribute *attr,
diff --git a/drivers/misc/sram.h b/drivers/misc/sram.h
new file mode 100644
index 000000000000..52501a84468c
--- /dev/null
+++ b/drivers/misc/sram.h
@@ -0,0 +1,39 @@
+/*
+ * Defines for the SRAM driver
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __SRAM_H
+#define __SRAM_H
+
+struct sram_partition {
+	void __iomem *base;
+
+	struct gen_pool *pool;
+	struct bin_attribute battr;
+	struct mutex lock;
+	struct list_head list;
+};
+
+struct sram_dev {
+	struct device *dev;
+	void __iomem *virt_base;
+
+	struct gen_pool *pool;
+	struct clk *clk;
+
+	struct sram_partition *partition;
+	u32 partitions;
+};
+
+struct sram_reserve {
+	struct list_head list;
+	u32 start;
+	u32 size;
+	bool export;
+	bool pool;
+	const char *label;
+};
+#endif /* __SRAM_H */
-- 
2.11.0
