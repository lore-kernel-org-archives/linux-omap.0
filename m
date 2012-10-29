From: Vaibhav Hiremath <hvaibhav@ti.com>
Subject: [PATCH 1/4] net: davinci_mdio: Fix typo mistake in calling runtime-pm api
Date: Mon, 29 Oct 2012 13:51:18 +0530
Message-ID: <1351498881-32482-3-git-send-email-hvaibhav@ti.com>
References: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1351498881-32482-1-git-send-email-hvaibhav@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: paul@pwsan.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, Vaibhav Hiremath <hvaibhav@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>, Richard Cochran <richardcochran@gmail.com>
List-Id: linux-omap@vger.kernel.org

By mistake (most likely a copy-paste), instead of pm_runtime_get_sync()
api, driver is calling pm_runtime_put_sync() api in resume callback
function. The bug was introduced by commit id (ae2c07aaf74:
davinci_mdio: runtime PM support).

Now, the reason why it didn't impact functionality is, the patch has
been tested on AM335x-EVM and BeagleBone platform while submitting;
and in case of AM335x the MDIO driver doesn't control the module
enable/disable part, which is handled by CPSW driver.

Signed-off-by: Vaibhav Hiremath <hvaibhav@ti.com>
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Richard Cochran <richardcochran@gmail.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 51a96db..ae74280 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -465,7 +465,7 @@ static int davinci_mdio_resume(struct device *dev)
 	u32 ctrl;
 
 	spin_lock(&data->lock);
-	pm_runtime_put_sync(data->dev);
+	pm_runtime_get_sync(data->dev);
 
 	/* restart the scan state machine */
 	ctrl = __raw_readl(&data->regs->control);
-- 
1.7.0.4
