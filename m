From: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: dts: omap5-uevm.dts: fix i2c5 pinctrl offsets
Date: Wed, 16 Sep 2015 01:34:31 +0300
Message-ID: <1442356471-13235-1-git-send-email-notasas@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The i2c5 pinctrl offsets are wrong. If the bootloader doesn't set the
pins up, communication with tca6424a doesn't work (controller timeouts)
and it is not possible to enable HDMI.

Fixes: 9be495c42609 ("ARM: dts: omap5-evm: Add I2c pinctrl data")
Signed-off-by: Grazvydas Ignotas <notasas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap5-uevm.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 3cc8f35..3cb030f 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -174,8 +174,8 @@
 
 	i2c5_pins: pinmux_i2c5_pins {
 		pinctrl-single,pins = <
-			0x184 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
-			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
+			0x186 (PIN_INPUT | MUX_MODE0)		/* i2c5_scl */
+			0x188 (PIN_INPUT | MUX_MODE0)		/* i2c5_sda */
 		>;
 	};
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
