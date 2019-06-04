From: Keerthy <j-keerthy@ti.com>
Subject: [PATCH] arm: dts: dra72x: Disable usb4_tm target module
Date: Tue, 4 Jun 2019 11:43:35 +0530
Message-ID: <20190604061335.8264-1-j-keerthy@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tony@atomide.com, robh+dt@kernel.org
Cc: linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, t-kristo@ti.com, j-keerthy@ti.com
List-Id: linux-omap@vger.kernel.org

usb4_tm is unsed on dra72 and accessing the module
with ti,sysc is causing a boot crash hence disable its target
module.

Fixes: 549fce068a3112 ("ARM: dts: dra7: Add l4 interconnect hierarchy and ti-sysc data")
Reported-by: Vignesh Raghavendra <vigneshr@ti.com>
Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/boot/dts/dra72x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/dra72x.dtsi b/arch/arm/boot/dts/dra72x.dtsi
index 89831552cd86..9c39c6b9b5d6 100644
--- a/arch/arm/boot/dts/dra72x.dtsi
+++ b/arch/arm/boot/dts/dra72x.dtsi
@@ -62,3 +62,7 @@
 &pcie2_rc {
 	compatible = "ti,dra726-pcie-rc", "ti,dra7-pcie";
 };
+
+&usb4_tm {
+	status = "disabled";
+};
-- 
2.17.1
