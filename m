From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 03/11] mfd: twl-core: No need to check for invalid subchip ID
Date: Wed, 16 Jan 2013 14:53:51 +0100
Message-ID: <1358344439-23017-4-git-send-email-peter.ujfalusi@ti.com>
References: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1358344439-23017-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The module id table no longer can have invalid/unused entries.
No need for checking the ID for validity.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 drivers/mfd/twl-core.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/drivers/mfd/twl-core.c b/drivers/mfd/twl-core.c
index b781cdd..fa1a5a0 100644
--- a/drivers/mfd/twl-core.c
+++ b/drivers/mfd/twl-core.c
@@ -72,7 +72,6 @@
 #define SUB_CHIP_ID1 1
 #define SUB_CHIP_ID2 2
 #define SUB_CHIP_ID3 3
-#define SUB_CHIP_ID_INVAL 0xff
 
 /* Base Address defns for twl4030_map[] */
 
@@ -326,12 +325,8 @@ int twl_i2c_write(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
+
 	sid = twl_map[mod_no].sid;
-	if (unlikely(sid == SUB_CHIP_ID_INVAL)) {
-		pr_err("%s: module %d is not part of the pmic\n",
-		       DRIVER_NAME, mod_no);
-		return -EINVAL;
-	}
 	twl = &twl_modules[sid];
 
 	ret = regmap_bulk_write(twl->regmap, twl_map[mod_no].base + reg,
@@ -368,12 +363,8 @@ int twl_i2c_read(u8 mod_no, u8 *value, u8 reg, unsigned num_bytes)
 		pr_err("%s: not initialized\n", DRIVER_NAME);
 		return -EPERM;
 	}
+
 	sid = twl_map[mod_no].sid;
-	if (unlikely(sid == SUB_CHIP_ID_INVAL)) {
-		pr_err("%s: module %d is not part of the pmic\n",
-		       DRIVER_NAME, mod_no);
-		return -EINVAL;
-	}
 	twl = &twl_modules[sid];
 
 	ret = regmap_bulk_read(twl->regmap, twl_map[mod_no].base + reg,
-- 
1.8.1
