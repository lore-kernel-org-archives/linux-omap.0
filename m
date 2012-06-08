From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 5/7] arm/dts: omap4-sdp: Enable audio support via device tree
Date: Fri,  8 Jun 2012 17:02:03 +0300
Message-ID: <1339164125-32534-6-git-send-email-peter.ujfalusi@ti.com>
References: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog112.obsmtp.com ([74.125.149.207]:40967 "EHLO
	na3sys009aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757218Ab2FHOCf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 8 Jun 2012 10:02:35 -0400
Received: by lbbgm6 with SMTP id gm6so1619270lbb.5
        for <linux-omap@vger.kernel.org>; Fri, 08 Jun 2012 07:02:32 -0700 (PDT)
In-Reply-To: <1339164125-32534-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Grant Likely <grant.likely@secretlab.ca>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-omap@vger.kernel.org, Rajendra Nayak <rnayak@ti.com>, Liam Girdwood <lrg@ti.com>

On OMAP4 SDP the audio setup includes the twl6040 codec and digital
microphones.

Since OMAP4 SDP is a reference board it has all possible audio interfaces
connected. This information is passed via the ti,audio-routing
property.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap4-sdp.dts |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap4-sdp.dts b/arch/arm/boot/dts/omap4-sdp.dts
index f09d1f5..964f8ec 100644
--- a/arch/arm/boot/dts/omap4-sdp.dts
+++ b/arch/arm/boot/dts/omap4-sdp.dts
@@ -88,6 +88,41 @@
 			gpios = <&gpio5 11 0>; /* 139 */
 		};
 	};
+
+	sound {
+		compatible = "ti,abe-twl6040";
+		ti,model = "SDP4430";
+
+		ti,jack-detection = <1>;
+		ti,mclk-freq = <38400000>;
+
+		ti,mcpdm = <&mcpdm>;
+		ti,dmic = <&dmic>;
+
+		ti,twl6040 = <&twl6040>;
+
+		/* Audio routing */
+		ti,audio-routing =
+			"Headset Stereophone", "HSOL",
+			"Headset Stereophone", "HSOR",
+			"Earphone Spk", "EP",
+			"Ext Spk", "HFL",
+			"Ext Spk", "HFR",
+			"Line Out", "AUXL",
+			"Line Out", "AUXR",
+			"Vibrator", "VIBRAL",
+			"Vibrator", "VIBRAR",
+			"HSMIC", "Headset Mic",
+			"Headset Mic", "Headset Mic Bias",
+			"MAINMIC", "Main Handset Mic",
+			"Main Handset Mic", "Main Mic Bias",
+			"SUBMIC", "Sub Handset Mic",
+			"Sub Handset Mic", "Main Mic Bias",
+			"AFML", "Line In",
+			"AFMR", "Line In",
+			"DMic", "Digital Mic",
+			"Digital Mic", "Digital Mic1 Bias";
+	};
 };
 
 &i2c1 {
-- 
1.7.8.6

