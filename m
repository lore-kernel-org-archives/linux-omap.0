From: Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH v4 2/4] ARM: dts: add AM33XX vdd core opp50 suspend for Beaglebone.
Date: Tue, 13 Aug 2013 15:20:10 -0700
Message-ID: <1376432412-8509-3-git-send-email-Russ.Dill@ti.com>
References: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50]:36196 "EHLO
	mail-oa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759255Ab3HMWUT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 13 Aug 2013 18:20:19 -0400
In-Reply-To: <1376432412-8509-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: devicetree@vger.kernel.org, Kevin Hilman <khilman@deeprootsystems.com>, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Changes since v1:
* Rebased onto new am335x PM branch

This adds a sleep and wake sequence to set the VDD core voltage to the
OPP50 level, 0.950V. This saves power during suspend. The sequences are
specific to the Beaglebone layout and PMIC, the TPS65217. The sequences
are written out by the Cortex-M3.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 444b4ed..3f6528d 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -127,10 +127,33 @@
 			status = "okay";
 			clock-frequency = <400000>;
 
+			/* Set OPP50 (0.95V) for VDD core */
+			sleep_sequence = /bits/ 8 <
+				0x02 0x24 0x0b 0x6d /* Password unlock 1 */
+				0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
+				0x02 0x24 0x0b 0x6d /* Password unlock 2 */
+				0x02 0x24 0x10 0x02 /* Set DCDC3 to 0.95V */
+				0x02 0x24 0x0b 0x6c /* Password unlock 1 */
+				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
+				0x02 0x24 0x0b 0x6c /* Password unlock 2 */
+				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
+			>;
+
+			/* Set OPP100 (1.10V) for VDD core */
+			wake_sequence = /bits/ 8 <
+				0x02 0x24 0x0b 0x6d /* Password unlock 1 */
+				0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
+				0x02 0x24 0x0b 0x6d /* Password unlock 2 */
+				0x02 0x24 0x10 0x08 /* Set DCDC3 to 1.1V */
+				0x02 0x24 0x0b 0x6c /* Password unlock 1 */
+				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
+				0x02 0x24 0x0b 0x6c /* Password unlock 2 */
+				0x02 0x24 0x11 0x86 /* Apply DCDC changes */
+			>;
+
 			tps: tps@24 {
 				reg = <0x24>;
 			};
-
 		};
 	};
 
-- 
1.8.3.2

