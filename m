From: Nishanth Menon <nm@ti.com>
Subject: [PATCH] ARM: dts: dra7-evm: keep TPS core control signals active
Date: Wed, 23 Apr 2014 15:34:53 -0500
Message-ID: <1398285293-32106-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:39244 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752767AbaDWUe5 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 23 Apr 2014 16:34:57 -0400
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>, J Keerthy <j-keerthy@ti.com>, Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>

SYSEN1, 2 control DDR voltages and REGEN2 actually controls PLLEN
(without which platform cannot function). We need to mark in dts that
these are supposed to be always on.

Palmas REGEN1 and REGEN3(called REGEN2) are unused on the platform. So
we let them auto disable themselves by not defining them.

Cc: J Keerthy <j-keerthy@ti.com>
Signed-off-by: Subramaniam Chanderashekarapuram <subramaniam.ca@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---

Patch based on v3.15-rc2, also tested on next-20140423 tag:

Tested by applying [1] (auto disable unused regulator for regulators that are deferred):
Without [1]: http://slexy.org/raw/s21MCHgeJo (no regulators are disabled)
with [1]:  http://slexy.org/raw/s21c99YY8n (unused regulators auto disabled).
 - DDR and board shuts off :(

With fix: http://slexy.org/raw/s2TH36cThR

[1] https://patchwork.kernel.org/patch/2545061/

 arch/arm/boot/dts/dra7-evm.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/dra7-evm.dts b/arch/arm/boot/dts/dra7-evm.dts
index 5babba0..3f94f75 100644
--- a/arch/arm/boot/dts/dra7-evm.dts
+++ b/arch/arm/boot/dts/dra7-evm.dts
@@ -209,6 +209,27 @@
 					regulator-max-microvolt = <3300000>;
 					regulator-boot-on;
 				};
+
+				sysen1: sysen1 {
+					/* SYSEN1 ->... EVM_3V3_SW -> DDR VTT */
+					regulator-name = "sysen1";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				sysen2: sysen2 {
+					/* SYSEN2 -> ... TPS57112 1v35DDR */
+					regulator-name = "sysen2";
+					regulator-boot-on;
+					regulator-always-on;
+				};
+
+				regen2: regen2 {
+					/* Internal REGEN2 is PLLEN */
+					regulator-name = "regen2";
+					regulator-boot-on;
+					regulator-always-on;
+				};
 			};
 		};
 	};
-- 
1.7.9.5

