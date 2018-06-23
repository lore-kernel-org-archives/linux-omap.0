From: David Lechner <david@lechnology.com>
Subject: [PATCH 7/8] ARM: dts: da850: add node for PRUSS
Date: Sat, 23 Jun 2018 16:08:09 -0500
Message-ID: <20180623210810.21232-8-david@lechnology.com>
References: <20180623210810.21232-1-david@lechnology.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180623210810.21232-1-david@lechnology.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: David Lechner <david@lechnology.com>, Ohad Ben-Cohen <ohad@wizery.com>, Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

This adds a new remoteproc node to the da850 device tree for the PRUSS.

Signed-off-by: David Lechner <david@lechnology.com>
---

Note: this requires the recent common-clk patches for power-domains

 arch/arm/boot/dts/da850.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3fc8b8fd816e..8b052e96fb53 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -540,6 +540,14 @@
 			clocks = <&pll0_auxclk>;
 			status = "disabled";
 		};
+		pru_rproc: cpu@30000 {
+			compatible = "ti,da850-pru-rproc";
+			reg = <0x30000 0x10000>;
+			interrupts = <3>, <4>;
+			interrupt-names = "pru0-vq", "pru1-vq";
+			power-domains = <&psc0 13>;
+			status = "disabled";
+		};
 		mmc0: mmc@40000 {
 			compatible = "ti,da830-mmc";
 			reg = <0x40000 0x1000>;
-- 
2.17.1
