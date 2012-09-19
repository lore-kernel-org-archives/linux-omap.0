From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH RESEND v7 1/5] ARM: dts: AM33XX: Add basic pinctrl device tree data
Date: Thu, 20 Sep 2012 02:49:26 +0530
Message-ID: <1348089570-16161-2-git-send-email-anilkumar@ti.com>
References: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:49390 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752072Ab2ISVUG (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 19 Sep 2012 17:20:06 -0400
In-Reply-To: <1348089570-16161-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com
Cc: b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, AnilKumar Ch <anilkumar@ti.com>

Adds basic pinctrl device tree data for AM33XX family of devices.
This patch is based on the pinctrl-single driver.

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index b4e3e47..894fec6 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -55,6 +55,15 @@
 		};
 	};
 
+	am33xx_pinmux: pinmux@44e10800 {
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

