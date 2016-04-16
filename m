From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: [PATCH] ARM: dts: omap3: Fix ISP syscon register offset
Date: Sat, 16 Apr 2016 09:20:28 +0300
Message-ID: <1460787628-17316-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
List-Id: linux-omap@vger.kernel.org

According to the TRM, SCM CONTROL_CSIRXFE register is on offset 0x6c

Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
---
 arch/arm/boot/dts/omap34xx.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap34xx.dtsi b/arch/arm/boot/dts/omap34xx.dtsi
index 5cdba1f..e446562 100644
--- a/arch/arm/boot/dts/omap34xx.dtsi
+++ b/arch/arm/boot/dts/omap34xx.dtsi
@@ -46,7 +46,7 @@
 			       0x480bd800 0x017c>;
 			interrupts = <24>;
 			iommus = <&mmu_isp>;
-			syscon = <&scm_conf 0xdc>;
+			syscon = <&scm_conf 0x6c>;
 			ti,phy-type = <OMAP3ISP_PHY_TYPE_COMPLEX_IO>;
 			#clock-cells = <1>;
 			ports {
-- 
1.9.1
