From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 3/4] arm: dts: dra7: add syscon phandle to cpsw node
Date: Mon, 21 Sep 2015 15:56:52 +0530
Message-ID: <1442831213-3913-4-git-send-email-mugunthanvnm@ti.com>
References: <1442831213-3913-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1442831213-3913-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

There are 2 MACIDs stored in the control module of the dra7.
These are read by the cpsw driver if no valid MACID was found
in the devicetree.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5d65db9..76c739d 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1447,6 +1447,7 @@
 				     <GIC_SPI 336 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 337 IRQ_TYPE_LEVEL_HIGH>;
 			ranges;
+			syscon = <&scm_conf>;
 			status = "disabled";
 
 			davinci_mdio: mdio@48485000 {
-- 
2.6.0.rc2.10.gf4d9753
