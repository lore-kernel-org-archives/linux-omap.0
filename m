From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH 2/2] bus: ti-sysc: Add mcasp optional clocks flag
Date: Thu, 15 Nov 2018 14:07:55 -0800
Message-ID: <20181115220755.GI53235@atomide.com>
References: <20181115220237.32129-1-tony@atomide.com>
 <20181115220237.32129-3-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181115220237.32129-3-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>, Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>
List-Id: linux-omap@vger.kernel.org

* Tony Lindgren <tony@atomide.com> [181115 22:03]:
> We have OPT_CLKS_NEEDED in legacy platform data, but it's missing
> from the ti-sysc driver for device tree based configuration.
> 
> In order to pass OPT_CLKS_NEEDED quirk flag we need to update omap4 module
> data and add a new compatible for dra7 as the module layout is different
> from sysc_regbits_omap4_mcasp.

And below is the related dts change for dra7.

Regards,

Tony

8< -----------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Wed, 31 Oct 2018 09:02:18 -0700
Subject: [PATCH] ARM: dts: Use dra7 mcasp compatible for mcasp instances

Looks like dra7 needs optional clocks enabled for mcasp unlike
am33xx and am437x do.

Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7-l4.dtsi | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -2718,7 +2718,7 @@
 		};
 
 		target-module@60000 {			/* 0x48460000, ap 9 0e.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp1";
 			reg = <0x60000 0x4>,
 			      <0x60004 0x4>;
@@ -2752,7 +2752,7 @@
 		};
 
 		target-module@64000 {			/* 0x48464000, ap 11 1e.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp2";
 			reg = <0x64000 0x4>,
 			      <0x64004 0x4>;
@@ -2786,7 +2786,7 @@
 		};
 
 		target-module@68000 {			/* 0x48468000, ap 13 26.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp3";
 			reg = <0x68000 0x4>,
 			      <0x68004 0x4>;
@@ -2819,7 +2819,7 @@
 		};
 
 		target-module@6c000 {			/* 0x4846c000, ap 15 2e.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp4";
 			reg = <0x6c000 0x4>,
 			      <0x6c004 0x4>;
@@ -2852,7 +2852,7 @@
 		};
 
 		target-module@70000 {			/* 0x48470000, ap 19 36.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp5";
 			reg = <0x70000 0x4>,
 			      <0x70004 0x4>;
@@ -2885,7 +2885,7 @@
 		};
 
 		target-module@74000 {			/* 0x48474000, ap 35 14.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp6";
 			reg = <0x74000 0x4>,
 			      <0x74004 0x4>;
@@ -2918,7 +2918,7 @@
 		};
 
 		target-module@78000 {			/* 0x48478000, ap 39 0c.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp7";
 			reg = <0x78000 0x4>,
 			      <0x78004 0x4>;
@@ -2951,7 +2951,7 @@
 		};
 
 		target-module@7c000 {			/* 0x4847c000, ap 43 04.0 */
-			compatible = "ti,sysc-omap4-simple", "ti,sysc";
+			compatible = "ti,sysc-dra7-mcasp", "ti,sysc";
 			ti,hwmods = "mcasp8";
 			reg = <0x7c000 0x4>,
 			      <0x7c004 0x4>;
-- 
2.19.1
