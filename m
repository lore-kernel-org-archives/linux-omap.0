From: Ravikumar Kattekola <rk@ti.com>
Subject: [PATCH 2/2] ARM: dts: dra7-evm: Update SMPS7 (VDD_CORE) max voltage to match DM
Date: Wed, 3 Dec 2014 17:33:57 +0530
Message-ID: <1417608237-12258-3-git-send-email-rk@ti.com>
References: <1417608237-12258-1-git-send-email-rk@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1417608237-12258-1-git-send-email-rk@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Ravikumar Kattekola <rk@ti.com>
List-Id: linux-omap@vger.kernel.org

As per the latest Data Manual, for newer samples,
the nominal voltage required for VDD_CORE at OPP_NOM can be
upto 1.06V which was 1.03V earlier.

Update the regulator max voltage constraint for SMPS7,
connected to VDD_CORE, to meet this requirement.

Document reference:
DRA74 Data Manual, SPRS857M - Dec 2012, Revised Oct 2014.
DRA72 Data Manual, SPRS906G - Dec 2012, revised Oct 2014.

Signed-off-by: Ravikumar Kattekola <rk@ti.com>
---
 arch/arm/boot/dts/dra7-evm.dts  |    2 +-
 arch/arm/boot/dts/dra72-evm.dts |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index b6b9286..10b725c 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -313,7 +313,7 @@
 					/* CORE_VDD */
 					regulator-name = "smps7";
 					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1030000>;
+					regulator-max-microvolt = <1060000>;
 					regulator-always-on;
 					regulator-boot-on;
 				};
diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index afc74fd..89085d0 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -160,7 +160,7 @@
 					/* VDD_CORE */
 					regulator-name = "smps2";
 					regulator-min-microvolt = <850000>;
-					regulator-max-microvolt = <1030000>;
+					regulator-max-microvolt = <1060000>;
 					regulator-boot-on;
 					regulator-always-on;
 				};
-- 
1.7.9.5
