From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 4/4] ARM: dts: dra7: Fix broken pbias device creation
Date: Mon, 27 Jul 2015 17:46:41 +0530
Message-ID: <1437999401-3519-5-git-send-email-kishon@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1437999401-3519-1-git-send-email-kishon@ti.com>
Sender: stable-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

commit <d919501feffa> ("ARM: dts: dra7: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
scm_conf. After this device for pbias_regulator is
not created.

Fix it by adding "simple-bus" compatible property to
scm_conf dt node.

Fixes: d919501feffa ("ARM: dts: dra7: add minimal l4 bus
layout with control module support")

Cc: <stable@vger.kernel.org>
Suggested-by: Tero Kristo <t-kristo@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25b..3062b1f 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -116,7 +116,7 @@
 				ranges = <0 0x2000 0x2000>;
 
 				scm_conf: scm_conf@0 {
-					compatible = "syscon";
+					compatible = "syscon", "simple-bus";
 					reg = <0x0 0x1400>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-- 
1.7.9.5
