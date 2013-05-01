From: Russ Dill <Russ.Dill@ti.com>
Subject: [RFC 2/2] ARM: dts: add AM33XX vdd core opp50 suspend for Beaglebone.
Date: Wed,  1 May 2013 12:02:27 -0700
Message-ID: <1367434947-6442-3-git-send-email-Russ.Dill@ti.com>
References: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:53684 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755978Ab3EATCj (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 1 May 2013 15:02:39 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz17so869233pbc.3
        for <linux-omap@vger.kernel.org>; Wed, 01 May 2013 12:02:38 -0700 (PDT)
In-Reply-To: <1367434947-6442-1-git-send-email-Russ.Dill@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: khilman@deeprootsystems.com, tony@atomide.com, Vaibhav Bedia <vaibhav.bedia@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>

This adds a sleep and wake sequence to set the VDD core voltage to the
OPP50 level, 0.950V. This saves power during suspend. The sequences are
specific to the Beaglebone layout and PMIC, the TPS65217. The sequences
are written out by the am33xx PM code.

Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 arch/arm/boot/dts/am335x-bone.dts | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 725aa63..bccada7 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -73,10 +73,33 @@
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
 
 		rtc@44e3e000 {
-- 
1.8.1.2

