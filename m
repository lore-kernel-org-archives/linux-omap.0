From: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] doc: devicetree: Add bindings documentation for omap-des driver
Date: Thu, 7 Nov 2013 18:37:09 -0600
Message-ID: <1383871035-16608-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: santosh.shilimkar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, "open list:DOCUMENTATION" <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add documentation for the generic OMAP DES crypto module describing the device
tree bindings.

Signed-off-by: Joel Fernandes <joelf-l0cyMroinI0@public.gmane.org>
---
 .../devicetree/bindings/crypto/omap-des.txt        | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/crypto/omap-des.txt

diff --git a/Documentation/devicetree/bindings/crypto/omap-des.txt b/Documentation/devicetree/bindings/crypto/omap-des.txt
new file mode 100644
index 0000000..0637647
--- /dev/null
+++ b/Documentation/devicetree/bindings/crypto/omap-des.txt
@@ -0,0 +1,28 @@
+OMAP SoC DES crypto Module
+
+Required properties:
+
+- compatible : Should be "ti,omap4-des"
+- ti,hwmods: Name of the hwmod associated with the DES module
+- reg : Offset and length of the register set for the module
+- interrupts : the interrupt-specifier for the DES module
+- clocks : phandle to the functional clock node of the DES module
+- clock-names : Name of the functional clock
+
+Optional properties:
+- dmas: DMA specifiers for tx and rx dma. See the DMA client binding,
+	Documentation/devicetree/bindings/dma/dma.txt
+- dma-names: DMA request names should include "tx" and "rx" if present
+
+Example:
+	/* DRA7xx SoC */
+	des: des@480a5000 {
+		compatible = "ti,omap4-des";
+		ti,hwmods = "des";
+		reg = <0x480a5000 0xa0>;
+		interrupts = <GIC_SPI 82 IRQ_TYPE_LEVEL_HIGH>;
+		dmas = <&sdma 117>, <&sdma 116>;
+		dma-names = "tx", "rx";
+		clocks = <&l3_iclk_div>;
+		clock-names = "fck";
+	};
-- 
1.8.1.2

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
