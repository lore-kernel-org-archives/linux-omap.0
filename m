From: Mugunthan V N <mugunthanvnm@ti.com>
Subject: [net-next PATCH 4/4] arm: dts: am4372: add syscon phandle to cpsw node
Date: Mon, 21 Sep 2015 15:56:53 +0530
Message-ID: <1442831213-3913-5-git-send-email-mugunthanvnm@ti.com>
References: <1442831213-3913-1-git-send-email-mugunthanvnm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1442831213-3913-1-git-send-email-mugunthanvnm@ti.com>
Sender: netdev-owner@vger.kernel.org
To: netdev@vger.kernel.org
Cc: linux-omap@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Mugunthan V N <mugunthanvnm@ti.com>
List-Id: linux-omap@vger.kernel.org

There are 2 MACIDs stored in the control module of the am4372.
These are read by the cpsw driver if no valid MACID was found
in the devicetree.

Signed-off-by: Mugunthan V N <mugunthanvnm@ti.com>
---
 arch/arm/boot/dts/am4372.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 0447c04a..d83ff9c 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -591,6 +591,7 @@
 			cpts_clock_mult = <0x80000000>;
 			cpts_clock_shift = <29>;
 			ranges;
+			syscon = <&scm_conf>;
 
 			davinci_mdio: mdio@4a101000 {
 				compatible = "ti,am4372-mdio","ti,davinci_mdio";
-- 
2.6.0.rc2.10.gf4d9753
