From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 07/11] ARM: DTS: dra72-evm: Add fixed regulator representing DVDD supply for aic3106
Date: Mon, 24 Aug 2015 10:20:03 +0300
Message-ID: <1440400807-32274-8-git-send-email-peter.ujfalusi@ti.com>
References: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1440400807-32274-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, Tero Kristo <t-kristo@ti.com>
List-Id: linux-omap@vger.kernel.org

The DVDD is supplied via TPS77018DBVT fixed regulator from evm_3v3

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 arch/arm/boot/dts/dra72-evm.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/dra72-evm.dts b/arch/arm/boot/dts/dra72-evm.dts
index 6f6bd98c98df..ac3a29483791 100644
--- a/arch/arm/boot/dts/dra72-evm.dts
+++ b/arch/arm/boot/dts/dra72-evm.dts
@@ -30,6 +30,15 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	aic_dvdd: fixedregulator-aic_dvdd {
+		/* TPS77018DBVT */
+		compatible = "regulator-fixed";
+		regulator-name = "aic_dvdd";
+		vin-supply = <&evm_3v3>;
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+	};
+
 	evm_3v3_sd: fixedregulator-sd {
 		compatible = "regulator-fixed";
 		regulator-name = "evm_3v3_sd";
-- 
2.5.0
