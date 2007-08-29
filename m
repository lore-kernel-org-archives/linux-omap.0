From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] To fix HS I2C driver for OMAP2430
Date: Wed, 29 Aug 2007 18:16:54 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701A90B86@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
Errors-To: linux-omap-open-source-bounces+gplao-linux-omap-open-source=gmane.org@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

This should fix HSI2C, Keypad and T2 failures on 2430SDP

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

File Changed:
 arch/arm/mach-omap2/clock.h

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

--- linux-omap/arch/arm/mach-omap2/clock.h	2007-08-21 15:44:23.000000000 =
-0500
+++ my_linux-omap/arch/arm/mach-omap2/clock.h	2007-08-29 =
18:07:40.000000000 -0500
@@ -1734,7 +1734,7 @@ static struct clk i2c2_ick =3D {
 	.name		=3D "i2c_ick",
 	.id		=3D 2,
 	.parent		=3D &l4_ck,
-	.flags		=3D CLOCK_IN_OMAP242X,
+	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP2420_EN_I2C2_SHIFT,
 	.recalc		=3D &followparent_recalc,
@@ -1764,7 +1764,7 @@ static struct clk i2c1_ick =3D {
 	.name		=3D "i2c_ick",
 	.id		=3D 1,
 	.parent		=3D &l4_ck,
-	.flags		=3D CLOCK_IN_OMAP242X,
+	.flags		=3D CLOCK_IN_OMAP242X | CLOCK_IN_OMAP243X,
 	.enable_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_ICLKEN1),
 	.enable_bit	=3D OMAP2420_EN_I2C1_SHIFT,
 	.recalc		=3D &followparent_recalc,
