From: =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
Subject: [PATCH 4/4] ARM: dts: am335x-igep0033: use phandles for USB and DMA refs
Date: Mon, 28 Apr 2014 10:58:32 -0300
Message-ID: <1398693512-5355-4-git-send-email-guido@vanguardiasur.com.ar>
References: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1398693512-5355-1-git-send-email-guido@vanguardiasur.com.ar>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>, bcousson@baylibre.com, tony@atomide.com
Cc: robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, linux@arm.linux.org.uk, linux-omap@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =?UTF-8?q?Ezequiel=20Garc=C3=ADa?= <ezequiel@vanguardiasur.com.ar>, =?UTF-8?q?Guido=20Mart=C3=ADnez?= <guido@vanguardiasur.com.ar>
List-Id: linux-omap@vger.kernel.org

Use phandles instead of unit adresses to reference usb and dma nodes.
This makes the DT more robust and readable.

Signed-off-by: Guido Mart=C3=ADnez <guido@vanguardiasur.com.ar>
---
 arch/arm/boot/dts/am335x-igep0033.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-igep0033.dtsi b/arch/arm/boot/dts=
/am335x-igep0033.dtsi
index 9f22c18..81cf68b 100644
--- a/arch/arm/boot/dts/am335x-igep0033.dtsi
+++ b/arch/arm/boot/dts/am335x-igep0033.dtsi
@@ -201,28 +201,28 @@
 &usb {
 	status =3D "okay";
=20
-	control@44e10620 {
+	&usb_ctrl_mod {
 		status =3D "okay";
 	};
=20
-	usb-phy@47401300 {
+	&usb0_phy {
 		status =3D "okay";
 	};
=20
-	usb-phy@47401b00 {
+	&usb1_phy {
 		status =3D "okay";
 	};
=20
-	usb@47401000 {
+	&usb0 {
 		status =3D "okay";
 	};
=20
-	usb@47401800 {
+	&usb1 {
 		status =3D "okay";
 		dr_mode =3D "host";
 	};
=20
-	dma-controller@47402000  {
+	&cppi41dma  {
 		status =3D "okay";
 	};
 };
--=20
1.9.2
