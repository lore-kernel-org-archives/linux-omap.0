From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] ARM: dts: am335x-boneblue: fix wl1835 IRQ pin
Date: Tue, 19 Dec 2017 16:32:40 -0600
Message-ID: <20171219223242.21386-1-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Use the correct IRQ gpio pin on the BeagleBone Blue to allow the
wl1835 wireless module to actually work.

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
CC: Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
CC: Drew Fustini <drew-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>
CC: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/am335x-boneblue.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-boneblue.dts b/arch/arm/boot/dts/am335x-boneblue.dts
index d5be9fc4f416..c5820919e709 100644
--- a/arch/arm/boot/dts/am335x-boneblue.dts
+++ b/arch/arm/boot/dts/am335x-boneblue.dts
@@ -216,7 +216,7 @@
 	wl18xx_pins: pinmux_wl18xx_pins {
 		pinctrl-single,pins = <
 			AM33XX_IOPAD(0x92c, PIN_OUTPUT_PULLDOWN | MUX_MODE7)	/* (K18) gmii1_txclk.gpio3[9] - WL_EN */
-			AM33XX_IOPAD(0x944, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* (H18) rmii1_refclk.gpio0[29] - WL_IRQ */
+			AM33XX_IOPAD(0x924, PIN_INPUT_PULLDOWN | MUX_MODE7)	/* (K16) gmii1_txd1.gpio0[21] - WL_IRQ */
 			AM33XX_IOPAD(0x930, PIN_OUTPUT_PULLUP | MUX_MODE7)	/* (L18) gmii1_rxclk.gpio3[10] - LS_BUF_EN */
 		>;
 	};
@@ -414,7 +414,7 @@
 		compatible = "ti,wl1835";
 		reg = <2>;
 		interrupt-parent = <&gpio0>;
-		interrupts = <29 IRQ_TYPE_EDGE_RISING>;
+		interrupts = <21 IRQ_TYPE_EDGE_RISING>;
 	};
 };
 
-- 
2.15.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
