From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv11 37/49] ARM: dts: AM35xx: use DT clock data
Date: Thu, 19 Dec 2013 13:24:08 +0200
Message-ID: <1387452260-23276-38-git-send-email-t-kristo@ti.com>
References: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:42565 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753345Ab3LSL1U (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 19 Dec 2013 06:27:20 -0500
In-Reply-To: <1387452260-23276-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

AM35xx now uses the clock data from device tree. Most of the data is
shared with OMAP3xxx, but as there is some delta, a new base .dtsi
file is also created for the SoC.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
---
 arch/arm/boot/dts/am3517.dtsi |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/am3517.dtsi b/arch/arm/boot/dts/am3517.dtsi
index 2fbe02f..788391f 100644
--- a/arch/arm/boot/dts/am3517.dtsi
+++ b/arch/arm/boot/dts/am3517.dtsi
@@ -61,3 +61,6 @@
 		};
 	};
 };
+
+/include/ "am35xx-clocks.dtsi"
+/include/ "omap36xx-am35xx-omap3430es2plus-clocks.dtsi"
-- 
1.7.9.5

