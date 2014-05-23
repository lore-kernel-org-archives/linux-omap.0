From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 02/13] ARM: omap5.dtsi: Add audio related parameters to hdmi node
Date: Fri, 23 May 2014 22:07:51 +0300
Message-ID: <4f3d2792c307c1fd4bcdf03090957aef57e101ad.1400871999.git.jsarha@ti.com>
References: <cover.1400871999.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:55981 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751589AbaEWTI2 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 23 May 2014 15:08:28 -0400
In-Reply-To: <cover.1400871999.git.jsarha@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: alsa-devel@alsa-project.org, linux-fbdev@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Cc: peter.ujfalusi@ti.com, broonie@kernel.org, liam.r.girdwood@linux.intel.com, bcousson@baylibre.com, tomi.valkeinen@ti.com, detheridge@ti.com, Jyri Sarha <jsarha@ti.com>

Adds HDMI audio sDMA properties.

Signed-off-by: Jyri Sarha <jsarha@ti.com>
---
 arch/arm/boot/dts/omap5.dtsi |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dtsi
index 32c02ce..279a9c7 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -937,6 +937,8 @@
 				ti,hwmods = "dss_hdmi";
 				clocks = <&dss_48mhz_clk>, <&dss_sys_clk>;
 				clock-names = "fck", "sys_clk";
+				dmas = <&sdma 76>;
+				dma-names = "audio_tx";
 			};
 		};
 	};
-- 
1.7.9.5

