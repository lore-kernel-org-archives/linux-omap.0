From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v4 05/10] ASoC: davinci-mcasp: Improve DT bindings document
Date: Tue, 8 Oct 2013 22:36:36 +0300
Message-ID: <fe59070dd71dcd40b0107ee9635fd2ba3f5d08bb.1381259962.git.jsarha@ti.com>
References: <cover.1381259962.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:37580 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755933Ab3JHTg6 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 8 Oct 2013 15:36:58 -0400
In-Reply-To: <cover.1381259962.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, broonie@kernel.org, mark.rutland@arm.com, joelf@ti.com, Jyri Sarha <jsarha@ti.com>

Makes interrupts property optional as the interrupts are not currently
used by the driver and adds interrupt-names property to name listed
interrupts. Currently know interrupt names are "tx" and "rx".

- Improve tdm-slots propery description

- Improve op-mode property description

- Add pinctrl-names and pinctrl-0 properties

- Remove #address-cells and #size-cells as they are not needed.

- Bracket named interrupts property tuples for uniformity.

- Add missing "for" to serial-dir prop in DT bindings doc.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../bindings/sound/davinci-mcasp-audio.txt         |   24 ++++++++++++--------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
index c3ccde7..ab2af66 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
@@ -11,13 +11,14 @@ Required properties:
          * "mpu" for the main registers (required). For compatibility with
            existing software, it is recommended this is the first entry.
          * "dat" for separate data port register access (optional).
-- interrupts : Interrupt number for McASP
-- op-mode : I2S/DIT ops mode.
-- tdm-slots : Slots for TDM operation.
+- op-mode : I2S/DIT ops mode. 0 for I2S mode. 1 for DIT mode used for S/PDIF,
+  	    IEC60958-1, and AES-3 formats.
+- tdm-slots : Slots for TDM operation. Indicates number of channels transmitted
+  	      or received over one serializer.
 - num-serializer : Serializers used by McASP.
-- serial-dir : A list of serializer pin mode. The list number should be equal
-		to "num-serializer" parameter. Each entry is a number indication
-		serializer pin direction. (0 - INACTIVE, 1 - TX, 2 - RX)
+- serial-dir : A list of serializer configuration. Each entry is a number
+               indication for serializer pin direction.
+               (0 - INACTIVE, 1 - TX, 2 - RX)
 - dmas: two element list of DMA controller phandles and DMA request line
         ordered pairs.
 - dma-names: identifier string for each DMA request line in the dmas property.
@@ -31,16 +32,21 @@ Optional properties:
 - rx-num-evt : FIFO levels.
 - sram-size-playback : size of sram to be allocated during playback
 - sram-size-capture  : size of sram to be allocated during capture
+- interrupts : Interrupt numbers for McASP, currently not used by the driver
+- interrupt-names : Known interrupt names are "tx" and "rx"
+- pinctrl-0: Should specify pin control group used for this controller.
+- pinctrl-names: Should contain only one value - "default", for more details
+  		 please refer to pinctrl-bindings.txt
+  
 
 Example:
 
 mcasp0: mcasp0@1d00000 {
 	compatible = "ti,da830-mcasp-audio";
-	#address-cells = <1>;
-	#size-cells = <0>;
 	reg = <0x100000 0x3000>;
 	reg-names "mpu";
-	interrupts = <82 83>;
+	interrupts = <82>, <83>;
+	interrupts-names = "tx", "rx";
 	op-mode = <0>;		/* MCASP_IIS_MODE */
 	tdm-slots = <2>;
 	num-serializer = <16>;
-- 
1.7.9.5

