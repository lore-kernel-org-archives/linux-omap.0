From: Roger Quadros <rogerq@ti.com>
Subject: [PATCH v3 2/3] ARM: dts: dra7: Add syscon-pllreset syscon to SATA PHY
Date: Fri, 17 Jul 2015 16:47:23 +0300
Message-ID: <1437140844-6032-3-git-send-email-rogerq@ti.com>
References: <1437140844-6032-1-git-send-email-rogerq@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437140844-6032-1-git-send-email-rogerq@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: kishon@ti.com, tony@atomide.com
Cc: nm@ti.com, nsekhar@ti.com, balbi@ti.com, grygorii.strashko@ti.com, t-kristo@ti.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, Roger Quadros <rogerq@ti.com>
List-Id: linux-omap@vger.kernel.org

This register is required to be passed to the SATA PHY driver
to workaround errata i783 (SATA Lockup After SATA DPLL Unlock/Relock).

Signed-off-by: Roger Quadros <rogerq@ti.com>
---
 arch/arm/boot/dts/dra7.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index 8f1e25b..4a0718c 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -1140,6 +1140,7 @@
 				ctrl-module = <&omap_control_sata>;
 				clocks = <&sys_clkin1>, <&sata_ref_clk>;
 				clock-names = "sysclk", "refclk";
+				syscon-pllreset = <&scm_conf 0x3fc>;
 				#phy-cells = <0>;
 			};
 
-- 
2.1.4
