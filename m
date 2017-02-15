From: Ben Hutchings <ben@decadent.org.uk>
Subject: [PATCH 3.16 214/306] net: ethernet: ti: cpsw: fix device and
 of_node leaks
Date: Wed, 15 Feb 2017 22:41:40 +0000
Message-ID: <lsq.1487198500.9710842@decadent.org.uk>
References: <lsq.1487198498.99718322@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <lsq.1487198498.99718322@decadent.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: akpm@linux-foundation.org, Johan Hovold <johan@kernel.org>, "David S. Miller" <davem@davemloft.net>, Mugunthan V N <mugunthanvnm@ti.com>, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

3.16.40-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Hovold <johan@kernel.org>

commit c7262aaace1b17a650598063e3b9ee1785fde377 upstream.

Make sure to drop the references taken by of_get_child_by_name() and
bus_find_device() before returning from cpsw_phy_sel().

Note that holding a reference to the cpsw-phy-sel device does not
prevent the devres-managed private data from going away.

Fixes: 5892cd135e16 ("drivers: net: cpsw-phy-sel: Add new driver...")
Cc: Mugunthan V N <mugunthanvnm@ti.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/ti/cpsw-phy-sel.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/net/ethernet/ti/cpsw-phy-sel.c
+++ b/drivers/net/ethernet/ti/cpsw-phy-sel.c
@@ -152,9 +152,12 @@ void cpsw_phy_sel(struct device *dev, ph
 	}
 
 	dev = bus_find_device(&platform_bus_type, NULL, node, match);
+	of_node_put(node);
 	priv = dev_get_drvdata(dev);
 
 	priv->cpsw_phy_sel(priv, phy_mode, slave);
+
+	put_device(dev);
 }
 EXPORT_SYMBOL_GPL(cpsw_phy_sel);
 
