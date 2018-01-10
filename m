From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v7 3/8] can: m_can: Remove check for version when allocating m_can net device
Date: Wed, 10 Jan 2018 16:25:20 +0530
Message-ID: <1515581725-29242-4-git-send-email-faiz_abbas@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
Sender: netdev-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

Currently the m_can version is used to set the tx_fifo_count to 1 when
allocating the net device. However, this is redundant as a value of 1
for the tx_fifo_count needs to be provided in the bosch,mram-cfg
property of the device tree node anyway.

Therefore, remove check for version when allocating the net device.

Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index f72116e..893edbb 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1213,7 +1213,6 @@ static struct net_device *alloc_m_can_dev(struct platform_device *pdev,
 	struct net_device *dev;
 	struct m_can_priv *priv;
 	int m_can_version;
-	unsigned int echo_buffer_count;
 
 	m_can_version = m_can_check_core_release(addr);
 	/* return if unsupported version */
@@ -1222,12 +1221,7 @@ static struct net_device *alloc_m_can_dev(struct platform_device *pdev,
 		goto return_dev;
 	}
 
-	/* If version < 3.1.x, then only one echo buffer is used */
-	echo_buffer_count = ((m_can_version == 30)
-				? 1U
-				: (unsigned int)tx_fifo_size);
-
-	dev = alloc_candev(sizeof(*priv), echo_buffer_count);
+	dev = alloc_candev(sizeof(*priv), tx_fifo_size);
 	if (!dev) {
 		dev = NULL;
 		goto return_dev;
-- 
2.7.4
