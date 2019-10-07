From: Emmanuel Vadot <manu@freebsd.org>
Subject: [PATCH] ARM: dts: Set status to disable for MMC3
Date: Mon,  7 Oct 2019 10:03:39 +0200
Message-ID: <20191007080339.57209-1-manu@freebsd.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>
List-Id: linux-omap@vger.kernel.org

Commit 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
fixed the mmc instances on the l3 interconnect but removed the disabled status.
Fix this and let boards properly define it if it have it.

Fixes: 5b63fb90adb95 ("ARM: dts: Fix incomplete dts data for am3 and am4 mmc")
Signed-off-by: Emmanuel Vadot <manu@freebsd.org>
---
 arch/arm/boot/dts/am33xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index fb6b8aa12cc5..b3a1fd9e39fa 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -260,6 +260,7 @@
 				ti,needs-special-reset;
 				interrupts = <29>;
 				reg = <0x0 0x1000>;
+				status = "disabled";
 			};
 		};
 
-- 
2.22.0
