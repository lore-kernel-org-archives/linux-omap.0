From: "Syed Mohammed, Khasim" <x0khasim@ti.com>
Subject: [RFC] irq.c for OMAP3430
Date: Tue, 29 May 2007 23:07:50 -0500
Message-ID: <9C23CDD79DA20A479D4615857B2E2C470106287A@dlee13.ent.ti.com>
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
To: Tony Lindgren <tony@atomide.com>
Cc: Linux OMAP <linux-omap-open-source@linux.omap.com>
List-Id: linux-omap@vger.kernel.org

Hi Tony,

I have incorporated your review comments for irq.c.=20

Please do let me know if you find any further issues with the same.

Regards,
Khasim

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-omap/arch/arm/mach-omap2/irq.c	2007-01-08 18:55:58.000000000 =
-0600
+++ val_3430_GIT/arch/arm/mach-omap2/irq.c	2007-05-29 20:21:42.000000000 =
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
@@ -118,10 +116,16 @@ void __init omap_init_irq(void)
 	for (i =3D 0; i < ARRAY_SIZE(irq_banks); i++) {
 		struct omap_irq_bank *bank =3D irq_banks + i;
=20
-		/* XXX */
-		if (!bank->base_reg)
-			continue;
-
+#ifdef CONFIG_ARCH_OMAP24XX
+		if (cpu_is_omap24xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP24XX_IC_BASE);
+		}
+#endif
+#ifdef CONFIG_ARCH_OMAP34XX
+		if (cpu_is_omap34xx()) {
+			bank->base_reg =3D IO_ADDRESS(OMAP34XX_IC_BASE);
+		}
+#endif
 		omap_irq_bank_init_one(bank);
=20
 		nr_irqs +=3D bank->nr_irqs;
