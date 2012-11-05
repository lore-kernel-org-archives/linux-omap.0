From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 04/10] ARM: dts: AM33XX: Add volume-keys device tree data to am335x-evm
Date: Mon, 5 Nov 2012 16:15:44 +0530
Message-ID: <1352112350-13398-5-git-send-email-anilkumar@ti.com>
References: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:57526 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754019Ab2KEKqK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 5 Nov 2012 05:46:10 -0500
In-Reply-To: <1352112350-13398-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, grant.likely@secretlab.ca, devicetree-discuss@lists.ozlabs.org, AnilKumar Ch <anilkumar@ti.com>

Add gpio based volume keys device tree data to am335x-evm by adding
all the required parameters like keycode, gpios and etc.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am335x-evm.dts |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index e087b87..9f65f17 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -137,6 +137,27 @@
 				0x0101001c	/* ENTER */
 				0x0201006c>;	/* DOWN */
 	};
+
+	gpio_keys: volume_keys@0 {
+		compatible = "gpio-keys";
+		#address-cells = <1>;
+		#size-cells = <0>;
+		autorepeat;
+
+		switch@9 {
+			label = "volume-up";
+			linux,code = <115>;
+			gpios = <&gpio1 2 1>;
+			gpio-key,wakeup;
+		};
+
+		switch@10 {
+			label = "volume-down";
+			linux,code = <114>;
+			gpios = <&gpio1 3 1>;
+			gpio-key,wakeup;
+		};
+	};
 };
 
 /include/ "tps65910.dtsi"
-- 
1.7.9.5

