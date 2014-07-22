From: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Subject: [PATCH v2 4/7] arm: dts: omap3-gta04: Move spi gpio pins to pmx_core2
Date: Tue, 22 Jul 2014 21:30:17 +0200
Message-ID: <1406057420-22269-5-git-send-email-marek@goldelico.com>
References: <1406057420-22269-1-git-send-email-marek@goldelico.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1406057420-22269-1-git-send-email-marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hns-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org, Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Because of commit: 3d495383648a7cda3ea51a1e2fa5d288581479aa
spi_gpio_pins node isn't valid anymore. Move to pmx_core2 node.

Signed-off-by: Marek Belisko <marek-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-gta04.dts | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-gta04.dts b/arch/arm/boot/dts/omap3-gta04.dts
index 5b08d93..4ca1277 100644
--- a/arch/arm/boot/dts/omap3-gta04.dts
+++ b/arch/arm/boot/dts/omap3-gta04.dts
@@ -141,12 +141,15 @@
                        0x0da (PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
                >;
        };
+};
 
+&omap3_pmx_core2 {
 	spi_gpio_pins: spi_gpio_pinmux {
-		pinctrl-single,pins = <0x5a8 (PIN_OUTPUT | MUX_MODE4) /* clk */
-			0x5b6 (PIN_OUTPUT | MUX_MODE4) /* cs */
-			0x5b8 (PIN_OUTPUT | MUX_MODE4) /* tx */
-			0x5b4 (PIN_INPUT | MUX_MODE4) /* rx */
+		pinctrl-single,pins = <
+			OMAP3630_CORE2_IOPAD(0x25d8, PIN_OUTPUT | MUX_MODE4) /* clk */
+			OMAP3630_CORE2_IOPAD(0x25e6, PIN_OUTPUT | MUX_MODE4) /* cs */
+			OMAP3630_CORE2_IOPAD(0x25e8, PIN_OUTPUT | MUX_MODE4) /* tx */
+			OMAP3630_CORE2_IOPAD(0x25e4, PIN_INPUT | MUX_MODE4) /* rx */
 		>;
 	};
 };
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
