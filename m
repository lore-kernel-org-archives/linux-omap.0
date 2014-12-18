From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Subject: [PATCH 2/5] ARM: dts: am4372: add VPFE DT node entries
Date: Thu, 18 Dec 2014 21:54:11 +0530
Message-ID: <1418919854-16164-3-git-send-email-prabhakar.csengg@gmail.com>
References: <1418919854-16164-1-git-send-email-prabhakar.csengg@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418919854-16164-1-git-send-email-prabhakar.csengg@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Russell King <linux@arm.linux.org.uk>, Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, LAK <linux-arm-kernel@lists.infradead.org>, OMAP <linux-omap@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
List-Id: linux-omap@vger.kernel.org

From: Benoit Parrot <bparrot@ti.com>

Add Video Processing Front End (VPFE) device tree
nodes for AM34xx family of devices.

Signed-off-by: Benoit Parrot <bparrot@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 arch/arm/boot/dts/am4372.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 46660ff..dbd52fd 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -896,6 +896,22 @@
 			compatible = "mmio-sram";
 			reg = <0x40300000 0x40000>; /* 256k */
 		};
+
+		vpfe0: vpfe@48326000 {
+			compatible = "ti,am437x-vpfe";
+			reg = <0x48326000 0x2000>;
+			interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "vpfe0";
+			status = "disabled";
+		};
+
+		vpfe1: vpfe@48328000 {
+			compatible = "ti,am437x-vpfe";
+			reg = <0x48328000 0x2000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>;
+			ti,hwmods = "vpfe1";
+			status = "disabled";
+		};
 	};
 };
 
-- 
1.9.1
