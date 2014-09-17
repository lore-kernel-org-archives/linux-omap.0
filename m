From: Dmitry Lifshitz <lifshitz@compulab.co.il>
Subject: [PATCH v2 2/6] ARM: dts: cm-t54: fix mux mode comment style
Date: Wed, 17 Sep 2014 15:10:04 +0300
Message-ID: <1410955808-2174-3-git-send-email-lifshitz@compulab.co.il>
References: <1410885322-5928-1-git-send-email-lifshitz@compulab.co.il>
 <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from softlayer.compulab.co.il ([50.23.254.55]:41296 "EHLO
	compulab.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416AbaIQMKT (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Wed, 17 Sep 2014 08:10:19 -0400
In-Reply-To: <1410955808-2174-1-git-send-email-lifshitz@compulab.co.il>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Dmitry Lifshitz <lifshitz@compulab.co.il>

Follow the comment style of mode0_name.modeX_name for pins
which mux mode differs from MUX_MODE0.

Signed-off-by: Dmitry Lifshitz <lifshitz@compulab.co.il>
---

 v2: New patch

 arch/arm/boot/dts/omap5-cm-t54.dts |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 429471a..44a9f23 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -127,8 +127,8 @@
 
 	wlan_gpios_pins: pinmux_wlan_gpios_pins {
 		pinctrl-single,pins = <
-			OMAP5_IOPAD(0x019c, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_109 */
-			OMAP5_IOPAD(0x019e, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* gpio4_110 */
+			OMAP5_IOPAD(0x019c, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* abemcpdm_ul_data.gpio4_109 */
+			OMAP5_IOPAD(0x019e, PIN_OUTPUT_PULLDOWN | MUX_MODE6) /* abemcpdm_dl_data.gpio4_110 */
 		>;
 	};
 
-- 
1.7.5.4

