From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 07/94] ARM: dts: Fix flags for gpio7
Date: Wed,  4 Sep 2019 11:56:12 -0400
Message-ID: <20190904155739.2816-7-sashal@kernel.org>
References: <20190904155739.2816-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190904155739.2816-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, Suman Anna <s-anna@ti.com>, Keerthy <j-keerthy@ti.com>, Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 2e8647bbe1c8233a20c32fd2648258f2c05c7335 ]

The ti,no-idle-on-init and ti,no-reset-on-init flags need to be at
the interconnect target module level for the modules that have it
defined. Otherwise we get the following warnings:

dts flag should be at module level for ti,no-idle-on-init
dts flag should be at module level for ti,no-reset-on-init

Reviewed-by: Suman Anna <s-anna@ti.com>
Tested-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi | 2 +-
 arch/arm/boot/dts/dra7-evm.dts                  | 2 +-
 arch/arm/boot/dts/dra7-l4.dtsi                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
index d50de7a6ea6c5..bc76f1705c0f6 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
+++ b/arch/arm/boot/dts/am57xx-beagle-x15-common.dtsi
@@ -379,7 +379,7 @@
 	};
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 714e971b912a4..de7f85efaa512 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -498,7 +498,7 @@
 	phy-supply = <&ldousb_reg>;
 };
 
-&gpio7 {
+&gpio7_target {
 	ti,no-reset-on-init;
 	ti,no-idle-on-init;
 };
diff --git a/arch/arm/boot/dts/dra7-l4.dtsi b/arch/arm/boot/dts/dra7-l4.dtsi
index 23faedec08abd..63628e166c0cd 100644
--- a/arch/arm/boot/dts/dra7-l4.dtsi
+++ b/arch/arm/boot/dts/dra7-l4.dtsi
@@ -1261,7 +1261,7 @@
 			};
 		};
 
-		target-module@51000 {			/* 0x48051000, ap 45 2e.0 */
+		gpio7_target: target-module@51000 {		/* 0x48051000, ap 45 2e.0 */
 			compatible = "ti,sysc-omap2", "ti,sysc";
 			ti,hwmods = "gpio7";
 			reg = <0x51000 0x4>,
-- 
2.20.1
