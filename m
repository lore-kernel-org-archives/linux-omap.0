From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 6/9] ARM: dts: am33xx: Add external clock provider
Date: Wed, 6 Aug 2014 16:47:21 +0300
Message-ID: <a6888259f9508e0cc4be720a5f17a487d1d6cd0c.1407332062.git.jsarha@ti.com>
References: <cover.1407332062.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1407332062.git.jsarha@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mturquette@linaro.org, dri-devel@lists.freedesktop.org, airlied@linux.ie, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, bcousson@baylibre.com
Cc: tony@atomide.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, peter.ujfalusi@ti.com, detheridge@ti.com, zonque@gmail.com, t-kristo@ti.com, Jyri Sarha <jsarha@ti.com>
List-Id: linux-omap@vger.kernel.org

Add external clock provaider for am33xx devices.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/am33xx.dtsi |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.dtsi
index 4a4e02d..5093c64 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -92,6 +92,16 @@
 		pinctrl-single,function-mask = <0x7f>;
 	};
 
+	ext_clocks {
+		compatible = "ti,external-clocks";
+
+		ext_clocks: clocks {
+		};
+
+		ext_clockdomains: clockdomains {
+		};
+	};
+
 	/*
 	 * XXX: Use a flat representation of the AM33XX interconnect.
 	 * The real AM33XX interconnect network is quite complex. Since
-- 
1.7.9.5
