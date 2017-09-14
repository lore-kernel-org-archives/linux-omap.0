From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH] ARM: dts: am43xx-epos-evm: Remove extra CPSW EMAC entry
Date: Thu, 14 Sep 2017 14:30:07 -0500
Message-ID: <20170914193007.7246-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Yogesh Siraswar <yogeshs@ti.com>

On am438x EPOS boards there is only one ethernet port, remove extra
port definition.

This boot log warnings during PHY detection.

Signed-off-by: Yogesh Siraswar <yogeshs@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9d276af7c539..081fa68b6f98 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -388,6 +388,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -402,11 +403,6 @@
 	phy-mode = "rmii";
 };
 
-&cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
-	phy-mode = "rmii";
-};
-
 &phy_sel {
 	rmii-clock-ext;
 };
-- 
2.14.1
