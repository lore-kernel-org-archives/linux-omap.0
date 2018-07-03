From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v2] can: m_can: Move accessing of message ram to after clocks are enabled
Date: Tue, 3 Jul 2018 16:47:10 +0530
Message-ID: <20180703111710.27084-1-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-can@vger.kernel.org, linux-omap@vger.kernel.org
Cc: wg@grandegger.com, mkl@pengutronix.de, davem@davemloft.net, faiz_abbas@ti.com
List-Id: linux-omap@vger.kernel.org

MCAN message ram should only be accessed once clocks are enabled.
Therefore, move the call to parse/init the message ram to after
clocks are enabled.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
Changes in v2:

rebased to latest mainline

 drivers/net/can/m_can/m_can.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index ac4c6dc2f8c8..04c48371ab2a 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1644,8 +1644,6 @@ static int m_can_plat_probe(struct platform_device *pdev)
 	priv->can.clock.freq = clk_get_rate(cclk);
 	priv->mram_base = mram_addr;
 
-	m_can_of_parse_mram(priv, mram_config_vals);
-
 	platform_set_drvdata(pdev, dev);
 	SET_NETDEV_DEV(dev, &pdev->dev);
 
@@ -1668,6 +1666,8 @@ static int m_can_plat_probe(struct platform_device *pdev)
 		goto clk_disable;
 	}
 
+	m_can_of_parse_mram(priv, mram_config_vals);
+
 	devm_can_led_init(dev);
 
 	of_can_transceiver(dev);
@@ -1715,8 +1715,6 @@ static __maybe_unused int m_can_resume(struct device *dev)
 
 	pinctrl_pm_select_default_state(dev);
 
-	m_can_init_ram(priv);
-
 	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 
 	if (netif_running(ndev)) {
@@ -1726,6 +1724,7 @@ static __maybe_unused int m_can_resume(struct device *dev)
 		if (ret)
 			return ret;
 
+		m_can_init_ram(priv);
 		m_can_start(ndev);
 		netif_device_attach(ndev);
 		netif_start_queue(ndev);
-- 
2.17.0
