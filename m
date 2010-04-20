From: Paul Walmsley <paul@pwsan.com>
Subject: [PATCH 4/4] OMAP3: PM: PM_MPUGRPSEL writes should use GRPSEL macros,
	not EN macros
Date: Tue, 20 Apr 2010 01:45:53 -0600
Message-ID: <20100420074550.3015.65546.stgit@localhost.localdomain>
References: <20100420074204.3015.56304.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from utopia.booyaka.com ([72.9.107.138]:35976 "EHLO
	utopia.booyaka.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753884Ab0DTHsf (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Tue, 20 Apr 2010 03:48:35 -0400
In-Reply-To: <20100420074204.3015.56304.stgit@localhost.localdomain>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>, Jouni =?utf-8?b?SMO2Z2FuZGVy?= <jouni.hogander@nokia.com>

Writes to the PM_*GRPSEL registers should use _GRPSEL_ macros, not _EN_=
 macros,
to match the TRM and guard against inadvertent error.  This patch shoul=
d
not cause any functional change.

Signed-off-by: Paul Walmsley <paul@pwsan.com>
Cc: Kevin Hilman <khilman@deeprootsystems.com>
Cc: Jouni H=C3=B6gander <jouni.hogander@nokia.com>
---
 arch/arm/mach-omap2/pm34xx.c |   19 ++++++++++++-------
 1 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-omap2/pm34xx.c b/arch/arm/mach-omap2/pm34xx.=
c
index 809a169..eab93b2 100644
--- a/arch/arm/mach-omap2/pm34xx.c
+++ b/arch/arm/mach-omap2/pm34xx.c
@@ -886,8 +886,9 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_GPT1_MASK | OMAP3430_EN_GPT12_MASK,
 			  WKUP_MOD, PM_WKEN);
 	/* No need to write EN_IO, that is always enabled */
-	prm_write_mod_reg(OMAP3430_EN_GPIO1_MASK | OMAP3430_EN_GPT1_MASK |
-			  OMAP3430_EN_GPT12_MASK,
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO1_MASK |
+			  OMAP3430_GRPSEL_GPT1_MASK |
+			  OMAP3430_GRPSEL_GPT12_MASK,
 			  WKUP_MOD, OMAP3430_PM_MPUGRPSEL);
 	/* For some reason IO doesn't generate wakeup event even if
 	 * it is selected to mpu wakeup goup */
@@ -906,11 +907,15 @@ static void __init prcm_setup_regs(void)
 			  OMAP3430_EN_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, PM_WKEN);
 	/* and allow them to wake up MPU */
-	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK | OMAP3430_EN_GPIO3_MASK=
 |
-			  OMAP3430_GRPSEL_GPIO4_MASK | OMAP3430_EN_GPIO5_MASK |
-			  OMAP3430_GRPSEL_GPIO6_MASK | OMAP3430_EN_UART3_MASK |
-			  OMAP3430_EN_MCBSP2_MASK | OMAP3430_EN_MCBSP3_MASK |
-			  OMAP3430_EN_MCBSP4_MASK,
+	prm_write_mod_reg(OMAP3430_GRPSEL_GPIO2_MASK |
+			  OMAP3430_GRPSEL_GPIO3_MASK |
+			  OMAP3430_GRPSEL_GPIO4_MASK |
+			  OMAP3430_GRPSEL_GPIO5_MASK |
+			  OMAP3430_GRPSEL_GPIO6_MASK |
+			  OMAP3430_GRPSEL_UART3_MASK |
+			  OMAP3430_GRPSEL_MCBSP2_MASK |
+			  OMAP3430_GRPSEL_MCBSP3_MASK |
+			  OMAP3430_GRPSEL_MCBSP4_MASK,
 			  OMAP3430_PER_MOD, OMAP3430_PM_MPUGRPSEL);
=20
 	/* Don't attach IVA interrupts */


--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
