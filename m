From: Nishanth Menon <nm@ti.com>
Subject: [PATCH 2/2] ARM: dts: am57xx-beagle-x15: Fix RTC aliases
Date: Wed, 8 Apr 2015 18:56:27 -0500
Message-ID: <1428537387-18776-3-git-send-email-nm@ti.com>
References: <1428537387-18776-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1428537387-18776-1-git-send-email-nm@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Grygorii Strashko <Grygorii.Strashko@linaro.org>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, Nishanth Menon <nm@ti.com>
List-Id: linux-omap@vger.kernel.org

With commit bc078316d86c ("ARM: dts: DRA7: Add node for RTC"), we now
have AM57xx RTC register itself as alias 0 even before DS1307 or TPS
rtc drivers are loaded up. However, since neither TPS, nor AM57xx RTC
are capable of being backedup by battery, we would like to maintain
the "primary" rtc as mcp79410 rtc device.

This also generates the following warnings in the bootlog highlighting
the issue:
[    5.895445] rtc-ds1307 2-006f: /aliases ID 0 not available
...
[    6.476285] palmas-rtc 48070000.i2c:tps659038@58:tps659038_rtc: /aliases ID 1 not available

So, add proper aliases to ensure that RTC order is always consistent
to userspace immaterial of probe order.

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    1 +
 arch/arm/boot/dts/dra7.dtsi             |    2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 57279e3b439b..6837f44db534 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -18,6 +18,7 @@
 	aliases {
 		rtc0 = &mcp_rtc;
 		rtc1 = &tps659038_rtc;
+		rtc2 = &rtc;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 5332b57b4950..0f73fea9f5c3 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1203,7 +1203,7 @@
 			status = "disabled";
 		};
 
-		rtc@48838000 {
+		rtc: rtc@48838000 {
 			compatible = "ti,am3352-rtc";
 			reg = <0x48838000 0x100>;
 			interrupts = <GIC_SPI 217 IRQ_TYPE_LEVEL_HIGH>,
-- 
1.7.9.5
