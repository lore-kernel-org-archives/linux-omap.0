From: David Lechner <david@lechnology.com>
Subject: [PATCH 8/8] ARM: dts: am33xx: add node for PRU remoteproc
Date: Sat, 23 Jun 2018 16:08:10 -0500
Message-ID: <20180623210810.21232-9-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds a new node to am33xx.dtsi for binding the PRUSS as a
remoteproc device.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/boot/dts/am33xx.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 9cd62bc2ca35..1e7837af4689 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -924,6 +924,15 @@
 			};
 		};
 
+		pru_rproc: cpu@4a300000 {
+			compatible = "ti,am3352-pru-rproc";
+			reg = <0x4a300000 0x80000>;
+			interrupts = <20>, <21>;
+			interrupt-names = "pru0-vq", "pru1-vq";
+			ti,hwmods = "pruss";
+			status = "disabled";
+		};
+
 		elm: elm@48080000 {
 			compatible = "ti,am3352-elm";
 			reg = <0x48080000 0x2000>;
-- 
2.17.1
