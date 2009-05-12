From: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
Subject: [PATCH 1/1] ARM:OMAP3: Fix PLL_MOD CLKEN offset in scratchpad
Date: Tue, 12 May 2009 14:02:16 +0300
Message-ID: <1242126136-8419-2-git-send-email-kalle.jokiniemi@digia.com>
References: <>
 <1242126136-8419-1-git-send-email-kalle.jokiniemi@digia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp1.digia.com ([82.118.214.156]:11122 "EHLO smtp1.digia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754049AbZELLCF (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Tue, 12 May 2009 07:02:05 -0400
In-Reply-To: <1242126136-8419-1-git-send-email-kalle.jokiniemi@digia.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: khilman@deeprootsystems.com
Cc: linux-omap@vger.kernel.org, jouni.hogander@nokia.com, Kalle Jokiniemi <kalle.jokiniemi@digia.com>

The CM_CLKEN_PLL register saved in scratchpad memory
was wrongly using offset of 0x0004 instead of 0x0000.

The effect of this was that boot ROM code would
restore the wrong value when waking up from off mode.
This wrong value, however, will be overwritten by
prcm context restore. Still, a short period of wrong
clock settings in CM_CLKEN_PLL remained between ROM
code and prcm context restore. This is fixed by the
patch.

Problem reported by: Jouni H=C3=B6gander <jouni.hogander@nokia.com>

Signed-off-by: Kalle Jokiniemi <kalle.jokiniemi@digia.com>
---
 arch/arm/mach-omap2/control.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/control.c b/arch/arm/mach-omap2/contro=
l.c
index a0429fe..60de860 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -235,7 +235,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clksel_wkup =3D
 			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =3D
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =3D
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll =3D
--=20
1.5.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
