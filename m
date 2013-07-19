From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 18/22] ARM: ux500: Remove '0x's from OMAP5 DTS file
Date: Fri, 19 Jul 2013 14:58:49 +0100
Message-ID: <1374242333-6852-18-git-send-email-lee.jones@linaro.org>
References: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374242333-6852-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, linus.walleij@stericsson.com, srinidhi.kasagar@stericsson.com, Lee Jones <lee.jones@linaro.org>, =?UTF-8?q?Beno=C3=AEt=20Cousson?= <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Cc: Beno=C3=AEt Cousson <b-cousson@ti.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/omap5.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/omap5.dtsi b/arch/arm/boot/dts/omap5.dts=
i
index e643620..be58604 100644
--- a/arch/arm/boot/dts/omap5.dtsi
+++ b/arch/arm/boot/dts/omap5.dtsi
@@ -604,7 +604,7 @@
 			ti,hwmods =3D "wd_timer2";
 		};
=20
-		emif1: emif@0x4c000000 {
+		emif1: emif@4c000000 {
 			compatible	=3D "ti,emif-4d5";
 			ti,hwmods	=3D "emif1";
 			phy-type	=3D <2>; /* DDR PHY type: Intelli PHY */
@@ -615,7 +615,7 @@
 			hw-caps-temp-alert;
 		};
=20
-		emif2: emif@0x4d000000 {
+		emif2: emif@4d000000 {
 			compatible	=3D "ti,emif-4d5";
 			ti,hwmods	=3D "emif2";
 			phy-type	=3D <2>; /* DDR PHY type: Intelli PHY */
--=20
1.8.1.2
