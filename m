From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 3/6] memory: omap-gpmc: make it explicitly non-modular
Date: Thu, 16 Jun 2016 20:37:45 -0400
Message-ID: <20160617003748.12188-4-paul.gortmaker@windriver.com>
References: <20160617003748.12188-1-paul.gortmaker@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160617003748.12188-1-paul.gortmaker@windriver.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Roger Quadros <rogerq@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

The Kconfig currently controlling compilation of this code is:

drivers/memory/Kconfig:config OMAP_GPMC
drivers/memory/Kconfig:  bool

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init was not in use by this code, the init ordering
remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We don't replace module.h with init.h since the file already has that.

Cc: Roger Quadros <rogerq@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/memory/omap-gpmc.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index af4884ba6b7c..827832ac0b8c 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -20,7 +20,6 @@
 #include <linux/ioport.h>
 #include <linux/spinlock.h>
 #include <linux/io.h>
-#include <linux/module.h>
 #include <linux/gpio/driver.h>
 #include <linux/interrupt.h>
 #include <linux/irqdomain.h>
@@ -1807,7 +1806,6 @@ static const struct of_device_id gpmc_dt_ids[] = {
 	{ .compatible = "ti,am3352-gpmc" },	/* am335x devices */
 	{ }
 };
-MODULE_DEVICE_TABLE(of, gpmc_dt_ids);
 
 /**
  * gpmc_read_settings_dt - read gpmc settings from device-tree
@@ -2437,15 +2435,7 @@ static __init int gpmc_init(void)
 {
 	return platform_driver_register(&gpmc_driver);
 }
-
-static __exit void gpmc_exit(void)
-{
-	platform_driver_unregister(&gpmc_driver);
-
-}
-
 postcore_initcall(gpmc_init);
-module_exit(gpmc_exit);
 
 static struct omap3_gpmc_regs gpmc_context;
 
-- 
2.8.4
