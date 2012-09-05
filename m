From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v5 1/3] arm/dts: AM33XX: Add basic pinctrl device tree data
Date: Wed, 5 Sep 2012 17:10:58 +0530
Message-ID: <1346845260-10978-2-git-send-email-anilkumar@ti.com>
References: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:43929 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464Ab2IELll (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 5 Sep 2012 07:41:41 -0400
In-Reply-To: <1346845260-10978-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: wg@grandegger.com, mkl@pengutronix.de, bryan.wu@canonical.com, rpurdie@rpsys.net, linux-leds@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index be43511..bf5f713 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,15 @@
 		};
 	};
 
+	am3358_pinmux: pinmux@44e10800 {
+		compatible = "pinctrl-single";
+		reg = <0x44e10800 0x0238>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		pinctrl-single,register-width = <32>;
+		pinctrl-single,function-mask = <0x7f>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5

