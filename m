From: Joachim Eastwood <manabian@gmail.com>
Subject: [PATCH 2/2] ARM: dts: Enable mcpdm and mcbsp1 on DuoVero
Date: Sat, 17 May 2014 14:07:00 +0200
Message-ID: <1400328420-28384-2-git-send-email-manabian@gmail.com>
References: <1400328420-28384-1-git-send-email-manabian@gmail.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-lb0-f181.google.com ([209.85.217.181]:34156 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932554AbaEQMHx (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sat, 17 May 2014 08:07:53 -0400
Received: by mail-lb0-f181.google.com with SMTP id u14so2747353lbd.12
        for <linux-omap@vger.kernel.org>; Sat, 17 May 2014 05:07:51 -0700 (PDT)
In-Reply-To: <1400328420-28384-1-git-send-email-manabian@gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, bcousson@baylibre.com
Cc: linux-omap@vger.kernel.org, Joachim Eastwood <manabian@gmail.com>, florian.vaussard@epfl.ch

Since commit 7adb0933b18debef3 (ARM: dts: omap4: Set all audio related
IP's status to disabled as default) all audio related device are
disabled by default. Most boards were updated to enable devices
explicitly, but DuoVero was missed.

mcpdm is used for twl6040 and mcbsp1 is used for BlueTooth audio.

Cc: florian.vaussard@epfl.ch
Signed-off-by: Joachim Eastwood <manabian@gmail.com>
---

Hi,

Only compile tested.

 arch/arm/boot/dts/omap4-duovero.dtsi | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-duovero.dtsi b/arch/arm/boot/dts/omap4-duovero.dtsi
index cc68a3b58648..e860ccd9d09c 100644
--- a/arch/arm/boot/dts/omap4-duovero.dtsi
+++ b/arch/arm/boot/dts/omap4-duovero.dtsi
@@ -67,8 +67,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <
 			&twl6040_pins
-			&mcpdm_pins
-			&mcbsp1_pins
 			&hsusbb1_pins
 	>;
 
@@ -202,6 +200,18 @@
 	clock-frequency = <400000>;
 };
 
+&mcbsp1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcbsp1_pins>;
+	status = "okay";
+};
+
+&mcpdm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcpdm_pins>;
+	status = "okay";
+};
+
 &mmc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
-- 
1.8.0

