From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] i2c-omap / PM: Drop CONFIG_PM_RUNTIME from i2c-omap.c
Date: Wed, 03 Dec 2014 02:58:15 +0100
Message-ID: <1764802.h0lkXSoFee@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
selected) PM_RUNTIME is always set if PM is set, so some #ifdef blocks
depending on CONFIG_PM_RUNTIME may be dropped now.

Do that in drivers/i2c/busses/i2c-omap.c.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Note: This depends on commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if
PM_SLEEP is selected) which is only in linux-next at the moment (via the
linux-pm tree).

Please let me know if it is OK to take this one into linux-pm.

---
 drivers/i2c/busses/i2c-omap.c |    2 --
 1 file changed, 2 deletions(-)

Index: linux-pm/drivers/i2c/busses/i2c-omap.c
===================================================================
--- linux-pm.orig/drivers/i2c/busses/i2c-omap.c
+++ linux-pm/drivers/i2c/busses/i2c-omap.c
@@ -1280,7 +1280,6 @@ static int omap_i2c_remove(struct platfo
 }
 
 #ifdef CONFIG_PM
-#ifdef CONFIG_PM_RUNTIME
 static int omap_i2c_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
@@ -1318,7 +1317,6 @@ static int omap_i2c_runtime_resume(struc
 
 	return 0;
 }
-#endif /* CONFIG_PM_RUNTIME */
 
 static struct dev_pm_ops omap_i2c_pm_ops = {
 	SET_RUNTIME_PM_OPS(omap_i2c_runtime_suspend,

