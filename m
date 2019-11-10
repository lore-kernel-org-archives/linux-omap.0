From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 18/66] ARM: dts: am335x-evm: fix number of cpsw
Date: Sat,  9 Nov 2019 21:47:57 -0500
Message-ID: <20191110024846.32598-18-sashal@kernel.org>
References: <20191110024846.32598-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191110024846.32598-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit dcbf6b18d81bcdc51390ca1b258c17e2e13b7d0c ]

am335x-evm has only one CPSW external port physically wired, but DT defines
2 ext. ports. As result, PHY connection failure reported for the second
ext. port.

Update DT to reflect am335x-evm board HW configuration, and, while here,
switch to use phy-handle instead of phy_id.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e82432c79f85f..3f3ad09c7cd5f 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -701,6 +701,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -708,15 +709,14 @@
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
 	status = "okay";
-};
 
-&cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "rgmii-txid";
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
 };
 
-&cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
+&cpsw_emac0 {
+	phy-handle = <&ethphy0>;
 	phy-mode = "rgmii-txid";
 };
 
-- 
2.20.1
