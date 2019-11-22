From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 024/219] ARM: dts: Fix hsi gdd range for omap4
Date: Fri, 22 Nov 2019 00:26:46 -0500
Message-ID: <20191122053001.752-17-sashal@kernel.org>
References: <20191122053001.752-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191122053001.752-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Sebastian Reichel <sebastian.reichel@collabora.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit e9e685480b74aef3f3d0967dadb52eea3ff625d2 ]

While reviewing the missing mcasp ranges I noticed omap4 hsi range
for gdd is wrong so let's fix it.

I'm not aware of any omap4 devices in mainline kernel though that use
hsi though.

Fixes: 84badc5ec5fc ("ARM: dts: omap4: Move l4 child devices to probe
them with ti-sysc")
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/omap4-l4.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
index 6eb26b837446c..5059ecac44787 100644
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -196,12 +196,12 @@
 			clock-names = "fck";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			ranges = <0x0 0x58000 0x4000>;
+			ranges = <0x0 0x58000 0x5000>;
 
 			hsi: hsi@0 {
 				compatible = "ti,omap4-hsi";
 				reg = <0x0 0x4000>,
-				      <0x4a05c000 0x1000>;
+				      <0x5000 0x1000>;
 				reg-names = "sys", "gdd";
 
 				clocks = <&l3_init_clkctrl OMAP4_HSI_CLKCTRL 0>;
-- 
2.20.1
