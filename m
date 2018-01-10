From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v7 4/8] can: m_can: Move allocation of net device to probe
Date: Wed, 10 Jan 2018 16:25:21 +0530
Message-ID: <1515581725-29242-5-git-send-email-faiz_abbas@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

With the version no longer required to allocate the net device, it can
be moved to probe and the alloc_m_can_dev() function can be simplified.

Therefore, move the allocation of net device to probe and change
alloc_m_can_dev() to setup_m_can_dev().

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 893edbb..07ebe7f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1207,25 +1207,20 @@ static bool m_can_niso_supported(const struct m_can_priv *priv)
 	return !niso_timeout;
 }
 
-static struct net_device *alloc_m_can_dev(struct platform_device *pdev,
-					  void __iomem *addr, u32 tx_fifo_size)
+static int setup_m_can_dev(struct platform_device *pdev, struct net_device *dev,
+			   void __iomem *addr)
 {
-	struct net_device *dev;
 	struct m_can_priv *priv;
 	int m_can_version;
 
 	m_can_version = m_can_check_core_release(addr);
 	/* return if unsupported version */
 	if (!m_can_version) {
-		dev = NULL;
-		goto return_dev;
+		dev_err(&pdev->dev, "Unsupported version number: %2d",
+			m_can_version);
+		return -EINVAL;
 	}
 
-	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
-	if (!dev) {
-		dev = NULL;
-		goto return_dev;
-	}
 	priv = netdev_priv(dev);
 	netif_napi_add(dev, &priv->napi, m_can_poll, M_CAN_NAPI_WEIGHT);
 
@@ -1271,12 +1266,10 @@ static struct net_device *alloc_m_can_dev(struct platform_device *pdev,
 		free_m_can_dev(dev);
 		dev_err(&pdev->dev, "Unsupported version number: %2d",
 			priv->version);
-		dev = NULL;
-		break;
+		return -EINVAL;
 	}
 
-return_dev:
-	return dev;
+	return 0;
 }
 
 static int m_can_open(struct net_device *dev)
@@ -1616,11 +1609,16 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	tx_fifo_size = mram_config_vals[7];
 
 	/* allocate the m_can device */
-	dev = alloc_m_can_dev(pdev, addr, tx_fifo_size);
+	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
 	if (!dev) {
 		ret = -ENOMEM;
 		goto disable_cclk_ret;
 	}
+
+	ret = setup_m_can_dev(pdev, dev, addr);
+	if (ret)
+		goto disable_cclk_ret;
+
 	priv = netdev_priv(dev);
 	dev->irq = irq;
 	priv->device = &pdev->dev;
-- 
2.7.4
