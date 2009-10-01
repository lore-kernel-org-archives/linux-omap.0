From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [PATCH 22/28] OMAP3: PM: Fix PLL_MOD CLKEN offset in scratchpad
Date: Thu,  1 Oct 2009 16:58:52 -0700
Message-ID: <1254441538-9257-23-git-send-email-khilman@deeprootsystems.com>
References: <1254441538-9257-1-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-2-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-3-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-4-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-5-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-6-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-7-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-8-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-9-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-10-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-11-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-12-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-13-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-14-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-15-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-16-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-17-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-18-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-19-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-20-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-21-git-send-email-khilman@deeprootsystems.com>
 <1254441538-9257-22-git-send-email-khilman@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-px0-f179.google.com ([209.85.216.179]:51872 "EHLO
	mail-px0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756054AbZJAX7d (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Oct 2009 19:59:33 -0400
Received: by mail-px0-f179.google.com with SMTP id 9so694314pxi.4
        for <linux-omap@vger.kernel.org>; Thu, 01 Oct 2009 16:59:37 -0700 (PDT)
In-Reply-To: <1254441538-9257-22-git-send-email-khilman@deeprootsystems.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: linux-omap@vger.kernel.org
Cc: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

=46rom: Kalle Jokiniemi <kalle.jokiniemi@digia.com>

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
index 6c462c7..50b3afc 100644
--- a/arch/arm/mach-omap2/control.c
+++ b/arch/arm/mach-omap2/control.c
@@ -228,7 +228,7 @@ void omap3_save_scratchpad_contents(void)
 	prcm_block_contents.cm_clksel_wkup =3D
 			cm_read_mod_reg(WKUP_MOD, CM_CLKSEL);
 	prcm_block_contents.cm_clken_pll =3D
-			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_CLKEN_PLL);
+			cm_read_mod_reg(PLL_MOD, CM_CLKEN);
 	prcm_block_contents.cm_autoidle_pll =3D
 			cm_read_mod_reg(PLL_MOD, OMAP3430_CM_AUTOIDLE_PLL);
 	prcm_block_contents.cm_clksel1_pll =3D
--=20
1.6.4.3

--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
