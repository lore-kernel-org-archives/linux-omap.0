From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 1/5] ARM: dts: twl6030: describe gpadc
Date: Mon, 18 Apr 2016 20:20:57 +0200
Message-ID: <279e70c9badea0356944093f9493e09922c6974b.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
In-Reply-To: <cover.1461003660.git.hns@goldelico.com>
References: <cover.1461003660.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>
Cc: ldewangan@nvidia.com, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, marek@goldelico.com, kernel@pyra-handheld.com, letux-kernel@openphoenux.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

tested on Pandaboard ES.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/twl6030.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/twl6030.dtsi b/arch/arm/boot/dts/twl6030.dtsi
index 55eb35f..c45f97f 100644
--- a/arch/arm/boot/dts/twl6030.dtsi
+++ b/arch/arm/boot/dts/twl6030.dtsi
@@ -99,4 +99,10 @@
 		compatible = "ti,twl6030-pwmled";
 		#pwm-cells = <2>;
 	};
+
+	gpadc {
+		compatible = "ti,twl6030-gpadc";
+		interrupts = <3>;
+		#io-channel-cells = <1>;
+	};
 };
-- 
2.7.3
