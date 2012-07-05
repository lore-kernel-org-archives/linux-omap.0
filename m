From: AnilKumar Ch <anilkumar@ti.com>
Subject: [PATCH 1/2] arm/dts: Add AM33XX basic pinctrl support
Date: Thu, 5 Jul 2012 14:43:35 +0530
Message-ID: <1341479616-18630-2-git-send-email-anilkumar@ti.com>
References: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:47156 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335Ab2GEJOH (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 5 Jul 2012 05:14:07 -0400
In-Reply-To: <1341479616-18630-1-git-send-email-anilkumar@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: tony@atomide.com, b-cousson@ti.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, grant.likely@secretlab.ca, AnilKumar Ch <anilkumar@ti.com>

Adds basic pinctrl support for AM33XX family of devices. This patch
is based on the pinctrl-simple driver submitted by Tony Lindgren's
here: http://lwn.net/Articles/496075/

Signed-off-by: AnilKumar Ch <anilkumar@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 59509c4..85def31 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -40,6 +40,18 @@
 		};
 	};
 
+	am3358_pinmux: pinmux@44E10800 {
+		compatible = "ti,omap4-padconf";
+		reg = <0x44E10800 0x0338>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+		#pinctrl-cells = <2>;
+		pinctrl-simple,register-width = <32>;
+		pinctrl-simple,function-mask = <0x7>;
+		pinctrl-simple,function-off = <0xffffffff>;
+		pinctrl-simple,pinconf-mask = <0x78>;
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex.Since
-- 
1.7.9.5

