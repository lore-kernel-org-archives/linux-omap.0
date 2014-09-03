From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: [PATCH] ARM: dts: am437x-gp: switch i2c0 to 100KHz
Date: Wed, 3 Sep 2014 13:46:21 -0500
Message-ID: <1409769981-17669-1-git-send-email-nm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On the GP EVM, the ambient light sensor is limited to 100KHz on the
I2C bus.

So use 100kHz for I2C on the GP EVM due to this limitation on the
ambient light sensor.

Reported-by: Aparna Balasubramanian <aparnab-l0cyMroinI0@public.gmane.org>
Signed-off-by: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
---
based on v3.17-rc1

 arch/arm/boot/dts/am437x-gp-evm.dts |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am437x-gp-evm.dts b/arch/arm/boot/dts/am437x-gp-evm.dts
index 646a6ea..9559c19 100644
--- a/arch/arm/boot/dts/am437x-gp-evm.dts
+++ b/arch/arm/boot/dts/am437x-gp-evm.dts
@@ -260,7 +260,7 @@
 	status = "okay";
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins>;
-	clock-frequency = <400000>;
+	clock-frequency = <100000>;
 
 	tps65218: tps65218@24 {
 		reg = <0x24>;
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
