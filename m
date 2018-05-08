From: Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH net-next] drivers: net: davinci_mdio: prevent sprious timeout
Date: Tue, 8 May 2018 13:56:38 +0530
Message-ID: <20180508082638.5707-1-nsekhar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: "David S . Miller" <davem@davemloft.net>, linux-omap@vger.kernel.org, netdev@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

A well timed kernel preemption in the time_after() loop
in wait_for_idle() can result in a spurious timeout
error to be returned.

Fix it by checking for status of hardware before returning
timeout error.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
The issue has not been personally observed by me, but has
been reported by users. Sending for next-next given the
non-critical nature. There is seems to be no easy way to
reproduce this.

 drivers/net/ethernet/ti/davinci_mdio.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 3c33f4504d8e..4fbd04fd38cf 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -231,10 +231,16 @@ static inline int wait_for_idle(struct davinci_mdio_data *data)
 
 	while (time_after(timeout, jiffies)) {
 		if (__raw_readl(&regs->control) & CONTROL_IDLE)
-			return 0;
+			goto out;
 	}
-	dev_err(data->dev, "timed out waiting for idle\n");
-	return -ETIMEDOUT;
+
+	if (!(__raw_readl(&regs->control) & CONTROL_IDLE)) {
+		dev_err(data->dev, "timed out waiting for idle\n");
+		return -ETIMEDOUT;
+	}
+
+out:
+	return 0;
 }
 
 static int davinci_mdio_read(struct mii_bus *bus, int phy_id, int phy_reg)
-- 
2.16.2
