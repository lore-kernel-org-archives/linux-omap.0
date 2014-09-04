From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH 1/2] ARM: dts: cm-t54: fix serial console power supply.
Date: Thu,  4 Sep 2014 16:02:52 +0300
Message-ID: <1409835773-22782-2-git-send-email-lifshitz@compulab.co.il>
References: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:50505 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754265AbaIDNDU (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 4 Sep 2014 09:03:20 -0400
In-Reply-To: <1409835773-22782-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Paul Walmsley <paul@pwsan.com>, Dmitry Lifshitz <lifshitz@compulab.co.il>

LDO8 regulator is used for act led and serial cosole power supply.

Its DT status is declared as "disabled", however the serial console was
functional until Commit 318dbb02b ("regulator: palmas: Fix SMPS
enable/disable/is_enabled") wich properly turns off LDO8 on boot.

Fix serial cosole power supply (and act led) on boot by turning LDO8 on.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---
 arch/arm/boot/dts/omap5-cm-t54.dts |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index b8698ca..429471a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -353,13 +353,12 @@
 				};
 
 				ldo8_reg: ldo8 {
-					/* VDD_3v0: Does not go anywhere */
+					/* VDD_3V_GP: act led/serial console */
 					regulator-name = "ldo8";
 					regulator-min-microvolt = <3000000>;
 					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
 					regulator-boot-on;
-					/* Unused */
-					status = "disabled";
 				};
 
 				ldo9_reg: ldo9 {
-- 
1.7.5.4

