From: "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH 1/2] DTS: ARM: gta04: define chosen/stdout-path
Date: Mon,  8 Jul 2019 16:46:04 +0200
Message-ID: <21ed570c5920346bf9dc1284c8dfee2e6ef79a51.1562597164.git.hns@goldelico.com>
References: <cover.1562597164.git.hns@goldelico.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1562597164.git.hns@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>
Cc: letux-kernel@openphoenux.org, linux-spi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, "H. Nikolaus Schaller" <hns@goldelico.com>
List-Id: linux-omap@vger.kernel.org

This allows to remove the console= entry in the kernel command line.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 arch/arm/boot/dts/omap3-gta04.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 6473d8dfadc0..9a9a29fe88ec 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -24,6 +24,10 @@
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
 
+	chosen {
+		stdout-path = &uart3;
+	};
+
 	aliases {
 		display0 = &lcd;
 		display1 = &tv0;
-- 
2.19.1
