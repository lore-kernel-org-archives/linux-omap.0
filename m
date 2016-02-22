From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 1/2] ARM: dts: am57xx-beagle-x15: Add eeprom information
Date: Mon, 22 Feb 2016 10:51:07 -0600
Message-ID: <1456159868-32416-2-git-send-email-nm@ti.com>
References: <1456159868-32416-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456159868-32416-1-git-send-email-nm-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Add EEPROM at 0x50 that describes the board configuration.
This is useful for userspace programs that may need to check board
revision and other similar information.

Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
 arch/arm/boot/dts/am57xx-beagle-x15.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/am57xx-beagle-x15.dts b/arch/arm/boot/dts/am57xx-beagle-x15.dts
index 36c0fa6c362a..50312f80b972 100644
--- a/arch/arm/boot/dts/am57xx-beagle-x15.dts
+++ b/arch/arm/boot/dts/am57xx-beagle-x15.dts
@@ -591,6 +591,11 @@
 		DRVDD-supply = <&vdd_3v3>;
 		DVDD-supply = <&aic_dvdd>;
 	};
+
+	eeprom: eeprom@50 {
+		compatible = "at,24c32";
+		reg = <0x50>;
+	};
 };
 
 &i2c3 {
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
