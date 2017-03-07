From: Franklin S Cooper Jr <fcooper@ti.com>
Subject: [PATCH 2/2] ARM: dts: am335x-icev2: Add SPI based NOR
Date: Tue, 7 Mar 2017 15:57:51 -0600
Message-ID: <20170307215751.29266-3-fcooper@ti.com>
References: <20170307215751.29266-1-fcooper@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170307215751.29266-1-fcooper@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mtd@lists.infradead.org, tony@atomide.com, robh+dt@kernel.org
Cc: Franklin S Cooper Jr <fcooper@ti.com>, Sekhar Nori <nsekhar@ti.com>
List-Id: linux-omap@vger.kernel.org

Enable support for W25Q64CVSSIG which is a Winbond 64 Mbit SPI NOR.

At boot you will see the following message:
m25p80 spi1.0: found s25fl064k, expected w25q64

This is because the JEDEC ID for this chip is the same as s25fl064k.
However, this should be harmless since both chips are essentially the
same.

Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 arch/arm/boot/dts/am335x-icev2.dts | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-icev2.dts b/arch/arm/boot/dts/am335x-icev2.dts
index a2ad076..1e643dc 100644
--- a/arch/arm/boot/dts/am335x-icev2.dts
+++ b/arch/arm/boot/dts/am335x-icev2.dts
@@ -245,6 +245,39 @@
 		spi-max-frequency = <1000000>;
 		spi-cpol;
 	};
+
+	spi_nor: flash@0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "winbond,w25q64", "jedec,spi-nor";
+		spi-max-frequency = <80000000>;
+		m25p,fast-read;
+		reg = <0>;
+
+		partition@0 {
+			label = "u-boot-spl";
+			reg = <0x0 0x80000>;
+			read-only;
+		};
+
+		partition@1 {
+			label = "u-boot";
+			reg = <0x80000 0x100000>;
+			read-only;
+		};
+
+		partition@2 {
+			label = "u-boot-env";
+			reg = <0x180000 0x20000>;
+			read-only;
+		};
+
+		partition@3 {
+			label = "misc";
+			reg = <0x1A0000 0x660000>;
+		};
+	};
+
 };
 
 &tscadc {
-- 
2.10.0
