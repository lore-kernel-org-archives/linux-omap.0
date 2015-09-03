From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 1/4] ARM: dts: omap24xx: fix address translation for pbias
Date: Thu, 3 Sep 2015 16:57:50 +0530
Message-ID: <1441279673-28105-2-git-send-email-kishon@ti.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441279673-28105-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

commit <72b10ac00eb1> ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
scm_conf. Since scm_conf doesn't have the 'ranges' property,
address translation fails while trying to convert the address
to resource. Fix it here.

Fixes: 72b10ac00eb1 ("ARM: dts: omap24xx: add minimal l4 bus
layout with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap2430.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap2430.dtsi
index 3961a6f..798dda0 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -56,6 +56,7 @@
 					reg = <0x270 0x240>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x270 0x240>;
 
 					scm_clocks: clocks {
 						#address-cells = <1>;
-- 
1.7.9.5
