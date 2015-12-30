From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH 5/6] ARM: dts: am57xx: cl-som-am57x: fix CPSW EMAC pinmux
Date: Wed, 30 Dec 2015 15:39:04 +0200
Message-ID: <1451482745-1820-6-git-send-email-lifshitz@compulab.co.il>
References: <1451482745-1820-1-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1451482745-1820-1-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Fix CPSW EMAC pinmux

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index cb9a518..9e0153a 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -167,7 +167,7 @@
 			DRA7XX_CORE_IOPAD(0x35b8, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d20.rgmii1_rd3 */
 			DRA7XX_CORE_IOPAD(0x35bc, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d21.rgmii1_rd2 */
 			DRA7XX_CORE_IOPAD(0x35c0, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d22.rgmii1_rd1 */
-			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT_PULLUP | MUX_MODE3)	/* vin2a_d23.rgmii1_rd0 */
+			DRA7XX_CORE_IOPAD(0x35c4, PIN_INPUT_PULLDOWN | MUX_MODE3) /* vin2a_d23.rgmii1_rd0 */
 		>;
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
