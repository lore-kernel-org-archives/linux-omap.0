From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] FIX BUG in GPT1 Clock Selection
Date: Wed, 10 Oct 2007 18:17:57 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C4701F4A222@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
Content-class: urn:content-classes:message
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

The GPT1 CLK SEL register was getting wrong src register, due to which =
GPT1 was not able to select SYS_CLK as input.

Signed-off-by: Syed Mohammed Khasim <x0khasim@ti.com>

File:
 arch/arm/mach-omap2/clock24xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

diff -purN linux-omap/arch/arm/mach-omap2/clock24xx.h =
my_linux-omap/arch/arm/mach-omap2/clock24xx.h
--- linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-10-09 =
18:14:08.000000000 -0500
+++ my_linux-omap/arch/arm/mach-omap2/clock24xx.h	2007-10-10 =
17:27:07.000000000 -0500
@@ -1489,7 +1489,7 @@ static struct clk gpt1_fck =3D {
 	.enable_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_FCLKEN),
 	.enable_bit	=3D OMAP24XX_EN_GPT1_SHIFT,
 	.init		=3D &omap2_init_clksel_parent,
-	.clksel_reg	=3D OMAP_CM_REGADDR(CORE_MOD, CM_CLKSEL2),
+	.clksel_reg	=3D OMAP_CM_REGADDR(WKUP_MOD, CM_CLKSEL1),
 	.clksel_mask	=3D OMAP24XX_CLKSEL_GPT1_MASK,
 	.clksel		=3D omap24xx_gpt_clksel,
 	.recalc		=3D &omap2_clksel_recalc,
