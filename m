From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH 1/5] ARM: dts: am43xx-epos-evm: Keep DCDC5 and DCDC6 always on
Date: Fri, 29 Mar 2019 12:53:32 -0500
Message-ID: <20190329175336.19824-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Kabir Sahane <x0153567@ti.com>

These regulator outputs are needed even in deep sleep modes to prevent
low-voltage detection events. Make these always ON to avoid this.

Signed-off-by: Kabir Sahane <x0153567@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---
 arch/arm/boot/dts/am43x-epos-evm.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/am43x-epos-evm.dts b/arch/arm/boot/dts/am43x-epos-evm.dts
index 9dfd80e3b76e..7db5cf3facde 100644
--- a/arch/arm/boot/dts/am43x-epos-evm.dts
+++ b/arch/arm/boot/dts/am43x-epos-evm.dts
@@ -634,12 +634,16 @@
 			regulator-name = "v1_0bat";
 			regulator-min-microvolt = <1000000>;
 			regulator-max-microvolt = <1000000>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		dcdc6: regulator-dcdc6 {
 			regulator-name = "v1_8bat";
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <1800000>;
+			regulator-boot-on;
+			regulator-always-on;
 		};
 
 		ldo1: regulator-ldo1 {
-- 
2.21.0
