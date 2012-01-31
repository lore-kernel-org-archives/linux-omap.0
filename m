From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: [PATCH 07/19] ARM: OMAP3+: SmartReflex: clear ERRCONFIG_VPBOUNDINTST only on a need
Date: Tue, 31 Jan 2012 10:58:20 +0100
Message-ID: <1328003912-11709-8-git-send-email-j-pihet@ti.com>
References: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:49867 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556Ab2AaJ7H (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 31 Jan 2012 04:59:07 -0500
Received: by mail-we0-f174.google.com with SMTP id b13so175586wer.19
        for <linux-omap@vger.kernel.org>; Tue, 31 Jan 2012 01:59:06 -0800 (PST)
In-Reply-To: <1328003912-11709-1-git-send-email-j-pihet@ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, balbi@ti.com, nm@ti.com
Cc: Kevin Hilman <khilman@ti.com>, Paul Walmsley <paul@pwsan.com>, Jean Pihet <j-pihet@ti.com>

=46rom: Nishanth Menon <nm@ti.com>

MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

ERRCONFIG register's VPBOUNDINTST has an additional functional meaning
It force clears Sr_interruptz internal signal. This can result in
scenarios where VP-> SR protocol is violated where voltage processor's
As interruptz is already high, VP will never clear the signal vpirqclr.
Therefore during the next force update to reset to nominal voltage,
VP can=E2=80=99t pulsed vpirqclr =3D> PRCM HW can=E2=80=99t generate th=
e tranxdone IRQ
and the situation is not recoverable untill a cold reset is invoked.

To prevent this situation, check if status is set before clearing the
status as this needs to be done only on a need basis.

Reported-by: Vincent Bour <v-bour@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Jean Pihet <j-pihet@ti.com>
---
 arch/arm/mach-omap2/smartreflex.c |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/smartreflex.c b/arch/arm/mach-omap2/sm=
artreflex.c
index ba6ad09..6dea30d 100644
--- a/arch/arm/mach-omap2/smartreflex.c
+++ b/arch/arm/mach-omap2/smartreflex.c
@@ -289,6 +289,8 @@ error:
 static void sr_v1_disable(struct omap_sr *sr)
 {
 	int timeout =3D 0;
+	int errconf_val =3D ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST=
 |
+			ERRCONFIG_MCUBOUNDINTST;
=20
 	/* Enable MCUDisableAcknowledge interrupt */
 	sr_modify_reg(sr, ERRCONFIG_V1,
@@ -297,13 +299,13 @@ static void sr_v1_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
=20
-	/* Disable all other SR interrupts and clear the status */
+	/* Disable all other SR interrupts and clear the status as needed */
+	if (sr_read_reg(sr, ERRCONFIG_V1) & ERRCONFIG_VPBOUNDINTST_V1)
+		errconf_val |=3D ERRCONFIG_VPBOUNDINTST_V1;
 	sr_modify_reg(sr, ERRCONFIG_V1,
 			(ERRCONFIG_MCUACCUMINTEN | ERRCONFIG_MCUVALIDINTEN |
 			ERRCONFIG_MCUBOUNDINTEN | ERRCONFIG_VPBOUNDINTEN_V1),
-			(ERRCONFIG_MCUACCUMINTST | ERRCONFIG_MCUVALIDINTST |
-			ERRCONFIG_MCUBOUNDINTST |
-			ERRCONFIG_VPBOUNDINTST_V1));
+			errconf_val);
=20
 	/*
 	 * Wait for SR to be disabled.
@@ -332,9 +334,17 @@ static void sr_v2_disable(struct omap_sr *sr)
 	/* SRCONFIG - disable SR */
 	sr_modify_reg(sr, SRCONFIG, SRCONFIG_SRENABLE, 0x0);
=20
-	/* Disable all other SR interrupts and clear the status */
-	sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+	/*
+	 * Disable all other SR interrupts and clear the status
+	 * write to status register ONLY on need basis - only if status
+	 * is set.
+	 */
+	if (sr_read_reg(sr, ERRCONFIG_V2) & ERRCONFIG_VPBOUNDINTST_V2)
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
 			ERRCONFIG_VPBOUNDINTST_V2);
+	else
+		sr_modify_reg(sr, ERRCONFIG_V2, ERRCONFIG_VPBOUNDINTEN_V2,
+				0x0);
 	sr_write_reg(sr, IRQENABLE_CLR, (IRQENABLE_MCUACCUMINT |
 			IRQENABLE_MCUVALIDINT |
 			IRQENABLE_MCUBOUNDSINT));
--=20
1.7.5.4

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
