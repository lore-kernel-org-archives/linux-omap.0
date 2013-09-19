From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH v3 07/11] ASoC: tlv320aic3x: Add regulators to DT bindings document
Date: Thu, 19 Sep 2013 14:29:40 +0300
Message-ID: <1b88bfa3793d807ff6e325df1bbff6cb4eb976e6.1379590036.git.jsarha@ti.com>
References: <cover.1379590035.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:54139 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab3ISLa1 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 19 Sep 2013 07:30:27 -0400
In-Reply-To: <cover.1379590035.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: linux-omap@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, grant.likely@linaro.org, rob.herring@calxeda.com, joelf@ti.com, Jyri Sarha <jsarha@ti.com>

Add regulator properties to tlv320aic3x DT bindings document.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 .../devicetree/bindings/sound/tlv320aic3x.txt      |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
index f47c3f5..11e24b2 100644
--- a/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
+++ b/Documentation/devicetree/bindings/sound/tlv320aic3x.txt
@@ -17,10 +17,17 @@ Optional properties:
 	3 - MICBIAS output is connected to AVDD,
 	If this node is not mentioned or if the value is incorrect, then MicBias
 	is powered down.
+- AVDD-supply, IOVDD-supply, DRVDD-supply, DVDD-supply : power supplies for the
+  device as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
 Example:
 
 tlv320aic3x: tlv320aic3x@1b {
 	compatible = "ti,tlv320aic3x";
 	reg = <0x1b>;
+
+	AVDD-supply = <&regulator>;
+	IOVDD-supply = <&regulator>;
+	DRVDD-supply = <&regulator>;
+	DVDD-supply = <&regulator>;
 };
-- 
1.7.9.5

