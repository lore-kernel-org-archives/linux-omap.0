From: Stefan Roese <sr@denx.de>
Subject: [PATCH 5/5] ASoC: omap: Add DT bindings documentation for HA DSP audio driver
Date: Mon, 28 Apr 2014 14:17:56 +0200
Message-ID: <1398687476-10829-5-git-send-email-sr@denx.de>
References: <1398687476-10829-1-git-send-email-sr@denx.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mo4-p05-ob.smtp.rzone.de ([81.169.146.181]:53676 "EHLO
	mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450AbaD1MYI (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 28 Apr 2014 08:24:08 -0400
In-Reply-To: <1398687476-10829-1-git-send-email-sr@denx.de>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
Cc: broonie@kernel.org, Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Thorsten Eisbein <thorsten.eisbein@head-acoustics.de>
---
 .../devicetree/bindings/sound/omap3-ha.txt         | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/omap3-ha.txt

diff --git a/Documentation/devicetree/bindings/sound/omap3-ha.txt b/Documentation/devicetree/bindings/sound/omap3-ha.txt
new file mode 100644
index 0000000..09eccda
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/omap3-ha.txt
@@ -0,0 +1,27 @@
+OMAP3 HA (HEAD acoustics) audio controller
+
+Required properties:
+- compatible: "ha,ha-dsp-card" for OMAP3-HA board (TAO3530 based)
+- ti,model: Name of the sound card (for example "omap3-ha")
+- ti,mcbsp: phandle for the McBSP node
+- ti,codec: phandle for the twl4030 audio node
+- gpios: GPIO used to sync the clock for playback and record
+
+Optional properties:
+- ha_dsp_codec_slave:
+  Add this property to test the codec in slave mode or without actual codec.
+  This makes it possible to test this driver by letting the OMAP be the DAI
+  link master.
+
+Example:
+sound2 {
+	compatible = "ha,ha-dsp-card";
+	ti,model = "omap3-ha";
+
+	/* McBSP3 is used for HA-DSP */
+	ti,mcbsp = <&mcbsp3>;
+	ti,codec = <&soc_audio>;
+
+	/* GPIO to sync the clock for playback and record */
+	gpios = <&gpio2 12 GPIO_ACTIVE_LOW>;	/* GPIO 44 */
+};
-- 
1.9.1

