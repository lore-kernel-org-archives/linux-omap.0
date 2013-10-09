From: Tero Kristo <t-kristo@ti.com>
Subject: [PATCHv8 23/36] ARM: dts: DRA7: link in clock DT data
Date: Wed, 9 Oct 2013 18:30:54 +0300
Message-ID: <1381332668-962-24-git-send-email-t-kristo@ti.com>
References: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:40096 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755376Ab3JIPeK (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Wed, 9 Oct 2013 11:34:10 -0400
In-Reply-To: <1381332668-962-1-git-send-email-t-kristo@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, paul@pwsan.com, tony@atomide.com, nm@ti.com, rnayak@ti.com, bcousson@baylibre.com, mturquette@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org

Clock tree DT data is now included from base dra7.dtsi file.

Signed-off-by: Tero Kristo <t-kristo@ti.com>
Tested-by: Nishanth Menon <nm@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/boot/dts/dra7.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index c01ef76..c98997b 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -572,4 +572,18 @@
 			status = "disabled";
 		};
 	};
+
+	clocks {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		/include/ "dra7xx-clocks.dtsi"
+	};
+
+	clockdomains {
+		coreaon_clkdm: coreaon_clkdm {
+			compatible = "ti,clockdomain";
+			clocks = <&dpll_usb_ck>;
+		};
+	};
 };
-- 
1.7.9.5

