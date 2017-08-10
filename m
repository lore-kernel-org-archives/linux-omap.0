From: Max Uvarov <muvarov@gmail.com>
Subject: [PATCH 2/2] drivers: net: davinci_mdio: print bus frequency
Date: Thu, 10 Aug 2017 10:42:00 +0300
Message-ID: <1502350920-22750-2-git-send-email-muvarov@gmail.com>
References: <1502350920-22750-1-git-send-email-muvarov@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1502350920-22750-1-git-send-email-muvarov@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, grygorii.strashko@ti.com, Max Uvarov <muvarov@gmail.com>
List-Id: linux-omap@vger.kernel.org

Frequency can be audjusted in DT it make sense to
print current used value on driver init.

Signed-off-by: Max Uvarov <muvarov@gmail.com>
---
 drivers/net/ethernet/ti/davinci_mdio.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_mdio.c b/drivers/net/ethernet/ti/davinci_mdio.c
index 611e7cc..3c33f45 100644
--- a/drivers/net/ethernet/ti/davinci_mdio.c
+++ b/drivers/net/ethernet/ti/davinci_mdio.c
@@ -159,8 +159,10 @@ static int davinci_mdio_reset(struct mii_bus *bus)
 
 	/* dump hardware version info */
 	ver = __raw_readl(&data->regs->version);
-	dev_info(data->dev, "davinci mdio revision %d.%d\n",
-		 (ver >> 8) & 0xff, ver & 0xff);
+	dev_info(data->dev,
+		 "davinci mdio revision %d.%d, bus freq %ld\n",
+		 (ver >> 8) & 0xff, ver & 0xff,
+		 data->pdata.bus_freq);
 
 	if (data->skip_scan)
 		goto done;
-- 
2.5.0
