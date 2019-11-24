From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v3 8/8] MIPS: DTS: jz4780: add sgx gpu node
Date: Sun, 24 Nov 2019 12:40:28 +0100
Message-ID: <c73e2cee4f818654f264b0b7b5458bfaa0ac6a7a.1574595627.git.hns@goldelico.com>
References: <cover.1574595627.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1574595627.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Paul Cercueil <paul@crapouillou.net>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, openpvrsgx-devgroup@letux.org, letux-kernel@openphoenux.org, kernel@pyra-handheld.com, linux-mips@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>, Paul Boddie <paul@boddie.org.uk>
List-Id: linux-omap@vger.kernel.org

and add interrupt and clocks.

Tested to build for CI20 board and load a (non-working) driver.

Suggested-by: Paul Boddie <paul@boddie.org.uk>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/mips/boot/dts/ingenic/jz4780.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
index c54bd7cfec55..21ea5f4a405b 100644
--- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
+++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
@@ -46,6 +46,17 @@
 		#clock-cells = <1>;
 	};
 
+	gpu: gpu@13040000 {
+		compatible = "ingenic,jz4780-sgx540-120", "img,sgx540-120", "img,sgx540", "img,sgx5";
+		reg = <0x13040000 0x4000>;
+
+		clocks = <&cgu JZ4780_CLK_GPU>;
+		clock-names = "gpu";
+
+		interrupt-parent = <&intc>;
+		interrupts = <63>;
+	};
+
 	tcu: timer@10002000 {
 		compatible = "ingenic,jz4780-tcu",
 			     "ingenic,jz4770-tcu",
-- 
2.23.0
