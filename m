From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/4] ARM: dts: omap4: fix address translation for pbias
Date: Thu, 3 Sep 2015 16:57:51 +0530
Message-ID: <1441279673-28105-3-git-send-email-kishon@ti.com>
References: <1441279673-28105-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1441279673-28105-1-git-send-email-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: t-kristo@ti.com, bcousson@baylibre.com, tony@atomide.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: linux@arm.linux.org.uk, nsekhar@ti.com, kishon@ti.com
List-Id: linux-omap@vger.kernel.org

commit <7415b0b4c645> ("ARM: dts: omap4: add minimal l4 bus layout
with control module support") moved pbias_regulator dt node
from being a child node of ocp to be the child node of
omap4_padconf_global. Since omap4_padconf_global doesn't have the
'ranges' property, address translation fails while trying to convert
the address to resource. Fix it here.

Fixes: 7415b0b4c645 ("ARM: dts: omap4: add minimal l4 bus layout
with control module support")

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap4.dtsi |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dtsi
index 5aad7f3..5a206c1 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -196,6 +196,7 @@
 					reg = <0x5a0 0x170>;
 					#address-cells = <1>;
 					#size-cells = <1>;
+					ranges = <0 0x5a0 0x170>;
 
 					pbias_regulator: pbias_regulator {
 						compatible = "ti,pbias-omap4", "ti,pbias-omap";
-- 
1.7.9.5
