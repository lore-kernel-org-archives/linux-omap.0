From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 21/81] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date: Thu, 28 Feb 2019 10:07:13 -0500
Message-ID: <20190228150813.10256-21-sashal@kernel.org>
References: <20190228150813.10256-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190228150813.10256-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Heiko Schocher <hs@denx.de>

[ Upstream commit 063c20e12f8bbbc10cabc2413606b140085beb62 ]

cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Fixes: e63201f19438 ("mmc: omap_hsmmc: Delete platform data GPIO CD and WP")
Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-shc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 1d925ed2b102c..8fbbad11a80c9 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -215,7 +215,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <0x4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	max-frequency = <26000000>;
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
2.19.1
