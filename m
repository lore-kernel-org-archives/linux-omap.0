From: =?UTF-8?q?Stefan=20S=C3=B8rensen?=
	<stefan.sorensen@spectralink.com>
Subject: [PATCH] ARM: OMAP2+: INTC: Acknowledge stuck active interrupts
Date: Thu,  6 Mar 2014 16:27:15 +0100
Message-ID: <1394119635-24194-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from 213083164162.static.sonofon.dk ([213.83.164.162]:57771 "EHLO
	HORWDSPRD01.spectralink.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751082AbaCFP1Y (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 6 Mar 2014 10:27:24 -0500
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: tony@atomide.com, linux-omap@vger.kernel.org
Cc: =?UTF-8?q?Stefan=20S=C3=B8rensen?= <stefan.sorensen@spectralink.com>

When an interrupt has become active on the INTC it will stay active
until it is acked, even if masked or de-asserted. The
INTC_PENDING_IRQn registers are however updated and since these are
used by omap_intc_handle_irq to determine which interrupt to handle,
it will never see the active interrupt. This will result in a storm of
useless interrupts that is only stopped when another higher priority
interrupt is asserted.

=46ix by sending the INTC an acknowledge if we find no interrupts to
handle.

Signed-off-by: Stefan S=C3=B8rensen <stefan.sorensen@spectralink.com>
---
 arch/arm/mach-omap2/irq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/mach-omap2/irq.c b/arch/arm/mach-omap2/irq.c
index e022a86..6037a9a 100644
--- a/arch/arm/mach-omap2/irq.c
+++ b/arch/arm/mach-omap2/irq.c
@@ -222,6 +222,7 @@ void __init ti81xx_init_irq(void)
 static inline void omap_intc_handle_irq(void __iomem *base_addr, struc=
t pt_regs *regs)
 {
 	u32 irqnr;
+	int handled_irq =3D 0;
=20
 	do {
 		irqnr =3D readl_relaxed(base_addr + 0x98);
@@ -249,8 +250,15 @@ out:
 		if (irqnr) {
 			irqnr =3D irq_find_mapping(domain, irqnr);
 			handle_IRQ(irqnr, regs);
+			handled_irq =3D 1;
 		}
 	} while (irqnr);
+
+	/* If an irq is masked or deasserted while active, we will
+	 * keep ending up here with no irq handled. So remove it from
+	 * the INTC with an ack.*/
+	if (!handled_irq)
+		omap_ack_irq(NULL);
 }
=20
 asmlinkage void __exception_irq_entry omap2_intc_handle_irq(struct pt_=
regs *regs)
--=20
1.8.5.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
