From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH v2] ARM: dts: am335x-bone-common: enable aes and sham
Date: Wed, 25 Feb 2015 13:52:41 -0500
Message-ID: <1424890361-31848-1-git-send-email-mporter@konsulko.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:33469 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752739AbbBYSws (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 25 Feb 2015 13:52:48 -0500
Received: by mail-ig0-f181.google.com with SMTP id hn18so8364761igb.2
        for <linux-omap@vger.kernel.org>; Wed, 25 Feb 2015 10:52:47 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Robert Nelson <robertcnelson@gmail.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Beaglebone Black doesn't have AES and SHAM enabled like the
original Beaglebone White dts. This breaks applications that
leverage the crypto blocks so fix this by enabling these nodes
in the am335x-bone-common.dtsi. With this change, enabling the
nodes in am335x-bone.dts is no longer required so remove them.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 8 ++++++++
 arch/arm/boot/dts/am335x-bone.dts         | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 6cc25ed..12cdb2b 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -300,3 +300,11 @@
 	cd-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
 	cd-inverted;
 };
+
+&aes {
+	status = "okay";
+};
+
+&sham {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 83d40f7..6b849372 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -24,11 +24,3 @@
 &mmc1 {
 	vmmc-supply = <&ldo3_reg>;
 };
-
-&sham {
-	status = "okay";
-};
-
-&aes {
-	status = "okay";
-};
-- 
1.8.4

