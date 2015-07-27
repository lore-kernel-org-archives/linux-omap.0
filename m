From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v2 2/3] ARM: dts: dra7: fix pinmux@1400 resource length
Date: Mon, 27 Jul 2015 13:27:29 +0300
Message-ID: <1437992850-6008-3-git-send-email-rogerq@ti.com>
References: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437992850-6008-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

We need to add 4 bytes to include the last 32-bit register space.

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index cf2931e..913032b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -141,7 +141,7 @@
 				dra7_pmx_core: pinmux@1400 {
 					compatible = "ti,dra7-padconf",
 						     "pinctrl-single";
-					reg = <0x1400 0x0464>;
+					reg = <0x1400 0x0468>;
 					#address-cells = <1>;
 					#size-cells = <0>;
 					#interrupt-cells = <1>;
-- 
2.1.4
