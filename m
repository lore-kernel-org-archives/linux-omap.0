From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 6/8] ARM/dts: omap3-beagle: Enable audio support
Date: Wed, 29 Aug 2012 16:31:05 +0300
Message-ID: <1346247067-9632-7-git-send-email-peter.ujfalusi@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:50802 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753671Ab2H2NbT (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 29 Aug 2012 09:31:19 -0400
Received: by obbuo13 with SMTP id uo13so912206obb.19
        for <linux-omap@vger.kernel.org>; Wed, 29 Aug 2012 06:31:18 -0700 (PDT)
In-Reply-To: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Benoit Cousson <b-cousson@ti.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org

Add the needed sections to enable audio support on BeagleBoard when booted
with DT blob.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/omap3-beagle.dts |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/omap3-beagle.dts
index cdcb98c..28cf180 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -17,6 +17,14 @@
 		device_type = "memory";
 		reg = <0x80000000 0x20000000>; /* 512 MB */
 	};
+
+	sound {
+		compatible = "ti,omap-twl4030";
+		ti,model = "omap3beagle";
+
+		ti,mcbsp = <&mcbsp2>;
+		ti,codec = <&twl_audio>;
+	};
 };
 
 &i2c1 {
@@ -32,6 +40,12 @@
 			regulator-min-microvolt = <1800000>;
 			regulator-max-microvolt = <3000000>;
 		};
+
+		twl_audio: audio {
+			compatible = "ti,twl4030-audio";
+			codec {
+			};
+		};
 	};
 };
 
-- 
1.7.8.6

