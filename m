From: "G, Manjunath Kondaiah" <manjugk@ti.com>
Subject: [PATCH v3] TWL IRQ: Fix fucntion declaration warnings
Date: Wed,  6 Oct 2010 03:26:59 +0530
Message-ID: <1286315819-5906-4-git-send-email-manjugk@ti.com>
References: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:58302 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757227Ab0JEV4k (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 5 Oct 2010 17:56:40 -0400
In-Reply-To: <1286315819-5906-1-git-send-email-manjugk@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Samuel Ortiz <sameo@linux.intel.com>, Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>

Fixes following sparse warnings for twl4030 and twl6030 irq files.

drivers/mfd/twl4030-irq.c:783:5: warning: symbol 'twl4030_init_irq' was not declared. Should it be static?
drivers/mfd/twl4030-irq.c:863:5: warning: symbol 'twl4030_exit_irq' was not declared. Should it be static?
drivers/mfd/twl4030-irq.c:873:5: warning: symbol 'twl4030_init_chip_irq' was not declared. Should it be static?

drivers/mfd/twl6030-irq.c:226:5: warning: symbol 'twl6030_init_irq' was not declared. Should it be static?
drivers/mfd/twl6030-irq.c:290:5: warning: symbol 'twl6030_exit_irq' was not declared. Should it be static?

Signed-off-by: G, Manjunath Kondaiah <manjugk@ti.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: Samuel Ortiz <sameo@linux.intel.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Nishanth Menon <nm@ti.com>
---
Changes from v2 to v3:
 - Created twl-core.h in drivers/mfd and seperated the patch from sparse fixes
   based on tony's suggestion.

Changes since v1 to v2:
 - no logical change for this patch but sparse fixes series got updated with
   review comments.

 drivers/mfd/twl-core.h    |   10 ++++++++++
 drivers/mfd/twl4030-irq.c |    1 +
 drivers/mfd/twl6030-irq.c |    2 ++
 3 files changed, 13 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mfd/twl-core.h

diff --git a/drivers/mfd/twl-core.h b/drivers/mfd/twl-core.h
new file mode 100644
index 0000000..8c50a55
--- /dev/null
+++ b/drivers/mfd/twl-core.h
@@ -0,0 +1,10 @@
+#ifndef __TWL_CORE_H__
+#define __TWL_CORE_H__
+
+extern int twl6030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+extern int twl6030_exit_irq(void);
+extern int twl4030_init_irq(int irq_num, unsigned irq_base, unsigned irq_end);
+extern int twl4030_exit_irq(void);
+extern int twl4030_init_chip_irq(const char *chip);
+
+#endif /*  __TWL_CORE_H__ */
diff --git a/drivers/mfd/twl4030-irq.c b/drivers/mfd/twl4030-irq.c
index 097f24d..2563750 100644
--- a/drivers/mfd/twl4030-irq.c
+++ b/drivers/mfd/twl4030-irq.c
@@ -35,6 +35,7 @@
 
 #include <linux/i2c/twl.h>
 
+#include "twl-core.h"
 
 /*
  * TWL4030 IRQ handling has two stages in hardware, and thus in software.
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 10bf228..8876b97 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -37,6 +37,8 @@
 #include <linux/kthread.h>
 #include <linux/i2c/twl.h>
 
+#include "twl-core.h"
+
 /*
  * TWL6030 (unlike its predecessors, which had two level interrupt handling)
  * three interrupt registers INT_STS_A, INT_STS_B and INT_STS_C.
-- 
1.7.0.4

