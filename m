From: Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 3/8] ARM: dts: motorola-cpcap-mapphone: add rtc
Date: Thu,  2 Mar 2017 02:08:55 +0100
Message-ID: <20170302010900.28532-4-sre@kernel.org>
References: <20170302010900.28532-1-sre@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170302010900.28532-1-sre@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Tony Lindgren <tony@atomide.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
index b7e12463016e..34fb93ba5966 100644
--- a/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
+++ b/arch/arm/boot/dts/motorola-cpcap-mapphone.dtsi
@@ -25,6 +25,13 @@
 			cpcap_regulators: regulators {
 			};
 		};
+
+		cpcap_rtc: rtc {
+			compatible = "motorola,cpcap-rtc";
+
+			interrupt-parent = <&cpcap>;
+			interrupts = <39 IRQ_TYPE_NONE>, <26 IRQ_TYPE_NONE>;
+		};
 	};
 };
 
-- 
2.11.0
