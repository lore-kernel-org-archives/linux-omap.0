From: Grygorii Strashko <grygorii.strashko@ti.com>
Subject: [PATCH v2 2/2] net: phy: relax error checking when creating sysfs link netdev->phydev
Date: Fri, 16 Mar 2018 17:08:35 -0500
Message-ID: <20180316220835.30006-3-grygorii.strashko@ti.com>
References: <20180316220835.30006-1-grygorii.strashko@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180316220835.30006-1-grygorii.strashko@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sekhar Nori <nsekhar@ti.com>, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>
List-Id: linux-omap@vger.kernel.org

Some ethernet drivers (like TI CPSW) may connect and manage >1 Net PHYs per
one netdevice, as result such drivers will produce warning during system
boot and fail to connect second phy to netdevice when PHYLIB framework
will try to create sysfs link netdev->phydev for second PHY
in phy_attach_direct(), because sysfs link with the same name has been
created already for the first PHY. As result, second CPSW external
port will became unusable.

Fix it by relaxing error checking when PHYLIB framework is creating sysfs
link netdev->phydev in phy_attach_direct(), suppressing warning by using
sysfs_create_link_nowarn() and adding error message instead.
After this change links (phy->netdev and netdev->phy) creation failure is not
fatal any more and system can continue working, which fixes TI CPSW issue.

Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Fixes: a3995460491d ("net: phy: Relax error checking on sysfs_create_link()")
Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
---
 drivers/net/phy/phy_device.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 478405e..fe16f58 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1012,10 +1012,17 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	err = sysfs_create_link(&phydev->mdio.dev.kobj, &dev->dev.kobj,
 				"attached_dev");
 	if (!err) {
-		err = sysfs_create_link(&dev->dev.kobj, &phydev->mdio.dev.kobj,
-					"phydev");
-		if (err)
-			goto error;
+		err = sysfs_create_link_nowarn(&dev->dev.kobj,
+					       &phydev->mdio.dev.kobj,
+					       "phydev");
+		if (err) {
+			dev_err(&dev->dev, "could not add device link to %s err %d\n",
+				kobject_name(&phydev->mdio.dev.kobj),
+				err);
+			/* non-fatal - some net drivers can use one netdevice
+			 * with more then one phy
+			 */
+		}
 
 		phydev->sysfs_links = true;
 	}
-- 
2.10.5
