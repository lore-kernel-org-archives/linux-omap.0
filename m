From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 09/19] ARM: dts: am335x: replace gpio-key,wakeup with wakeup-source property
Date: Wed, 21 Oct 2015 11:10:06 +0100
Message-ID: <1445422216-29375-10-git-send-email-sudeep.holla@arm.com>
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

Though the keyboard driver for GPIO buttons(gpio-keys) will continue to
check for/support the legacy "gpio-key,wakeup" boolean property to
enable gpio buttons as wakeup source, "wakeup-source" is the new
standard binding.

This patch replaces the legacy "gpio-key,wakeup" with the unified
"wakeup-source" property in order to avoid any futher copy-paste
duplication.

Cc: "Beno=C3=AEt Cousson" <bcousson@baylibre.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/am335x-evm.dts    | 4 ++--
 arch/arm/boot/dts/am335x-evmsk.dts  | 2 +-
 arch/arm/boot/dts/am335x-pepper.dts | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335=
x-evm.dts
index 1942a5c8132d..a6e398a213ec 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -83,14 +83,14 @@
 			label =3D "volume-up";
 			linux,code =3D <115>;
 			gpios =3D <&gpio0 2 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		switch@10 {
 			label =3D "volume-down";
 			linux,code =3D <114>;
 			gpios =3D <&gpio0 3 GPIO_ACTIVE_LOW>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
 	};
=20
diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am3=
35x-evmsk.dts
index 315bb02c9920..6b57baaa2bb0 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -123,7 +123,7 @@
 			label =3D "button2";
 			linux,code =3D <0x102>;
 			gpios =3D <&gpio0 30 GPIO_ACTIVE_HIGH>;
-			gpio-key,wakeup;
+			wakeup-source;
 		};
=20
 		switch@4 {
diff --git a/arch/arm/boot/dts/am335x-pepper.dts b/arch/arm/boot/dts/am=
335x-pepper.dts
index 7106114c7464..5107dbb07a7d 100644
--- a/arch/arm/boot/dts/am335x-pepper.dts
+++ b/arch/arm/boot/dts/am335x-pepper.dts
@@ -627,21 +627,21 @@
 		label =3D "home";
 		linux,code =3D <KEY_HOME>;
 		gpios =3D <&gpio1 22 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
=20
 	button@1 {
 		label =3D "menu";
 		linux,code =3D <KEY_MENU>;
 		gpios =3D <&gpio1 23 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
=20
 	buttons@2 {
 		label =3D "power";
 		linux,code =3D <KEY_POWER>;
 		gpios =3D <&gpio0 7 GPIO_ACTIVE_LOW>;
-		gpio-key,wakeup;
+		wakeup-source;
 	};
 };
=20
--=20
1.9.1
