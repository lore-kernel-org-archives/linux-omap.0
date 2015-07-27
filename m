From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 3/4] ARM: dts: OMAP5: Fix broken pbias device creation
Date: Mon, 27 Jul 2015 17:46:40 +0530
Message-ID: <1437999401-3519-4-git-send-email-kishon@ti.com>
References: <1437999401-3519-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437999401-3519-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bcousson@baylibre.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, t-kristo@ti.com, grygorii.strashko@ti.com, nsekhar@ti.com, kishon@ti.com, stable@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

commit <ed8509edddeb> ("ARM: dts: omap5: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
omap5_padconf_global. After this device for pbias_regulator is
not created.

Fix it by adding "simple-bus" compatible property to
omap5_padconf_global dt node.

Fixes: ed8509edddeb ("ARM: dts: omap5: add minimal l4 bus
layout with control module support")

Cc: <stable@vger.kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index c8fd648..b1a1263 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -180,7 +180,8 @@
 				};
 
 				omap5_padconf_global: omap5_padconf_global@5a0 {
-					compatible = "syscon";
+					compatible = "syscon",
+						     "simple-bus";
 					reg = <0x5a0 0xec>;
 					#address-cells = <1>;
 					#size-cells = <1>;
-- 
1.7.9.5
