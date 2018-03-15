From: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?=
        <sz.lin@moxa.com>
Subject: [PATCH] net: ethernet: ti: cpsw: add check for in-band mode setting with RGMII PHY interface
Date: Thu, 15 Mar 2018 14:41:43 +0800
Message-ID: <20180315064145.7022-1-sz.lin@moxa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?SZ=20Lin=20=28=E6=9E=97=E4=B8=8A=E6=99=BA=29?= <sz.lin@moxa.com>, Schuyler Patton <spatton@ti.com>, Grygorii Strashko <grygorii.strashko@ti.com>, "David S. Miller" <davem@davemloft.net>, Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>, Keerthy <j-keerthy@ti.com>, Sekhar Nori <nsekhar@ti.com>, linux-omap@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

According to AM335x TRM[1] 14.3.6.2, AM437x TRM[2] 15.3.6.2 and
DRA7 TRM[3] 24.11.4.8.7.3.3, in-band mode in EXT_EN(bit18) register is only
available when PHY is configured in RGMII mode with 10Mbps speed. It will
cause some networking issues without RGMII mode, such as carrier sense
errors and low throughput. TI also mentioned this issue in their forum[4].

This patch adds the check mechanism for PHY interface with RGMII interface
type, the in-band mode can only be set in RGMII mode with 10Mbps speed.

References:
[1]: https://www.ti.com/lit/ug/spruh73p/spruh73p.pdf
[2]: http://www.ti.com/lit/ug/spruhl7h/spruhl7h.pdf
[3]: http://www.ti.com/lit/ug/spruic2b/spruic2b.pdf
[4]: https://e2e.ti.com/support/arm/sitara_arm/f/791/p/640765/2392155

Suggested-by: Holsety Chen (陳憲輝) <Holsety.Chen@moxa.com>
Signed-off-by: SZ Lin (林上智) <sz.lin@moxa.com>
Signed-off-by: Schuyler Patton <spatton@ti.com>
---
 drivers/net/ethernet/ti/cpsw.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/cpsw.c b/drivers/net/ethernet/ti/cpsw.c
index 1b1b78fdc138..3bbf22ed59cf 100644
--- a/drivers/net/ethernet/ti/cpsw.c
+++ b/drivers/net/ethernet/ti/cpsw.c
@@ -1014,7 +1014,13 @@ static void _cpsw_adjust_link(struct cpsw_slave *slave,
 		/* set speed_in input in case RMII mode is used in 100Mbps */
 		if (phy->speed == 100)
 			mac_control |= BIT(15);
-		else if (phy->speed == 10)
+
+		/* in band mode only works in 10Mbps RGMII mode */
+		else if ((phy->speed == 10) &&
+			 ((phy->interface == PHY_INTERFACE_MODE_RGMII) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_ID) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_RXID) ||
+			 (phy->interface == PHY_INTERFACE_MODE_RGMII_TXID)))
 			mac_control |= BIT(18); /* In Band mode */
 
 		if (priv->rx_pause)
-- 
2.16.2
