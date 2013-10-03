From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 1/6] ARM: dts: Fix pinctrl mask for omap3
Date: Wed, 02 Oct 2013 22:16:57 -0700
Message-ID: <20131003051657.8444.97429.stgit@localhost>
References: <20131003051049.8444.16913.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131003051049.8444.16913.stgit@localhost>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?utf-8?q?Beno=C3=AEt?= Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

The wake-up interrupt bit is available on omap3/4/5 processors
unlike what we claim. Without fixing it we cannot use it on
omap3 and the system configured for wake-up events will just
hang on wake-up.

Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Cc: Beno=C3=AEt Cousson <bcousson-rdvid1DuHRBWk0Htik3J/w@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Signed-off-by: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
---
 arch/arm/boot/dts/omap3.dtsi       |    4 ++--
 arch/arm/mach-omap2/mux.h          |    4 +---
 include/dt-bindings/pinctrl/omap.h |    4 +---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index 7d95cda..b41bd57 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -108,7 +108,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			pinctrl-single,register-width =3D <16>;
-			pinctrl-single,function-mask =3D <0x7f1f>;
+			pinctrl-single,function-mask =3D <0xff1f>;
 		};
=20
 		omap3_pmx_wkup: pinmux@0x48002a00 {
@@ -117,7 +117,7 @@
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			pinctrl-single,register-width =3D <16>;
-			pinctrl-single,function-mask =3D <0x7f1f>;
+			pinctrl-single,function-mask =3D <0xff1f>;
 		};
=20
 		gpio1: gpio@48310000 {
diff --git a/arch/arm/mach-omap2/mux.h b/arch/arm/mach-omap2/mux.h
index 5d2080e..16f78a9 100644
--- a/arch/arm/mach-omap2/mux.h
+++ b/arch/arm/mach-omap2/mux.h
@@ -28,7 +28,7 @@
 #define OMAP_PULL_UP			(1 << 4)
 #define OMAP_ALTELECTRICALSEL		(1 << 5)
=20
-/* 34xx specific mux bit defines */
+/* omap3/4/5 specific mux bit defines */
 #define OMAP_INPUT_EN			(1 << 8)
 #define OMAP_OFF_EN			(1 << 9)
 #define OMAP_OFFOUT_EN			(1 << 10)
@@ -36,8 +36,6 @@
 #define OMAP_OFF_PULL_EN		(1 << 12)
 #define OMAP_OFF_PULL_UP		(1 << 13)
 #define OMAP_WAKEUP_EN			(1 << 14)
-
-/* 44xx specific mux bit defines */
 #define OMAP_WAKEUP_EVENT		(1 << 15)
=20
 /* Active pin states */
diff --git a/include/dt-bindings/pinctrl/omap.h b/include/dt-bindings/p=
inctrl/omap.h
index edbd250..bed35e3 100644
--- a/include/dt-bindings/pinctrl/omap.h
+++ b/include/dt-bindings/pinctrl/omap.h
@@ -23,7 +23,7 @@
 #define PULL_UP			(1 << 4)
 #define ALTELECTRICALSEL	(1 << 5)
=20
-/* 34xx specific mux bit defines */
+/* omap3/4/5 specific mux bit defines */
 #define INPUT_EN		(1 << 8)
 #define OFF_EN			(1 << 9)
 #define OFFOUT_EN		(1 << 10)
@@ -31,8 +31,6 @@
 #define OFF_PULL_EN		(1 << 12)
 #define OFF_PULL_UP		(1 << 13)
 #define WAKEUP_EN		(1 << 14)
-
-/* 44xx specific mux bit defines */
 #define WAKEUP_EVENT		(1 << 15)
=20
 /* Active pin states */

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
