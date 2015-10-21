From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 15/19] ARM: dts: omap: replace legacy *,wakeup property with wakeup-source
Date: Wed, 21 Oct 2015 11:10:12 +0100
Message-ID: <1445422216-29375-16-git-send-email-sudeep.holla@arm.com>
References: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445422216-29375-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Though the keyboard and other driver will continue to support the legac=
y
"gpio-key,wakeup", "linux,wakeup" boolean property to enable the wakeup
source, "wakeup-source" is the new standard binding.

This patch replaces all the legacy wakeup properties with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts  |  8 ++---
 arch/arm/boot/dts/omap3-beagle-xm.dts              |  2 +-
 arch/arm/boot/dts/omap3-beagle.dts                 |  2 +-
 arch/arm/boot/dts/omap3-cm-t3x.dtsi                |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-common.dtsi     |  2 +-
 arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi |  2 +-
 arch/arm/boot/dts/omap3-gta04.dtsi                 |  2 +-
 arch/arm/boot/dts/omap3-ldp.dts                    | 18 ++++++------
 arch/arm/boot/dts/omap3-lilly-a83x.dtsi            |  2 +-
 arch/arm/boot/dts/omap3-n900.dts                   | 10 +++----
 arch/arm/boot/dts/omap3-overo-alto35-common.dtsi   |  2 +-
 .../boot/dts/omap3-overo-chestnut43-common.dtsi    |  4 +--
 arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi    |  2 +-
 arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi |  4 +--
 arch/arm/boot/dts/omap3-overo-palo35-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-overo-palo43-common.dtsi   |  4 +--
 arch/arm/boot/dts/omap3-pandora-common.dtsi        | 34 +++++++++++---=
--------
 .../boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi    |  2 +-
 arch/arm/boot/dts/omap4-duovero-parlor.dts         |  2 +-
 arch/arm/boot/dts/omap4-var-om44customboard.dtsi   |  2 +-
 arch/arm/boot/dts/omap5-cm-t54.dts                 |  2 +-
 22 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts b/arch/a=
rm/boot/dts/logicpd-torpedo-37xx-devkit.dts
index 91146c318798..caeb3b076042 100644
--- a/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
+++ b/arch/arm/boot/dts/logicpd-torpedo-37xx-devkit.dts
@@ -23,28 +23,28 @@
 			label =3D "sysboot2";
 			gpios =3D <&gpio1 2 GPIO_ACTIVE_LOW>;	/* gpio2 */
 			linux,code =3D <BTN_0>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		sysboot5 {
 			label =3D "sysboot5";
 			gpios =3D <&gpio1 7 GPIO_ACTIVE_LOW>;	/* gpio7 */
 			linux,code =3D <BTN_1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		gpio1 {
 			label =3D "gpio1";
 			gpios =3D <&gpio6 21 GPIO_ACTIVE_LOW>;	/* gpio181 */
 			linux,code =3D <BTN_2>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		gpio2 {
 			label =3D "gpio2";
 			gpios =3D <&gpio6 18 GPIO_ACTIVE_LOW>;	/* gpio178 */
 			linux,code =3D <BTN_3>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/omap3-beagle-xm.dts b/arch/arm/boot/dts/=
omap3-beagle-xm.dts
index 7c4dca122a91..f0e2cf3c9e89 100644
--- a/arch/arm/boot/dts/omap3-beagle-xm.dts
+++ b/arch/arm/boot/dts/omap3-beagle-xm.dts
@@ -69,7 +69,7 @@
 			label =3D "user";
 			gpios =3D <&gpio1 4 GPIO_ACTIVE_HIGH>;
 			linux,code =3D <0x114>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 	};
diff --git a/arch/arm/boot/dts/omap3-beagle.dts b/arch/arm/boot/dts/oma=
p3-beagle.dts
index 67659a0ed13e..de5138e61ddc 100644
--- a/arch/arm/boot/dts/omap3-beagle.dts
+++ b/arch/arm/boot/dts/omap3-beagle.dts
@@ -80,7 +80,7 @@
 			label =3D "user";
 			gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
 			linux,code =3D <0x114>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/om=
ap3-cm-t3x.dtsi
index 4d091ca43e25..5ec6491d7933 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -238,7 +238,7 @@
 		ti,debounce-tol =3D /bits/ 16 <10>;
 		ti,debounce-rep =3D /bits/ 16 <1>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
=20
diff --git a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi b/arch/arm/=
boot/dts/omap3-devkit8000-common.dtsi
index 9ca2865a83d6..86850bb311eb 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-common.dtsi
@@ -64,7 +64,7 @@
 			label =3D "user";
 			gpios =3D <&gpio1 26 GPIO_ACTIVE_HIGH>;
 			linux,code =3D <BTN_EXTRA>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/=
arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index e84184de2a4a..2476d3accee0 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -68,6 +68,6 @@
 		ti,keep-vref-on =3D <1>;
 		ti,settle-delay-usec =3D /bits/ 16 <150>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/oma=
p3-gta04.dtsi
index 7166d8876ea8..d780ea16a0a3 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -37,7 +37,7 @@
 			label =3D "aux";
 			linux,code =3D <169>;
 			gpios =3D <&gpio1 7 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-=
ldp.dts
index bd6e6769c7ce..3198dafffb7a 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -35,63 +35,63 @@
 			label =3D "enter";
 			gpios =3D <&gpio4 5 GPIO_ACTIVE_LOW>; /* gpio101 */
 			linux,code =3D <KEY_ENTER>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_f1 {
 			label =3D "f1";
 			gpios =3D <&gpio4 6 GPIO_ACTIVE_LOW>; /* gpio102 */
 			linux,code =3D <KEY_F1>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_f2 {
 			label =3D "f2";
 			gpios =3D <&gpio4 7 GPIO_ACTIVE_LOW>; /* gpio103 */
 			linux,code =3D <KEY_F2>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_f3 {
 			label =3D "f3";
 			gpios =3D <&gpio4 8 GPIO_ACTIVE_LOW>; /* gpio104 */
 			linux,code =3D <KEY_F3>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_f4 {
 			label =3D "f4";
 			gpios =3D <&gpio4 9 GPIO_ACTIVE_LOW>; /* gpio105 */
 			linux,code =3D <KEY_F4>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_left {
 			label =3D "left";
 			gpios =3D <&gpio4 10 GPIO_ACTIVE_LOW>; /* gpio106 */
 			linux,code =3D <KEY_LEFT>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_right {
 			label =3D "right";
 			gpios =3D <&gpio4 11 GPIO_ACTIVE_LOW>; /* gpio107 */
 			linux,code =3D <KEY_RIGHT>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_up {
 			label =3D "up";
 			gpios =3D <&gpio4 12 GPIO_ACTIVE_LOW>; /* gpio108 */
 			linux,code =3D <KEY_UP>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		key_down {
 			label =3D "down";
 			gpios =3D <&gpio4 13 GPIO_ACTIVE_LOW>; /* gpio109 */
 			linux,code =3D <KEY_DOWN>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dt=
s/omap3-lilly-a83x.dtsi
index d0dd0365bfda..f0484cedd0bc 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -327,7 +327,7 @@
 		ti,pressure-max =3D /bits/ 16 <255>;
 		ti,swap-xy;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
=20
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3=
-n900.dts
index 5f5e0f3d5b64..c146f42313cb 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -67,28 +67,28 @@
 			gpios =3D <&gpio4 14 GPIO_ACTIVE_LOW>; /* 110 */
 			linux,input-type =3D <5>; /* EV_SW */
 			linux,code =3D <0x09>; /* SW_CAMERA_LENS_COVER */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		camera_focus {
 			label =3D "Camera Focus";
 			gpios =3D <&gpio3 4 GPIO_ACTIVE_LOW>; /* 68 */
 			linux,code =3D <0x210>; /* KEY_CAMERA_FOCUS */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		camera_capture {
 			label =3D "Camera Capture";
 			gpios =3D <&gpio3 5 GPIO_ACTIVE_LOW>; /* 69 */
 			linux,code =3D <0xd4>; /* KEY_CAMERA */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		lock_button {
 			label =3D "Lock Button";
 			gpios =3D <&gpio4 17 GPIO_ACTIVE_LOW>; /* 113 */
 			linux,code =3D <0x98>; /* KEY_SCREENLOCK */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		keypad_slide {
@@ -96,7 +96,7 @@
 			gpios =3D <&gpio3 7 GPIO_ACTIVE_LOW>; /* 71 */
 			linux,input-type =3D <5>; /* EV_SW */
 			linux,code =3D <0x0a>; /* SW_KEYPAD_SLIDE */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		proximity_sensor {
diff --git a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi b/arch/ar=
m/boot/dts/omap3-overo-alto35-common.dtsi
index 7aae8fb82c1f..3b3a75997f81 100644
--- a/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-alto35-common.dtsi
@@ -48,7 +48,7 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio1 10 GPIO_ACTIVE_LOW>;		/* gpio_10 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi b/arc=
h/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
index 17b82f82638a..7df27926ead2 100644
--- a/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-chestnut43-common.dtsi
@@ -41,13 +41,13 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1@14 {
 			label =3D "button1";
 			linux,code =3D <BTN_1>;
 			gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm=
/boot/dts/omap3-overo-common-lcd35.dtsi
index 80d236ac64a5..2bbc2bd30b81 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -161,6 +161,6 @@
 		ti,x-plate-ohms =3D /bits/ 16 <180>;
 		ti,pressure-max =3D /bits/ 16 <255>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm=
/boot/dts/omap3-overo-common-lcd43.dtsi
index 048fd216970a..d19a2f293c97 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -172,7 +172,7 @@
 		ti,x-plate-ohms =3D /bits/ 16 <180>;
 		ti,pressure-max =3D /bits/ 16 <255>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
 };
=20
diff --git a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi b/arch/=
arm/boot/dts/omap3-overo-gallop43-common.dtsi
index 49d2254a99b0..250cc7fe5d5e 100644
--- a/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-gallop43-common.dtsi
@@ -41,13 +41,13 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1@14 {
 			label =3D "button1";
 			linux,code =3D <BTN_1>;
 			gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi b/arch/ar=
m/boot/dts/omap3-overo-palo35-common.dtsi
index 680d7262399c..8df7ec35d17d 100644
--- a/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo35-common.dtsi
@@ -41,13 +41,13 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1@14 {
 			label =3D "button1";
 			linux,code =3D <BTN_1>;
 			gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi b/arch/ar=
m/boot/dts/omap3-overo-palo43-common.dtsi
index 087aedf5b902..0ea2c451c809 100644
--- a/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-palo43-common.dtsi
@@ -41,13 +41,13 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;		/* gpio_23 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 		button1@14 {
 			label =3D "button1";
 			linux,code =3D <BTN_1>;
 			gpios =3D <&gpio1 14 GPIO_ACTIVE_LOW>;		/* gpio_14 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boo=
t/dts/omap3-pandora-common.dtsi
index f2084e6d01e7..a5827c7ba1af 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -84,112 +84,112 @@
 			label =3D "up";
 			linux,code =3D <KEY_UP>;
 			gpios =3D <&gpio4 14 GPIO_ACTIVE_LOW>;	/* GPIO_110 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		down-button {
 			label =3D "down";
 			linux,code =3D <KEY_DOWN>;
 			gpios =3D <&gpio4 7 GPIO_ACTIVE_LOW>;	/* GPIO_103 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		left-button {
 			label =3D "left";
 			linux,code =3D <KEY_LEFT>;
 			gpios =3D <&gpio4 0 GPIO_ACTIVE_LOW>;	/* GPIO_96 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		right-button {
 			label =3D "right";
 			linux,code =3D <KEY_RIGHT>;
 			gpios =3D <&gpio4 2 GPIO_ACTIVE_LOW>;	/* GPIO_98 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		pageup-button {
 			label =3D "game 1";
 			linux,code =3D <KEY_PAGEUP>;
 			gpios =3D <&gpio4 13 GPIO_ACTIVE_LOW>;	/* GPIO_109 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		pagedown-button {
 			label =3D "game 3";
 			linux,code =3D <KEY_PAGEDOWN>;
 			gpios =3D <&gpio4 10 GPIO_ACTIVE_LOW>;	/* GPIO_106 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		home-button {
 			label =3D "game 4";
 			linux,code =3D <KEY_HOME>;
 			gpios =3D <&gpio4 5 GPIO_ACTIVE_LOW>;	/* GPIO_101 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		end-button {
 			label =3D "game 2";
 			linux,code =3D <KEY_END>;
 			gpios =3D <&gpio4 15 GPIO_ACTIVE_LOW>;	/* GPIO_111 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		right-shift {
 			label =3D "l";
 			linux,code =3D <KEY_RIGHTSHIFT>;
 			gpios =3D <&gpio4 6 GPIO_ACTIVE_LOW>;	/* GPIO_102 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		kp-plus {
 			label =3D "l2";
 			linux,code =3D <KEY_KPPLUS>;
 			gpios =3D <&gpio4 1 GPIO_ACTIVE_LOW>;	/* GPIO_97 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		right-ctrl {
 			label =3D "r";
 			linux,code =3D <KEY_RIGHTCTRL>;
 			gpios =3D <&gpio4 9 GPIO_ACTIVE_LOW>;	/* GPIO_105 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		kp-minus {
 			label =3D "r2";
 			linux,code =3D <KEY_KPMINUS>;
 			gpios =3D <&gpio4 11 GPIO_ACTIVE_LOW>;	/* GPIO_107 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		left-ctrl {
 			label =3D "ctrl";
 			linux,code =3D <KEY_LEFTCTRL>;
 			gpios =3D <&gpio4 8 GPIO_ACTIVE_LOW>;	/* GPIO_104 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		menu {
 			label =3D "menu";
 			linux,code =3D <KEY_MENU>;
 			gpios =3D <&gpio4 3 GPIO_ACTIVE_LOW>;	/* GPIO_99 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		hold {
 			label =3D "hold";
 			linux,code =3D <KEY_COFFEE>;
 			gpios =3D <&gpio6 16 GPIO_ACTIVE_LOW>;	/* GPIO_176 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		left-alt {
 			label =3D "alt";
 			linux,code =3D <KEY_LEFTALT>;
 			gpios =3D <&gpio4 4 GPIO_ACTIVE_HIGH>;	/* GPIO_100 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		lid {
@@ -617,7 +617,7 @@
 		ti,x-plate-ohms =3D /bits/ 16 <40>;
 		ti,pressure-max =3D /bits/ 16 <255>;
=20
-		linux,wakeup;
+		wakeup-source;
 	};
=20
 	lcd: lcd@1 {
diff --git a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi b/arc=
h/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
index f4b1a61853e3..157345bb8e79 100644
--- a/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
+++ b/arch/arm/boot/dts/omap3-panel-sharp-ls037v7dw01.dtsi
@@ -66,6 +66,6 @@
 		ti,x-plate-ohms =3D /bits/ 16 <40>;
 		ti,pressure-max =3D /bits/ 16 <255>;
 		ti,swap-xy;
-		linux,wakeup;
+		wakeup-source;
 	};
 };
diff --git a/arch/arm/boot/dts/omap4-duovero-parlor.dts b/arch/arm/boot=
/dts/omap4-duovero-parlor.dts
index 1a78f013f37a..ab17b9929250 100644
--- a/arch/arm/boot/dts/omap4-duovero-parlor.dts
+++ b/arch/arm/boot/dts/omap4-duovero-parlor.dts
@@ -36,7 +36,7 @@
 			label =3D "button0";
 			linux,code =3D <BTN_0>;
 			gpios =3D <&gpio4 25 GPIO_ACTIVE_LOW>;	/* gpio_121 */
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi b/arch/ar=
m/boot/dts/omap4-var-om44customboard.dtsi
index f2d2fdb75628..6e278d7716a5 100644
--- a/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
+++ b/arch/arm/boot/dts/omap4-var-om44customboard.dtsi
@@ -41,7 +41,7 @@
 			label =3D "user";
 			gpios =3D <&gpio6 24 GPIO_ACTIVE_HIGH>; /* gpio 184 */
 			linux,code =3D <BTN_EXTRA>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/oma=
p5-cm-t54.dts
index 61ad2ea34720..95c5523c1230 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -359,7 +359,7 @@
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
