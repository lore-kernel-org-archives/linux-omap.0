From: Tony Lindgren <tony@atomide.com>
Subject: [PATCH 11/12] ARM: dts: Drop legacy custom hwmods property for omap4 uart
Date: Mon, 27 May 2019 05:13:47 -0700
Message-ID: <20190527121348.45251-12-tony@atomide.com>
References: <20190527121348.45251-1-tony@atomide.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190527121348.45251-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Roger Quadros <rogerq@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
List-Id: linux-omap@vger.kernel.org

With recent ti-sysc driver changes, we can now finally probe most
modules without needing the custom ti,hwmods property.

Let's start with omap4 uart as we can test that for runtime PM
for core retention idle mode.

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/omap4-l4.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-l4.dtsi b/arch/arm/boot/dts/omap4-l4.dtsi
--- a/arch/arm/boot/dts/omap4-l4.dtsi
+++ b/arch/arm/boot/dts/omap4-l4.dtsi
@@ -1371,7 +1371,6 @@
 
 		target-module@20000 {			/* 0x48020000, ap 3 06.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart3";
 			reg = <0x20050 0x4>,
 			      <0x20054 0x4>,
 			      <0x20058 0x4>;
@@ -1728,7 +1727,6 @@
 
 		target-module@6a000 {			/* 0x4806a000, ap 26 18.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart1";
 			reg = <0x6a050 0x4>,
 			      <0x6a054 0x4>,
 			      <0x6a058 0x4>;
@@ -1758,7 +1756,6 @@
 
 		target-module@6c000 {			/* 0x4806c000, ap 28 20.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart2";
 			reg = <0x6c050 0x4>,
 			      <0x6c054 0x4>,
 			      <0x6c058 0x4>;
@@ -1788,7 +1785,6 @@
 
 		target-module@6e000 {			/* 0x4806e000, ap 30 1c.1 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
-			ti,hwmods = "uart4";
 			reg = <0x6e050 0x4>,
 			      <0x6e054 0x4>,
 			      <0x6e058 0x4>;
-- 
2.21.0
