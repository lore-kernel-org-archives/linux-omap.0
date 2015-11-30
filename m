From: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Subject: [PATCH v2 04/18] ARM: am57xx: cl-som-am57x: dts: add EEPROM support
Date: Mon, 30 Nov 2015 16:33:57 +0200
Message-ID: <1448894037-1337-1-git-send-email-lifshitz@compulab.co.il>
References: <1448433590-1399-5-git-send-email-lifshitz@compulab.co.il>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448433590-1399-5-git-send-email-lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Toni Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Igor Grinberg <grinberg-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Nikita Kiryanov <nikita-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On-board EEPROM chip is used for storing a board production
info.

Add module EEPROM support (over I2C4 bus).

Signed-off-by: Dmitry Lifshitz <lifshitz-UTxiZqZC01RS1MOuV/RT9w@public.gmane.org>
---

  v2:

   * Fix EEPROM chip model

 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 9f15dda..695f250 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -290,6 +290,12 @@
 		compatible = "emmicro,em3027";
 		reg = <0x56>;
 	};
+
+	eeprom_module: atmel@50 {
+		compatible = "atmel,24c08";
+		reg = <0x50>;
+		pagesize = <16>;
+	};
 };
 
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
