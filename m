From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Subject: [PATCH] ARM: dts: am335x-phycore-som: fix rv4162 compatible
Date: Wed, 19 Apr 2017 22:30:12 +0200
Message-ID: <20170419203012.8158-1-alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>, Teresa Remmet <t.remmet@phytec.de>
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>
List-Id: linux-omap@vger.kernel.org

The rv4162 compatbile string is missing the vendor part, add it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/am335x-phycore-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-phycore-som.dtsi b/arch/arm/boot/dts/am335x-phycore-som.dtsi
index 14533ff6d0ad..428a25e952b0 100644
--- a/arch/arm/boot/dts/am335x-phycore-som.dtsi
+++ b/arch/arm/boot/dts/am335x-phycore-som.dtsi
@@ -138,7 +138,7 @@
 	};
 
 	i2c_rtc: rtc@68 {
-		compatible = "rv4162";
+		compatible = "microcrystal,rv4162";
 		reg = <0x68>;
 		status = "disabled";
 	};
-- 
2.11.0
