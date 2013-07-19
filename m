From: Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 13/22] ARM: ux500: Remove '0x's from OMAP3 IGEP0020 DTS file
Date: Fri, 19 Jul 2013 14:58:44 +0100
Message-ID: <1374242333-6852-13-git-send-email-lee.jones@linaro.org>
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
 arch/arm/boot/dts/omap3-igep0020.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/omap3-igep0020.dts b/arch/arm/boot/dts/o=
map3-igep0020.dts
index e8c4828..f7a8122 100644
--- a/arch/arm/boot/dts/omap3-igep0020.dts
+++ b/arch/arm/boot/dts/omap3-igep0020.dts
@@ -99,19 +99,19 @@
 			label =3D "SPL";
 			reg =3D <0 0x100000>;
 		};
-		partition@0x80000 {
+		partition@80000 {
 			label =3D "U-Boot";
 			reg =3D <0x100000 0x180000>;
 		};
-		partition@0x1c0000 {
+		partition@1c0000 {
 			label =3D "Environment";
 			reg =3D <0x280000 0x100000>;
 		};
-		partition@0x280000 {
+		partition@280000 {
 			label =3D "Kernel";
 			reg =3D <0x380000 0x300000>;
 		};
-		partition@0x780000 {
+		partition@780000 {
 			label =3D "Filesystem";
 			reg =3D <0x680000 0x1f980000>;
 		};
--=20
1.8.1.2
