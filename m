From: robertcnelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ARM: dts: omap3-beagle-xm: enable pullup for dvi on twl_gpio
Date: Fri, 20 Sep 2013 14:52:16 -0500
Message-ID: <1379706736-4041-1-git-send-email-robertcnelson@gmail.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

From: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

This fixes some video sync issues seen with KVM equipment on bootup, with
omapdrm/kms by making sure the TFP410 is powered up, via pulling up GPIO2 on
the twl4030.

https://groups.google.com/d/msg/beagleboard/Wk9SLuw-EvY/oCxJcAHufAMJ

Signed-off-by: Robert Nelson <robertcnelson-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/boot/dts/omap3-beagle-xm.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/omap3-beagle-xm.dts
index 0c514dc..c48778f 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -131,14 +131,14 @@
 
 &twl_gpio {
 	ti,use-leds;
-	/* pullups: BIT(1) */
-	ti,pullups = <0x000002>;
+	/* pullups: BIT(1), BIT(2) */
+	ti,pullups = <0x000006>;
 	/*
 	 * pulldowns:
-	 * BIT(2), BIT(6), BIT(7), BIT(8), BIT(13)
+	 * BIT(6), BIT(7), BIT(8), BIT(13)
 	 * BIT(15), BIT(16), BIT(17)
 	 */
-	ti,pulldowns = <0x03a1c4>;
+	ti,pulldowns = <0x03a1c0>;
 };
 
 &usb_otg_hs {
-- 
1.8.4.rc3

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
