From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 2/2] ARM: dts: omap5: Increase max-voltage of pbias regulator
Date: Mon, 9 Oct 2017 11:23:12 +0530
Message-ID: <20171009055312.24165-3-kishon@ti.com>
References: <20171009055312.24165-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171009055312.24165-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, nsekhar@ti.com, Ravikumar Kattekola <rk@ti.com>, Kishon Vijay Abraham I <kishon@ti.com>
List-Id: linux-omap@vger.kernel.org

From: Ravikumar Kattekola <rk@ti.com>

As per recent TRM, PBIAS cell on omap5 devices supports
3.3v and not 3.0v as documented earlier.

Update PBIAS regulator max voltage to match this.

Document reference:
SWPU249AF - OMAP543x Technical reference manual August 2016

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index eaff2a5751dd..e6af460ee301 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -194,7 +194,7 @@
 						pbias_mmc_reg: pbias_mmc_omap5 {
 							regulator-name = "pbias_mmc_omap5";
 							regulator-min-microvolt = <1800000>;
-							regulator-max-microvolt = <3000000>;
+							regulator-max-microvolt = <3300000>;
 						};
 					};
 				};
-- 
2.11.0
