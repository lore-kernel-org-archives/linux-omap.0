From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Switch UART mux pins
Date: Thu, 9 Apr 2015 17:33:16 -0500
Message-ID: <1428618797-17190-2-git-send-email-nm@ti.com>
References: <1428618797-17190-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428618797-17190-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

BeagleBoard-X15 pre-production change includes switching over to UART
pins that now allow for UART download capability. All original boards
should either have been returned for modifications or already modified
for the required change and maintaining compatibility for older boards
are no longer needed.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 15f198e4864d..cea3be3a051c 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -130,8 +130,8 @@
 
 	uart3_pins_default: uart3_pins_default {
 		pinctrl-single,pins = <
-			0x248 (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_rxd.rxd */
-			0x24c (PIN_INPUT_SLEW | MUX_MODE0) /* uart3_txd.txd */
+			0x3f8 (PIN_INPUT_SLEW | MUX_MODE2) /* uart2_ctsn.uart3_rxd */
+			0x3fc (PIN_INPUT_SLEW | MUX_MODE1) /* uart2_rtsn.uart3_txd */
 		>;
 	};
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
