From: Matt Porter <mporter@konsulko.com>
Subject: [PATCH RESEND] serial: omap_serial: document missing properties and add an example
Date: Fri,  6 Mar 2015 10:16:12 -0500
Message-ID: <1425654972-8044-1-git-send-email-mporter@konsulko.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Devicetree List <devicetree@vger.kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

The omap_serial.txt binding documentation lacks a number of properties
that are used in DTS files for platforms incorporating this peripheral.
Fix this by documenting the missing required and optional fields and
add an example.

Signed-off-by: Matt Porter <mporter@konsulko.com>
---
 .../devicetree/bindings/serial/omap_serial.txt       | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
index 342eedd..54c2a15 100644
--- a/Documentation/devicetree/bindings/serial/omap_serial.txt
+++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
@@ -4,7 +4,27 @@ Required properties:
 - compatible : should be "ti,omap2-uart" for OMAP2 controllers
 - compatible : should be "ti,omap3-uart" for OMAP3 controllers
 - compatible : should be "ti,omap4-uart" for OMAP4 controllers
+- reg : address and length of the register space
+- interrupts or interrupts-extended : Should contain the uart interrupt
+                                      specifier or both the interrupt
+                                      controller phandle and interrupt
+                                      specifier.
 - ti,hwmods : Must be "uart<n>", n being the instance number (1-based)
 
 Optional properties:
 - clock-frequency : frequency of the clock input to the UART
+- dmas : DMA specifier, consisting of a phandle to the DMA controller
+         node and a DMA channel number.
+- dma-names : "rx" for receive channel, "tx" for transmit channel.
+
+Example:
+
+                uart4: serial@49042000 {
+                        compatible = "ti,omap3-uart";
+                        reg = <0x49042000 0x400>;
+                        interrupts = <80>;
+                        dmas = <&sdma 81 &sdma 82>;
+                        dma-names = "tx", "rx";
+                        ti,hwmods = "uart4";
+                        clock-frequency = <48000000>;
+                };
-- 
1.8.4
