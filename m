From: Amit Kucheria <amit.kucheria@verdurent.com>
Subject: [PATCH 1/5] mfd: twl4030-power: Rename DEVGROUP to DEV_GRP
Date: Mon, 19 Oct 2009 15:10:44 +0300
Message-ID: <1255954244-28873-1-git-send-email-amit.kucheria@verdurent.com>
References: <1255954211-28496-1-git-send-email-amit.kucheria@verdurent.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755493AbZJSMKv@vger.kernel.org>
In-Reply-To: <1255954211-28496-1-git-send-email-amit.kucheria@verdurent.com>
Sender: linux-kernel-owner@vger.kernel.org
To: List Linux Kernel <linux-kernel@vger.kernel.org>
Cc: sameo@linux.intel.com, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Stick to the names used in the reference manual

Signed-off-by: Amit Kucheria <amit.kucheria@verdurent.com>
Cc: sameo@linux.intel.com
Cc: linux-omap@vger.kernel.org
---
 drivers/mfd/twl4030-power.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index d423e0c..82e3bcb 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -69,12 +69,12 @@ static u8 twl4030_start_script_address = 0x2b;
 
 /* resource configuration registers */
 
-#define DEVGROUP_OFFSET		0
+#define DEV_GRP_OFFSET		0
 #define TYPE_OFFSET		1
 
-/* Bit positions */
-#define DEVGROUP_SHIFT		5
-#define DEVGROUP_MASK		(7 << DEVGROUP_SHIFT)
+/* Bit positions in the registers */
+#define DEV_GRP_SHIFT		5
+#define DEV_GRP_MASK		(7 << DEV_GRP_SHIFT)
 #define TYPE_SHIFT		0
 #define TYPE_MASK		(7 << TYPE_SHIFT)
 #define TYPE2_SHIFT		3
@@ -328,7 +328,7 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 
 	/* Set resource group */
 	err = twl4030_i2c_read_u8(TWL4030_MODULE_PM_RECEIVER, &grp,
-				rconfig_addr + DEVGROUP_OFFSET);
+				rconfig_addr + DEV_GRP_OFFSET);
 	if (err) {
 		pr_err("TWL4030 Resource %d group could not be read\n",
 			rconfig->resource);
@@ -336,10 +336,10 @@ static int __init twl4030_configure_resource(struct twl4030_resconfig *rconfig)
 	}
 
 	if (rconfig->devgroup >= 0) {
-		grp &= ~DEVGROUP_MASK;
-		grp |= rconfig->devgroup << DEVGROUP_SHIFT;
+		grp &= ~DEV_GRP_MASK;
+		grp |= rconfig->devgroup << DEV_GRP_SHIFT;
 		err = twl4030_i2c_write_u8(TWL4030_MODULE_PM_RECEIVER,
-					grp, rconfig_addr + DEVGROUP_OFFSET);
+					grp, rconfig_addr + DEV_GRP_OFFSET);
 		if (err < 0) {
 			pr_err("TWL4030 failed to program devgroup\n");
 			return err;
-- 
1.6.3.3
