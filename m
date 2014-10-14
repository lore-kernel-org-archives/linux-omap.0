From: Felipe Balbi <balbi@ti.com>
Subject: [PATCH 3/3] arm: boot: dts: am437x-sk: fix lcd enable pin mux data
Date: Tue, 14 Oct 2014 13:28:55 -0500
Message-ID: <1413311335-25083-3-git-send-email-balbi@ti.com>
References: <1413311335-25083-1-git-send-email-balbi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:46846 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753601AbaJNS33 (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 14 Oct 2014 14:29:29 -0400
In-Reply-To: <1413311335-25083-1-git-send-email-balbi@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Benoit Cousson <bcousson@baylibre.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, linux-fbdev@vger.kernel.org, Darren Etheridge <detheridge@ti.com>, Felipe Balbi <balbi@ti.com>

Caused by a copy & paste error. Note that even with
this bug AM437x SK display still works because GPIO
mux mode is always enabled. It's still wrong to mux
somebody else's pin.

Luckily ball D25 (offset 0x238 - gpio5_8) on AM437x
isn't used for anything.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---
 arch/arm/boot/dts/am437x-sk-evm.dts | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
index 859ff3d..681be00 100644
--- a/arch/arm/boot/dts/am437x-sk-evm.dts
+++ b/arch/arm/boot/dts/am437x-sk-evm.dts
@@ -320,8 +320,7 @@
 
 	lcd_pins: lcd_pins {
 		pinctrl-single,pins = <
-			/* GPIO 5_8 to select LCD / HDMI */
-			0x238 (PIN_OUTPUT_PULLUP | MUX_MODE7)
+			0x1c (PIN_OUTPUT_PULLUP | MUX_MODE7) /* gpcm_ad7.gpio1_7 */
 		>;
 	};
 };
-- 
2.1.0.GIT

