From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] net: ethernet: ti: cpsw-phy-sel: remove unneeded semicolon
Date: Thu, 17 Jan 2019 20:59:19 +0800
Message-ID: <20190117125919.15248-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: davem@davemloft.net, grygorii.strashko@ti.com, tony@atomide.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-omap@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: linux-omap@vger.kernel.org

Remove unneeded semicolon.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/cpsw-phy-sel.c b/drivers/net/ethernet/ti/cpsw-phy-sel.c
index 396e1cd..fec275e 100644
--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -78,7 +78,7 @@ static void cpsw_gmii_sel_am3352(struct cpsw_phy_sel_priv *priv,
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
-	};
+	}
 
 	mask = GMII_SEL_MODE_MASK << (slave * 2) | BIT(slave + 6);
 	mask |= BIT(slave + 4);
@@ -133,7 +133,7 @@ static void cpsw_gmii_sel_dra7xx(struct cpsw_phy_sel_priv *priv,
 	case PHY_INTERFACE_MODE_MII:
 		mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
-	};
+	}
 
 	switch (slave) {
 	case 0:
-- 
2.7.0
