From: Jyri Sarha <jsarha@ti.com>
Subject: [PATCH 15/19] ARM: omap5.dtsi: Add audio related parameters to hdmi node
Date: Mon, 12 May 2014 12:12:26 +0300
Message-ID: <3e3b77eae539bfb78db12edc1e942d3ceea01a40.1399884780.git.jsarha@ti.com>
References: <cover.1399884780.git.jsarha@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:44761 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754515AbaELJNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 12 May 2014 05:13:09 -0400
In-Reply-To: <cover.1399884780.git.jsarha@ti.com>
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
index b2a28e6..bac7d8e 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -931,6 +931,8 @@
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

