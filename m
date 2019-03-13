From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 28/60] ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
Date: Wed, 13 Mar 2019 15:09:49 -0400
Message-ID: <20190313191021.158171-28-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 759c962d3c9bb1a60e3b4b780daa66ee6d4be13a ]

The PHY must add both tx and rx delay and not only on the tx clock.
The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
the tx dealy is disabled.

The reason why rgmii-txid worked because the rx delay was not disabled by
the driver so essentially we ended up with rgmii-id PHY mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 245868f58fe3..583f83b1742d 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -651,13 +651,13 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 	dual_emac_res_vlan = <1>;
 };
 
 &cpsw_emac1 {
 	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 	dual_emac_res_vlan = <2>;
 };
 
-- 
2.19.1
