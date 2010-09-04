From: Vishwanath BS <vishwanath.bs@ti.com>
Subject: [PATCH V2] I2C: Fix for suspend/resume issue in i2c-core
Date: Sat,  4 Sep 2010 14:18:01 +0530
Message-ID: <1283590081-14593-1-git-send-email-vishwanath.bs@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:41802 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750746Ab0IDIuV (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Sat, 4 Sep 2010 04:50:21 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: linux-omap@vger.kernel.org, Vishwanath BS <vishwanath.bs@ti.com>, Partha Basak <p-basak2@ti.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@deeprootsystems.com>, Ben Dooks <ben-linux@fluff.org>, Jean Delvare <khali@linux-fr.org>

In current i2c core driver, call to pm_runtime_set_active from i2c_device_pm_resume
will unconditionally enable i2c module and increment child count of the parent.
Because of this, in CPU Idle path, i2c does not idle, preventing Core to
enter retention. Also i2c module will not be suspended upon system suspend as
pm_runtime_set_suspended is not called from i2c_device_pm_suspend.
This issue is fixed by  removing  pm_runtime_set_active call from resume path which
is not necessary.
This fix has been tested on OMAP4430.

Signed-off-by: Partha Basak <p-basak2@ti.com>
Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

Cc: Rafael J. Wysocki <rjw@sisk.pl>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Jean Delvare <khali@linux-fr.org>
---
 drivers/i2c/i2c-core.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)
 mode change 100644 => 100755 drivers/i2c/i2c-core.c

diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
old mode 100644
new mode 100755
index 6649176..13927d5
--- a/drivers/i2c/i2c-core.c
+++ b/drivers/i2c/i2c-core.c
@@ -216,12 +216,6 @@ static int i2c_device_pm_resume(struct device *dev)
 	else
 		ret = i2c_legacy_resume(dev);
 
-	if (!ret) {
-		pm_runtime_disable(dev);
-		pm_runtime_set_active(dev);
-		pm_runtime_enable(dev);
-	}
-
 	return ret;
 }
 
-- 
1.7.0.4

