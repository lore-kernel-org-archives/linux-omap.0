From: Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH RESEND] irqchip: omap-intc: improve IRQ handler
Date: Mon, 20 Jul 2015 15:49:10 -0500
Message-ID: <20150720204910.GH5394@saruman.tx.rr.com>
References: <1437410759-4945-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.11.1507202241550.18576@nanos>
Reply-To: <balbi@ti.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="smOfPzt+Qjm5bNGJ"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1507202241550.18576@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Felipe Balbi <balbi@ti.com>, Tony Lindgren <tony@atomide.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

--smOfPzt+Qjm5bNGJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2015 at 10:44:08PM +0200, Thomas Gleixner wrote:
> On Mon, 20 Jul 2015, Felipe Balbi wrote:
> > +	irqnr =3D intc_readl(INTC_SIR);
> > +	irqnr &=3D ACTIVEIRQ_MASK;
> > +	WARN(!irqnr, "Spurious IRQ ?\n");
>=20
> Shouldn't that be WARN_ONCE?

Sure, why not ?

8<--------------------------------------------------------------------

=46rom a71590d725e54b888db278de6c278d2a106fc76d Mon Sep 17 00:00:00 2001
=46rom: Felipe Balbi <balbi@ti.com>
Date: Fri, 2 Jan 2015 16:18:54 -0600
Subject: [PATCH RESEND v2] irqchip: omap-intc: improve IRQ handler

as it turns out the current IRQ number will
*always* be available from SIR register which
renders the reads of PENDING registers as plain
unnecessary overhead.

In order to catch any situation where SIR reads
as zero, we're adding a WARN() to turn it into
a very verbose error and users actually report
it.

With this patch average running time of
omap_intc_handle_irq() reduced from about 28.5us
to 19.8us as measured by the kernel function
profiler.

Tested with BeagleBoneBlack Rev A5C.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes from V1:

 - replace WARN() with WARN_ONCE()

 drivers/irqchip/irq-omap-intc.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/drivers/irqchip/irq-omap-intc.c b/drivers/irqchip/irq-omap-int=
c.c
index a569c6dbd1d1..e15f10746310 100644
--- a/drivers/irqchip/irq-omap-intc.c
+++ b/drivers/irqchip/irq-omap-intc.c
@@ -331,37 +331,12 @@ static int __init omap_init_irq(u32 base, struct devi=
ce_node *node)
 static asmlinkage void __exception_irq_entry
 omap_intc_handle_irq(struct pt_regs *regs)
 {
-	u32 irqnr =3D 0;
-	int handled_irq =3D 0;
-	int i;
-
-	do {
-		for (i =3D 0; i < omap_nr_pending; i++) {
-			irqnr =3D intc_readl(INTC_PENDING_IRQ0 + (0x20 * i));
-			if (irqnr)
-				goto out;
-		}
-
-out:
-		if (!irqnr)
-			break;
-
-		irqnr =3D intc_readl(INTC_SIR);
-		irqnr &=3D ACTIVEIRQ_MASK;
+	u32 irqnr;
=20
-		if (irqnr) {
-			handle_domain_irq(domain, irqnr, regs);
-			handled_irq =3D 1;
-		}
-	} while (irqnr);
-
-	/*
-	 * If an irq is masked or deasserted while active, we will
-	 * keep ending up here with no irq handled. So remove it from
-	 * the INTC with an ack.
-	 */
-	if (!handled_irq)
-		omap_ack_irq(NULL);
+	irqnr =3D intc_readl(INTC_SIR);
+	irqnr &=3D ACTIVEIRQ_MASK;
+	WARN_ONCE(!irqnr, "Spurious IRQ ?\n");
+	handle_domain_irq(domain, irqnr, regs);
 }
=20
 void __init omap3_init_irq(void)
--=20
2.4.4


--=20
balbi

--smOfPzt+Qjm5bNGJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVrV7GAAoJEIaOsuA1yqREr3QP/R58mJXTHF5XYUEmoq3jmYS2
e6iQM/JQrW48AMwyenkp1XEQyNSZHtiG92t4jSsW7DMfrJWzZVTofrvm1G54kJeQ
8QeM5ZYSJEgaGnC4iLTUwBGG/Orrxwovsu2oPojIqqUqjHGTvddF03fWvqKBHLhw
SwzUL0jIuBXGvgMJH55zem2Ab7MbxIsyTStMMbCziKLqCx2sqcaxZuJuTEcxSTQ+
QxtmRl4XryZEUo3cAWu7rvPsh/K+5dH9iH5AagcB1mWNGZy9EkR200OJocropE5/
wyGwBZefNygSvfGAJqhBVTzlfmYz8Uus5YRicdIeyHTrjLKutRDzzgAEYaIes1Os
+6vghtlJ59iCrDZt+QVl+uSLuFr1t8JJoUR5YIP+GN6oDZXdwgaLlOnTpj8fqMxk
2jEQ3sJMXaePpvgh0CRQGReIfLIMfpwgq7nKNieBEXLktGwk8nkWrZ9G068T9uHM
sKI8/Wn2PvObcHxEcyFLhYJV7l5iwNTw7kWmQ03wsDAyPuyK9ipjXI0BUdwhBh4v
OuD7tS0O5p8tL4XB5SP8/d8szXPjvmUP+WRtpEZfMk80KAzAfaayRpCtB6oGiQi/
HryP8orl3mI98co/mkKjbz/37wkunMZh6/8llAjCiHqrPiZ4ircMUNV1v+p4x+kY
8YTrUKIQ/OzDL2sLJvBA
=E2rz
-----END PGP SIGNATURE-----

--smOfPzt+Qjm5bNGJ--
