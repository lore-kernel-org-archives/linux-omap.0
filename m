From: Heiko Schocher <hs@denx.de>
Subject: [PATCH v1 2/2] ARM: dts: am335x-shc.dts: fix wrong cd pin level
Date: Tue, 22 Jan 2019 06:26:23 +0100
Message-ID: <20190122052623.1779840-3-hs@denx.de>
References: <20190122052623.1779840-1-hs@denx.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190122052623.1779840-1-hs@denx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org
Cc: Heiko Schocher <hs@denx.de>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

cd pin on mmc1 is GPIO_ACTIVE_LOW not GPIO_ACTIVE_HIGH

Signed-off-by: Heiko Schocher <hs@denx.de>
---

 arch/arm/boot/dts/am335x-shc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335x-shc.dts
index 5cdaf0cd9401..bfbe27a80006 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -213,7 +213,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
 	bus-width = <0x4>;
-	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
+	cd-gpios = <&gpio0 6 GPIO_ACTIVE_LOW>;
 	cd-inverted;
 	max-frequency = <26000000>;
 	vmmc-supply = <&vmmcsd_fixed>;
-- 
2.17.2
