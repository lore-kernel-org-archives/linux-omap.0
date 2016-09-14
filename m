From: Dave Gerlach <d-gerlach@ti.com>
Subject: [PATCH 1/3] Revert "ARM: dts: am335x-boneblack: Enable 1GHz OPP for cpu"
Date: Wed, 14 Sep 2016 15:57:15 -0500
Message-ID: <20160914205717.21975-2-d-gerlach@ti.com>
References: <20160914205717.21975-1-d-gerlach@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <20160914205717.21975-1-d-gerlach@ti.com>
Sender: linux-pm-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Dave Gerlach <d-gerlach@ti.com>
List-Id: linux-omap@vger.kernel.org

This reverts commit c36e6ec904876de1935b1d74d2d711e6f5ceb572.

The original commit updated the cpufreq operating points tables for
am335x-boneblack but was merged before the driver making use of the node
was merged, which breaks the existing cpufreq implementation on the
system, so revert the patch until the ti-cpufreq driver is merged.

Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
---
 arch/arm/boot/dts/am335x-boneblack.dts | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index ca721670bd91..55c0e954b146 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -33,17 +33,6 @@
 	status = "okay";
 };
 
-&cpu0_opp_table {
-	/*
-	 * All PG 2.0 silicon may not support 1GHz but some of the early
-	 * BeagleBone Blacks have PG 2.0 silicon which is guaranteed
-	 * to support 1GHz OPP so enable it for PG 2.0 on this board.
-	 */
-	oppnitro@1000000000 {
-		opp-supported-hw = <0x06 0x0100>;
-	};
-};
-
 &am33xx_pinmux {
 	nxp_hdmi_bonelt_pins: nxp_hdmi_bonelt_pins {
 		pinctrl-single,pins = <
-- 
2.9.3

