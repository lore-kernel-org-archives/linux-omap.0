From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next v2 1/2] of: mdio: Fall back to mdiobus_register() with NULL device_node
Date: Tue, 15 May 2018 16:56:18 -0700
Message-ID: <20180515235619.27773-2-f.fainelli@gmail.com>
References: <20180515235619.27773-1-f.fainelli@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180515235619.27773-1-f.fainelli@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Vivien Didelot <vivien.didelot@savoirfairelinux.com>, "David S. Miller" <davem@davemloft.net>, Nicolas Ferre <nicolas.ferre@microchip.com>, Fugang Duan <fugang.duan@nxp.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, Giuseppe Cavallaro <peppe.cavallaro@st.com>, Alexandre Torgue <alexandre.torgue@st.com>, Jose Abreu <joabreu@synopsys.com>, Grygorii Strashko <grygorii.strashko@ti.com>, Woojung Huh <woojung.huh@microchip.com>, Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Antoine Tenart <antoine.tenart@free-electrons.com>, Tobias Jordan <Tobias.Jordan@elektrobit.com>Russell King <r>
List-Id: linux-omap@vger.kernel.org

When the device_node specified is NULL, fall back to mdiobus_register().
We have a number of drivers having a similar pattern which is:

if (np)
	of_mdiobus_register()
else
	mdiobus_register()

so incorporate that behavior within the core of_mdiobus_register()
function. This is also consistent with the stub version that we defined
when CONFIG_OF=n.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/of/of_mdio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/of/of_mdio.c b/drivers/of/of_mdio.c
index 8c0c92712fc9..d963baf8e53a 100644
--- a/drivers/of/of_mdio.c
+++ b/drivers/of/of_mdio.c
@@ -204,6 +204,9 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 	bool scanphys = false;
 	int addr, rc;
 
+	if (!np)
+		return mdiobus_register(mdio);
+
 	/* Do not continue if the node is disabled */
 	if (!of_device_is_available(np))
 		return -ENODEV;
-- 
2.14.1
