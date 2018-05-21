From: Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH net-next 4/5] net: ethernet: davinci_emac: Fix printing of base address
Date: Mon, 21 May 2018 11:45:54 -0700
Message-ID: <20180521184555.21555-5-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Keerthy <j-keerthy@ti.com>, Bhumika Goyal <bhumirks@gmail.com>, =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>, Richard Cochran <richardcochran@gmail.com>, Lukas Wunner <lukas@wunner.de>, Rob Herring <robh@kernel.org>, "open list:TI ETHERNET SWITCH DRIVER CPSW" <linux-omap@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

Use %pa which is the correct formatter to print a physical address,
instead of %p which is just a pointer.

Fixes: a6286ee630f6 ("net: Add TI DaVinci EMAC driver")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/ti/davinci_emac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/davinci_emac.c b/drivers/net/ethernet/ti/davinci_emac.c
index abceea802ea1..be0fec17d95d 100644
--- a/drivers/net/ethernet/ti/davinci_emac.c
+++ b/drivers/net/ethernet/ti/davinci_emac.c
@@ -1930,8 +1930,8 @@ static int davinci_emac_probe(struct platform_device *pdev)
 
 	if (netif_msg_probe(priv)) {
 		dev_notice(&pdev->dev, "DaVinci EMAC Probe found device "
-			   "(regs: %p, irq: %d)\n",
-			   (void *)priv->emac_base_phys, ndev->irq);
+			   "(regs: %pa, irq: %d)\n",
+			   &priv->emac_base_phys, ndev->irq);
 	}
 	pm_runtime_put(&pdev->dev);
 
-- 
2.14.1
