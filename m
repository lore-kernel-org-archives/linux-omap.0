From: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
Subject: [PATCH] ARM: dts: am335x/am57xx: replace gpio-key,wakeup with wakeup-source property
Date: Mon,  8 Feb 2016 21:55:53 +0000
Message-ID: <1454968553-12088-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

Commit 3efda00129bd ("ARM: dts: am335x: replace gpio-key,wakeup with
wakeup-source property") replaces all the legacy "gpio-key,wakeup" with
the unified  "wakeup-source" property to prevent any further copy-paste
duplication.

However couple of use of these legacy property sneaked in during the
merge window. This patch replaces them too.

Cc: "Beno=C3=AEt Cousson" <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
---
 arch/arm/boot/dts/am335x-shc.dts          | 4 ++--
 arch/arm/boot/dts/am57xx-cl-som-am57x.dts | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Hi Tony,

I see these files got introduced during v4.5 merge window and we could
not stop the copy-paste from the earlier versions files from which they
were copied.

Regards,
Sudeep

diff --git a/arch/arm/boot/dts/am335x-shc.dts b/arch/arm/boot/dts/am335=
x-shc.dts
index 1b5b044fcd91..865de8500f1c 100644
--- a/arch/arm/boot/dts/am335x-shc.dts
+++ b/arch/arm/boot/dts/am335x-shc.dts
@@ -46,7 +46,7 @@
 			gpios =3D <&gpio1 29 GPIO_ACTIVE_HIGH>;
 			linux,code =3D <KEY_BACK>;
 			debounce-interval =3D <1000>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		front_button {
@@ -54,7 +54,7 @@
 			gpios =3D <&gpio1 25 GPIO_ACTIVE_HIGH>;
 			linux,code =3D <KEY_FRONT>;
 			debounce-interval =3D <1000>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/=
dts/am57xx-cl-som-am57x.dts
index c53882643ae9..497eb07ced19 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -545,7 +545,7 @@
 		ti,debounce-tol =3D /bits/ 16 <10>;
 		ti,debounce-rep =3D /bits/ 16 <1>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
=20
--=20
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
