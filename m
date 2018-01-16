From: Faiz Abbas <faiz_abbas@ti.com>
Subject: [PATCH v8 5/5] can: m_can: Support higher speed CAN-FD bitrates
Date: Tue, 16 Jan 2018 17:07:14 +0530
Message-ID: <1516102634-6771-6-git-send-email-faiz_abbas@ti.com>
References: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516102634-6771-1-git-send-email-faiz_abbas@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, faiz_abbas@ti.com, nsekhar@ti.com, fcooper@ti.com, robh@kernel.org, Wenyou.Yang@microchip.com, sergei.shtylyov@cogentembedded.com, linux-omap@vger.kernel.org, b29396@freescale.com
List-Id: linux-omap@vger.kernel.org

From: Franklin S Cooper Jr <fcooper@ti.com>

During test transmitting using CAN-FD at high bitrates (> 2 Mbps)
would fail. Scoping the signals I noticed that only a single bit
was being transmitted and with a bit more investigation realized the
actual MCAN IP would go back to initialization mode automatically.

It appears this issue is due to the MCAN needing to use the Transmitter
Delay Compensation Mode with the correct value for the transmitter delay
compensation offset (tdco). What impacts the tdco value isn't 100% clear
but to calculate it you use an equation defined in the MCAN User's Guide.

The user guide mentions that this register needs to be set based on clock
values, secondary sample point and the data bitrate. One of the key
variables that can't automatically be determined is the secondary
sample point (ssp). This ssp is similar to the sp but is specific to this
transmitter delay compensation mode. The guidelines for configuring
ssp is rather vague but via some CAN test it appears for DRA76x that
putting the value same as data sampling point works.

The CAN-CIA's "Bit Time Requirements for CAN FD" paper presented at
the International CAN Conference 2013 indicates that this TDC mode is
only needed for data bit rates above 2.5 Mbps. Therefore, only enable
this mode when the data bit rate is above 2.5 Mbps.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
---
 drivers/net/can/m_can/m_can.c | 46 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 43 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 95c5594..93bf0c6 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -127,6 +127,12 @@ enum m_can_mram_cfg {
 #define DBTP_DSJW_SHIFT		0
 #define DBTP_DSJW_MASK		(0xf << DBTP_DSJW_SHIFT)
 
+/* Transmitter Delay Compensation Register (TDCR) */
+#define TDCR_TDCO_SHIFT		8
+#define TDCR_TDCO_MASK		(0x7F << TDCR_TDCO_SHIFT)
+#define TDCR_TDCF_SHIFT		0
+#define TDCR_TDCF_MASK		(0x7F << TDCR_TDCF_SHIFT)
+
 /* Test Register (TEST) */
 #define TEST_LBCK		BIT(4)
 
@@ -983,13 +989,47 @@ static int m_can_set_bittiming(struct net_device *dev)
 	m_can_write(priv, M_CAN_NBTP, reg_btp);
 
 	if (priv->can.ctrlmode & CAN_CTRLMODE_FD) {
+		reg_btp = 0;
 		brp = dbt->brp - 1;
 		sjw = dbt->sjw - 1;
 		tseg1 = dbt->prop_seg + dbt->phase_seg1 - 1;
 		tseg2 = dbt->phase_seg2 - 1;
-		reg_btp = (brp << DBTP_DBRP_SHIFT) | (sjw << DBTP_DSJW_SHIFT) |
-			(tseg1 << DBTP_DTSEG1_SHIFT) |
-			(tseg2 << DBTP_DTSEG2_SHIFT);
+
+		/* TDC is only needed for bitrates beyond 2.5 MBit/s.
+		 * This is mentioned in the "Bit Time Requirements for CAN FD"
+		 * paper presented at the International CAN Conference 2013
+		 */
+		if (dbt->bitrate > 2500000) {
+			u32 tdco, ssp;
+
+			/* Use the same value of secondary sampling point
+			 * as the data sampling point
+			 */
+			ssp = dbt->sample_point;
+
+			/* Equation based on Bosch's M_CAN User Manual's
+			 * Transmitter Delay Compensation Section
+			 */
+			tdco = (priv->can.clock.freq / 1000) *
+			       ssp / dbt->bitrate;
+
+			/* Max valid TDCO value is 127 */
+			if (tdco > 127) {
+				netdev_warn(dev, "TDCO value of %u is beyond maximum. Using maximum possible value\n",
+					    tdco);
+				tdco = 127;
+			}
+
+			reg_btp |= DBTP_TDC;
+			m_can_write(priv, M_CAN_TDCR,
+				    tdco << TDCR_TDCO_SHIFT);
+		}
+
+		reg_btp |= (brp << DBTP_DBRP_SHIFT) |
+			   (sjw << DBTP_DSJW_SHIFT) |
+			   (tseg1 << DBTP_DTSEG1_SHIFT) |
+			   (tseg2 << DBTP_DTSEG2_SHIFT);
+
 		m_can_write(priv, M_CAN_DBTP, reg_btp);
 	}
 
-- 
2.7.4
