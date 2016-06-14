From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: [PATCH 2/2 v2] ARM: dts: add aliases for ti,omap[234]-gpio devices
Date: Tue, 14 Jun 2016 20:57:12 +0200
Message-ID: <1465930632-18941-3-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-gpio-owner@vger.kernel.org>
In-Reply-To: <1465930632-18941-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-gpio-owner@vger.kernel.org
To: Grygorii Strashko <grygorii.strashko@ti.com>, Santosh Shilimkar <ssantosh@kernel.org>, Kevin Hilman <khilman@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>
Cc: linux-omap@vger.kernel.org, linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de
List-Id: linux-omap@vger.kernel.org

This together with the corresponding change to the gpio-omap driver
ensures that the gpio numbering is independant of the probing order.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/boot/dts/am33xx.dtsi   | 4 ++++
 arch/arm/boot/dts/am4372.dtsi   | 6 ++++++
 arch/arm/boot/dts/dm814x.dtsi   | 2 ++
 arch/arm/boot/dts/dm816x.dtsi   | 2 ++
 arch/arm/boot/dts/dra7.dtsi     | 8 ++++++++
 arch/arm/boot/dts/omap2420.dtsi | 7 +++++++
 arch/arm/boot/dts/omap2430.dtsi | 8 ++++++++
 arch/arm/boot/dts/omap3.dtsi    | 6 ++++++
 arch/arm/boot/dts/omap4.dtsi    | 6 ++++++
 arch/arm/boot/dts/omap5.dtsi    | 8 ++++++++
 10 files changed, 57 insertions(+)

diff --git a/arch/arm/boot/dts/am33xx.dtsi b/arch/arm/boot/dts/am33xx.d=
tsi
index 52be48bbd2dd..fbfc17ab56d8 100644
--- a/arch/arm/boot/dts/am33xx.dtsi
+++ b/arch/arm/boot/dts/am33xx.dtsi
@@ -35,6 +35,10 @@
 		phy1 =3D &usb1_phy;
 		ethernet0 =3D &cpsw_emac0;
 		ethernet1 =3D &cpsw_emac1;
+		gpio0 =3D &gpio0;
+		gpio1 =3D &gpio1;
+		gpio2 =3D &gpio2;
+		gpio3 =3D &gpio3;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.d=
tsi
index 12fcde4d4d2e..0f5a915ba94b 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -31,6 +31,12 @@
 		ethernet0 =3D &cpsw_emac0;
 		ethernet1 =3D &cpsw_emac1;
 		spi0 =3D &qspi;
+		gpio0 =3D &gpio0;
+		gpio1 =3D &gpio1;
+		gpio2 =3D &gpio2;
+		gpio3 =3D &gpio3;
+		gpio4 =3D &gpio4;
+		gpio5 =3D &gpio5;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/dm814x.dtsi b/arch/arm/boot/dts/dm814x.d=
tsi
index d4537dc61497..d5a49ad31d50 100644
--- a/arch/arm/boot/dts/dm814x.dtsi
+++ b/arch/arm/boot/dts/dm814x.dtsi
@@ -25,6 +25,8 @@
 		usb1 =3D &usb1;
 		phy0 =3D &usb0_phy;
 		phy1 =3D &usb1_phy;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/dm816x.dtsi b/arch/arm/boot/dts/dm816x.d=
tsi
index 44e39c743b53..500d9091701e 100644
--- a/arch/arm/boot/dts/dm816x.dtsi
+++ b/arch/arm/boot/dts/dm816x.dtsi
@@ -21,6 +21,8 @@
 		serial2 =3D &uart3;
 		ethernet0 =3D &eth0;
 		ethernet1 =3D &eth1;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
index e0074014385a..4d6e2309a742 100644
--- a/arch/arm/boot/dts/dra7.dtsi
+++ b/arch/arm/boot/dts/dra7.dtsi
@@ -42,6 +42,14 @@
 		d_can0 =3D &dcan1;
 		d_can1 =3D &dcan2;
 		spi0 =3D &qspi;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		gpio4 =3D &gpio5;
+		gpio5 =3D &gpio6;
+		gpio6 =3D &gpio7;
+		gpio7 =3D &gpio8;
 	};
=20
 	timer {
diff --git a/arch/arm/boot/dts/omap2420.dtsi b/arch/arm/boot/dts/omap24=
20.dtsi
index fb712b9aa874..933e4415d3d2 100644
--- a/arch/arm/boot/dts/omap2420.dtsi
+++ b/arch/arm/boot/dts/omap2420.dtsi
@@ -13,6 +13,13 @@
 / {
 	compatible =3D "ti,omap2420", "ti,omap2";
=20
+	aliases {
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+	};
+
 	ocp {
 		l4: l4@48000000 {
 			compatible =3D "ti,omap2-l4", "simple-bus";
diff --git a/arch/arm/boot/dts/omap2430.dtsi b/arch/arm/boot/dts/omap24=
30.dtsi
index 455aaea407dd..8c0e5555a550 100644
--- a/arch/arm/boot/dts/omap2430.dtsi
+++ b/arch/arm/boot/dts/omap2430.dtsi
@@ -13,6 +13,14 @@
 / {
 	compatible =3D "ti,omap2430", "ti,omap2";
=20
+	aliases {
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		gpio4 =3D &gpio5;
+	};
+
 	ocp {
 		l4_wkup: l4_wkup@49000000 {
 			compatible =3D "ti,omap2-l4-wkup", "simple-bus";
diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dts=
i
index 9fbda38528dc..2676c34c5830 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -25,6 +25,12 @@
 		serial0 =3D &uart1;
 		serial1 =3D &uart2;
 		serial2 =3D &uart3;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		gpio4 =3D &gpio5;
+		gpio5 =3D &gpio6;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/omap4.dtsi b/arch/arm/boot/dts/omap4.dts=
i
index 3fdc51cd0fad..367a2fb04829 100644
--- a/arch/arm/boot/dts/omap4.dtsi
+++ b/arch/arm/boot/dts/omap4.dtsi
@@ -25,6 +25,12 @@
 		serial1 =3D &uart2;
 		serial2 =3D &uart3;
 		serial3 =3D &uart4;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		gpio4 =3D &gpio5;
+		gpio5 =3D &gpio6;
 	};
=20
 	cpus {
diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index 84c10195e79b..017edd442390 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -32,6 +32,14 @@
 		serial3 =3D &uart4;
 		serial4 =3D &uart5;
 		serial5 =3D &uart6;
+		gpio0 =3D &gpio1;
+		gpio1 =3D &gpio2;
+		gpio2 =3D &gpio3;
+		gpio3 =3D &gpio4;
+		gpio4 =3D &gpio5;
+		gpio5 =3D &gpio6;
+		gpio6 =3D &gpio7;
+		gpio7 =3D &gpio8;
 	};
=20
 	cpus {
--=20
2.8.1

--
To unsubscribe from this list: send the line "unsubscribe linux-gpio" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
