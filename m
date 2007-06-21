From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [PATCH] Add 3430 support in irq.c
Date: Wed, 20 Jun 2007 22:17:55 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C47012A513A@dlee13.ent.ti.com>
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
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Add 3430 support in irq.c

Signed-off-by: Syed Mohammed Khasim  <x0khasim@ti.com>

Files:
 arch/arm/mach-omap2/irq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-06-20 14:44:42.000000000 =
-0500
@@ -37,11 +37,9 @@ static struct omap_irq_bank {
 } __attribute__ ((aligned(4))) irq_banks[] =3D {
 	{
 		/* MPU INTC */
-		.base_reg	=3D IO_ADDRESS(OMAP24XX_IC_BASE),
+		.base_reg	=3D 0,
 		.nr_irqs	=3D 96,
-	}, {
-		/* XXX: DSP INTC */
-	}
+	},
 };
=20
 /* XXX: FIQ and additional INTC support (only MPU at the moment) */
@@ -118,10 +116,12 @@ void __init omap_init_irq(void)
 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank =3D irq_banks + i;
=20
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+		if (cpu_is_omap24xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
+		}
+		if (cpu_is_omap34xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
+		}
 		omap_irq_bank_init_one(bank);
=20
 		nr_irqs +=3D bank->nr_irqs;
