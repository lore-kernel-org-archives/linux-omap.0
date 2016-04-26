From: "J.D. Schroeder" <Linux.HWI@garmin.com>
Subject: [PATCH 3/3] ARM: DRA7x: dts: Update the OSC_32K_CLK frequency
Date: Tue, 26 Apr 2016 12:54:29 -0500
Message-ID: <1461693269-19436-4-git-send-email-Linux.HWI@garmin.com>
References: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461693269-19436-1-git-send-email-Linux.HWI@garmin.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: "J.D. Schroeder" <jay.schroeder@garmin.com>
List-Id: linux-omap@vger.kernel.org

From: "J.D. Schroeder" <jay.schroeder@garmin.com>

This commit updates the OSC_32K_CLK (secure_32k_clk_src_ck) frequency
from the precise 32kHz frequency (i.e., 32.768 kHz) to the more
accurate frequency of ~34.6 kHz. Actual measured frequencies of the
clock vary from board to board anywhere from 34.4 kHz up to 34.8 kHz.

Signed-off-by: J.D. Schroeder <jay.schroeder@garmin.com>
Reviewed-by: Trenton Andres <trenton.andres@garmin.com>
---
 arch/arm/boot/dts/dra7xx-clocks.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7xx-clocks.dtsi b/arch/arm/boot/dts/dra7xx-clocks.dtsi
index a514fc3..4501140 100644
--- a/arch/arm/boot/dts/dra7xx-clocks.dtsi
+++ b/arch/arm/boot/dts/dra7xx-clocks.dtsi
@@ -95,7 +95,7 @@
 	secure_32k_clk_src_ck: secure_32k_clk_src_ck {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-		clock-frequency = <32768>;
+		clock-frequency = <34600>; /* approximate frequency */
 	};
 
 	virt_12000000_ck: virt_12000000_ck {
-- 
1.9.1
